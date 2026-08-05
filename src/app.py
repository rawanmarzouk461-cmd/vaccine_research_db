import streamlit as st
import mysql.connector
import pandas as pd

st.set_page_config(page_title="Vaccine R&D Management System", layout="wide")

def get_db_connection():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="ENTER_YOUR_PASSWORD_HERE", #ENTER YOUR MySQL server Password Here
        database="vaccine_db"
    )

st.title("Vaccine Research & Development Management System")

menu = ["View Data & Search", "Add Vaccine Candidate", "Update Study Status", "Delete Record"]
choice = st.sidebar.selectbox("Navigation Menu", menu)

if choice == "View Data & Search":
    st.subheader("Database Overview & Search")
    
    table_option = st.selectbox(
        "Select Table or View", 
        ["vaccine_candidates", "clinical_studies", "participants", "adverse_events", "vw_study_overview", "vw_active_adverse_events"]
    )
    
    conn = get_db_connection()
    query = f"SELECT * FROM {table_option}"
    df = pd.read_sql(query, conn)
    conn.close()
    
    search_term = st.text_input("Search records:")
    if search_term:
        mask = df.apply(lambda row: row.astype(str).str.contains(search_term, case=False).any(), axis=1)
        df = df[mask]
        
    st.dataframe(df, use_container_width=True)

elif choice == "Add Vaccine Candidate":
    st.subheader("Add New Vaccine Candidate")
    
    with st.form("add_candidate_form"):
        name = st.text_input("Vaccine Name (e.g. VAC-2026)")
        platform = st.selectbox("Technology Platform", ["mRNA", "Viral Vector", "Protein Subunit", "Inactivated", "Live Attenuated"])
        disease = st.text_input("Target Disease")
        created_date = st.date_input("Creation Date")
        
        submitted = st.form_submit_button("Save Candidate")
        
        if submitted:
            if name and disease:
                try:
                    conn = get_db_connection()
                    cursor = conn.cursor()
                    sql = "INSERT INTO vaccine_candidates (name, technology_platform, target_disease, created_date) VALUES (%s, %s, %s, %s)"
                    cursor.execute(sql, (name, platform, disease, created_date))
                    conn.commit()
                    cursor.close()
                    conn.close()
                    st.success(f"Vaccine Candidate '{name}' added successfully.")
                except Exception as e:
                    st.error(f"Error: {e}")
            else:
                st.warning("Please fill in all required fields.")

elif choice == "Update Study Status":
    st.subheader("Update Clinical Study Status")
    
    conn = get_db_connection()
    studies_df = pd.read_sql("SELECT study_id, phase, status FROM clinical_studies", conn)
    conn.close()
    
    st.dataframe(studies_df, use_container_width=True)
    
    study_id = st.number_input("Enter Study ID to Update", min_value=1, step=1)
    new_status = st.selectbox("Select New Status", ["Pending", "Ongoing", "Completed", "Terminated"])
    
    if st.button("Update Status"):
        try:
            conn = get_db_connection()
            cursor = conn.cursor()
            sql = "UPDATE clinical_studies SET status = %s WHERE study_id = %s"
            cursor.execute(sql, (new_status, study_id))
            conn.commit()
            cursor.close()
            conn.close()
            st.success(f"Status for Study ID {study_id} updated to '{new_status}'.")
        except Exception as e:
            st.error(f"Error: {e}")

elif choice == "Delete Record":
    st.subheader("Delete Lab Test Record")
    
    conn = get_db_connection()
    tests_df = pd.read_sql("SELECT * FROM lab_tests", conn)
    conn.close()
    
    st.dataframe(tests_df, use_container_width=True)
    
    test_id = st.number_input("Enter Test ID to Delete", min_value=1, step=1)
    
    if st.button("Delete Lab Test"):
        try:
            conn = get_db_connection()
            cursor = conn.cursor()
            sql = "DELETE FROM lab_tests WHERE test_id = %s"
            cursor.execute(sql, (test_id,))
            conn.commit()
            cursor.close()
            conn.close()
            st.success(f"Lab Test ID {test_id} deleted successfully.")
        except Exception as e:
            st.error(f"Error: {e}")
