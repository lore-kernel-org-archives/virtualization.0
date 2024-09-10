Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C74B24205
	for <virtualization@lists.linux.dev>; Tue, 10 Sep 2024 06:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725949134; cv=none; b=Qdts4eCW/+J6kw6zsJsoY6kHFlyzeTM+PkqY3pTVY9qklo6aw3/F++Hpn8Pf2nD2KcmmmOqXchdwuj3V8K5evq876iWfZT7A1iUtZHKTQoq4WUCAnXY954Ejb4TZQ+oJzZMpfXNzfLISnSxPnM+d4UCOM+jqtSfYaUNJBsT+qnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725949134; c=relaxed/simple;
	bh=hdBqLI2hbifF177Bi8AEnnCe6axSyUi+g99o1jE0BFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oRpfGSrFyclXuGcoF/q9HWZaEtapVK8RVDFvM5apECPwXxELJnlAKLOWyZUnzt6UdCRomrGvHpvJ6TIgFv0AK3AodAxrSxWbAmzUWvwLR0P0dndK5bU5BlLubocNL0AZrQhur1YEgQPIhrksJaBKfptnkodmRA+mhNu1PGTG1pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZmJmTa/O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZmJmTa/O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725949131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1X5Q60A0hCQO4RvA4w6RfJ+x6I4CcJAkO11q+kc5eas=;
	b=ZmJmTa/OxYU2nvcBdC5JAZFNUoemTt9igcxZnhksgnpTNEwf7Hm2dfWBjngEIzKfNQAPrn
	1lZPVy3xM/5u5tY2684CWcKuy9OBT2WnCITUoMTQmf+aeeP/teSf0XWSUAZwlafBNf3GE3
	b+74zjkHc3eeJfsy4hDvWRvJn7+kkOo=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-7GdzP08LOOOTa-ugEZDVbw-1; Tue, 10 Sep 2024 02:18:50 -0400
X-MC-Unique: 7GdzP08LOOOTa-ugEZDVbw-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-205425b7e27so59610455ad.0
        for <virtualization@lists.linux.dev>; Mon, 09 Sep 2024 23:18:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725949129; x=1726553929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1X5Q60A0hCQO4RvA4w6RfJ+x6I4CcJAkO11q+kc5eas=;
        b=uYGl0Mow/ItZ1lsYMuEQTTs96m9ECfrc5qIgBZpYjnXoNKnhT8rZZXZQ6vIKwGafty
         Ne4nvwS+S8mT98O+z+B5NPggr3fn9x3f9jZTtl1kyCjGvXYgdzT55rj1C1+S0SLAWj1u
         FnioIKRyJYWA+GZ2sseWIQ9Z84wZToKdIeWw8Ta1AfyHawhRQb3Pdp8wDjP737SbMHI/
         RvsORGM4DH/AF4EleEg0lUY0bgCJ6UoJphZxUOHTSaVRkDAMlw2s0/PB1nI7Qgg6pUZX
         cs9RgMePS8dt+EbtrywThCWM3iZU6+DjXmCG/ifkfiWzZXcd/DJHiGhcoZiOdYYpvCc7
         xa4w==
X-Forwarded-Encrypted: i=1; AJvYcCWhDdiCOYnhJx8VrsKLW9VLeIa3IhCwdGaKyljqmf3W63RuHOvm+xLnNN/Bl5/S2Y9HhMD5lSdxvHAMngjL4A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyuOuPmjE0dJ8wglakQj47j2iLDb6vJ0MXt38G1A/NwOpJ2I7eE
	5EI58RIvdPsq83sNGbV8p7G0Wv+tIiLPnd/DpQI42J36sM+3kac1npANdcvxio88LSGUY9dt4nH
	8cH6EcWk9E5Lv2alVEA5jkgfKDICUb8Pc1LT9APH48+El58vGWositzk4PAcaN1ZVeXbJNbbTk3
	j7x0NA1zrg6hvDCyj99ZzyoOUJLAsKjz4cvfI2PMs=
