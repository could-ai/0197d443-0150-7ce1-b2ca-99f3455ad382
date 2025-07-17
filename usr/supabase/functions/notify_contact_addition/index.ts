import { serve } from "https://deno.land/std@0.114.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js";
import "https://deno.land/x/dotenv/load.ts";

const supabaseUrl = Deno.env.get("SUPABASE_URL");
const supabaseServiceRoleKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY");
const supabaseClient = createClient(supabaseUrl, supabaseServiceRoleKey);

async function sendEmail(to, subject, body) {
  // Example using SendGrid (use actual API endpoint and parameters)
  const sendgridApiKey = Deno.env.get("SENDGRID_API_KEY");
  const response = await fetch("https://api.sendgrid.com/v3/mail/send", {
    method: "POST",
    headers: {
      "Authorization": `Bearer ${sendgridApiKey}`,
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      personalizations: [{ to: [{ email: to }] }],
      from: { email: "noreply@yourdomain.com" },
      subject: subject,
      content: [{ type: "text/plain", value: body }],
    }),
  });

  if (!response.ok) {
    console.error("Failed to send email:", response.statusText);
  }
}

serve(async (req) => {
  const { type, record } = await req.json();
  if (type === "INSERT") {
    const contactName = record.name;
    const emailSubject = "New Contact Added";
    const emailBody = `A new contact has been added: ${contactName}`;
    await sendEmail("lth@could.ai", emailSubject, emailBody);
  }
  return new Response("Email notification process completed.");
});