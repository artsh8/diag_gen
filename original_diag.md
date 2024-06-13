```mermaid
erDiagram
 address { id int8 gar uuid no_gar varchar }
 customer { id int8 person_id int8 }
 customer_order { id int8 customer_id int8 employee_id int8 order_items jsonb created_at timestamp updated_at timestamp }
 employee { id int8 person_id int8 }
 person { id int8 user_id int8 first_name text last_name text full_name tsvector }
 person_address { id int8 person_id int8 address_id int8 }
 product { id int8 code uuid name varchar }
 user_t { id int8 login varchar main_email varchar is_del bool extra jsonb }
 
 customer }o--|| person : ""
 customer_order }o--|| product : ""
 customer_order }o--|| customer : ""
 customer_order }o--|| employee : ""
 employee }o--|| person : ""
 person }o--|| user_t : ""
 person_address }o--|| address : ""
 person_address }o--|| person : ""