# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_02_15_172632) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "auths", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.index ["email"], name: "index_auths_on_email", unique: true
    t.index ["reset_password_token"], name: "index_auths_on_reset_password_token", unique: true
  end

  create_table "card_comments", force: :cascade do |t|
    t.string "text"
    t.bigint "card_id", null: false
    t.bigint "auth_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["auth_id"], name: "index_card_comments_on_auth_id"
    t.index ["card_id"], name: "index_card_comments_on_card_id"
  end

  create_table "cards", force: :cascade do |t|
    t.string "title"
    t.string "content"
    t.integer "position"
    t.bigint "kanban_column_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["kanban_column_id"], name: "index_cards_on_kanban_column_id"
  end

  create_table "kanban_assignees", id: false, force: :cascade do |t|
    t.bigint "kanban_id", null: false
    t.bigint "profile_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["kanban_id", "profile_id"], name: "index_kanban_assignees_on_kanban_id_and_profile_id"
  end

  create_table "kanban_columns", force: :cascade do |t|
    t.string "name"
    t.bigint "kanban_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["kanban_id"], name: "index_kanban_columns_on_kanban_id"
  end

  create_table "kanbans", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.jsonb "cards"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "author_id"
    t.index ["author_id"], name: "index_kanbans_on_author_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.bigint "auth_id"
    t.string "name"
    t.string "username"
    t.string "position"
    t.string "skills", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["auth_id"], name: "index_profiles_on_auth_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "card_comments", "auths"
  add_foreign_key "card_comments", "cards"
  add_foreign_key "cards", "kanban_columns"
  add_foreign_key "kanban_columns", "kanbans"
  add_foreign_key "kanbans", "profiles", column: "author_id"
end
