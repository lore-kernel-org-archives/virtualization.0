Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5649B1B2536
	for <virtualization@lists.linux.dev>; Mon,  9 Sep 2024 08:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725871639; cv=none; b=fCAVVzDi/cyNSk+GiGemkf1alqi515heYqiEoJPSpNjccGXtp+RghGP7A0cp4mmhKbn2v5i9o6IAe69bFjqMnVm9GA1syuaB2Wzu2NVQgB++uelQt/TqCJ3b7R8soGlHI1KP37bBFN+KpIRTv+YhHnx/pspCyqbvBzMHJh4tiQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725871639; c=relaxed/simple;
	bh=h1RxGxU/ldBBKe3fUy9gAFcrUq1p0/v76JbkP3luf7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FPox57NteegsK/67nTSdLYHIHCqfiS17BYPT9uHmBUh34jPkk4VmvKLLzMdpmV6PbaDq3ncjKVfPjPncVYFQroBC8mHXQ4eb9EtElbvcQXtOmAoo+dbFfDVwq404iDWpAfRyq5VEO3cYNx8Vx4C2aDfkE6nJSTkA8AYkKxF9H0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DGURRKRO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DGURRKRO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725871636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PLp4apn4fOEYqLqz0yGi2d0CZ9ZfsWGLxUbBGOrIoXU=;
	b=DGURRKROy2YR2P5EVBhCFjCfvNnPiK8B7xrMkB3Zi5VUL9xR2YEgdwX0rB+fN31Bsszr5h
	ItTUzhSORqEoqYpuVsONebNjRsf4MD4xVRO2gQQyNuqMBTLxY2/XIHcmciieyWzUjLr9lQ
	Us2voAGGmio0MoONmiKXspEm7OD4Vwc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-BcQuSROwMxWey_Vc9MyEXw-1; Mon, 09 Sep 2024 04:47:15 -0400
X-MC-Unique: BcQuSROwMxWey_Vc9MyEXw-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2d404e24c18so4399325a91.3
        for <virtualization@lists.linux.dev>; Mon, 09 Sep 2024 01:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725871634; x=1726476434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PLp4apn4fOEYqLqz0yGi2d0CZ9ZfsWGLxUbBGOrIoXU=;
        b=dm2Vepuz7IJilcEoR3zPp0lE76nT8rEGA3uO8d0aPxMjiQJG+rv4QE3Dng3kyWl7va
         XZ8H6zw/86No79oLBvgrtnCJRQhb30IECBM/eiIZPKa4tE6x8UEXUIyZ/uRu4PFeUYrv
         1gJtrTCWZis8qCkKEPwQdAAU4UobOkKe561qIts8DWLfaimBrciWWu9gkiNOozurM+nb
         VEf9Nhw4/ZWXpwhCikTDC1B7X2p501ritwJdZzDNZSRzyiW0D3+Ld+JqtL/MjhFfHtEl
         u76CU9+BpIJ7z9dnhVx5s051C4w5i7EsTpMAOygXmnLRJNzisSocMb5PI9CpdY3vhqTs
         PKxg==
X-Forwarded-Encrypted: i=1; AJvYcCXn6XUv5iZuOn4uo2B1uEpCrwZwrC8wpMiL0ygtaDejYXvh0vvLgRAWv2U+yhLZkiy+FeLLkobWU1Ldi2Clsg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxDUKFQmqAW54a3G4PamazlD4c2nXC3545Yd+7kxZ4Y09RQc/mU
	LF29T+Eg4gEW/w/4jSgSoLBayMkY4vnzUaBzXcMnCwUOhMjl3QJbByxjMZunlLSdnnN7+c0qblE
	5FtxheklmZYZl8tyAOtt6Cyj1IEt/svN1RnnWK/PMtQ6ANN5CnZ78LAnSyWOB1Z8ExHrXX8lCgI
	pU3NAJdrjws01K0A+gBI2GVQX+xX7cPQ0zKrVGhNg=
X-Received: by 2002:a17:90a:c715:b0:2d8:840d:d9f2 with SMTP id 98e67ed59e1d1-2daffc85c5fmr8782831a91.24.1725871634185;
        Mon, 09 Sep 2024 01:47:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwpVuSQwu5rHpSjAJhWxuerYnWXzbkGFdBvmrRsDPtwMf96+c7ID3U0UT+Dq90wayWCnzjxptqo2QiTX9OnMw=
