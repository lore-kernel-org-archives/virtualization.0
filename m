Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF47639FC6
	for <virtualization@lists.linux.dev>; Thu, 28 Mar 2024 07:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711611721; cv=none; b=Cx4Fl4jKB8UlatVd3bUhMISXqa+MxdijxKunMZ612lsfLRUIUy7vhc2q109g/lJ8dQIctWfu4oAM8ar7zcvaURgHwC5IYYnW3X27EeS2hVQ933sTIwvslJL6kQPsLm1baY8fCICiQg5HEZ342wrfLh3IgilL92pBtaItw9R/ZmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711611721; c=relaxed/simple;
	bh=eA8TzTcQP5f0idf/MJqLhxKB3/6FLsCweLlrZ+LYuhQ=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=kC5cdk0/NOV1fZBVYVZHu5eu8R2MmpNRjx431TvRbsKYsghSw+prC4F5F/PDWsYug45+4UTs2qvSKj8Iv/o1cnWdJk21WohElzVHcaIhQFRByc+NTDgXq6hTujdWBroa+dJfc22IjG3Pi5SgvJD7GTR+hmdHRGocGcEDPAMG3uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mtjNKxbe; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mtjNKxbe"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711611716; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=PCvNh/BmTs3HnAMGUF8I14hWMG7LN0/s8SW5GmvmG64=;
	b=mtjNKxbefiuwUGaq9DIe59heUmujpgfrECfU1zdvsR4CtnHkxwVoYEe+q9pWuvuxQE547RT9ixUoeL/xmqAnr9dFdwHiNxniAwuWqgwZF2IpEvVKmgyzm7kdP2czZVAP3bpIPeK5BQMlu8c0v3AMRoQeOpxVAGHvx2IZVnl2bdE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W3Se7R9_1711611715;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3Se7R9_1711611715)
          by smtp.aliyun-inc.com;
          Thu, 28 Mar 2024 15:41:56 +0800
Message-ID: <1711611643.583144-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v6 06/10] virtio_ring: no store dma info when unmap is not needed
Date: Thu, 28 Mar 2024 15:40:43 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <20240327111430.108787-1-xuanzhuo@linux.alibaba.com>
 <20240327111430.108787-7-xuanzhuo@linux.alibaba.com>
 <CACGkMEsmnzEUmaffn3ueY1JtbJ4UzLpr9o0s4j1jwoVuO-yy8Q@mail.gmail.com>
In-Reply-To: <CACGkMEsmnzEUmaffn3ueY1JtbJ4UzLpr9o0s4j1jwoVuO-yy8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Thu, 28 Mar 2024 15:06:33 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Wed, Mar 27, 2024 at 7:14=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > As discussed:
> > http://lore.kernel.org/all/CACGkMEug-=3DC+VQhkMYSgUKMC=3D=3D04m7-uem_yC=
21bgGkKZh845w@mail.gmail.com
> >
> > When the vq is premapped mode, the driver manages the dma
> > info is a good way.
> >
> > So this commit make the virtio core not to store the dma
> > info and release the memory which is used to store the dma
> > info.
> >
> > If the use_dma_api is false, the memory is also not allocated.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 120 ++++++++++++++++++++++++++++-------
> >  1 file changed, 97 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 1f7c96543d58..08e4f6e1d722 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -69,23 +69,26 @@
> >
> >  struct vring_desc_state_split {
> >         void *data;                     /* Data for callback. */
> > -       struct vring_desc_extra *indir_desc;    /* Indirect descriptor,=
 if any. */
> > +       struct vring_desc_dma *indir_desc;      /* Indirect descriptor,=
 if any. */
> >  };
> >
> >  struct vring_desc_state_packed {
> >         void *data;                     /* Data for callback. */
> > -       struct vring_desc_extra *indir_desc; /* Indirect descriptor, if=
 any. */
> > +       struct vring_desc_dma *indir_desc; /* Indirect descriptor, if a=
ny. */
> >         u16 num;                        /* Descriptor list length. */
> >         u16 last;                       /* The last desc state in a lis=
t. */
> >  };
> >
> >  struct vring_desc_extra {
> > -       dma_addr_t addr;                /* Descriptor DMA addr. */
> > -       u32 len;                        /* Descriptor length. */
> >         u16 flags;                      /* Descriptor flags. */
> >         u16 next;                       /* The next desc state in a lis=
t. */
> >  };
> >
> > +struct vring_desc_dma {
> > +       dma_addr_t addr;                /* Descriptor DMA addr. */
> > +       u32 len;                        /* Descriptor length. */
>
> This seems to be odd, flag should be part of dma info.

flags contains F_NEXT, that is used by detach when no dma info.

>
> To reduce the changeset, I would split out next.

Do you mean split this patch set?

Thanks



>
> Thank
>
