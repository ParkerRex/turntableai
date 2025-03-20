set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.add_user_to_public()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
    INSERT INTO public.users (id, username, email, created_at, updated_at)
    VALUES (NEW.id, NEW.email, NEW.email, NOW(), NOW());
    RETURN NEW;
END;
$function$
;


