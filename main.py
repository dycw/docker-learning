from random import randrange  # noqa: DUO102

from bs4 import BeautifulSoup, Tag
from loguru import logger
from requests import get

# crawl IMDB Top 250 and randomly select a movie


URL = "http://www.imdb.com/chart/top"


def main() -> None:
    response = get(URL)

    soup = BeautifulSoup(response.text, "lxml")  # faster

    movietags = soup.select("td.titleColumn")
    inner_movietags = soup.select("td.titleColumn a")
    ratingtags = soup.select("td.posterColumn span[name=ir]")

    def get_year(movie_tag: Tag) -> int:
        moviesplit = movie_tag.text.split()
        year = moviesplit[-1]
        return year

    years = [get_year(tag) for tag in movietags]
    actors_list = [tag["title"] for tag in inner_movietags]
    titles = [tag.text for tag in inner_movietags]
    ratings = [float(tag["data-value"]) for tag in ratingtags]

    n_movies = len(titles)

    while True:
        idx = randrange(0, n_movies)  # noqa: DUO102, S311

        logger.info(
            f"{titles[idx]} {years[idx]}, Rating: {ratings[idx]:.1f}, "
            f"Starring: {actors_list[idx]}"
        )

        if True:
            break

        else:
            user_input = input("Do you want another movie (y/[n])? ")
            if user_input != "y":
                break


if __name__ == "__main__":
    main()
