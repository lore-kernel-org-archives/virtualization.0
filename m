Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F4013C699
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Jun 2024 08:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717662437; cv=none; b=uMzth4ipgFa1l2nyIgOWLx4vZWVe4o7/TrprpNUhbqa+mC/eFBlIjyBwUt3WiGrihzpliQPV5FaqzmdDxImqUGkfcD0AVvs5FDECw0ITPjf6qrgxYur0VLYpuX3chqJZrnFmNgan8bXC8V2cfQUl/G7T/2bpg7qvVYF2ngYv6qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717662437; c=relaxed/simple;
	bh=0RPa2qG64d4CV8qTMSVJcHebmM0oHIdUaDhe4/gM4L4=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=o3bwr598+N1lPiCQXsfKRfb4XE6kbfWpfghMIF2R2p8lL33w2vRDYajxn50PIqBAnp+IE5kOtpG1r+i5eI1Yv+Y6upOQJcIXzc/3e0y5/u7VJ9qY0hE5hHFCtDl9c5FRsluZ3NDpC2xk8YKKjlBctByg5dTj81dL/Ux8l+5IRGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YCe35BbF; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YCe35BbF"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7732341674
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Jun 2024 08:27:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -17.499
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3w7lsN1EPAoQ for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jun 2024 08:27:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=xuanzhuo@linux.alibaba.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A6A9141638
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A6A9141638
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YCe35BbF
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A6A9141638
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Jun 2024 08:27:12 +0000 (UTC)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717662429; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=DJ4ESPeHxb8olJByyigV2mRr385Ve3kcSAKM7qYz2MM=;
	b=YCe35BbFL91fzJG6l0PhEVKdxzep0MUyRvCADCC8yIm4sXpvDafPWcaHIBP/rXtDmd/nYjBUHgaxaJ4vhH9jLhoHMzyd38sbGvkoaYyj62GrDrZYujRx7jhCwe0sV8TpxYsWxk1jDsmdXpociXnAs45N7DqHPZkY0ifQVFiogLg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W7xkc8b_1717662426;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W7xkc8b_1717662426)
          by smtp.aliyun-inc.com;
          Thu, 06 Jun 2024 16:27:06 +0800
Message-ID: <1717662283.8634596-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v13 04/12] virtio_ring: support add premapped buf
Date: Thu, 6 Jun 2024 16:24:43 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Alexander Potapenko <glider@google.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 netdev@vger.kernel.org,
 bpf@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 virtualization@lists.linux-foundation.org
References: <20230810123057.43407-1-xuanzhuo@linux.alibaba.com>
 <20230810123057.43407-5-xuanzhuo@linux.alibaba.com>
 <0b726a75574ad98200b815f173e59a5378e9df04.camel@linux.ibm.com>
 <1717644183.6895547-1-xuanzhuo@linux.alibaba.com>
 <CAG_fn=UsqAhH57s08+prkj2iJshhxuLznzDNft4dPXHKX9V72Q@mail.gmail.com>
In-Reply-To: <CAG_fn=UsqAhH57s08+prkj2iJshhxuLznzDNft4dPXHKX9V72Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Thu, 6 Jun 2024 10:20:21 +0200, Alexander Potapenko <glider@google.com> =
wrote:
> > Could you try this?
>
> Hi Xuan,
>
> What kernel revision does this patch apply to? I tried it against
> v6.10-rc2, and only the first hunk applied.
> However this seems to fix the problem, at least the kernel boots without
> warnings now.


Sorry, I have some changes locally.

If the hunk #1 is applied, then it is ok.

Do you think we need more test? Or I post an new patch directly.

Thanks.


>
> > Thanks.
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 37c9c5b55864..cb280b66c7a2 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -3119,8 +3119,10 @@ dma_addr_t virtqueue_dma_map_single_attrs(struct
> virtqueue *_vq, void *ptr,
> >  {
> >         struct vring_virtqueue *vq =3D to_vvq(_vq);
> >
> > -       if (!vq->use_dma_api)
> > +       if (!vq->use_dma_api) {
> > +               kmsan_handle_dma(virt_to_page(ptr), offset_in_page(ptr),
> size, dir);
> >                 return (dma_addr_t)virt_to_phys(ptr);
> > +       }
> >
> >         return dma_map_single_attrs(vring_dma_dev(vq), ptr, size, dir,
> attrs);
> >  }
> > @@ -3171,8 +3173,10 @@ dma_addr_t virtqueue_dma_map_page_attrs(struct
> virtqueue *_vq, struct page *page
> >  {
> >         struct vring_virtqueue *vq =3D to_vvq(_vq);
> >
> > -       if (!vq->use_dma_api)
> > +       if (!vq->use_dma_api) {
> > +               kmsan_handle_dma(page, offset, size, dir);
> >                 return page_to_phys(page) + offset;
> > +       }
> >
> >         return dma_map_page_attrs(vring_dma_dev(vq), page, offset, size,
> dir, attrs);
> >  }
>
>
>
> --
> Alexander Potapenko
> Software Engineer
>
> Google Germany GmbH
> Erika-Mann-Stra=C3=9Fe, 33
> 80636 M=C3=BCnchen
>
> Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
> Registergericht und -nummer: Hamburg, HRB 86891
> Sitz der Gesellschaft: Hamburg
>
