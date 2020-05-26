From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH v2 2/2] crypto: virtio: Fix use-after-free in
 virtio_crypto_skcipher_finalize_req()
Date: Tue, 26 May 2020 09:19:17 +0200
Message-ID: <0248e0f6-7648-f08d-afa2-170ad2e724b7@web.de>
References: <20200526031956.1897-1-longpeng2@huawei.com>
 <20200526031956.1897-3-longpeng2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20200526031956.1897-3-longpeng2@huawei.com>
Content-Language: en-GB
Sender: stable-owner@vger.kernel.org
To: "Longpeng(Mike)" <longpeng2@huawei.com>, linux-crypto@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: Corentin Labbe <clabbe@baylibre.com>, Gonglei <arei.gonglei@huawei.com>, Herbert Xu <herbert@gondor.apana.org.au>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

> The system'll crash when the users insmod crypto/tcrypto.ko with mode=3D=
155
> ( testing "authenc(hmac(sha1),cbc(aes))" ). It's caused by reuse the mem=
ory
> of request structure.

Wording adjustments:
* =E2=80=A6 system will crash =E2=80=A6
* =E2=80=A6 It is caused by reusing the =E2=80=A6


> when these memory will be used again.

when this memory =E2=80=A6


> =E2=80=A6 Thus release specific resources before

Is there a need to improve also this information another bit?

Regards,
Markus
