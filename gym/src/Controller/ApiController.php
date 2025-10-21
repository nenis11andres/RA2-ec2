<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use App\Entity\Reserva;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\JsonResponse;


final class ApiController extends AbstractController
{
#[Route('/public/reservas?usuario={id}', name: 'public_reservas', methods: ['GET'])]
    public function reservasTotales(EntityManagerInterface $em): JsonResponse
    {
        $reservas = $em->getRepository(Reserva::class)->findAll();

        $result = [];
        foreach ($reservas as $reserva) {
            $result[] = [
                'id' => $reserva->getClase(),
                 // Asegúrate de llamar el método correctamente
            ];
        }

        return new JsonResponse($result);
    }
}