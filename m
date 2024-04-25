Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D2D3BBF1
	for <virtualization@lists.linux.dev>; Thu, 25 Apr 2024 06:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714025097; cv=none; b=QJ+YMJL9Y/ucM3cjGgGleiAucTG00H9qZi7MdlryIJ8zrBDZEv4GDteoVJAuYpdnmLAM/vYBg2hyNdPkoJ3QFiMO/rIRr7ffseatOa4bXP3cA83gJNpmY5TOY5vTpE+U5+RQPi2gxVA3rYt/3AEzFpBlcU5eznNejtc8N1dgHkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714025097; c=relaxed/simple;
	bh=yoyDuhImaFYk6MfODe7FWOzq5lPz3/6sKseHfzmm3YU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QzUOZdHCZyijkZ1i7zZS4mwSquKI51AJbuTm6Z29d32O+slNvkeYmCtsfBq/8v1NLkvZAYVFaMtOEw3nKqMn9q28PpaTBHdvH72Cmqd4B4blXu7edQiqBRa4V6ck/uGeDIk8zjcGGJktkJQsUVyveae4p72Bjf5gxV9x+tficdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EjU6S75R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EjU6S75R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714025094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2VqVkXo1lE+9fpUNrU4aH8DrBoZjKZt/x6xACkTCsDc=;
	b=EjU6S75ReSb9jLeEsput9CxNRYDU1MoTHMe89y1rgYm6Tzb2Fh7DdwEophmCByRqdOSi4b
	+TjuZkrVaDJkTzFee+ay11C32H926gy8KJCXcllgVW+w6NO31YfvDhRkEHDjArT4a5tomk
	SeHWAQPMJPPXDqs157tnWt1HTDk1Hbs=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-fz7y-kPVO4K9rFGjik18yg-1; Thu, 25 Apr 2024 02:04:51 -0400
X-MC-Unique: fz7y-kPVO4K9rFGjik18yg-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2a2f7048a7fso769321a91.2
        for <virtualization@lists.linux.dev>; Wed, 24 Apr 2024 23:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714025090; x=1714629890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2VqVkXo1lE+9fpUNrU4aH8DrBoZjKZt/x6xACkTCsDc=;
        b=R+wKI9Ab7LaovbQe0s8AOUmEX/PqtXXnoDps1afqXgiL/+bnCcXRrymjQpy+4OtY8y
         buvh0vV0dTdbldt1BUie5sEvh0PehQH76PLLkhfo4TLVNF+2YFbtAzVLzt8aaYloUika
         jhvRFTopqvNwvCubLmqbkftdj+sVvMJyYyoUzcbi82ltyWGiRR/UAWz1yWzwsSJ/cfVr
         P1awPkkc1ysdnOeRE1mdBAZ8SOC8Rtc9tI8sjemmE6sssGaefIc1YiT8zW8jSoTAINuu
         tZXOskzsLDJQc0qCUo3PA2MV0TviBdCtxP5WGjk/735Aloi1MSM+SQy+IL3tHIaIGs8C
         RCLw==
X-Gm-Message-State: AOJu0Yz4En7TfVrhs2GAG+6cYgEmAzXN//mOHNRb8dSgxrH9uh5qYsOD
	QkAs11LrcjADbj6o6Eln5gr6DmfoZDd4607a0ojTc4KGP6L5m+Je9QOn/LRZ3VG2u+mXv8/BwKF
	L0NJ0505gc0R0qni6az07BpxolS0SuR2WfhHXu0D3uJI5r7wrwk31Uy/2eJEszr2eYVS9SAOjCW
	u+mcVq1NH+JGpUsvBjOe7C8q9vTygGeqiAiEoUAAU=
X-Received: by 2002:a17:90a:744f:b0:2ac:257d:3e7c with SMTP id o15-20020a17090a744f00b002ac257d3e7cmr4850607pjk.9.1714025090184;
        Wed, 24 Apr 2024 23:04:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGk1Zk4n8BNQN3/HiN3DwbEZl719SLEOZEGJXMcEDPIdNVxRJ8DswGiPqBmV3wMyKxXlJmav9ONmNVL2nM68TU=
X-Received: by 2002:a17:90a:744f:b0:2ac:257d:3e7c with SMTP id
 o15-20020a17090a744f00b002ac257d3e7cmr4850590pjk.9.1714025089840; Wed, 24 Apr
 2024 23:04:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240424081636.124029-1-xuanzhuo@linux.alibaba.com>
 <20240424081636.124029-3-xuanzhuo@linux.alibaba.com> <CACGkMEtf9twxTSGpGpmcR4LYS_k1g=NRO78NhkG4uLJ3d+TqAA@mail.gmail.com>
 <1714012507.44893-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1714012507.44893-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 25 Apr 2024 14:04:38 +0800
Message-ID: <CACGkMEu3M8_izh837Z5Eg7uJTVUGNAKcdGRcF=7FAu_REZ1tyA@mail.gmail.com>
Subject: Re: [PATCH vhost v3 2/4] virtio_net: big mode skip the unmap check
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 10:37=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> On Thu, 25 Apr 2024 10:11:55 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Wed, Apr 24, 2024 at 4:17=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > The virtio-net big mode did not enable premapped mode,
> > > so we did not need to check the unmap. And the subsequent
> > > commit will remove the failover code for failing enable
> > > premapped for merge and small mode. So we need to remove
> > > the checking do_dma code in the big mode path.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/net/virtio_net.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index c22d1118a133..16d84c95779c 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -820,7 +820,7 @@ static void virtnet_rq_unmap_free_buf(struct virt=
queue *vq, void *buf)
> > >
> > >         rq =3D &vi->rq[i];
> > >
> > > -       if (rq->do_dma)
> > > +       if (!vi->big_packets || vi->mergeable_rx_bufs)
> >
> > This seems to be equivalent to
> >
> > if (!vi->big_packets)
>
>
> If VIRTIO_NET_F_MRG_RXBUF and guest_gso are coexisting,
> big_packets and mergeable_rx_bufs are all true.
> !vi->big_packets only means the small.
>
> Did I miss something?

Nope, you are right.

The big_packets are kind of misleading as it doesn't mean big mode.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>
> Thanks.
>
>
> >
> >
> > >                 virtnet_rq_unmap(rq, buf, 0);
> > >
> > >         virtnet_rq_free_buf(vi, rq, buf);
> > > @@ -2128,7 +2128,7 @@ static int virtnet_receive(struct receive_queue=
 *rq, int budget,
> > >                 }
> > >         } else {
> > >                 while (packets < budget &&
> > > -                      (buf =3D virtnet_rq_get_buf(rq, &len, NULL)) !=
=3D NULL) {
> > > +                      (buf =3D virtqueue_get_buf(rq->vq, &len)) !=3D=
 NULL) {
> > >                         receive_buf(vi, rq, buf, len, NULL, xdp_xmit,=
 &stats);
> > >                         packets++;
> > >                 }
> >
> > Other part looks good.
> >
> > Thanks
> >
> > > --
> > > 2.32.0.3.g01195cf9f
> > >
> >
>

