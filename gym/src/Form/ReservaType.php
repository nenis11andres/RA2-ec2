<?php

namespace App\Form;

use App\Entity\Clase;
use App\Entity\Reserva;
use App\Entity\User;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class ReservaType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('usuario', EntityType::class, [
                'class' => User::class,
                'choice_label' => 'id',
            ])
            ->add('clase', EntityType::class, [
                'class' => Clase::class,
                'choice_label' => 'id',
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Reserva::class,
        ]);
    }
}
