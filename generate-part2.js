const XLSX = require('xlsx');
const fs = require('fs');

const file = 'Part 2 Quiz2. Data Preparation and Visualization/Part2Quiz_Montoya.Shane Emmanuel.xlsx';
const wb = XLSX.readFile(file);
const ws = wb.Sheets[wb.SheetNames[0]];
const rows = XLSX.utils.sheet_to_json(ws, { header: 1, raw: false, defval: '' });

const lines = rows.map((r) => r.map((v) => String(v).replace(/\t/g, ' ')).join('\t'));
const text = lines.join('\n').replace(/`/g, '\\`');

const out = `window.PART2_RAW_DATA = \`${text}\`;
window.PART2_ROW_COUNT = ${rows.length - 1};
`;

fs.writeFileSync('part2-raw-data.js', out, 'utf8');
console.log('rows', rows.length - 1);
