## Integration Design Decisions

During the integration process, the two database systems were merged into one unified and more normalized system for managing volunteer emergency assistance calls in the Yedidim organization.

The main goal of the integration was to preserve important information from both systems while reducing duplication, inconsistencies, and unnecessary complexity.

### Unifying Request and Call

One of the main changes was merging the `Request` and `Call` entities into a single entity named `Call`.

Both entities represented the same real-world action — opening an assistance request — therefore they were unified into one central entity in the integrated system.

---

### Renaming Entities and Attributes

Several entity and attribute names were changed to improve clarity and professionalism.

For example:
- `Family` was renamed to `Caller`
- `family_id` → `caller_id`
- `family_name` → `caller_name`
- `phone` → `phone_number`

This decision was made because the system handles any caller and not only families.

---

### Keeping Status as a Separate Entity

The `Status` entity was kept as a separate entity instead of being stored directly as an attribute inside `Call`.

This design allows multiple calls to share the same status values such as:
- Open
- Closed
- InProgress

The decision improves normalization and enables centralized management of statuses.

Each call has one status, while each status can belong to many calls.

---

### Location Entity Design

A major difference between the two systems involved location management.

In one system, location data appeared as attributes inside the call entity, while in the other system there was a separate `Location` entity.

After evaluation, it was decided to keep `Location` as an independent entity because location information may be complex and reusable across multiple parts of the system.

The entity includes:
- Address
- Longitude
- Latitude
- Location notes

In addition, a relationship between `Volunteer` and `Location` was preserved in order to represent the volunteer’s real-time current location.

This decision was important because the volunteer’s city only represents their residence location, while the system also needs to know the volunteer’s current position in order to dispatch the closest available volunteer to a call.

---

### Skills and Call Types

The relationship between `Skill` and `Call_Type` was preserved instead of connecting skills directly to `Call`.

This decision was made because required skills depend on the general type of the call rather than on a specific individual call.

For example:
- A flat tire assistance call always requires a certain skill regardless of the specific situation.

Special requirements for a specific call, such as requiring an English-speaking volunteer, are stored inside the call description itself.

---

### Availability Management

The `Availability` entity was preserved in order to represent planned and fixed volunteer availability according to:
- Days
- Hours
- Areas

At the same time, the `availability_status` attribute inside `Volunteer` was also preserved in order to represent the volunteer’s immediate real-time availability.

This separation allows the system to distinguish between scheduled availability and the volunteer’s current active status.

---

### Removing Unnecessary Entities

Entities such as `Delivery` and `Treatment` were removed from the integrated design.

These entities were not considered essential to the core functionality of the system and added unnecessary complexity to the database structure.

The final integrated system focuses on creating a clear, efficient, and well-structured database for managing volunteers and emergency assistance calls while preserving the important information from both original systems.
