import argparse
from pathlib import Path

import pandas as pd


def get_datalist_df(images_paths):
    datalist = []
    for image_path in images_paths:
        if image_path.parent.stem == "CNV":
            datalist.append(
                {
                    "image": str(image_path),
                    "report": "Choroidal Neovascularization",
                }
            )
        elif image_path.parent.stem == "DME":
            datalist.append(
                {
                    "image": str(image_path),
                    "report": "Diabetic Macular Edema",
                }
            )
        elif image_path.parent.stem == "DRUSEN":
            datalist.append(
                {
                    "image": str(image_path),
                    "report": "Drusen",
                }
            )
        elif image_path.parent.stem == "NORMAL":
            datalist.append(
                {
                    "image": str(image_path),
                    "report": "Normal retina",
                }
            )
        else:
            print(f"Unknown class: {image_path.parent.stem}")

    data_df = pd.DataFrame(datalist)
    data_df = data_df.sample(frac=1, random_state=42).reset_index(drop=True)

    return data_df



def parse_args():
    parser = argparse.ArgumentParser()

    parser.add_argument("--output_dir", help="Path to directory to save files with paths.")

    args = parser.parse_args()
    return args


def main(args):
    train_data_dir = Path("/data/train")
    train_datalist_df = get_datalist_df(list(train_data_dir.glob("**/*.jpeg")))

    val_data_dir = Path("/data/val")
    val_datalist_df = get_datalist_df(list(val_data_dir.glob("**/*.jpeg")))

    test_data_dir = Path("/data/test")
    test_datalist_df = get_datalist_df(list(test_data_dir.glob("**/*.jpeg")))

    output_dir = Path(args.output_dir)
    train_datalist_df.to_csv(output_dir / "train.tsv", index=False, sep="\t")
    val_datalist_df.to_csv(output_dir / "validation.tsv", index=False, sep="\t")
    test_datalist_df.to_csv(output_dir / "test.tsv", index=False, sep="\t")


if __name__ == "__main__":
    args = parse_args()
    main(args)
