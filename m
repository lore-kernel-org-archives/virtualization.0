Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEF76D39
	for <virtualization@lists.linux.dev>; Thu, 21 Mar 2024 08:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711009780; cv=none; b=X4eMGB/if/UB+hBzqOVQ+fif3tepOvkHIKzK+9+g+V7UVqN8FLDrXkySfT0/mrFutX8AXr9h7p7tfYXU2R+47eBA134Rs8QJca5JzXmNuF0vAPCyEKB998DVB/V3EPvSlWw2R2OnV3CxLAgMjldzqJJ0Bcr8y3U4bwJVA6EualI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711009780; c=relaxed/simple;
	bh=jTThaYGyIMH0aJhExiOspwLqhrKdtdYXqz1UzSNWN4E=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=Nil60h0WMkrF0j90S3hAK2vgydCzGhn77AEtsq9fjdfgMW9RyTxpgUxy8UumgPHeJ4iaRrtdcM2Ow6UOW0KG5jHW3a1S59L6eVrMj44t5WP9GQlPDtdWHlCZ3kMO77c7qr5chikYDloTOMxnVWi2I35pCkUj0QtbFO+2Hvag3xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EG5Gfs11; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EG5Gfs11"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711009775; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=WT/ai5ipo1Bn5+gI+e+iFmFY1xBJ5G8+huvOA+E+Z2A=;
	b=EG5Gfs1186jyohlbyoQRjhN4b1GcMtN9kcbhEgJzLRGGUfbdzXfWr4rkJdAMxg6Jc1FrPREAawYO9lVt3IFpgP5dDal61wceAoWUxL5DEMw2lBp25J8jTB6bJYkCUP3zyFOK0LdFN5KHCszgLcEYP8G/nsRm/PL+auQRm58bT+c=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W3-C-Iu_1711009772;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3-C-Iu_1711009772)
          by smtp.aliyun-inc.com;
          Thu, 21 Mar 2024 16:29:33 +0800
Message-ID: <1711009465.784253-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v4 03/10] virtio_ring: packed: structure the indirect desc table
Date: Thu, 21 Mar 2024 16:24:25 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <20240312033557.6351-1-xuanzhuo@linux.alibaba.com>
 <20240312033557.6351-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEs_DT1309_hj8igcvX7H1sU+-s_OP6Jnp-c=0kmu+ia_g@mail.gmail.com>
In-Reply-To: <CACGkMEs_DT1309_hj8igcvX7H1sU+-s_OP6Jnp-c=0kmu+ia_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Thu, 21 Mar 2024 12:47:18 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Mar 12, 2024 at 11:36=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibab=
a.com> wrote:
> >
> > This commit structure the indirect desc table.
> > Then we can get the desc num directly when doing unmap.
> >
> > And save the dma info to the struct, then the indirect
> > will not use the dma fields of the desc_extra. The subsequent
> > commits will make the dma fields are optional. But for
> > the indirect case, we must record the dma info.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 66 +++++++++++++++++++++---------------
> >  1 file changed, 38 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 0dfbd17e5a87..22a588bba166 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -72,9 +72,16 @@ struct vring_desc_state_split {
> >         struct vring_desc *indir_desc;  /* Indirect descriptor, if any.=
 */
> >  };
> >
> > +struct vring_packed_desc_indir {
> > +       dma_addr_t addr;                /* Descriptor Array DMA addr. */
> > +       u32 len;                        /* Descriptor Array length. */
> > +       u32 num;
> > +       struct vring_packed_desc desc[];
> > +};
> > +
> >  struct vring_desc_state_packed {
> >         void *data;                     /* Data for callback. */
> > -       struct vring_packed_desc *indir_desc; /* Indirect descriptor, i=
f any. */
> > +       struct vring_packed_desc_indir *indir_desc; /* Indirect descrip=
tor, if any. */
>
> Maybe it's better just to have a vring_desc_extra here.


Do you mean replacing vring_packed_desc_indir by vring_desc_extra?

I am ok for that. But vring_desc_extra has two extra items:

	u16 flags;			/* Descriptor flags. */
	u16 next;			/* The next desc state in a list. */

vring_packed_desc_indir has "desc". I think that is more convenient.

So, I think vring_packed_desc_indir is appropriate.
Or I missed something.


Thanks.


>
> Thanks
>
