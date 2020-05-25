From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [2/2] crypto: virtio: Fix use-after-free in
 virtio_crypto_skcipher_finalize_req()
Date: Mon, 25 May 2020 09:36:10 +0200
Message-ID: <cbd8ab27-71c3-2fb0-2fa3-263901596773@web.de>
References: <a5ef5d51-e35c-983f-8e7f-5f19552abe9e@web.de>
 <a17850bb-f70d-1f77-3823-afd70816ce57@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-crypto-owner@vger.kernel.org>
In-Reply-To: <a17850bb-f70d-1f77-3823-afd70816ce57@huawei.com>
Content-Language: en-GB
Sender: linux-crypto-owner@vger.kernel.org
To: Longpeng <longpeng2@huawei.com>, linux-crypto@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: Arei Gonglei <arei.gonglei@huawei.com>, Corentin Labbe <clabbe@baylibre.com>, "David S. Miller" <davem@davemloft.net>, Herbert Xu <herbert@gondor.apana.org.au>, Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

> Could you help me to make the sentence better?

How do you think about a wording variant like the following?

  So the system will crash when this memory will be used again.


>> * You proposed to move a call of the function =E2=80=9Ccrypto_finalize_=
skcipher_request=E2=80=9D.
>>   How does this change fit to the mentioned position?
>>
> The resources which need to be freed is not used anymore, but the pointe=
rs
> of these resources may be changed in the function
> "crypto_finalize_skcipher_request", so free these resources before call =
the
> function is suitable.

Another alternative:
  The resources which need to be cleaned up are not used any more.
  But the pointers of these resources may be changed in the
  function =E2=80=9Ccrypto_finalize_skcipher_request=E2=80=9D.
  Thus release specific resources before calling this function.

Regards,
Markus
