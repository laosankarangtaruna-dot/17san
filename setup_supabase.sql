-- Jalankan script ini di Supabase Dashboard > SQL Editor, lalu klik "Run".
-- Pastikan Anda sudah login ke project: tsbzxrszzdfwunopityg

-- 1) Buat tabel penyimpanan data tunggal (key-value JSON)
create table if not exists public.lomba_data (
  id text primary key,
  payload jsonb not null,
  updated_at timestamptz default now()
);

-- 2) Aktifkan Row Level Security
alter table public.lomba_data enable row level security;

-- 3) Izinkan akses penuh untuk anon key (sesuai kebutuhan app ini).
--    CATATAN KEAMANAN: siapa saja dengan URL bisa membaca/menulis baris ini.
--    Cocok untuk app internal/kecil. Jika ingin lebih aman, ganti policy.
drop policy if exists "allow_anon_all" on public.lomba_data;
create policy "allow_anon_all"
  on public.lomba_data
  for all
  to anon
  using (true)
  with check (true);

-- 4) (Opsional) izin untuk role authenticated juga
drop policy if exists "allow_auth_all" on public.lomba_data;
create policy "allow_auth_all"
  on public.lomba_data
  for all
  to authenticated
  using (true)
  with check (true);
