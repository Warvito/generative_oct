""" Script to create train, validation and test data lists with paths to images and radiological reports. """
import argparse
from pathlib import Path

import pandas as pd


def parse_args():
    parser = argparse.ArgumentParser()

    parser.add_argument("--metadata_path", help="Path to CSAW-M_train.csv file.")
    parser.add_argument("--output_dir", help="Path to directory to save files with paths.")

    args = parser.parse_args()
    return args


def main(args):
    metadata_df = pd.read_csv(args.metadata_path, sep=";", na_values="-")

    data_list = []
    for index, row in metadata_df.iterrows():

        if int(row["Label"]) <= 2:
            sentence = "Low masking level"
        elif int(row["Label"]) <= 6:
            sentence = "Medium masking level"
        else:
            sentence = "High masking level"

        data_list.append(
            {
                "image": f"/data/images/preprocessed/train/{row['Filename']}",
                "report": sentence,
            }
        )

    data_df = pd.DataFrame(data_list)
    data_df = data_df.sample(frac=1, random_state=42).reset_index(drop=True)

    train_data_list = data_df[:9000]
    val_data_list = data_df[9000:]

    # save the data lists
    output_dir = Path(args.output_dir)
    train_data_list.to_csv(output_dir / "train.tsv", index=False, sep="\t")
    val_data_list.to_csv(output_dir / "validation.tsv", index=False, sep="\t")


if __name__ == "__main__":
    args = parse_args()
    main(args)
