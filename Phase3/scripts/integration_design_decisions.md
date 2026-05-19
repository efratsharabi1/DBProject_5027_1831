# Integration Process Summary

As part of this project, an integration process was performed between two different systems used for managing volunteer emergency assistance calls in the Yedidim organization. The goal of the integration was to create a unified, organized, and more normalized system while preserving the important information from both systems and removing redundancy and inconsistencies.

# Main Changes Performed

## Merging the Request and Call Entities

Both systems contained an entity representing an assistance request:

* One system used the entity:

  * Request
* The second system used:

  * Call

Since both entities represented the same business concept, they were merged into a single entity named:

* Call

This created one central entity responsible for managing all emergency calls in the system.

---

## Renaming the Family Entity to Caller

The original system included an entity named:

* Family

After analyzing the system requirements, it was understood that the system does not specifically manage families, but rather any person opening a call.

Therefore, the entity name was changed to:

* Caller

Additionally, the following attributes were renamed:

* Contactperson_id → caller_id
* contactperson_name → caller_name

---

## Removing number_of_members

The attribute:

* number_of_members

was removed from the Caller entity.

Reason:

* The number of family members is not essential information for a vehicle assistance system.
* The attribute did not contribute directly to call management and was therefore removed to keep the model simpler and more focused.

---

## Removing phone_number from Call

Initially, the phone number was stored inside the Call entity.

After creating the Caller entity, the attribute:

* phone_number

was removed from Call.

Reason:

* All caller information is now managed through Caller.
* Keeping the phone number in both entities would create data redundancy.

Therefore, the phone number is now stored only in:

* Caller

---

## Keeping Status as a Separate Entity

In one system, the status appeared as an attribute inside Call.
In the second system, Status existed as a separate entity.

It was decided to keep:

* Status

as an independent entity.

Reason:

* Multiple calls may share the same status.
* This improves normalization and prevents duplicate values.

The relationship created:

* Status 1 : N Call

---

## Creating a Central Location Entity

In one system, location appeared as attributes inside the call.
In the second system, Location existed as a separate entity.

It was decided to keep:

* Location

as an independent entity.

Reason:

* Location data is reused in several parts of the system.
* It supports both textual addresses and geographic coordinates.

The entity includes:

* address
* latitude
* longitude
* location_description

---

## Keeping Current Volunteer Location

A relationship between Volunteer and Location was preserved.

Purpose:

* To represent the volunteer’s current real-time location.

Reason:

* The volunteer’s city represents only their home location.
* The system must also know where the volunteer currently is in order to dispatch the closest volunteer to a call.

---

## Keeping Both Availability and availability_status

The entity:

* Availability

was preserved.

Purpose:

* To represent planned and recurring volunteer availability according to days, hours, and regions.

Additionally, the attribute:

* availability_status

was also preserved.

Purpose:

* To represent the volunteer’s current real-time availability status.

This separation allows the system to distinguish between:

* Scheduled availability
* Actual current availability

---

## Renaming Type to Call_Type

The entity:

* Type

was renamed to:

* Call_Type

Reason:

* The name Type was too generic.
* Call_Type clearly represents a type of emergency call.

---

## Connecting Skill to Call_Type

It was decided to connect:

* Skill
* Call_Type

instead of connecting Skill directly to Call.

Reason:

* Required skills depend on the type of call in general.
* For example:

  * A flat tire call requires wheel replacement skills.

Special requirements for specific calls are stored inside the call description.

---

## Removing the counter Attribute from Volunteer

The attribute:

* counter

was removed from the Volunteer entity.

Based on its context, the attribute probably represented:

* Number of handled calls
* Number of assignments
* Activity level

However:

* Its meaning was unclear.
* It is not a fundamental volunteer attribute.

Information of this type is better calculated dynamically using SQL queries rather than stored permanently.

For example:

* The number of handled calls can be calculated using SQL COUNT functions.

---

## Removing location from Training

The original system contained a location attribute inside Training.

After creating a dedicated Location entity, this attribute was removed.

Reason:

* To prevent data redundancy.
* To use one consistent Location entity throughout the system.

If necessary, Training can later be connected to Location through a relationship.

---

## Removing the Delivery and Treatment Entities

The following entities were removed:

* Delivery
* Treatment

Reason:

* These entities were not essential to the core functionality of the system.
* They added unnecessary complexity to the ERD.

The goal of the integration was to create a system that is:

* Focused
* Clear
* Easier to maintain and use

# Summary

The integration process created a unified and normalized system for managing emergency assistance calls and volunteers. During the process, overlapping entities were merged, redundant information was removed, entity and attribute names were improved, and a clearer ERD model was created to better represent the workflow of the Yedidim organization.
