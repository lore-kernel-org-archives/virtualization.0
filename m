From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [v2 2/2] crypto: virtio: Fix use-after-free in
 virtio_crypto_skcipher_finalize_req()
Date: Tue, 26 May 2020 11:01:44 +0200
Message-ID: <8aab4c6b-7d41-7767-4945-e8af1dec902b@web.de>
References: <20200526031956.1897-1-longpeng2@huawei.com>
 <20200526031956.1897-3-longpeng2@huawei.com>
 <0248e0f6-7648-f08d-afa2-170ad2e724b7@web.de>
 <03d3387f-c886-4fb9-e6f2-9ff8dc6bb80a@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <03d3387f-c886-4fb9-e6f2-9ff8dc6bb80a@huawei.com>
Content-Language: en-GB
Sender: stable-owner@vger.kernel.org
To: "Longpeng (Mike)" <longpeng2@huawei.com>, linux-crypto@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: Corentin Labbe <clabbe@baylibre.com>, Gonglei <arei.gonglei@huawei.com>, Herbert Xu <herbert@gondor.apana.org.au>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

>>> =E2=80=A6 Thus release specific resources before
>>
>> Is there a need to improve also this information another bit?
>>
> You mean the last two paragraph is redundant ?

No.

I became curious if you would like to choose a more helpful information
according to the wording =E2=80=9Cspecific resources=E2=80=9D.

Regards,
Markus
