From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH 2/2] crypto: virtio: Fix use-after-free in
 virtio_crypto_skcipher_finalize_req()
Date: Mon, 25 May 2020 08:30:25 +0200
Message-ID: <a5ef5d51-e35c-983f-8e7f-5f19552abe9e@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: longpeng2@huawei.com, linux-crypto@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: Arei Gonglei <arei.gonglei@huawei.com>, Corentin Labbe <clabbe@baylibre.com>, "David S. Miller" <davem@davemloft.net>, Herbert Xu <herbert@gondor.apana.org.au>, Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

> =E2=80=A6 So the system will crash
> at last when this memory be used again.

I would prefer a wording with less typos here.


> We can free the resources before calling ->complete to fix this issue.

* An imperative wording can be nicer.
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?id=3D9cb1fd0efd195590b828b9b8=
65421ad345a4a145#n151

* You proposed to move a call of the function =E2=80=9Ccrypto_finalize_skc=
ipher_request=E2=80=9D.
  How does this change fit to the mentioned position?

* Would you like to add the tag =E2=80=9CFixes=E2=80=9D to the commit mess=
age?

Regards,
Markus