X-Received: by 2002:a17:903:947:b0:206:a6e7:39c3 with SMTP id d9443c01a7336-206f04e1713mr132654505ad.13.1725949129214;
        Mon, 09 Sep 2024 23:18:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwe5O//tKilaPY6uJOV8TomERBCIhBHn12O6cdPCiAWN6lvW9OqUp2zr9SeWLTzSUT/raPjpxZiuUKWMce+as=
X-Received: by 2002:a17:903:947:b0:206:a6e7:39c3 with SMTP id
 d9443c01a7336-206f04e1713mr132654255ad.13.1725949128671; Mon, 09 Sep 2024
 23:18:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240820071913.68004-1-xuanzhuo@linux.alibaba.com>
 <20240906044143-mutt-send-email-mst@kernel.org> <1725612818.815039-1-xuanzhuo@linux.alibaba.com>
 <20240906045904-mutt-send-email-mst@kernel.org> <1725614736.9464588-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEt4XmMnZWEK56npxiA_QB0x48AU9fWfA63y5PHuHpLdBQ@mail.gmail.com> <1725871401.4568927-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1725871401.4568927-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 10 Sep 2024 14:18:37 +0800
Message-ID: <CACGkMEvfC=Jf169V-J7oU5Z3QY7ET7L5NH_WJvC2gsDYV2wfHg@mail.gmail.com>
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

On Mon, Sep 9, 2024 at 4:50=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> On Mon, 9 Sep 2024 16:38:16 +0800, Jason Wang <jasowang@redhat.com> wrote=
:
> > On Fri, Sep 6, 2024 at 5:32=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibab=
a.com> wrote:
> > >
> > > On Fri, 6 Sep 2024 05:08:56 -0400, "Michael S. Tsirkin" <mst@redhat.c=
om> wrote:
> > > > On Fri, Sep 06, 2024 at 04:53:38PM +0800, Xuan Zhuo wrote:
> > > > > On Fri, 6 Sep 2024 04:43:29 -0400, "Michael S. Tsirkin" <mst@redh=
at.com> wrote:
> > > > > > On Tue, Aug 20, 2024 at 03:19:13PM +0800, Xuan Zhuo wrote:
> > > > > > > leads to regression on VM with the sysctl value of:
> > > > > > >
> > > > > > > - net.core.high_order_alloc_disable=3D1
> > > > > > >
> > > > > > > which could see reliable crashes or scp failure (scp a file 1=
00M in size
> > > > > > > to VM):
> > > > > > >
> > > > > > > The issue is that the virtnet_rq_dma takes up 16 bytes at the=
 beginning
> > > > > > > of a new frag. When the frag size is larger than PAGE_SIZE,
> > > > > > > everything is fine. However, if the frag is only one page and=
 the
> > > > > > > total size of the buffer and virtnet_rq_dma is larger than on=
e page, an
> > > > > > > overflow may occur. In this case, if an overflow is possible,=
 I adjust
