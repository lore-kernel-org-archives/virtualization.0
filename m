From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 3/3] Virtio draft IV: the net driver
Date: Wed, 11 Jul 2007 12:28:30 +0200
Message-ID: <200707111228.30707.borntraeger@de.ibm.com>
References: <1183522348.6110.37.camel@localhost.localdomain>
	<1183522765.6110.40.camel@localhost.localdomain>
	<1183524053.6110.45.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1183524053.6110.45.camel@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: Carsten Otte <cotte@de.ibm.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

Am Mittwoch, 4. Juli 2007 schrieb Rusty Russell:
> +static void try_fill_recv(struct virtnet_info *vi)
> +{
> +	struct sk_buff *skb;
> +	struct scatterlist sg[MAX_SKB_FRAGS];
> +	int num, err;
> +
> +	for (;;) {
> +		skb =3D netdev_alloc_skb(vi->ndev, MAX_PACKET_LEN);
> +		if (unlikely(!skb))
> +			break;
> +
> +		skb_put(skb, MAX_PACKET_LEN);
> +		num =3D skb_to_sgvec(skb, sg, 0, skb->len);
> +		skb_queue_head(&vi->recv, skb);
> +
> +		err =3D vi->vq_recv->ops->add_buf(vi->vq_recv, sg, 0, num, skb);
> +		if (err) {
> +			skb_unlink(skb, &vi->recv);
> +			kfree_skb(skb);
> +			break;
> +		}
> +		vi->num++;
> +	}

Hmm, so it allocates skbs until oom or until add_buf fails, right?

Do you expect the add_buf call to fail if we have enough buffers? Who def=
ines=20
the amount of buffers we can add via add_buf?


--=20
IBM Deutschland Entwicklung GmbH
Vorsitzender des Aufsichtsrats: Martin Jetter
Gesch=E4ftsf=FChrung: Herbert Kircher=20
Sitz der Gesellschaft: B=F6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
