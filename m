From: "Longpeng(Mike)" <longpeng2@huawei.com>
Subject: [PATCH 0/2] crypto: virtio: fix two crash issue
Date: Mon, 25 May 2020 08:56:25 +0800
Message-ID: <20200525005627.707-1-longpeng2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-crypto@vger.kernel.org
Cc: "Longpeng(Mike)" <longpeng2@huawei.com>, Gonglei <arei.gonglei@huawei.com>, Herbert Xu <herbert@gondor.apana.org.au>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Link: https://lkml.org/lkml/2020/1/23/205

Cc: Gonglei <arei.gonglei@huawei.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: virtualization@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org

Longpeng(Mike) (2):
  crypto: virtio: fix src/dst scatterlist calculation
  crypto: virtio: fix an memory use-after-free bug

 drivers/crypto/virtio/virtio_crypto_algs.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

-- 
2.17.1
