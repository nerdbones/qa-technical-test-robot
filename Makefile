install:
	python -m pip install --upgrade pip
	pip install -r requirements.txt
	rfbrowser init

test-qa1:
	robot -d results/web/QA1 -v ENV:QA1 tests/web

test-qa2:
	robot -d results/web/QA2 -v ENV:QA2 tests/web

test-qa3:
	robot -d results/web/QA3 -v ENV:QA3 tests/web

test-all:
	bash scripts/run_web_all_envs.sh

mobile-qa1:
	robot -d results/mobile/QA1 -v ENV:QA1 tests/mobile

mobile-qa2:
	robot -d results/mobile/QA2 -v ENV:QA2 tests/mobile

mobile-qa3:
	robot -d results/mobile/QA3 -v ENV:QA3 tests/mobile
