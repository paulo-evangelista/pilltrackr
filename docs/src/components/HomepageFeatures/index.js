import clsx from 'clsx';
import Heading from '@theme/Heading';
import styles from './styles.module.css';
import img1 from '@site/static/img/img-1.webp';
import img2 from '@site/static/img/img-2.webp';
import img3 from '@site/static/img/img-3.webp';


const FeatureList = [
  {
    title: 'Simplicidade na Utilização',
    Svg: () => (
      <img src={img1} alt="Descrição da imagem" style={{ width: '30%', height: 'auto' }} />
    ),
    description: (
      <>
        Nosso aplicativo foi desenvolvido para ser fácil de usar, permitindo que
        você gerencie os medicamentos do hospital de maneira eficiente e intuitiva.
      </>
    ),
  },
  {
    title: 'Foque no que é Importante',
    Svg: () => (
      <img src={img2} alt="Descrição da imagem" style={{ width: '30%', height: 'auto' }} />
    ),
    description: (
      <>
        Nosso sistema permite que você foque no gerenciamento eficaz do estoque, enquanto
        cuidamos da complexidade. Simplifique as operações do dia a dia e ganhe agilidade.
      </>
    ),
  },
  {
    title: 'Segurança e Confiabilidade',
    Svg: () => (
      <img src={img3} alt="Descrição da imagem" style={{ width: '30%', height: 'auto' }} />
    ),
    description: (
      <>
        Garanta a segurança e a confiabilidade dos dados do estoque com nosso sistema,
        projetado para atender as exigências do setor de saúde.
      </>
    ),
  },
];

function Feature({Svg, title, description}) {
  return (
    <div className={clsx('col col--4')}>
      <div className="text--center">
        <Svg className={styles.featureSvg} role="img" />
      </div>
      <div className="text--center padding-horiz--md">
        <Heading as="h3">{title}</Heading>
        <p>{description}</p>
      </div>
    </div>
  );
}

export default function HomepageFeatures() {
  return (
    <section className={styles.features}>
      <div className="container">
        <div className="row">
          {FeatureList.map((props, idx) => (
            <Feature key={idx} {...props} />
          ))}
        </div>
      </div>
    </section>
  );
}
