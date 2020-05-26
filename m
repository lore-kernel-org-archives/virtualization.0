From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [v2 2/2] crypto: virtio: Fix use-after-free in
 virtio_crypto_skcipher_finalize_req()
Date: Tue, 26 May 2020 11:30:09 +0200
Message-ID: <2ef98863-fbbf-beca-6a45-cedd686dc23a@web.de>
References: <20200526031956.1897-1-longpeng2@huawei.com>
 <20200526031956.1897-3-longpeng2@huawei.com>
 <0248e0f6-7648-f08d-afa2-170ad2e724b7@web.de>
 <03d3387f-c886-4fb9-e6f2-9ff8dc6bb80a@huawei.com>
 <8aab4c6b-7d41-7767-4945-e8af1dec902b@web.de>
 <321c79df-6397-bbf1-0047-b0b10e5af353@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <321c79df-6397-bbf1-0047-b0b10e5af353@huawei.com>
Content-Language: en-GB
Sender: stable-owner@vger.kernel.org
To: "Longpeng (Mike)" <longpeng2@huawei.com>, linux-crypto@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: Gonglei <arei.gonglei@huawei.com>, Herbert Xu <herbert@gondor.apana.org.au>, Corentin Labbe <clabbe@baylibre.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

> I respect your work, but please let us to focus on the code itself. I think
> experts in this area know what these patches want to solve after look at the code.

I suggest to reconsider such a view.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=9cb1fd0efd195590b828b9b865421ad345a4a145#n102

Regards,
Markus
