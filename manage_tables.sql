-- manage_tables.sql has the suspects, security_footage, and lab_results tables populated with data

const { error } = await supabase
  .from('suspects')
  .insert([
    { letter: "t", name: 'Srikriti', alibi_location: 'Grainger Library', alibi_time: '19:00:00', alibi_statement: 'I was studying on the third floor in Grainger.', has_alibi: true },
    { letter: "l", name: 'Eshita', alibi_location: 'CIF', alibi_time: '19:00:00', alibi_statement: 'I was in the CIF studying for an exam.', has_alibi: true },
    { letter: "g", name: 'Rohan', alibi_location: 'Illini Union Bowling Alley', alibi_time: '19:00:00', alibi_statement: 'I was bowling at the Union with my roommate.', has_alibi: true },
    { letter: "i", name: 'Anish', alibi_location: 'Oozu Ramen', alibi_time: '19:00:00', alibi_statement: 'I was getting ramen at Oozu with a friend.', has_alibi: true },
    { letter: "u", name: 'Sahana', alibi_location: 'ARC', alibi_time: '19:00:00', alibi_statement: 'I was working out in the ARC.', has_alibi: true },
    { letter: "y", name: 'Daniel', alibi_location: 'Main Quad', alibi_time: '19:00:00', alibi_statement: 'I was on the main quad with my friends.', has_alibi: true },
    { letter: "g", name: 'Srikriti', alibi_location: 'Six-Pack', alibi_time: '19:00:00', alibi_statement: 'I walked to the Six-Pack to see my friend in FAR', has_alibi: true }
  ])


const { error } = await supabase
  .from('security_footage')
  .insert([
    { location: 'Grainger Library', time_seen: '19:00:00', activity: 'Building closed for cleaning — no students present.' },
    { location: 'Oozu Ramen', time_seen: '19:00:00', activity: 'Confirmed customer matching description, seated with a friend.' },
    { location: 'Illini Union Bowling Alley', time_seen: '19:00:00', activity: 'Lanes closed for maintenance all evening.' },
    { location: 'CIF', time_seen: '19:00:00', activity: 'Confirmed student studying on fourth floor.' },
    { location: 'Main Quad', time_seen: '19:00:00', activity: 'Empty — sprinklers running, no foot traffic.' },
    { location: 'ARC', time_seen: '19:00:00', activity: 'Confirmed member checked in, seen on cardio floor.' }
  ])

const { error } = await supabase
  .from('polygraph_results')
  .insert([
    { name: 'Rohan', polygraph_result: 'Passed' },
    { name: 'Srikriti', polygraph_result: 'Inconclusive' },
    { name: 'Daniel', polygraph_result: 'Passed' },
  ])


const { error } = await supabase
  .from('envelope')
  .insert({ id: 1, is_locked: true, submitted_code: null })