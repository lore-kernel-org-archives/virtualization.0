Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA93E13DB9F
	for <virtualization@lists.linux.dev>; Fri, 21 Feb 2025 00:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740099361; cv=none; b=pF74/U8dvGoZxOaaER667KWs+2Fv1Yn6wgge+B7F4z2eT2acGwzZ+7qUfDMbDDrBoVQM/WxdNq+1xTJnc63y3F79W2RabezZ5O/hDidzA0AH9NsgdcukJ5RzNWba8dUcf7srh7Ibu4xgAZ0XmhOEYx/uQwNZnrWerQW0PzvSaTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740099361; c=relaxed/simple;
	bh=fV1mBsSJF2DsjbNy6DP++8YFbTYKXele61nzgQiiQfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OQBA179ucKbPGBuToXddMBuWygu+IUcOSM7KPOi+fasw5SKDeFUR+b1Gi97f9ckpxZFQsOm9i3P24t3yi5tQdOCQiOHgJUYR7c2t0NoJh1s460hpcVuL9M61YASG/nLNALJQZKg0kjBDAky3Fk1EEAq+eFWWYm7/TJ5e76CTKLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QtLkdUSy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QtLkdUSy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740099357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GNy7L+vuP5BvqDAnGLHquOls1vdb8Cwyy2NuM7jwo8I=;
	b=QtLkdUSyTAumHrWo5PMDpHLALumygO0qTwIM/Hxd9UjUEr0JIx+PrtY4nHF0iiDIS2BLy1
	crNvJLZ/WoWkKWRtifOeXiBYPsT2yEAUlYT/OEzb1Aw+fpVFxcfeL6OnkHbyvu3XKIJdjb
	50tgueN1LdcvX2IRu23q8vibakjqtMI=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-FSa3F-CaPJyP0JENlYKZMg-1; Thu, 20 Feb 2025 19:55:56 -0500
X-MC-Unique: FSa3F-CaPJyP0JENlYKZMg-1
X-Mimecast-MFC-AGG-ID: FSa3F-CaPJyP0JENlYKZMg_1740099355
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-220f0382404so29916025ad.1
        for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 16:55:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740099355; x=1740704155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GNy7L+vuP5BvqDAnGLHquOls1vdb8Cwyy2NuM7jwo8I=;
        b=wDiUQuKxarjJKHpDJMs8bHG28EtVbvTC7NLpg67qnvePM2zwYqdJAbhJ7SPEvf+DVn
         u7oQ6+mrbeQpfmJVvt7e8ZEr+ANmHKzX+Ly1EWkQWmUDSubUbD6B4IXFp9RrKpnCxtqd
         VcDd3Jl5XGvk9RAdiJDI3oIlOsMoACCola2rJGRfksmpN7YcSEyiUjUAFJP3kiVTOnUl
         sa/g5Dw4bbj1XzrlFIwqdflBq0PKgl+Dt/M9giUjKZUuTngILWsIGlPvNtej+icKSWim
         wS7sc6ZmaqsifeUKBfe/MkfsKA/07PcYL/hOYDAgjtVLk0xRYO67r411CfjrWrFyVp4e
         17xA==
X-Forwarded-Encrypted: i=1; AJvYcCU6xV9ZfLk/RwpbKFL+1d6awZkya9cpgi4BWHK7/rvDMT/WK/e1lzwd1gfDy41Y2m/wwTg7aGEbi0zcZCNdow==@lists.linux.dev
X-Gm-Message-State: AOJu0YxRPUR+D4PhEllneTKcvcuXI/Gi5+RmiUnGRYd4ozCU/g2BKHAz
	/u8150sKSyi7SXR1GOnOczimDLYeN2xbL1Tvrj0M6RE9hT9+hD5fyt6fTs2WYslDoiRbQfPqr3e
	tr/KpapgJcqicoNWGHWYwbjgelpOuMb+uc9D1Yv66RKSGlCkPwb/pLSdExGcijz+J0HqrdoIXyy
	GCoPE22tCUfsZa4MOQ4Q+k8F3zIpYJa+AukzpzXeo=
