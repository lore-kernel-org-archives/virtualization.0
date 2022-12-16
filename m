Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 509B4C4332F
	for <virtualization@archiver.kernel.org>; Fri, 16 Dec 2022 03:43:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C963382139;
	Fri, 16 Dec 2022 03:43:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C963382139
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OYOLlqLA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dp9l0UKCMqeR; Fri, 16 Dec 2022 03:43:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5076A82135;
	Fri, 16 Dec 2022 03:43:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5076A82135
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14AA9C0033;
	Fri, 16 Dec 2022 03:43:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5EAA8C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 03:43:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 26AC440191
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 03:43:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 26AC440191
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=OYOLlqLA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Nph7MagcinNK
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 03:43:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 22786400D1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 22786400D1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 03:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671162207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zfz+hZsu0mSAfvWAnAaAGFxMGv6r+4O1MrzGOXMUmB0=;
 b=OYOLlqLA3thT6abxI5LkqFhaqymNoT28YHyr8DeXX6VfcxQZEF0WD0chM/ZMkPo/nsObWn
 xF1PkxYMnCNLLE1PIJGcHOv3ayTCRDeQj/eXYR9zswBqR62GZ4qu4z0NOCIsfypncCxWac
 qyxzN7XvEhVo1NRPivthAiflwUGzcMI=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-190-WnOdohQLOeG8ufbCF2nbNg-1; Thu, 15 Dec 2022 22:43:25 -0500
X-MC-Unique: WnOdohQLOeG8ufbCF2nbNg-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-143d68edfa1so707190fac.11
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Dec 2022 19:43:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zfz+hZsu0mSAfvWAnAaAGFxMGv6r+4O1MrzGOXMUmB0=;
 b=hO2nALXlV5CNk4nduvjXCrfgBRyw1huFQLJVF2Kdv5kxo+8q2TMTtoq1PUAHXz9UgM
 k/X99hEqZlcUIfva7KdbaKf7lLfylgD3oEeCLgL/0K4Z7GBeLeOsh2C1k/o1oPQqs1Vc
 6eKDYZSAFsEEQom3JBmsXGt6gw8u1m4D9aCBxbXMVeJv1P0SCxzOCWeGdcavnsshjUos
 fCdakcxyN5U2WUM8c8Ar2m20uhfIU28FhZqTlubik39Mes49voD+UCwkflA3HU39woNI
 iOIX2MUk1JScJF/uuBNtxnKx2eIil8rQ+r11eVfhWYfevFpy7wOQDQoqdVRURT8syoc8
 Roug==
X-Gm-Message-State: ANoB5pm3fQh9dD/eYMQ5teZlYPFp55a/ZoswBW/W7Z4deJ6Ghar8LB1I
 rUz1qdqDTs3MF4lLdhRVY2lyqqE/KwDPi5CGIxZfP8/utX9MivWFAxlep7DS+3u8kGH2CtN30vK
 SUbF1t6Jxy8pyVFANIjjQ9FtrXvTNpJ2n1QFtwwqN3fuwxfs2fhFNeS/EDw==
X-Received: by 2002:a05:6870:9e8f:b0:144:a97b:1ae2 with SMTP id
 pu15-20020a0568709e8f00b00144a97b1ae2mr319391oab.35.1671162204861; 
 Thu, 15 Dec 2022 19:43:24 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7OmOp/XpirrXRViBtMxKqtenidH9XAN95sX4U25/bIv5XYq0XBM55D6y7jxPwBaziM5LOxB28ONerqMfvW4eI=
X-Received: by 2002:a05:6870:9e8f:b0:144:a97b:1ae2 with SMTP id
 pu15-20020a0568709e8f00b00144a97b1ae2mr319384oab.35.1671162204619; Thu, 15
 Dec 2022 19:43:24 -0800 (PST)
MIME-Version: 1.0
References: <20221215032719.72294-1-jasowang@redhat.com>
 <20221215034740-mutt-send-email-mst@kernel.org>
 <CACGkMEsLeCRDqyuyGzWw+kjYrTVDjUjOw6+xHESPT2D1p03=sQ@mail.gmail.com>
 <20221215042918-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221215042918-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 16 Dec 2022 11:43:13 +0800
