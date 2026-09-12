import styles from "./page.module.css";

export default function Home() {
  return (
    <main className={styles.page}>
      <h1 className={styles.title}>Mercadex</h1>
      <p className={styles.subtitle}>Painel Administrativo</p>
    </main>
  );
}
