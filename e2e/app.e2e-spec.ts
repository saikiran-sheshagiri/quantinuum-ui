import { QuantinuumUiPage } from './app.po';

describe('quantinuum-ui App', () => {
  let page: QuantinuumUiPage;

  beforeEach(() => {
    page = new QuantinuumUiPage();
  });

  it('should display message saying app works', () => {
    page.navigateTo();
    expect(page.getParagraphText()).toEqual('app works!');
  });
});
