import psycopg2
import random

conn = psycopg2.connect(
    host="localhost",
    database="volunteerDB",
    user="EfratElisheva",
    password="EfratElisheva"
)

cur = conn.cursor()

# =========================
# VOLUNTEER_SKILL
# =========================
for _ in range(1000):
    volunteer_id = random.randint(1, 20)
    skill_id = random.randint(1, 15)

    cur.execute("""
        INSERT INTO VOLUNTEER_SKILL (Volunteer_ID, Skill_ID)
        VALUES (%s, %s)
        ON CONFLICT DO NOTHING
    """, (volunteer_id, skill_id))

# =========================
# VOLUNTEER_CALL
# =========================
for _ in range(1000):
    volunteer_id = random.randint(1, 20)
    call_id = random.randint(1, 20)

    cur.execute("""
        INSERT INTO VOLUNTEER_CALL (Volunteer_ID, Call_ID)
        VALUES (%s, %s)
        ON CONFLICT DO NOTHING
    """, (volunteer_id, call_id))

# =========================
# VOLUNTEER_TRAINING
# =========================
for _ in range(1000):
    training_id = random.randint(1, 15)
    volunteer_id = random.randint(1, 20)

    cur.execute("""
        INSERT INTO VOLUNTEER_TRAINING (Training_ID, Volunteer_ID)
        VALUES (%s, %s)
        ON CONFLICT DO NOTHING
    """, (training_id, volunteer_id))

conn.commit()
cur.close()
conn.close()

print("DATA INSERTED")