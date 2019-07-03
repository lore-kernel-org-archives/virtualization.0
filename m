From: Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v2 06/35] crypto: Use kmemdup rather than duplicating its
	implementation
Date: Thu,  4 Jul 2019 00:27:08 +0800
Message-ID: <20190703162708.32137-1-huangfq.daxian__17173.2454140269$1563995295$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: Aymen Sghaier <aymen.sghaier@nxp.com>, Herbert Xu <herbert@gondor.apana.org.au>, =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>, "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-crypto@vger.kernel.org, Fuqian Huang <huangfq.daxian@gmail.com>, "David S . Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

kmemdup is introduced to duplicate a region of memory in a neat way.
Rather than kmalloc/kzalloc + memcpy, which the programmer needs to
write the size twice (sometimes lead to mistakes), kmemdup improves
readability, leads to smaller code and also reduce the chances of mistakes.
Suggestion to use kmemdup rather than using kmalloc/kzalloc + memcpy.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v2:
  - Fix a typo in commit message (memset -> memcpy)

 drivers/crypto/caam/caampkc.c              | 11 +++--------
 drivers/crypto/virtio/virtio_crypto_algs.c |  4 +---
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/crypto/caam/caampkc.c b/drivers/crypto/caam/caampkc.c
index fe24485274e1..a03464b4c019 100644
--- a/drivers/crypto/caam/caampkc.c
+++ b/drivers/crypto/caam/caampkc.c
@@ -816,7 +816,7 @@ static int caam_rsa_set_pub_key(struct crypto_akcipher *tfm, const void *key,
 		return ret;
 
 	/* Copy key in DMA zone */
-	rsa_key->e = kzalloc(raw_key.e_sz, GFP_DMA | GFP_KERNEL);
+	rsa_key->e = kmemdup(raw_key.e, raw_key.e_sz, GFP_DMA | GFP_KERNEL);
 	if (!rsa_key->e)
 		goto err;
 
@@ -838,8 +838,6 @@ static int caam_rsa_set_pub_key(struct crypto_akcipher *tfm, const void *key,
 	rsa_key->e_sz = raw_key.e_sz;
 	rsa_key->n_sz = raw_key.n_sz;
 
-	memcpy(rsa_key->e, raw_key.e, raw_key.e_sz);
-
 	return 0;
 err:
 	caam_rsa_free_key(rsa_key);
@@ -920,11 +918,11 @@ static int caam_rsa_set_priv_key(struct crypto_akcipher *tfm, const void *key,
 		return ret;
 
 	/* Copy key in DMA zone */
-	rsa_key->d = kzalloc(raw_key.d_sz, GFP_DMA | GFP_KERNEL);
+	rsa_key->d = kmemdup(raw_key.d, raw_key.d_sz, GFP_DMA | GFP_KERNEL);
 	if (!rsa_key->d)
 		goto err;
 
-	rsa_key->e = kzalloc(raw_key.e_sz, GFP_DMA | GFP_KERNEL);
+	rsa_key->e = kmemdup(raw_key.e, raw_key.e_sz, GFP_DMA | GFP_KERNEL);
 	if (!rsa_key->e)
 		goto err;
 
@@ -947,9 +945,6 @@ static int caam_rsa_set_priv_key(struct crypto_akcipher *tfm, const void *key,
 	rsa_key->e_sz = raw_key.e_sz;
 	rsa_key->n_sz = raw_key.n_sz;
 
-	memcpy(rsa_key->d, raw_key.d, raw_key.d_sz);
-	memcpy(rsa_key->e, raw_key.e, raw_key.e_sz);
-
 	caam_rsa_set_priv_key_form(ctx, &raw_key);
 
 	return 0;
diff --git a/drivers/crypto/virtio/virtio_crypto_algs.c b/drivers/crypto/virtio/virtio_crypto_algs.c
index 10f266d462d6..42d19205166b 100644
--- a/drivers/crypto/virtio/virtio_crypto_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_algs.c
@@ -129,13 +129,11 @@ static int virtio_crypto_alg_ablkcipher_init_session(
 	 * Avoid to do DMA from the stack, switch to using
 	 * dynamically-allocated for the key
 	 */
-	uint8_t *cipher_key = kmalloc(keylen, GFP_ATOMIC);
+	uint8_t *cipher_key = kmemdup(key, keylen, GFP_ATOMIC);
 
 	if (!cipher_key)
 		return -ENOMEM;
 
-	memcpy(cipher_key, key, keylen);
-
 	spin_lock(&vcrypto->ctrl_lock);
 	/* Pad ctrl header */
 	vcrypto->ctrl.header.opcode =
-- 
2.11.0
