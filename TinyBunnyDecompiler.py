from subprocess import run
from os import path, makedirs, walk, remove
from shutil import which, rmtree
from sys import exit, executable
from tempfile import mkdtemp


ARCHIVE_PATH = r'C:\Program Files (x86)\Tiny Bunny\game\archive.rpa'
OUT_DIR = r'C:\game'


def install_tools():
    if not which('git'):
        print('[ERROR] Git not found')
        input('Press Enter to exit...')
        return

    if not which('pip'):
        print('[ERROR] Pip not found')
        input('Press Enter to exit...')
        return

    temp_dir = mkdtemp()

    try:
        rpatool_dir = path.join(temp_dir, 'RPATOOL')
        unrpyc_dir = path.join(temp_dir, 'UNRPYC')

        print('Installing rpatool...')
        result = run(['git', 'clone', 'https://github.com/RaidLite/rpatool.git', rpatool_dir])

        if result.returncode != 0:
            return

        result = run(
            [
                executable, '-m', 'pip', 'install', '.'
            ],
            cwd=rpatool_dir,
            check=False
        )

        if result.returncode != 0:
            return

        print('Installing unrpyc...')
        result = run(
            [
                'git', 'clone', 'https://github.com/CensoredUsername/unrpyc.git', unrpyc_dir
            ],
            cwd=None,
            check=False
        )

        if result.returncode != 0:
            return

        run(
            [
                executable, '-m', 'pip', 'install', '.'
            ],
            cwd=unrpyc_dir,
            check=False
        )
        print('Installation complete.')

    finally:
        rmtree(temp_dir, ignore_errors=True)

    input('Press Enter to exit...')


def decompile():
    makedirs(OUT_DIR, exist_ok=True)
    print('Extracting archive...')
    result = run([executable, '-m', 'rpatool', '-x', ARCHIVE_PATH, '-o', OUT_DIR])

    if result.returncode != 0:
        input('Press Enter to exit...')
        return

    print('Decompiling scripts...')
    result = run([executable, '-m', 'unrpyc', '-c', OUT_DIR])

    if result.returncode != 0:
        input('Press Enter to exit...')
        return

    print('Removing compiled files...')

    for root, dirs, files in walk(OUT_DIR):
        for file in files:
            if file.endswith(('.rpyc', '.rpymc')):
                try:
                    remove(path.join(root, file))
                except OSError:
                    pass

    print('Done.')
    input('Press Enter to exit...')


def main():
    while True:
        print()
        print('--- TinyBunnyDecompiler ---')
        print()
        print('1. Install tools')
        print('2. Decompile')
        print('3. Exit')
        print()

        match input('--> '):
            case '1':
                install_tools()
                exit(0)
            case '2':
                decompile()
                exit(0)
            case '3': exit(0)
            case _: print('Invalid choice!')


if __name__ == '__main__':
    main()
