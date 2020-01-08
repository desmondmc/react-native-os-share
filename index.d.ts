export default class OsShare {
  static share: (options: { url: string }) => Promise<void>;
}