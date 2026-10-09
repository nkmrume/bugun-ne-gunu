import fs from 'fs';

const items = JSON.parse(fs.readFileSync('scripts/unverified-inventory.json', 'utf8'));

for (let m = 1; m <= 12; m++) {
  const monthItems = items.filter(i => i.month === m);
  console.log(`=== AY ${m} (${monthItems.length} kayıt) ===`);
  monthItems.forEach(i => console.log(`  ${i.day}.${i.month}: [${i.slug}] ${i.title} (${i.category})`));
}