Message-ID: <CACGkMEsbvTQrEp5dmQRHp58Mu=E7f433Xrvsbs4nZMA5R3B6mQ@mail.gmail.com>
Subject: Re: [PATCH net V2] virtio-net: correctly enable callback during
 start_xmit
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Dec 15, 2022 at 5:35 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Dec 15, 2022 at 05:15:43PM +0800, Jason Wang wrote:
> > On Thu, Dec 15, 2022 at 5:02 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Thu, Dec 15, 2022 at 11:27:19AM +0800, Jason Wang wrote:
> > > > Commit a7766ef18b33("virtio_net: disable cb aggressively") enables
> > > > virtqueue callback via the following statement:
> > > >
> > > >         do {
> > > >            ......
> > > >       } while (use_napi && kick &&
> > > >                unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> > > >
> > > > When NAPI is used and kick is false, the callback won't be enabled
> > > > here. And when the virtqueue is about to be full, the tx will be
> > > > disabled, but we still don't enable tx interrupt which will cause a TX
> > > > hang. This could be observed when using pktgen with burst enabled.
> > > >
> > > > Fixing this by trying to enable tx interrupt after we disable TX when
> > > > we're not using napi or kick is false.
> > > >
> > > > Fixes: a7766ef18b33 ("virtio_net: disable cb aggressively")
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > ---
> > > > The patch is needed for -stable.
> > > > Changes since V1:
> > > > - enable tx interrupt after we disable tx
> > > > ---
> > > >  drivers/net/virtio_net.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index 86e52454b5b5..dcf3a536d78a 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -1873,7 +1873,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
> > > >        */
> > > >       if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
> > > >               netif_stop_subqueue(dev, qnum);
> > > > -             if (!use_napi &&
> > > > +             if ((!use_napi || !kick) &&
> > > >                   unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
> > > >                       /* More just got used, free them then recheck. */
> > > >                       free_old_xmit_skbs(sq, false);
> > >
> > > This will work but the following lines are:
> > >
> > >                        if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
> > >                                 netif_start_subqueue(dev, qnum);
> > >                                 virtqueue_disable_cb(sq->vq);
> > >                         }
> > >
> > >
> > > and I thought we are supposed to keep callbacks enabled with napi?
> >
> > This seems to be the opposite logic of commit a7766ef18b33 that
> > disables callbacks for NAPI.
> >
> > It said:
> >
> >     There are currently two cases where we poll TX vq not in response to a
> >     callback: start xmit and rx napi.  We currently do this with callbacks
> >     enabled which can cause extra interrupts from the card.  Used not to be
> >     a big issue as we run with interrupts disabled but that is no longer the
> >     case, and in some cases the rate of spurious interrupts is so high
> >     linux detects this and actually kills the interrupt.
> >
> > My undersatnding is that it tries to disable callbacks on TX.
>
> I think we want to disable callbacks while polling, yes. here we are not
> polling, and I think we want a callback because otherwise nothing will
> orphan skbs and a socket can be blocked, not transmitting anything - a
> deadlock.

I'm not sure how I got here, did you mean a partial revert of
a7766ef18b33 (the part that disables TX callbacks on start_xmit)?

Btw, I plan to remove non NAPI mode completely, since it was disabled
by default for years and we don't see any complaint, then we may have
modern features like BQL and better TCP performance. In that sense we
may simply keep tx callback open as most of modern NIC did.

>
> > > One of the ideas of napi is to free on napi callback, not here
> > > immediately.
> > >
> > > I think it is easier to just do a separate branch here. Along the
> > > lines of:
> > >
> > >                 if (use_napi) {
> > >                         if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)))
> > >                                 virtqueue_napi_schedule(napi, vq);
> >
> > This seems to be a new logic and it causes some delay in processing TX
> > (unnecessary NAPI).
>
> That's good, we overloaded the queue so we are already going
> too fast, deferring tx so queue has chance to drain
> will allow better batching in the qdisc.

I meant, compare to

1) schedule NAPI and poll TX

The current code did

2) poll TX immediately

2) seems faster?

Thanks

>
> > >                 } else {
> > >                         ... old code ...
> > >                 }
> > >
> > > also reduces chances of regressions on !napi (which is not well tested)
> > > and keeps callbacks off while we free skbs.
> >
> > I think my patch doesn't change the logic of !napi? (It checks !napi || kick).
> >
> > Thanks
>
> I agree it doesn't seem to as written.
>
> > >
> > > No?
> > >
> > >
> > > > --
> > > > 2.25.1
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
