From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH 1/2] crypto: virtio: Fix src/dst scatterlist calculation
 in __virtio_crypto_skcipher_do_req()
Date: Mon, 25 May 2020 08:05:02 +0200
Message-ID: <21478291-9191-1da3-a7e5-65e87c743a3c@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-crypto-owner@vger.kernel.org>
Content-Language: en-GB
Sender: linux-crypto-owner@vger.kernel.org
To: longpeng2@huawei.com, linux-crypto@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Arei Gonglei <arei.gonglei@huawei.com>, Corentin Labbe <clabbe@baylibre.com>, "David S. Miller" <davem@davemloft.net>, Herbert Xu <herbert@gondor.apana.org.au>, Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

> The system will crash when we insmod crypto/tcrypt.ko whit mode=3D38.

* I suggest to use the word =E2=80=9Cwith=E2=80=9D in this sentence.

* Will it be helpful to explain the passed mode number?


> BTW I add a check for sg_nents_for_len() its return value since
> sg_nents_for_len() function could fail.

Please reconsider also development consequences for this suggestion.
Will a separate update step be more appropriate for the addition of
an input parameter validation?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?id=3D9cb1fd0efd195590b828b9b865=
421ad345a4a145#n138

Would you like to add the tag =E2=80=9CFixes=E2=80=9D to the commit messag=
e?

Regards,
Markus
