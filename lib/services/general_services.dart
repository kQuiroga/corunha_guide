class GeneralServices {
  changeCategoryName(String category) {
    if (category.toLowerCase() == 'monumentos') {
      return 'listado_monumentos';
    }

    if (category.toLowerCase() == 'restaurantes') {
      return 'listado_restaurantes';
    }

    if (category.toLowerCase() == 'playas') {
      return 'listado_playas';
    }

    if (category.toLowerCase() == 'museos') {
      return 'listado_museos';
    }
  }
}
