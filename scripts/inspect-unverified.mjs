import fs from 'fs';
import path from 'path';

const filePath = path.join(process.cwd(), 'src', 'lib', 'data', 'special-days-data.ts');
const fileContent = fs.readFileSync(filePath, 'utf8');

const match = fileContent.match(/export const INITIAL_SPECIAL_DAYS: SpecialDay\[\] = (\[[\s\S]*\]);/);
if (!match) {
  console.error("Could not find INITIAL_SPECIAL_DAYS array in file");
  process.exit(1);
}

const list = JSON.parse(match[1]);
console.log('Total items:', list.length);
const unverified = list.filter(d => d.editorial_status !== 'verified');
console.log('Unverified count:', unverified.length);

const categories = {};
unverified.forEach(d => {
  categories[d.category] = (categories[d.category] || 0) + 1;
});
console.log('\nUnverified breakdown by category:', categories);

console.log('\nFirst 30 unverified:');
unverified.slice(0, 30).forEach(d => {
  console.log(`- [${d.slug}] ${d.title} (${d.day_no}/${d.month_no}) [${d.category}]`);
});
