Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4182FC4332F
	for <virtualization@archiver.kernel.org>; Thu, 15 Dec 2022 09:16:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C348F60ACD;
	Thu, 15 Dec 2022 09:16:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C348F60ACD
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V9PZyhZm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FQTKlTITfpWO; Thu, 15 Dec 2022 09:16:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4017D60A98;
	Thu, 15 Dec 2022 09:16:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4017D60A98
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0DA6AC0033;
	Thu, 15 Dec 2022 09:16:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E2ABC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Dec 2022 09:16:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0C59F81FA3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Dec 2022 09:16:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0C59F81FA3
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=V9PZyhZm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6IgfMnQaycjg
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Dec 2022 09:16:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DE3E481FA1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DE3E481FA1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Dec 2022 09:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671095758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lC0q2v1Ms1RwMBWk+EIJ5wdM8fzD9SD5v3dqY2kTOsc=;
 b=V9PZyhZm2PqE6UeNX9QVzoBlD0ROMyyDKXwHxYl8YYkWt1hdeJ4as2z/abHHyNkh0yrsk2
 pGOxEhvyaGNN/qcmoCFigm+1ZGfMJ7PETvgtIU9xgJhxo7QddECtknCq3myWJmh/kvtr00
 30cmPyiP3eT2lqbykJZ+sTv2Tf+O/IA=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-168-1ZMfF5ctORWLpJiZaS5DoQ-1; Thu, 15 Dec 2022 04:15:55 -0500
X-MC-Unique: 1ZMfF5ctORWLpJiZaS5DoQ-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-14496b502dfso6876018fac.17
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Dec 2022 01:15:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lC0q2v1Ms1RwMBWk+EIJ5wdM8fzD9SD5v3dqY2kTOsc=;
 b=RGvo8eNL/FbGPIgNkwv/Kq35/9LQvdSLbHo3/5gr19RdQW0bvMfEilnUJrGDMt/I7T
 AM3AAaL2dMdfv8Qqw9q95EWejHtYlzVirfeCCv5vrd3PzC5+MkCt7X4AINDCInifeOHM
 IA5oowtx1kWA/lds3FsBBa8faBPJcr55KzcRbd0x7Qb4jgspMnM/mtqrpy7qjgkG/TVh
 i34t3syRp35W8j2ln2R/roW1zBf/VHfp7lk4tUGXZImbuuZ55gR/nH1LFjKfLxH8VsC4
 nIx2a605P83sTFL6plh6DtzL//JU9ysnOUuV9BsRByIZq51U3Q3CjxNTpCufVz1CHdKu
 gOtw==
X-Gm-Message-State: ANoB5pm6MyX2VPvi3RWq588Sa3A8RQX6K+SzIvNqMVMD9CRGgxVCoBSM
 cSgl73sd/FjYb29LDmBAPpebMlXQkEppb1o4KhjrCjBOTKYUtDZnglAN3UCF8G0O3fmteM9b5AJ
 sV04ji6dE/C6VVTNC4nYnq7yMLC+VyU0/qcXk+cqkkY+h5Xlgyy/hUiXPog==
X-Received: by 2002:a05:6870:9e8f:b0:144:a97b:1ae2 with SMTP id
 pu15-20020a0568709e8f00b00144a97b1ae2mr95008oab.35.1671095754730; 
 Thu, 15 Dec 2022 01:15:54 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5EHbNOPkZfylg33J79++dPcOATXw0I6yodET6T4YfzW2bTB6xnRR0Mde8v49QFni7U7MDkwOsKmYmKzb3k5JU=
X-Received: by 2002:a05:6870:9e8f:b0:144:a97b:1ae2 with SMTP id
 pu15-20020a0568709e8f00b00144a97b1ae2mr95002oab.35.1671095754482; Thu, 15 Dec
 2022 01:15:54 -0800 (PST)
MIME-Version: 1.0
References: <20221215032719.72294-1-jasowang@redhat.com>
 <20221215034740-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221215034740-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 15 Dec 2022 17:15:43 +0800
Message-ID: <CACGkMEsLeCRDqyuyGzWw+kjYrTVDjUjOw6+xHESPT2D1p03=sQ@mail.gmail.com>
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

On Thu, Dec 15, 2022 at 5:02 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Dec 15, 2022 at 11:27:19AM +0800, Jason Wang wrote:
> > Commit a7766ef18b33("virtio_net: disable cb aggressively") enables
> > virtqueue callback via the following statement:
> >
> >         do {
> >            ......
> >       } while (use_napi && kick &&
> >                unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> >
> > When NAPI is used and kick is false, the callback won't be enabled
> > here. And when the virtqueue is about to be full, the tx will be
> > disabled, but we still don't enable tx interrupt which will cause a TX
> > hang. This could be observed when using pktgen with burst enabled.
> >
> > Fixing this by trying to enable tx interrupt after we disable TX when
> > we're not using napi or kick is false.
> >
> > Fixes: a7766ef18b33 ("virtio_net: disable cb aggressively")
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> > The patch is needed for -stable.
> > Changes since V1:
> > - enable tx interrupt after we disable tx
> > ---
> >  drivers/net/virtio_net.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 86e52454b5b5..dcf3a536d78a 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -1873,7 +1873,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
> >        */
> >       if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
> >               netif_stop_subqueue(dev, qnum);
> > -             if (!use_napi &&
> > +             if ((!use_napi || !kick) &&
> >                   unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
> >                       /* More just got used, free them then recheck. */
> >                       free_old_xmit_skbs(sq, false);
>
> This will work but the following lines are:
>
>                        if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
>                                 netif_start_subqueue(dev, qnum);
>                                 virtqueue_disable_cb(sq->vq);
>                         }
>
>
> and I thought we are supposed to keep callbacks enabled with napi?

This seems to be the opposite logic of commit a7766ef18b33 that
disables callbacks for NAPI.

It said:

    There are currently two cases where we poll TX vq not in response to a
    callback: start xmit and rx napi.  We currently do this with callbacks
    enabled which can cause extra interrupts from the card.  Used not to be
    a big issue as we run with interrupts disabled but that is no longer the
    case, and in some cases the rate of spurious interrupts is so high
    linux detects this and actually kills the interrupt.

My undersatnding is that it tries to disable callbacks on TX.

> One of the ideas of napi is to free on napi callback, not here
> immediately.
>
> I think it is easier to just do a separate branch here. Along the
> lines of:
>
>                 if (use_napi) {
>                         if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)))
>                                 virtqueue_napi_schedule(napi, vq);

This seems to be a new logic and it causes some delay in processing TX
(unnecessary NAPI).

>                 } else {
>                         ... old code ...
>                 }
>
> also reduces chances of regressions on !napi (which is not well tested)
> and keeps callbacks off while we free skbs.

I think my patch doesn't change the logic of !napi? (It checks !napi || kick).

Thanks

>
> No?
>
>
> > --
> > 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
