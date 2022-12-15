Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC2A6C4332F
	for <virtualization@archiver.kernel.org>; Thu, 15 Dec 2022 09:35:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1C83140176;
	Thu, 15 Dec 2022 09:35:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1C83140176
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZBFdU0cS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4XptvNV2UhcU; Thu, 15 Dec 2022 09:35:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8414940C08;
	Thu, 15 Dec 2022 09:35:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8414940C08
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61976C0033;
	Thu, 15 Dec 2022 09:35:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51FDFC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Dec 2022 09:35:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2C36240176
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Dec 2022 09:35:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2C36240176
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3SBzsCXD8ib7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Dec 2022 09:35:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EF0574015E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EF0574015E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Dec 2022 09:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671096902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=81Hq6t0bBAAS+O4HOr41urE88Cd72754O7sYgGyx03s=;
 b=ZBFdU0cSqAKx+WcH9lKRVumA9mSHZkBgC8fUSETzvB9j4QpBkv2L05kZUVNfuUnTesoB/K
 FVXnFGt34/AMcoP7nJLevoFfuCiwhnYoL9Ye2d6v/8+pg3b9d8RDZPLI96vW1fu9DLf9rR
 GA8eShjx8GtcXQKxxCkzZ2EDK4IEY3U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-153-jyOID7MQNtWDBv5Z8NxOCQ-1; Thu, 15 Dec 2022 04:35:01 -0500
X-MC-Unique: jyOID7MQNtWDBv5Z8NxOCQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 p14-20020a05600c204e00b003cf4cce4da5so538244wmg.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Dec 2022 01:35:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=81Hq6t0bBAAS+O4HOr41urE88Cd72754O7sYgGyx03s=;
 b=jUY+pm3d4ShUu9DHyso6EhZtkpg/kAuG/Mqpi1wRA8P1f00WS5r8gPa29a6gF3aw6j
 MCPJDVE2mpQzLz/1v6qFwBB254nyxMizY/edVq9gixzBZLMqWduT5jGIhuLeheBhW1w9
 LlyXYtB0Sm0ijNoxy8eBmZaBmu29cqeuVZZyYN23pFSAwT8eXPC/XKT4FYG8E4M9e/Uj
 nhQu/wgFPSQZGxFMUX0EzVrS76wuyZ3dx2mv1LVqAHe7+1eOmKKvzC8VPmg36+fmjkoe
 Nt3eF4MSuVek34WWSs/t5HOvPjCKMfOChxNKB5g4uciuaRSvdBE5Oo6QXklOvOKRXMqx
 Znxw==
X-Gm-Message-State: ANoB5plXKlWft/Q8lfaEOgL44i8BSxBMoNtrlPcOWGMdcyf+2iyf3jkN
 UcIZxKpWS8zXO8rQFva4T3o4n38pmlYg5oYYaKEWoe5mDck7OaiS4xFNmMJp5vNpC3AgZRFt2hv
 fa2sWmOXpTwIHlyqAgOAmzyvaQp4h7CfuqbiEz8hM6w==
X-Received: by 2002:a05:600c:4f48:b0:3cf:76c3:b2e2 with SMTP id
 m8-20020a05600c4f4800b003cf76c3b2e2mr21438987wmq.35.1671096899531; 
 Thu, 15 Dec 2022 01:34:59 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4CHoxsEL13wD3BHfSaLfTzzWcogwYUTAak9uDbxIO6dJ63q+Xxv2aZVTQVgg131D6MsPYvDg==
X-Received: by 2002:a05:600c:4f48:b0:3cf:76c3:b2e2 with SMTP id
 m8-20020a05600c4f4800b003cf76c3b2e2mr21438976wmq.35.1671096899307; 
 Thu, 15 Dec 2022 01:34:59 -0800 (PST)
Received: from redhat.com ([2a02:14f:179:247f:e426:6c6e:c44d:93b])
 by smtp.gmail.com with ESMTPSA id
 n12-20020a05600c3b8c00b003cf78aafdd7sm6804213wms.39.2022.12.15.01.34.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Dec 2022 01:34:58 -0800 (PST)