X-Gm-Gg: ASbGncv6gCdAu7DUrqdWVLv4GWMsnFcQ9T5ZYL1duPiA9BXyQk4WllWBkMG1wNLAtwS
	YjwIFfHHUYQ7QvuG3bfCyE9u6kE8e9C+R1DGcTOBO51hLlmmiq4Ctlh/Vsamuhtg=
X-Received: by 2002:a17:902:f689:b0:20d:cb6:11e with SMTP id d9443c01a7336-2219ff61211mr16249535ad.26.1740099355258;
        Thu, 20 Feb 2025 16:55:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8S4q180J8wfgz6tGusfQ0NQthsbHXXSQU0QZSoirAYrGPHl9rkncJDp+BBTc7oqXXlufQB9c7G3k1LOo8rO8=
X-Received: by 2002:a17:902:f689:b0:20d:cb6:11e with SMTP id
 d9443c01a7336-2219ff61211mr16249265ad.26.1740099354751; Thu, 20 Feb 2025
 16:55:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250218023908.1755-1-jasowang@redhat.com> <20250220162359-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250220162359-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 21 Feb 2025 08:55:30 +0800
X-Gm-Features: AWEUYZm8_TusPuJH3xQ4ETsht6VJ5b0urYN8Wvwj2tbdPnWKqkMznfIIszOdZiA
Message-ID: <CACGkMEueUcag6ETNqjPeCaKAird8E9P8JutSmtyOPrGeyaMtpg@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio-net: tweak for better TX performance in
 NAPI mode
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TV0zMXnbc0wVOfpXINJNsUO1oUph69wjFt_gMJ4o7-A_1740099355
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 5:25=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Feb 18, 2025 at 10:39:08AM +0800, Jason Wang wrote:
> > There are several issues existed in start_xmit():
> >
> > - Transmitted packets need to be freed before sending a packet, this
> >   introduces delay and increases the average packets transmit
> >   time. This also increase the time that spent in holding the TX lock.
> > - Notification is enabled after free_old_xmit_skbs() which will
> >   introduce unnecessary interrupts if TX notification happens on the
> >   same CPU that is doing the transmission now (actually, virtio-net
> >   driver are optimized for this case).
> >
> > So this patch tries to avoid those issues by not cleaning transmitted
> > packets in start_xmit() when TX NAPI is enabled and disable
> > notifications even more aggressively. Notification will be since the
> > beginning of the start_xmit(). But we can't enable delayed
> > notification after TX is stopped as we will lose the
> > notifications. Instead, the delayed notification needs is enabled
> > after the virtqueue is kicked for best performance.
> >
> > Performance numbers:
> >
> > 1) single queue 2 vcpus guest with pktgen_sample03_burst_single_flow.sh
> >    (burst 256) + testpmd (rxonly) on the host:
> >
> > - When pinning TX IRQ to pktgen VCPU: split virtqueue PPS were
> >   increased 55% from 6.89 Mpps to 10.7 Mpps and 32% TX interrupts were
> >   eliminated. Packed virtqueue PPS were increased 50% from 7.09 Mpps to
> >   10.7 Mpps, 99% TX interrupts were eliminated.
> >
> > - When pinning TX IRQ to VCPU other than pktgen: split virtqueue PPS
> >   were increased 96% from 5.29 Mpps to 10.4 Mpps and 45% TX interrupts
> >   were eliminated; Packed virtqueue PPS were increased 78% from 6.12
> >   Mpps to 10.9 Mpps and 99% TX interrupts were eliminated.
> >
> > 2) single queue 1 vcpu guest + vhost-net/TAP on the host: single
> >    session netperf from guest to host shows 82% improvement from
> >    31Gb/s to 58Gb/s, %stddev were reduced from 34.5% to 1.9% and 88%
> >    of TX interrupts were eliminated.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
>
> okay
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
> but tell me something, would it be even better to schedule
> napi once, and have that deal with enabling notifications?

