<?php

namespace App\Entity;

use App\Repository\ActividadRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: ActividadRepository::class)]
class Actividad
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    private ?string $nombre = null;

    /**
     * @var Collection<int, Clase>
     */
    #[ORM\OneToMany(targetEntity: Clase::class, mappedBy: 'actividad')]
    private Collection $clases;

    public function __construct()
    {
        $this->clases = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getNombre(): ?string
    {
        return $this->nombre;
    }

    public function setNombre(string $nombre): static
    {
        $this->nombre = $nombre;

        return $this;
    }

    /**
     * @return Collection<int, Clase>
     */
    public function getClases(): Collection
    {
        return $this->clases;
    }

    public function addClase(Clase $clase): static
    {
        if (!$this->clases->contains($clase)) {
            $this->clases->add($clase);
            $clase->setActividad($this);
        }

        return $this;
    }

    public function removeClase(Clase $clase): static
    {
        if ($this->clases->removeElement($clase)) {
            // set the owning side to null (unless already changed)
            if ($clase->getActividad() === $this) {
                $clase->setActividad(null);
            }
        }

        return $this;
    }
}
