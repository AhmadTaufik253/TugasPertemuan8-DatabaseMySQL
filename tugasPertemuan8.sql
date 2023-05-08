
CREATE TRIGGER transaksi_pembayaran
AFTER INSERT ON pembayaran
FOR EACH ROW
BEGIN
  DECLARE jumlah_bayar INT;
  SELECT jumlah INTO jumlah_bayar FROM pembayaran WHERE pesanan_id = NEW.pesanan_id;
  IF jumlah_bayar >= (SELECT total FROM pesanan WHERE id = NEW.pesanan_id) THEN
    UPDATE pembayaran SET status_pembayaran = 'lunas' WHERE id = NEW.pesanan_id;
  ELSE
    UPDATE pembayaran SET status_pembayaran = 'belum lunas' WHERE ID = NEW.pesanan_id;
  END IF;
END;