I'm not sure I will get here, if we know a NAPI is scheduled, any
reason for enabling notifications?

Thanks

>
> > ---
> >  drivers/net/virtio_net.c | 45 ++++++++++++++++++++++++++++------------
> >  1 file changed, 32 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 7646ddd9bef7..ac26a6201c44 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -1088,11 +1088,10 @@ static bool is_xdp_raw_buffer_queue(struct virt=
net_info *vi, int q)
> >               return false;
> >  }
> >
> > -static void check_sq_full_and_disable(struct virtnet_info *vi,
> > -                                   struct net_device *dev,
> > -                                   struct send_queue *sq)
> > +static bool tx_may_stop(struct virtnet_info *vi,
> > +                     struct net_device *dev,
> > +                     struct send_queue *sq)
> >  {
> > -     bool use_napi =3D sq->napi.weight;
> >       int qnum;
> >
> >       qnum =3D sq - vi->sq;
> > @@ -1114,6 +1113,25 @@ static void check_sq_full_and_disable(struct vir=
tnet_info *vi,
> >               u64_stats_update_begin(&sq->stats.syncp);
> >               u64_stats_inc(&sq->stats.stop);
> >               u64_stats_update_end(&sq->stats.syncp);
> > +
> > +             return true;
> > +     }
> > +
> > +     return false;
> > +}
> > +
> > +static void check_sq_full_and_disable(struct virtnet_info *vi,
> > +                                   struct net_device *dev,
> > +                                   struct send_queue *sq)
> > +{
> > +     bool use_napi =3D sq->napi.weight;
> > +     int qnum;
> > +
> > +     qnum =3D sq - vi->sq;
> > +
> > +     if (tx_may_stop(vi, dev, sq)) {
> > +             struct netdev_queue *txq =3D netdev_get_tx_queue(dev, qnu=
m);
> > +
> >               if (use_napi) {
> >                       if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)=
))
> >                               virtqueue_napi_schedule(&sq->napi, sq->vq=
);
> > @@ -3253,15 +3271,10 @@ static netdev_tx_t start_xmit(struct sk_buff *s=
kb, struct net_device *dev)
> >       bool use_napi =3D sq->napi.weight;
> >       bool kick;
> >
> > -     /* Free up any pending old buffers before queueing new ones. */
> > -     do {
> > -             if (use_napi)
> > -                     virtqueue_disable_cb(sq->vq);
> > -
> > +     if (!use_napi)
> >               free_old_xmit(sq, txq, false);
> > -
> > -     } while (use_napi && !xmit_more &&
> > -            unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> > +     else
> > +             virtqueue_disable_cb(sq->vq);
> >
> >       /* timestamp packet in software */
> >       skb_tx_timestamp(skb);
> > @@ -3287,7 +3300,10 @@ static netdev_tx_t start_xmit(struct sk_buff *sk=
b, struct net_device *dev)
> >               nf_reset_ct(skb);
> >       }
> >
> > -     check_sq_full_and_disable(vi, dev, sq);
> > +     if (use_napi)
> > +             tx_may_stop(vi, dev, sq);
> > +     else
> > +             check_sq_full_and_disable(vi, dev,sq);
> >
> >       kick =3D use_napi ? __netdev_tx_sent_queue(txq, skb->len, xmit_mo=
re) :
> >                         !xmit_more || netif_xmit_stopped(txq);
> > @@ -3299,6 +3315,9 @@ static netdev_tx_t start_xmit(struct sk_buff *skb=
, struct net_device *dev)
> >               }
> >       }
> >
> > +     if (use_napi && kick && unlikely(!virtqueue_enable_cb_delayed(sq-=
>vq)))
> > +             virtqueue_napi_schedule(&sq->napi, sq->vq);
> > +
> >       return NETDEV_TX_OK;
> >  }
> >
> > --
> > 2.34.1
>

