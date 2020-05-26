From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH v2 1/2] crypto: virtio: Fix src/dst scatterlist
 calculation in __virtio_crypto_skcipher_do_req()
Date: Tue, 26 May 2020 09:03:21 +0200
Message-ID: <d58a046a-e559-55be-16ba-64db43a06568@web.de>
References: <20200526031956.1897-1-longpeng2@huawei.com>
 <20200526031956.1897-2-longpeng2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20200526031956.1897-2-longpeng2@huawei.com>
Content-Language: en-GB
Sender: stable-owner@vger.kernel.org
To: "Longpeng(Mike)" <longpeng2@huawei.com>, linux-crypto@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: Corentin Labbe <clabbe@baylibre.com>, Herbert Xu <herbert@gondor.apana.org.au>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, Gonglei <arei.gonglei@huawei.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

> Fix it by sg_next() on calculation of src/dst scatterlist.

Wording adjustment:
=E2=80=A6 by calling the function =E2=80=9Csg_next=E2=80=9D =E2=80=A6


=E2=80=A6
> +++ b/drivers/crypto/virtio/virtio_crypto_algs.c
> @@ -350,13 +350,18 @@ __virtio_crypto_skcipher_do_req(struct virtio_cryp=
to_sym_request *vc_sym_req,
=E2=80=A6
>  	src_nents =3D sg_nents_for_len(req->src, req->cryptlen);
> +	if (src_nents < 0) {
> +		pr_err("Invalid number of src SG.\n");
> +		return src_nents;
> +	}
> +
>  	dst_nents =3D sg_nents(req->dst);
=E2=80=A6

I suggest to move the addition of such input parameter validation
to a separate update step.

Regards,
Markus
