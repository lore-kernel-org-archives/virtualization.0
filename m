Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37CE286287
	for <virtualization@lists.linux.dev>; Wed, 19 Feb 2025 00:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739925093; cv=none; b=coe+sEUaBuO9pgx2uaIoNXgCqasi42Jni08uRH1R6zhzaGN3pVQ28m3PJvN9KfVMd4ScCysDBCREUky7yyHFlb3HWiFu9aaw96niN+ycH99aLlkbdi1dSyoCj6oZp6W04n04g646XO4JZY/9G4Ogs0XYR/LGE9eoJWxuPQbsLFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739925093; c=relaxed/simple;
	bh=Na0GNiLT4L4zLHxrtoE/rvr4Nade4nh6Grlkymh5FJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BWkL5y5f0QifUqZszxIaxfIE6O6eBg4WegXoIiOw+mv9g6SoHJKMwF1upriXZ4vx9FxvSMIAa3WSvCkmdvNo/xMntIiPZVfDQXiJwNERH03PNHpW4lOyHSDT8aQPPZg9rsiunbC3TqBF7gb4knhhjkSpI0KhJkh1j7L4Aeu5uw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hc/bXMVp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hc/bXMVp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739925090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YAmwz/TJol3C4T2p6erXBkDQSw4VvEw2r6fPlWa4qmk=;
	b=Hc/bXMVpULIJn3JRLj6s6TznCVkSTkccg4S/LKT5zPf6DSZmx02zg67MgfwW7Vj/8LuF67
	SxwawP1WFTnsnkyWrLSd7MpIKWbIelpJFA3NjKl4UFC+KLDb+Tdn8dmWE03vzF6skz05qg
	WWWSQJIxjOX3pxyIB1/wHfYDo8E9XO4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-Ap_t5ivHMAuWZxKxwSbvkg-1; Tue, 18 Feb 2025 19:31:29 -0500
X-MC-Unique: Ap_t5ivHMAuWZxKxwSbvkg-1
X-Mimecast-MFC-AGG-ID: Ap_t5ivHMAuWZxKxwSbvkg_1739925088
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fc17c3eeb5so11157351a91.1
        for <virtualization@lists.linux.dev>; Tue, 18 Feb 2025 16:31:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739925088; x=1740529888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YAmwz/TJol3C4T2p6erXBkDQSw4VvEw2r6fPlWa4qmk=;
        b=sp3VHOK7XiRqefHXCnHSV819+ryk2u//+TuBPoqQeubyDdX6gUuYLRjHnvLLwePrWl
         QVM2mc1+v6Wf7IP1C/0IZtmyxkq4dODQBZs8in/B49pXbKcPT6DX+HqYOM/hyNoowmXE
         Swx1Lt084IYpBFU82uvsS/DRp56Z+rZyavO7fJTzP/6tKwlpeAMcoGNlatnBDbiKJoQf
         8bvxze3/t/MOI5hwNBdRnXJlFyYgSMsYnju5fdsfHtX2DnvnFRIpT2er3XRBVoCB4zTU
         Mhb8SxfzjoibcyKUIQAeYPnGv/eAFgwHsEqOVTuBl8u/lMelimZe7vypMqQEg0gphCLq
         8+7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXJMGlEotyGRQCJu2tV7RtJV+5bPDU16okVSCgqZb4vMSDm1jZFRqzrIS/OEL6CzVTFGvwxplq7MnTiYLyhfQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzYM+iJOfHAptmFikLfjQwD1O6QtmVjsXEvDHEH/+xViN7zSifG
	pC6nmWAMPcBdK6guIsBucV0T0NCoNxUGkEeJx/Q/3r+QPlIERoK2rCxv5v0nAjuZnoF5zSVuSw4
	bZTcPmyMSCj3CxmdGIY3k9ITga1decn6CO9WNv2FSaPx1kWQvvYUug86KHs8vmxFt3ZP897RvJc
	7q4qLC/VZlI3deDNkyqhqKhAQCh/5+cwap+H94378=
X-Gm-Gg: ASbGncvAYJoqWfz3zx04qyqDHe6Wqc/Mh8kVQsuSrz4R9FXylIL0elNApD8u4eteE2a
	F6D1E9qMHFsJcNIYenyKR1W/BidbAijcB+Z1JbkeieZIuAuNIBpnrpJZQnaO9BTU=
X-Received: by 2002:a17:90b:3d86:b0:2fa:e9b:33b8 with SMTP id 98e67ed59e1d1-2fc40f22d67mr28344805a91.18.1739925088335;
        Tue, 18 Feb 2025 16:31:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEN+NiCiTEw2BOo1eSpKQjrIpmFz6sGzkC9hWo0e38VXbikFKkp+S2HXR9/BCBMga/6/gY/Qx+e/Anbnv7VRik=
X-Received: by 2002:a17:90b:3d86:b0:2fa:e9b:33b8 with SMTP id
 98e67ed59e1d1-2fc40f22d67mr28344773a91.18.1739925087954; Tue, 18 Feb 2025
 16:31:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250218023908.1755-1-jasowang@redhat.com> <20250218034919-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250218034919-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 19 Feb 2025 08:31:16 +0800
X-Gm-Features: AWEUYZmcRGjFhBQePkw-Og0LRELmpBWQ_jYA7oPxy5AXeKWPLYOKXF4KpjxgiY4
Message-ID: <CACGkMEu5UtkDvVuNd5fxsbVSOtqzNE92R6SzjsREaLFTJ8=NUA@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio-net: tweak for better TX performance in
 NAPI mode
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0fBCTlGcfg_Uj-9FQyj-z-uC3hlgcv-lEG2Dfh9o6sI_1739925088
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 4:49=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
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
> can you pls also test perf with tx irq disabled mode, to be sure?

Yes, performance doesn't change in orphan mode (both PPS and throughput).

This matches the patch that doesn't not change any logic for orphan mode.

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

