From: "Longpeng(Mike)" <longpeng2@huawei.com>
Subject: [PATCH v3 0/3] crypto: virtio: Fix three  issues
Date: Tue, 2 Jun 2020 15:04:58 +0800
Message-ID: <20200602070501.2023-1-longpeng2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-crypto-owner@vger.kernel.org>
Sender: linux-crypto-owner@vger.kernel.org
To: linux-crypto@vger.kernel.org
Cc: Longpeng <longpeng2@huawei.com>, Gonglei <arei.gonglei@huawei.com>, Herbert Xu <herbert@gondor.apana.org.au>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Patch 1 & 2: fix two crash issues, Link: https://lkml.org/lkml/2020/1/23/205
Patch 3: fix another functional issue

Changes since v2:
 - put another bugfix together

Changes since v1:
 - remove some redundant checks [Jason]
 - normalize the commit message [Markus]

Cc: Gonglei <arei.gonglei@huawei.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: virtualization@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org

Longpeng(Mike) (3):
  crypto: virtio: Fix src/dst scatterlist calculation in
    __virtio_crypto_skcipher_do_req()
  crypto: virtio: Fix use-after-free in
    virtio_crypto_skcipher_finalize_req()
  crypto: virtio: Fix dest length calculation in
    __virtio_crypto_skcipher_do_req()

 drivers/crypto/virtio/virtio_crypto_algs.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

-- 
1.8.3.1
