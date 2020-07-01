From: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] crypto: virtio - constify features[] and id_table[]
Date: Wed,  1 Jul 2020 22:29:36 +0200
Message-ID: <20200701202936.44156-1-rikard.falkeborn@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-crypto-owner@vger.kernel.org>
Sender: linux-crypto-owner@vger.kernel.org
Cc: mst@redhat.com, jasowang@redhat.com, arei.gonglei@huawei.com, herbert@gondor.apana.org.au, davem@davemloft.net, virtualization@lists.linux-foundation.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, Rikard Falkeborn <rikard.falkeborn@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

features[] and id_table[] are not modified and can be made const to
allow the compiler to put them in read-only memory.

Before:
   text    data     bss     dec     hex filename
  11534    2056     160   13750    35b6 drivers/crypto/virtio/virtio_crypto_core.o

After:
   text    data     bss     dec     hex filename
  11630    1992     128   13750    35b6 drivers/crypto/virtio/virtio_crypto_core.o

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/crypto/virtio/virtio_crypto_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
index ba8a19c72391..0c66d6193ca2 100644
--- a/drivers/crypto/virtio/virtio_crypto_core.c
+++ b/drivers/crypto/virtio/virtio_crypto_core.c
@@ -498,11 +498,11 @@ static int virtcrypto_restore(struct virtio_device *vdev)
 }
 #endif
 
-static unsigned int features[] = {
+static const unsigned int features[] = {
 	/* none */
 };
 
-static struct virtio_device_id id_table[] = {
+static const struct virtio_device_id id_table[] = {
 	{ VIRTIO_ID_CRYPTO, VIRTIO_DEV_ANY_ID },
 	{ 0 },
 };
-- 
2.27.0
