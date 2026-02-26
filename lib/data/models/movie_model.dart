import 'package:flutter/material.dart';

class Movie {
  final String id;
  final String title;
  final String genre;
  final String duration;
  final String rating;
  final String synopsis;
  final String imageUrl;
  final double score;
  final bool isNew;

  const Movie({
    required this.id,
    required this.title,
    required this.genre,
    required this.duration,
    required this.rating,
    required this.synopsis,
    required this.imageUrl,
    required this.score,
    this.isNew = false,
  });
}

final List<Movie> mockMovies = [
  const Movie(
    id: '1',
    title: 'Interstellar',
    genre: 'Sci-Fi',
    duration: '2h 49min',
    rating: 'PG-13',
    synopsis: 'Un grupo de exploradores viaja a través de un agujero de gusano en el espacio en un intento de garantizar la supervivencia de la humanidad.',
    imageUrl: 'assets/images/interstellar.jpg',
    score: 8.7,
  ),
  const Movie(
    id: '2',
    title: 'Dune: Part Two',
    genre: 'Sci-Fi',
    duration: '2h 46min',
    rating: 'PG-13',
    synopsis: 'Paul Atreides se une a Chani y los Fremen en una guerra de venganza contra los conspiradores que destruyeron a su familia.',
    imageUrl: 'assets/images/dune2.jpg',
    score: 8.5,
    isNew: true,
  ),
  const Movie(
    id: '3',
    title: 'Oppenheimer',
    genre: 'Drama',
    duration: '3h 00min',
    rating: 'R',
    synopsis: 'La historia del físico J. Robert Oppenheimer y su papel en el desarrollo de la bomba atómica.',
    imageUrl: 'assets/images/oppenheimer.jpg',
    score: 8.9,
  ),
  const Movie(
    id: '4',
    title: 'The Batman',
    genre: 'Acción',
    duration: '2h 56min',
    rating: 'PG-13',
    synopsis: 'Batman se adentra en Gotham para desenmascarar a un asesino en serie conocido como el Acertijo.',
    imageUrl: 'assets/images/batman.jpg',
    score: 7.8,
  ),
  const Movie(
    id: '5',
    title: 'Avatar 2',
    genre: 'Aventura',
    duration: '3h 12min',
    rating: 'PG-13',
    synopsis: 'Jake Sully y Neytiri deben abandonar su hogar y explorar las regiones de Pandora.',
    imageUrl: 'assets/images/avatar.jpg',
    score: 7.6,
  ),
  const Movie(
    id: '6',
    title: 'Deadpool & Wolverine',
    genre: 'Acción',
    duration: '2h 8min',
    rating: 'R',
    synopsis: 'Deadpool viaja al multiverso donde encontrará a un Wolverine muy diferente al que conocemos.',
    imageUrl: 'assets/images/deadpool.jpg',
    score: 7.9,
    isNew: true,
  ),
];
