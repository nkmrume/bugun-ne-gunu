import fs from 'fs';
import path from 'path';

const filePath = path.join(process.cwd(), 'src', 'lib', 'data', 'special-days-data.ts');
const fileContent = fs.readFileSync(filePath, 'utf8');

const match = fileContent.match(/export const INITIAL_SPECIAL_DAYS: SpecialDay\[\] = (\[[\s\S]*\]);/);
const list = JSON.parse(match[1]);

console.log("Analyzing 351 items...");
const unverified = list.filter(d => d.editorial_status !== 'verified');

const results = unverified.map(d => ({
  slug: d.slug,
  title: d.title,
  month: d.month_no,
  day: d.day_no,
  category: d.category,
  day_type: d.day_type
}));

fs.writeFileSync('scripts/unverified-inventory.json', JSON.stringify(results, null, 2), 'utf8');
console.log(`Saved ${results.length} unverified items to scripts/unverified-inventory.json`);
