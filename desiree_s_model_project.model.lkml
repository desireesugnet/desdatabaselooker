connection: "thelook"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

datagroup: desiree_s_model_project_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "4 hours"
}

persist_with: desiree_s_model_project_default_datagroup

explore: order_items {
  always_filter: {
    filters: {
      field: user_data.id
      value: "null"
    }
  }
  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
  join: user_data {
    type: left_outer
    sql_on: ${order_items.order_id}= ${user_data.id} ;;
    relationship: many_to_one
  }
  join: schema_migrations {
    type: left_outer
    sql_on: ${order_items.order_id}= ${schema_migrations.filename} ;;
    relationship: many_to_many
  }
}

explore: orders {
  view_label: "Orders Based on Users"
  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: products {}

explore: schema_migrations {}

explore: user_data {
  join: users {
    type: left_outer
    sql_on: ${user_data.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}
