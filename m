From: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v3 3/3] crypto: virtio: Fix dest length calculation in __virtio_crypto_skcipher_do_req()
Date: Fri, 05 Jun 2020 14:10:50 +0000
Message-ID: <20200605141050.AACEA207D3__20722.5757812679$1591366267$gmane$org@mail.kernel.org>
References: <20200602070501.2023-4-longpeng2@huawei.com>
Return-path: <linux-crypto-owner@vger.kernel.org>
In-Reply-To: <20200602070501.2023-4-longpeng2@huawei.com>
Sender: linux-crypto-owner@vger.kernel.org
To: Sasha Levin <sashal@kernel.org>, linux-crypto@vger.kernel.org
Cc: "Longpeng(Mike)" <longpeng2@huawei.com>, Gonglei <arei.gonglei@huawei.com>, Herbert Xu <herbert@gondor.apana.org.au>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, stable@vger.kernel.orgstable@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Hi

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag
fixing commit: dbaf0624ffa5 ("crypto: add virtio-crypto driver").

The bot has tested the following trees: v5.6.15, v5.4.43, v4.19.125, v4.14.182.

v5.6.15: Build OK!
v5.4.43: Build failed! Errors:
    drivers/crypto/virtio/virtio_crypto_algs.c:408:35: error: ‘struct ablkcipher_request’ has no member named ‘cryptlen’
    drivers/crypto/virtio/virtio_crypto_algs.c:408:35: error: ‘struct ablkcipher_request’ has no member named ‘cryptlen’
    drivers/crypto/virtio/virtio_crypto_algs.c:408:35: error: ‘struct ablkcipher_request’ has no member named ‘cryptlen’
    drivers/crypto/virtio/virtio_crypto_algs.c:408:35: error: ‘struct ablkcipher_request’ has no member named ‘cryptlen’
    drivers/crypto/virtio/virtio_crypto_algs.c:408:35: error: ‘struct ablkcipher_request’ has no member named ‘cryptlen’
    drivers/crypto/virtio/virtio_crypto_algs.c:408:35: error: ‘struct ablkcipher_request’ has no member named ‘cryptlen’
    ./include/linux/kernel.h:866:2: error: first argument to ‘__builtin_choose_expr’ not a constant

v4.19.125: Build failed! Errors:
    drivers/crypto/virtio/virtio_crypto_algs.c:422:35: error: ‘struct ablkcipher_request’ has no member named ‘cryptlen’
    drivers/crypto/virtio/virtio_crypto_algs.c:422:35: error: ‘struct ablkcipher_request’ has no member named ‘cryptlen’
    drivers/crypto/virtio/virtio_crypto_algs.c:422:35: error: ‘struct ablkcipher_request’ has no member named ‘cryptlen’
    drivers/crypto/virtio/virtio_crypto_algs.c:422:35: error: ‘struct ablkcipher_request’ has no member named ‘cryptlen’
    drivers/crypto/virtio/virtio_crypto_algs.c:422:35: error: ‘struct ablkcipher_request’ has no member named ‘cryptlen’
    drivers/crypto/virtio/virtio_crypto_algs.c:422:35: error: ‘struct ablkcipher_request’ has no member named ‘cryptlen’
    ./include/linux/kernel.h:870:2: error: first argument to ‘__builtin_choose_expr’ not a constant

v4.14.182: Build failed! Errors:
    drivers/crypto/virtio/virtio_crypto_algs.c:409:35: error: ‘struct ablkcipher_request’ has no member named ‘cryptlen’


NOTE: The patch will not be queued to stable trees until it is upstream.

How should we proceed with this patch?

-- 
Thanks
Sasha