Date: Thu, 15 Dec 2022 04:34:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net V2] virtio-net: correctly enable callback during
 start_xmit
Message-ID: <20221215042918-mutt-send-email-mst@kernel.org>
References: <20221215032719.72294-1-jasowang@redhat.com>
 <20221215034740-mutt-send-email-mst@kernel.org>
 <CACGkMEsLeCRDqyuyGzWw+kjYrTVDjUjOw6+xHESPT2D1p03=sQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsLeCRDqyuyGzWw+kjYrTVDjUjOw6+xHESPT2D1p03=sQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

On Thu, Dec 15, 2022 at 05:15:43PM +0800, Jason Wang wrote:
> On Thu, Dec 15, 2022 at 5:02 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Dec 15, 2022 at 11:27:19AM +0800, Jason Wang wrote:
> > > Commit a7766ef18b33("virtio_net: disable cb aggressively") enables
> > > virtqueue callback via the following statement:
> > >
> > >         do {
> > >            ......
> > >       } while (use_napi && kick &&
> > >                unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> > >
> > > When NAPI is used and kick is false, the callback won't be enabled
> > > here. And when the virtqueue is about to be full, the tx will be
> > > disabled, but we still don't enable tx interrupt which will cause a TX
> > > hang. This could be observed when using pktgen with burst enabled.
> > >
> > > Fixing this by trying to enable tx interrupt after we disable TX when
> > > we're not using napi or kick is false.
> > >
> > > Fixes: a7766ef18b33 ("virtio_net: disable cb aggressively")
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > > The patch is needed for -stable.
> > > Changes since V1:
> > > - enable tx interrupt after we disable tx
> > > ---
> > >  drivers/net/virtio_net.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 86e52454b5b5..dcf3a536d78a 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -1873,7 +1873,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
> > >        */
> > >       if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
> > >               netif_stop_subqueue(dev, qnum);
> > > -             if (!use_napi &&
> > > +             if ((!use_napi || !kick) &&
> > >                   unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
> > >                       /* More just got used, free them then recheck. */
> > >                       free_old_xmit_skbs(sq, false);
> >
> > This will work but the following lines are:
> >
> >                        if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
> >                                 netif_start_subqueue(dev, qnum);
> >                                 virtqueue_disable_cb(sq->vq);
> >                         }
> >
> >
> > and I thought we are supposed to keep callbacks enabled with napi?
> 
> This seems to be the opposite logic of commit a7766ef18b33 that
> disables callbacks for NAPI.
> 
> It said:
> 
>     There are currently two cases where we poll TX vq not in response to a
>     callback: start xmit and rx napi.  We currently do this with callbacks
>     enabled which can cause extra interrupts from the card.  Used not to be
>     a big issue as we run with interrupts disabled but that is no longer the
>     case, and in some cases the rate of spurious interrupts is so high
>     linux detects this and actually kills the interrupt.
> 
> My undersatnding is that it tries to disable callbacks on TX.

I think we want to disable callbacks while polling, yes. here we are not
polling, and I think we want a callback because otherwise nothing will
orphan skbs and a socket can be blocked, not transmitting anything - a
deadlock.

> > One of the ideas of napi is to free on napi callback, not here
> > immediately.
> >
> > I think it is easier to just do a separate branch here. Along the
> > lines of:
> >
> >                 if (use_napi) {
> >                         if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)))
> >                                 virtqueue_napi_schedule(napi, vq);
> 
> This seems to be a new logic and it causes some delay in processing TX
> (unnecessary NAPI).

That's good, we overloaded the queue so we are already going
too fast, deferring tx so queue has chance to drain
will allow better batching in the qdisc.

> >                 } else {
> >                         ... old code ...
> >                 }
> >
> > also reduces chances of regressions on !napi (which is not well tested)
> > and keeps callbacks off while we free skbs.
> 
> I think my patch doesn't change the logic of !napi? (It checks !napi || kick).
> 
> Thanks

I agree it doesn't seem to as written.

> >
> > No?
> >
> >
> > > --
> > > 2.25.1
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
