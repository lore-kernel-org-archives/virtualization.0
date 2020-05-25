From: "Longpeng(Mike)" <longpeng2@huawei.com>
Subject: [PATCH 2/2] crypto: virtio: fix an memory use-after-free bug
Date: Mon, 25 May 2020 08:56:27 +0800
Message-ID: <20200525005627.707-3-longpeng2@huawei.com>
References: <20200525005627.707-1-longpeng2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-crypto-owner@vger.kernel.org>
In-Reply-To: <20200525005627.707-1-longpeng2@huawei.com>
Sender: linux-crypto-owner@vger.kernel.org
To: linux-crypto@vger.kernel.org
Cc: "Longpeng(Mike)" <longpeng2@huawei.com>, Gonglei <arei.gonglei@huawei.com>, Herbert Xu <herbert@gondor.apana.org.au>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, LABBE Corentin <clabbe@baylibre.com>
List-Id: virtualization@lists.linuxfoundation.org

The system'll crash when we insmod crypto/tcrypto.ko with mode=155.

After dig into this case, I find it's caused by reuse the request
memory.

In crypto_authenc_init_tfm, we'll set the reqsize to:
  [PART 1]sizeof(authenc_request_ctx) +
  [PART 2]ictx->reqoff +
  [PART 3]MAX(ahash part, skcipher part)
and the 'PART 3' will be used by both ahash and skcipher.

When virtio_crypto driver finish skcipher req, it'll call ->complete
callback(in crypto_finalize_skcipher_request) and then free its
resources which pointers are recorded in 'skcipher parts'.

However, the ->complete is 'crypto_authenc_encrypt_done' in this case,
it will use the 'ahash part' of the request and change its content,
so virtio_crypto driver will get the wrong pointer after ->complete
finish and mistakenly free some other memory. So the system will crash
at last when this memory be used again.

We can free the resources before calling ->complete to fix this issue.

Cc: Gonglei <arei.gonglei@huawei.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>                                                                                                                                                                      
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: virtualization@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org

Reported-by: LABBE Corentin <clabbe@baylibre.com>
Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 drivers/crypto/virtio/virtio_crypto_algs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_algs.c b/drivers/crypto/virtio/virtio_crypto_algs.c
index 2fa1129f96d6..3800356fb764 100644
--- a/drivers/crypto/virtio/virtio_crypto_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_algs.c
@@ -587,10 +587,11 @@ static void virtio_crypto_skcipher_finalize_req(
 		scatterwalk_map_and_copy(req->iv, req->dst,
 					 req->cryptlen - AES_BLOCK_SIZE,
 					 AES_BLOCK_SIZE, 0);
-	crypto_finalize_skcipher_request(vc_sym_req->base.dataq->engine,
-					   req, err);
 	kzfree(vc_sym_req->iv);
 	virtcrypto_clear_request(&vc_sym_req->base);
+
+	crypto_finalize_skcipher_request(vc_sym_req->base.dataq->engine,
+					   req, err);
 }
 
 static struct virtio_crypto_algo virtio_crypto_algs[] = { {
-- 
2.17.1
