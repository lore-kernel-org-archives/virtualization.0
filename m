From: "Longpeng(Mike)" <longpeng2@huawei.com>
Subject: [PATCH v3 3/3] crypto: virtio: Fix dest length calculation in __virtio_crypto_skcipher_do_req()
Date: Tue, 2 Jun 2020 15:05:01 +0800
Message-ID: <20200602070501.2023-4-longpeng2@huawei.com>
References: <20200602070501.2023-1-longpeng2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200602070501.2023-1-longpeng2@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-crypto@vger.kernel.org
Cc: "Longpeng(Mike)" <longpeng2@huawei.com>, Gonglei <arei.gonglei@huawei.com>, Herbert Xu <herbert@gondor.apana.org.au>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

The src/dst length is not aligned with AES_BLOCK_SIZE(which is 16) in some
testcases in tcrypto.ko.

For example, the src/dst length of one of cts(cbc(aes))'s testcase is 17, the
crypto_virtio driver will set @src_data_len=16 but @dst_data_len=17 in this
case and get a wrong at then end.

  SRC: pp pp pp pp pp pp pp pp pp pp pp pp pp pp pp pp pp (17 bytes)
  EXP: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc pp (17 bytes)
  DST: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 00 (pollute the last bytes)
  (pp: plaintext  cc:ciphertext)

Fix this issue by limit the length of dest buffer.

Fixes: dbaf0624ffa5 ("crypto: add virtio-crypto driver")
Cc: Gonglei <arei.gonglei@huawei.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: virtualization@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 drivers/crypto/virtio/virtio_crypto_algs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/virtio/virtio_crypto_algs.c b/drivers/crypto/virtio/virtio_crypto_algs.c
index 52261b6..cb8a6ea 100644
--- a/drivers/crypto/virtio/virtio_crypto_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_algs.c
@@ -407,6 +407,7 @@ static int virtio_crypto_skcipher_setkey(struct crypto_skcipher *tfm,
 		goto free;
 	}
 
+	dst_len = min_t(unsigned int, req->cryptlen, dst_len);
 	pr_debug("virtio_crypto: src_len: %u, dst_len: %llu\n",
 			req->cryptlen, dst_len);
 
-- 
1.8.3.1