X-Received: by 2002:a17:90a:c715:b0:2d8:840d:d9f2 with SMTP id
 98e67ed59e1d1-2daffc85c5fmr8782816a91.24.1725871633763; Mon, 09 Sep 2024
 01:47:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240820071913.68004-1-xuanzhuo@linux.alibaba.com>
 <20240908153930-mutt-send-email-mst@kernel.org> <1725851336.7999291-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1725851336.7999291-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 9 Sep 2024 16:47:02 +0800
Message-ID: <CACGkMEvirXU9816r31UCUz8ne-URj-h-txG6Ozd8vwBp-=sbSQ@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: fix overflow inside virtnet_rq_alloc
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, virtualization@lists.linux.dev, 
	Si-Wei Liu <si-wei.liu@oracle.com>, Darren Kenny <darren.kenny@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 11:16=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Sun, 8 Sep 2024 15:40:32 -0400, "Michael S. Tsirkin" <mst@redhat.com> =
wrote:
> > On Tue, Aug 20, 2024 at 03:19:13PM +0800, Xuan Zhuo wrote:
> > > leads to regression on VM with the sysctl value of:
> > >
> > > - net.core.high_order_alloc_disable=3D1
> > >
> > > which could see reliable crashes or scp failure (scp a file 100M in s=
ize
> > > to VM):
> > >
> > > The issue is that the virtnet_rq_dma takes up 16 bytes at the beginni=
ng
> > > of a new frag. When the frag size is larger than PAGE_SIZE,
> > > everything is fine. However, if the frag is only one page and the
> > > total size of the buffer and virtnet_rq_dma is larger than one page, =
an
> > > overflow may occur. In this case, if an overflow is possible, I adjus=
t
> > > the buffer size. If net.core.high_order_alloc_disable=3D1, the maximu=
m
> > > buffer size is 4096 - 16. If net.core.high_order_alloc_disable=3D0, o=
nly
> > > the first buffer of the frag is affected.
> > >
> > > Fixes: f9dac92ba908 ("virtio_ring: enable premapped mode whatever use=
_dma_api")
> > > Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
> > > Closes: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c=
0a@oracle.com
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >
> >
> > BTW why isn't it needed if we revert f9dac92ba908?
>
>
> This patch fixes the bug in premapped mode.
>
> The revert operation just disables premapped mode.
>
> So I think this patch is enough to fix the bug, and we can enable
> premapped by default.
>
> If you worry about the premapped mode, I advice you merge this patch and =
do
> the revert[1]. Then the bug is fixed, and the premapped mode is
> disabled by default, we can just enable it for af-xdp.
>
> [1]: http://lore.kernel.org/all/20240906123137.108741-1-xuanzhuo@linux.al=
ibaba.com

Though I think this is a good balance but if we can't get more inputs
from Darren. It seems safer to merge what he had tested.

Thanks

>
> Thanks.
>
>
> >
> > > ---
> > >  drivers/net/virtio_net.c | 12 +++++++++---
> > >  1 file changed, 9 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index c6af18948092..e5286a6da863 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -918,9 +918,6 @@ static void *virtnet_rq_alloc(struct receive_queu=
e *rq, u32 size, gfp_t gfp)
> > >     void *buf, *head;
> > >     dma_addr_t addr;
> > >
> > > -   if (unlikely(!skb_page_frag_refill(size, alloc_frag, gfp)))
> > > -           return NULL;
> > > -
> > >     head =3D page_address(alloc_frag->page);
> > >
> > >     dma =3D head;
> > > @@ -2421,6 +2418,9 @@ static int add_recvbuf_small(struct virtnet_inf=
o *vi, struct receive_queue *rq,
> > >     len =3D SKB_DATA_ALIGN(len) +
> > >           SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > >
> > > +   if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)))
> > > +           return -ENOMEM;
> > > +
> > >     buf =3D virtnet_rq_alloc(rq, len, gfp);
> > >     if (unlikely(!buf))
> > >             return -ENOMEM;
> > > @@ -2521,6 +2521,12 @@ static int add_recvbuf_mergeable(struct virtne=
t_info *vi,
> > >      */
> > >     len =3D get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
> > >
> > > +   if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
> > > +           return -ENOMEM;
> > > +
> > > +   if (!alloc_frag->offset && len + room + sizeof(struct virtnet_rq_=
dma) > alloc_frag->size)
> > > +           len -=3D sizeof(struct virtnet_rq_dma);
> > > +
> > >     buf =3D virtnet_rq_alloc(rq, len + room, gfp);
> > >     if (unlikely(!buf))
> > >             return -ENOMEM;
> > > --
> > > 2.32.0.3.g01195cf9f
> >
>

