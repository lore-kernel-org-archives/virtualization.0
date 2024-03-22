Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0561428A
	for <virtualization@lists.linux.dev>; Fri, 22 Mar 2024 07:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711094296; cv=none; b=LJQ2Y7iWO0alJQN6MVIexnL9TUSo2Uahr25+oGfJq8nDyxPg3U9Yw1XUAHue+tgcHiX30gtH6Y0hhtT+zPP81K4VXgiF0834mM6N0omaWesOUAqvviC/A5nXh0NXKxz2OudJ9it/+TkZKuxmu/Dk/LFKpFSp3lKRBd0/0wO55uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711094296; c=relaxed/simple;
	bh=fgq3Ar4nYwPurlKzSdomPDCpRkNlzGySLfAfm9jZQsM=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=PlpAu2JQcHVYPS0HAyKTO3cEamuslxsRPhGCy63rAEYClyojO5trePaS06q0OP7XC2LnS39ca7XDwQohA+/xiztzwi2BHZLnW3/De/AmjiW3MSv5KlACqC8Zi78mXaE4kLOz4LAOZEKsWWfGOJRR7HXwkK55CA9tBFYS89+geto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ahxstz4e; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ahxstz4e"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711094285; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=RS7Q5/aJh5MuCEx/qwvTl65m32kKDl22PUwrCQVtmq4=;
	b=Ahxstz4epa+ykTU6ucLUSVl5djHxXucxOBw9T3928J62a7dnUV7kPRRieHLT+sWMMg/UHHSOBeYRznzp3KA+fpwHkTu8wl8WnhrN0Eeflk30RU3LtU4AcHCygIk966wTqNFLUZKK20VjkZZ+bttaO8y4SAYkLSuXnMAbf/jYHss=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W31VhFe_1711094284;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W31VhFe_1711094284)
          by smtp.aliyun-inc.com;
          Fri, 22 Mar 2024 15:58:04 +0800
Message-ID: <1711093912.1488938-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v4 03/10] virtio_ring: packed: structure the indirect desc table
Date: Fri, 22 Mar 2024 15:51:52 +0800
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
 <1711009465.784253-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEvimfmQRUZ04CykZs-6cOkASF8S02n2N7caJ4XivR8hNw@mail.gmail.com>
In-Reply-To: <CACGkMEvimfmQRUZ04CykZs-6cOkASF8S02n2N7caJ4XivR8hNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Fri, 22 Mar 2024 13:15:10 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Thu, Mar 21, 2024 at 4:29=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > On Thu, 21 Mar 2024 12:47:18 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Tue, Mar 12, 2024 at 11:36=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.al=
ibaba.com> wrote:
> > > >
> > > > This commit structure the indirect desc table.
> > > > Then we can get the desc num directly when doing unmap.
> > > >
> > > > And save the dma info to the struct, then the indirect
> > > > will not use the dma fields of the desc_extra. The subsequent
> > > > commits will make the dma fields are optional. But for
> > > > the indirect case, we must record the dma info.
> > > >
> > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > ---
> > > >  drivers/virtio/virtio_ring.c | 66 +++++++++++++++++++++-----------=
----
> > > >  1 file changed, 38 insertions(+), 28 deletions(-)
> > > >
> > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_r=
ing.c
> > > > index 0dfbd17e5a87..22a588bba166 100644
> > > > --- a/drivers/virtio/virtio_ring.c
> > > > +++ b/drivers/virtio/virtio_ring.c
> > > > @@ -72,9 +72,16 @@ struct vring_desc_state_split {
> > > >         struct vring_desc *indir_desc;  /* Indirect descriptor, if =
any. */
> > > >  };
> > > >
> > > > +struct vring_packed_desc_indir {
> > > > +       dma_addr_t addr;                /* Descriptor Array DMA add=
r. */
> > > > +       u32 len;                        /* Descriptor Array length.=
 */
> > > > +       u32 num;
> > > > +       struct vring_packed_desc desc[];
> > > > +};
> > > > +
> > > >  struct vring_desc_state_packed {
> > > >         void *data;                     /* Data for callback. */
> > > > -       struct vring_packed_desc *indir_desc; /* Indirect descripto=
r, if any. */
> > > > +       struct vring_packed_desc_indir *indir_desc; /* Indirect des=
criptor, if any. */
> > >
> > > Maybe it's better just to have a vring_desc_extra here.
> >
> >
> > Do you mean replacing vring_packed_desc_indir by vring_desc_extra?
>
> Just add a vring_desc_extra in vring_desc_state_packed.
>
> >
> > I am ok for that. But vring_desc_extra has two extra items:
> >
> >         u16 flags;                      /* Descriptor flags. */
> >         u16 next;                       /* The next desc state in a lis=
t. */
> >
> > vring_packed_desc_indir has "desc". I think that is more convenient.
> >
> > So, I think vring_packed_desc_indir is appropriate.
>
> It reuses the existing structure so we had the chance to reuse the
> helper.

Do you mean vring_unmap_extra_packed()?

After last commit(virtio_ring: packed: remove double check of the unmap ops=
):

	/* caller must check vring_need_unmap_buffer() */
	static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
					     const struct vring_desc_extra *extra)
	{
		u16 flags;

		flags =3D extra->flags;

		dma_unmap_page(vring_dma_dev(vq),
			       extra->addr, extra->len,
			       (flags & VRING_DESC_F_WRITE) ?
			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
	}

But we should call dma_unmap_single() for indirect desc.

We know, dma_unmap_single() and dma_unmap_page() are same in essence.
So if we call dma_unmap_page for the indirect desc, we can reuse
this function. But I do not prefer doing this.

Thanks.


> And it could be used for future chained indirect (if it turns
> out to be necessary).
>
> Thanks
>
> > Or I missed something.
> >
> >
> > Thanks.
> >
> >
> > >
> > > Thanks
> > >
> >
>
>
