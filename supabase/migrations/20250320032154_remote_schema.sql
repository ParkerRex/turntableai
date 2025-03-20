

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


CREATE EXTENSION IF NOT EXISTS "pgsodium" WITH SCHEMA "pgsodium";






COMMENT ON SCHEMA "public" IS 'standard public schema';



CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";






CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgjwt" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";






CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";






CREATE TYPE "public"."vote_type" AS ENUM (
    'awesome',
    'lame'
);


ALTER TYPE "public"."vote_type" OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "public"."avatars" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "name" "text" NOT NULL,
    "image_url" "text" NOT NULL,
    "points_required" integer DEFAULT 0
);


ALTER TABLE "public"."avatars" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."chat_messages" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "room_id" "uuid",
    "user_id" "uuid",
    "content" "text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."chat_messages" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."point_events" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid",
    "points" integer NOT NULL,
    "reason" "text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."point_events" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."queue_entries" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "room_id" "uuid",
    "song_id" "uuid",
    "position" integer NOT NULL,
    "added_by_id" "uuid",
    "added_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."queue_entries" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."room_djs" (
    "room_id" "uuid" NOT NULL,
    "user_id" "uuid" NOT NULL
);


ALTER TABLE "public"."room_djs" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."room_listeners" (
    "room_id" "uuid" NOT NULL,
    "user_id" "uuid" NOT NULL
);


ALTER TABLE "public"."room_listeners" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."rooms" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "name" "text" NOT NULL,
    "genre" "text",
    "owner_id" "uuid",
    "current_song_id" "uuid",
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."rooms" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."songs" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "title" "text" NOT NULL,
    "artist" "text" NOT NULL,
    "url" "text" NOT NULL,
    "duration" integer NOT NULL,
    "uploaded_by_id" "uuid",
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."songs" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."users" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "username" "text" NOT NULL,
    "email" "text" NOT NULL,
    "password_hash" "text" NOT NULL,
    "avatar_id" "uuid",
    "points" integer DEFAULT 0,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."users" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."votes" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "room_id" "uuid",
    "song_id" "uuid",
    "user_id" "uuid",
    "vote_type" "public"."vote_type" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."votes" OWNER TO "postgres";


ALTER TABLE ONLY "public"."avatars"
    ADD CONSTRAINT "avatars_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."chat_messages"
    ADD CONSTRAINT "chat_messages_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."point_events"
    ADD CONSTRAINT "point_events_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."queue_entries"
    ADD CONSTRAINT "queue_entries_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."queue_entries"
    ADD CONSTRAINT "queue_entries_room_id_position_key" UNIQUE ("room_id", "position");



ALTER TABLE ONLY "public"."room_djs"
    ADD CONSTRAINT "room_djs_pkey" PRIMARY KEY ("room_id", "user_id");



ALTER TABLE ONLY "public"."room_listeners"
    ADD CONSTRAINT "room_listeners_pkey" PRIMARY KEY ("room_id", "user_id");



ALTER TABLE ONLY "public"."rooms"
    ADD CONSTRAINT "rooms_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."songs"
    ADD CONSTRAINT "songs_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."users"
    ADD CONSTRAINT "users_email_key" UNIQUE ("email");



ALTER TABLE ONLY "public"."users"
    ADD CONSTRAINT "users_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."users"
    ADD CONSTRAINT "users_username_key" UNIQUE ("username");



ALTER TABLE ONLY "public"."votes"
    ADD CONSTRAINT "votes_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."votes"
    ADD CONSTRAINT "votes_room_id_song_id_user_id_key" UNIQUE ("room_id", "song_id", "user_id");



CREATE INDEX "idx_chat_messages_room_id" ON "public"."chat_messages" USING "btree" ("room_id");



CREATE INDEX "idx_chat_messages_user_id" ON "public"."chat_messages" USING "btree" ("user_id");



CREATE INDEX "idx_point_events_user_id" ON "public"."point_events" USING "btree" ("user_id");



CREATE INDEX "idx_queue_entries_room_id" ON "public"."queue_entries" USING "btree" ("room_id");



CREATE INDEX "idx_queue_entries_song_id" ON "public"."queue_entries" USING "btree" ("song_id");



CREATE INDEX "idx_room_djs_room_id" ON "public"."room_djs" USING "btree" ("room_id");



CREATE INDEX "idx_room_djs_user_id" ON "public"."room_djs" USING "btree" ("user_id");



CREATE INDEX "idx_room_listeners_room_id" ON "public"."room_listeners" USING "btree" ("room_id");



CREATE INDEX "idx_room_listeners_user_id" ON "public"."room_listeners" USING "btree" ("user_id");



CREATE INDEX "idx_rooms_current_song_id" ON "public"."rooms" USING "btree" ("current_song_id");



CREATE INDEX "idx_rooms_owner_id" ON "public"."rooms" USING "btree" ("owner_id");



CREATE INDEX "idx_songs_uploaded_by_id" ON "public"."songs" USING "btree" ("uploaded_by_id");



CREATE INDEX "idx_users_avatar_id" ON "public"."users" USING "btree" ("avatar_id");



CREATE INDEX "idx_votes_room_id" ON "public"."votes" USING "btree" ("room_id");



CREATE INDEX "idx_votes_song_id" ON "public"."votes" USING "btree" ("song_id");



CREATE INDEX "idx_votes_user_id" ON "public"."votes" USING "btree" ("user_id");



