import OpenAI from 'https://deno.land/x/openai@v4.24.0/mod.ts'

export const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

Deno.serve(async (req) => {
  const { systemPrompt, userPrompt, returnFormat } = await req.json()
  const apiKey = Deno.env.get("OPENAI_API_KEY") || "";
  const openai = new OpenAI({
    apiKey: apiKey,
  })

  // Documentation here: https://github.com/openai/openai-node
  const chatCompletion = await openai.chat.completions.create({
    messages: [{role: 'system', content: systemPrompt},{ role: 'user', content: userPrompt }],
    // Choose model from here: https://platform.openai.com/docs/models
    model: 'gpt-4o-mini',
    stream: false,
    response_format: returnFormat
  })

  const reply = chatCompletion.choices[0].message.content

  return new Response(reply, {
    headers: { 'Content-Type': 'text/plain' },
  })
})