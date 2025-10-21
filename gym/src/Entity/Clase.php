<?php

namespace App\Entity;

use App\Repository\ClaseRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: ClaseRepository::class)]
class Clase
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    private ?string $dia = null;

    #[ORM\Column]
    private ?int $hora = null;

    #[ORM\ManyToOne(inversedBy: 'clases')]
    private ?Actividad $actividad = null;

    /**
     * @var Collection<int, Reserva>
     */
    #[ORM\OneToMany(targetEntity: Reserva::class, mappedBy: 'clase')]
    private Collection $reservas;

    public function __construct()
    {
        $this->reservas = new ArrayCollection();
    }


    public function getId(): ?int
    {
        return $this->id;
    }

    public function getDia(): ?string
    {
        return $this->dia;
    }

    public function setDia(string $dia): static
    {
        $this->dia = $dia;

        return $this;
    }

    public function getHora(): ?int
    {
        return $this->hora;
    }

    public function setHora(int $hora): static
    {
        $this->hora = $hora;

        return $this;
    }

    public function getActividad(): ?Actividad
    {
        return $this->actividad;
    }

    public function setActividad(?Actividad $actividad): static
    {
        $this->actividad = $actividad;

        return $this;
    }

    /**
     * @return Collection<int, Reserva>
     */
    public function getReservas(): Collection
    {
        return $this->reservas;
    }

    public function addReserva(Reserva $reserva): static
    {
        if (!$this->reservas->contains($reserva)) {
            $this->reservas->add($reserva);
            $reserva->setClase($this);
        }

        return $this;
    }

    public function removeReserva(Reserva $reserva): static
    {
        if ($this->reservas->removeElement($reserva)) {
            // set the owning side to null (unless already changed)
            if ($reserva->getClase() === $this) {
                $reserva->setClase(null);
            }
        }

        return $this;
    }

   
}