ALTER TABLE ONLY "public"."chat_messages"
    ADD CONSTRAINT "chat_messages_room_id_fkey" FOREIGN KEY ("room_id") REFERENCES "public"."rooms"("id");



ALTER TABLE ONLY "public"."chat_messages"
    ADD CONSTRAINT "chat_messages_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id");



ALTER TABLE ONLY "public"."point_events"
    ADD CONSTRAINT "point_events_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id");



ALTER TABLE ONLY "public"."queue_entries"
    ADD CONSTRAINT "queue_entries_added_by_id_fkey" FOREIGN KEY ("added_by_id") REFERENCES "public"."users"("id");



ALTER TABLE ONLY "public"."queue_entries"
    ADD CONSTRAINT "queue_entries_room_id_fkey" FOREIGN KEY ("room_id") REFERENCES "public"."rooms"("id");



ALTER TABLE ONLY "public"."queue_entries"
    ADD CONSTRAINT "queue_entries_song_id_fkey" FOREIGN KEY ("song_id") REFERENCES "public"."songs"("id");



ALTER TABLE ONLY "public"."room_djs"
    ADD CONSTRAINT "room_djs_room_id_fkey" FOREIGN KEY ("room_id") REFERENCES "public"."rooms"("id");



ALTER TABLE ONLY "public"."room_djs"
    ADD CONSTRAINT "room_djs_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id");



ALTER TABLE ONLY "public"."room_listeners"
    ADD CONSTRAINT "room_listeners_room_id_fkey" FOREIGN KEY ("room_id") REFERENCES "public"."rooms"("id");



ALTER TABLE ONLY "public"."room_listeners"
    ADD CONSTRAINT "room_listeners_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id");



ALTER TABLE ONLY "public"."rooms"
    ADD CONSTRAINT "rooms_current_song_id_fkey" FOREIGN KEY ("current_song_id") REFERENCES "public"."songs"("id");



ALTER TABLE ONLY "public"."rooms"
    ADD CONSTRAINT "rooms_owner_id_fkey" FOREIGN KEY ("owner_id") REFERENCES "public"."users"("id");



ALTER TABLE ONLY "public"."songs"
    ADD CONSTRAINT "songs_uploaded_by_id_fkey" FOREIGN KEY ("uploaded_by_id") REFERENCES "public"."users"("id");



ALTER TABLE ONLY "public"."users"
    ADD CONSTRAINT "users_avatar_id_fkey" FOREIGN KEY ("avatar_id") REFERENCES "public"."avatars"("id");



ALTER TABLE ONLY "public"."votes"
    ADD CONSTRAINT "votes_room_id_fkey" FOREIGN KEY ("room_id") REFERENCES "public"."rooms"("id");



ALTER TABLE ONLY "public"."votes"
    ADD CONSTRAINT "votes_song_id_fkey" FOREIGN KEY ("song_id") REFERENCES "public"."songs"("id");



ALTER TABLE ONLY "public"."votes"
    ADD CONSTRAINT "votes_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id");



ALTER TABLE "public"."avatars" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."chat_messages" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."point_events" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."queue_entries" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."room_djs" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."room_listeners" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."rooms" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."songs" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."users" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."votes" ENABLE ROW LEVEL SECURITY;




ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";


GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";



































































































































































































GRANT ALL ON TABLE "public"."avatars" TO "anon";
GRANT ALL ON TABLE "public"."avatars" TO "authenticated";
GRANT ALL ON TABLE "public"."avatars" TO "service_role";



GRANT ALL ON TABLE "public"."chat_messages" TO "anon";
GRANT ALL ON TABLE "public"."chat_messages" TO "authenticated";
GRANT ALL ON TABLE "public"."chat_messages" TO "service_role";



GRANT ALL ON TABLE "public"."point_events" TO "anon";
GRANT ALL ON TABLE "public"."point_events" TO "authenticated";
GRANT ALL ON TABLE "public"."point_events" TO "service_role";



GRANT ALL ON TABLE "public"."queue_entries" TO "anon";
GRANT ALL ON TABLE "public"."queue_entries" TO "authenticated";
GRANT ALL ON TABLE "public"."queue_entries" TO "service_role";



GRANT ALL ON TABLE "public"."room_djs" TO "anon";
GRANT ALL ON TABLE "public"."room_djs" TO "authenticated";
GRANT ALL ON TABLE "public"."room_djs" TO "service_role";



GRANT ALL ON TABLE "public"."room_listeners" TO "anon";
GRANT ALL ON TABLE "public"."room_listeners" TO "authenticated";
GRANT ALL ON TABLE "public"."room_listeners" TO "service_role";



GRANT ALL ON TABLE "public"."rooms" TO "anon";
GRANT ALL ON TABLE "public"."rooms" TO "authenticated";
GRANT ALL ON TABLE "public"."rooms" TO "service_role";



GRANT ALL ON TABLE "public"."songs" TO "anon";
GRANT ALL ON TABLE "public"."songs" TO "authenticated";
GRANT ALL ON TABLE "public"."songs" TO "service_role";



GRANT ALL ON TABLE "public"."users" TO "anon";
GRANT ALL ON TABLE "public"."users" TO "authenticated";
GRANT ALL ON TABLE "public"."users" TO "service_role";



GRANT ALL ON TABLE "public"."votes" TO "anon";
GRANT ALL ON TABLE "public"."votes" TO "authenticated";
GRANT ALL ON TABLE "public"."votes" TO "service_role";



ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "service_role";






























RESET ALL;