> > > > > > > the buffer size. If net.core.high_order_alloc_disable=3D1, th=
e maximum
> > > > > > > buffer size is 4096 - 16. If net.core.high_order_alloc_disabl=
e=3D0, only
> > > > > > > the first buffer of the frag is affected.
> > > > > > >
> > > > > > > Fixes: f9dac92ba908 ("virtio_ring: enable premapped mode what=
ever use_dma_api")
> > > > > > > Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
> > > > > > > Closes: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba=
164a540c0a@oracle.com
> > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > >
> > > > > >
> > > > > > Guys where are we going with this? We have a crasher right now,
> > > > > > if this is not fixed ASAP I'd have to revert a ton of
> > > > > > work Xuan Zhuo just did.
> > > > >
> > > > > I think this patch can fix it and I tested it.
> > > > > But Darren said this patch did not work.
> > > > > I need more info about the crash that Darren encountered.
> > > > >
> > > > > Thanks.
> > > >
> > > > So what are we doing? Revert the whole pile for now?
> > > > Seems to be a bit of a pity, but maybe that's the best we can do
> > > > for this release.
> > >
> > > @Jason Could you review this?
> >
> > I think we probably need some tweaks for this patch.
> >
> > For example, the changelog is not easy to be understood especially
> > consider it starts something like:
> >
> > "
> >     leads to regression on VM with the sysctl value of:
> >
> >     - net.core.high_order_alloc_disable=3D1
> >
> >     which could see reliable crashes or scp failure (scp a file 100M in=
 size
> >     to VM):
> > "
> >
> > Need some context and actually sysctl is not a must to reproduce the
> > issue, it can also happen when memory is fragmented.
>
> OK.
>
>
> >
> > Another issue is that, if we move the skb_page_frag_refill() out of
> > the virtnet_rq_alloc(). The function semantics turns out to be weird:
> >
> > skb_page_frag_refill(len, &rq->alloc_frag, gfp);
> > ...
> > virtnet_rq_alloc(rq, len, gfp);
>
> YES.
>
> >
> > I wonder instead of subtracting the dma->len, how about simply count
> > the dma->len in len if we call virtnet_rq_aloc() in
> > add_recvbuf_small()?
>
> 1. For the small mode, it is safe. That just happens in the merge mode.
> 2. In the merge mode, if we count the dma->len in len, we should know
>    if the frag->offset is zero or not. We can not do that before
>    skb_page_frag_refill(), because skb_page_frag_refill() may allocate
>    new page, the frag->offset is zero. So the judgment must is after
>    skb_page_frag_refill().

I may miss something. I mean always reserve dma->len for each frag.

But anyway, we need to tweak the function API, either explicitly pass
the frag or use the rq->frag implicitly.

Thanks

>
> Thanks.
>
>
> >
> > >
> > > I think this problem is clear, though I do not know why it did not wo=
rk
> > > for Darren.
> >
> > I had a try. This issue could be reproduced easily and this patch
> > seems to fix the issue with a KASAN enabled kernel.
> >
> > Thanks
> >
> > >
> > > Thanks.
> > >
> > >
> > > >
> > > >
> > > > > >
> > > > > >
> > > > > > > ---
> > > > > > >  drivers/net/virtio_net.c | 12 +++++++++---
> > > > > > >  1 file changed, 9 insertions(+), 3 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_ne=
t.c
> > > > > > > index c6af18948092..e5286a6da863 100644
> > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > @@ -918,9 +918,6 @@ static void *virtnet_rq_alloc(struct rece=
ive_queue *rq, u32 size, gfp_t gfp)
> > > > > > >         void *buf, *head;
> > > > > > >         dma_addr_t addr;
> > > > > > >
> > > > > > > -       if (unlikely(!skb_page_frag_refill(size, alloc_frag, =
gfp)))
> > > > > > > -               return NULL;
> > > > > > > -
> > > > > > >         head =3D page_address(alloc_frag->page);
> > > > > > >
> > > > > > >         dma =3D head;
> > > > > > > @@ -2421,6 +2418,9 @@ static int add_recvbuf_small(struct vir=
tnet_info *vi, struct receive_queue *rq,
> > > > > > >         len =3D SKB_DATA_ALIGN(len) +
> > > > > > >               SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > > > > > >
> > > > > > > +       if (unlikely(!skb_page_frag_refill(len, &rq->alloc_fr=
ag, gfp)))
> > > > > > > +               return -ENOMEM;
> > > > > > > +
> > > > > > >         buf =3D virtnet_rq_alloc(rq, len, gfp);
> > > > > > >         if (unlikely(!buf))
> > > > > > >                 return -ENOMEM;
> > > > > > > @@ -2521,6 +2521,12 @@ static int add_recvbuf_mergeable(struc=
t virtnet_info *vi,
> > > > > > >          */
> > > > > > >         len =3D get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_le=
n, room);
> > > > > > >
> > > > > > > +       if (unlikely(!skb_page_frag_refill(len + room, alloc_=
frag, gfp)))
> > > > > > > +               return -ENOMEM;
> > > > > > > +
> > > > > > > +       if (!alloc_frag->offset && len + room + sizeof(struct=
 virtnet_rq_dma) > alloc_frag->size)
> > > > > > > +               len -=3D sizeof(struct virtnet_rq_dma);
> > > > > > > +
> > > > > > >         buf =3D virtnet_rq_alloc(rq, len + room, gfp);
> > > > > > >         if (unlikely(!buf))
> > > > > > >                 return -ENOMEM;
> > > > > > > --
> > > > > > > 2.32.0.3.g01195cf9f
> > > > > >
> > > >
> > >
> >
>

