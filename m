Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DAC9C4332F
	for <virtualization@archiver.kernel.org>; Fri, 23 Dec 2022 06:30:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B7FAD401DB;
	Fri, 23 Dec 2022 06:30:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B7FAD401DB
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PcIeEK6u
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BJfsOXCbRTE6; Fri, 23 Dec 2022 06:30:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CF6BA40184;
	Fri, 23 Dec 2022 06:30:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CF6BA40184
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C85AC0071;
	Fri, 23 Dec 2022 06:30:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21840C0070
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 06:29:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E27A560A87
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 06:29:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E27A560A87
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PcIeEK6u
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UMHf7QsoIHYU
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 06:29:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EF67F605B3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EF67F605B3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 06:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671776996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WiikjAKCvnHp1vgV1Kaih+JCYQ6gPd1e+8fFKg9J1Ac=;
 b=PcIeEK6upoqP38jhBXJSrKW/11SbeaTHWMPX7sQB/JrLbNAMMCBSQLKc4E+jlxHPwWj/sn
 FgvaShf1x24CXXpgHAs1PUu0i1kH4pnst2Pxc01jL4ZkkDF85PwSmid+M4l8KreeMipo+w
 Qm259/zFj9EpBLryw49lz1mkWkZL9LU=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-466-DM4Y7zPBN4yIChxTm0fDVQ-1; Fri, 23 Dec 2022 01:29:55 -0500
X-MC-Unique: DM4Y7zPBN4yIChxTm0fDVQ-1
Received: by mail-ot1-f70.google.com with SMTP id
 cg13-20020a056830630d00b00670556db34fso2160748otb.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 22:29:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WiikjAKCvnHp1vgV1Kaih+JCYQ6gPd1e+8fFKg9J1Ac=;
 b=mtw3BuDu2Yova7TedFMafGCt6XRnn/bc4Xc0ieDM1CyCplPDL+0u+w+kR/mZRYRN2u
 56G8J/zYDBg/bBbohWVYA3bIxSG5x5QlyxkWO7HYY6v6ryWFw2/+ZWhF3oUzUkQBNGr6
 IaXRDTQb/qH7K4QLUPwU3PAUEwz7FzKgdFNCKTZAFkfidYqJqR1K6Z5u3BXyyoUI8dRq
 N8+SWuGVDQho+wRUEHBXlIW1TODd3sNMVNMM3aTHtZsUu9asz6bpPhZJFtLxJK+1tx52
 Atwk/LpkCy46+iq1XGtL98hXSQmcGCjvGsAN5r9m2g+pTPu3TuUmI6SkdHOAXxKvzAYf
 fbiQ==
X-Gm-Message-State: AFqh2kqT9TjwPHSg5XZnOz2slP9RuewJq+Rz0XwaAiSsN8/pEQCFGCug
 em/TO/BS+mqNyCAVkDnnxmRrc0485jvLt7WR8GDhN9tUS5IgIsya7bkWqMO8GoSorasInYfOOtl
 R7aPcqe/RWeGEvjWFtyPoFc72Jr6Y3x2YPg4R2jteeUFyU1rNpcqg6ZkH6w==
X-Received: by 2002:aca:1111:0:b0:35e:7a42:7ab5 with SMTP id
 17-20020aca1111000000b0035e7a427ab5mr431954oir.280.1671776994359; 
 Thu, 22 Dec 2022 22:29:54 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvwAmVj4pYtzy/MEZCDVErGxTjIQ/hOw+CgSBao5LSUxKEJOkd++cRwrwP4isqzNYUGYGNhsdIslmcmRpir8RE=
X-Received: by 2002:aca:1111:0:b0:35e:7a42:7ab5 with SMTP id
 17-20020aca1111000000b0035e7a427ab5mr431949oir.280.1671776994092; Thu, 22 Dec
 2022 22:29:54 -0800 (PST)
MIME-Version: 1.0
References: <20221215032719.72294-1-jasowang@redhat.com>
 <20221215034740-mutt-send-email-mst@kernel.org>
 <CACGkMEsLeCRDqyuyGzWw+kjYrTVDjUjOw6+xHESPT2D1p03=sQ@mail.gmail.com>
 <20221215042918-mutt-send-email-mst@kernel.org>
 <CACGkMEsbvTQrEp5dmQRHp58Mu=E7f433Xrvsbs4nZMA5R3B6mQ@mail.gmail.com>
In-Reply-To: <CACGkMEsbvTQrEp5dmQRHp58Mu=E7f433Xrvsbs4nZMA5R3B6mQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 23 Dec 2022 14:29:43 +0800
Message-ID: <CACGkMEsu_OFFs15d2dzNbfSjzAZfYXLn9CNcO3ELPbDqZsndzg@mail.gmail.com>
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

On Fri, Dec 16, 2022 at 11:43 AM Jason Wang <jasowang@redhat.com> wrote:
>
> On Thu, Dec 15, 2022 at 5:35 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Dec 15, 2022 at 05:15:43PM +0800, Jason Wang wrote:
> > > On Thu, Dec 15, 2022 at 5:02 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Thu, Dec 15, 2022 at 11:27:19AM +0800, Jason Wang wrote:
> > > > > Commit a7766ef18b33("virtio_net: disable cb aggressively") enables
> > > > > virtqueue callback via the following statement:
> > > > >
> > > > >         do {
> > > > >            ......
> > > > >       } while (use_napi && kick &&
> > > > >                unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> > > > >
> > > > > When NAPI is used and kick is false, the callback won't be enabled
> > > > > here. And when the virtqueue is about to be full, the tx will be
> > > > > disabled, but we still don't enable tx interrupt which will cause a TX
> > > > > hang. This could be observed when using pktgen with burst enabled.
> > > > >
> > > > > Fixing this by trying to enable tx interrupt after we disable TX when
> > > > > we're not using napi or kick is false.
> > > > >
> > > > > Fixes: a7766ef18b33 ("virtio_net: disable cb aggressively")
> > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > ---
> > > > > The patch is needed for -stable.
> > > > > Changes since V1:
> > > > > - enable tx interrupt after we disable tx
> > > > > ---
> > > > >  drivers/net/virtio_net.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index 86e52454b5b5..dcf3a536d78a 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -1873,7 +1873,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
> > > > >        */
> > > > >       if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
> > > > >               netif_stop_subqueue(dev, qnum);
> > > > > -             if (!use_napi &&
> > > > > +             if ((!use_napi || !kick) &&
> > > > >                   unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
> > > > >                       /* More just got used, free them then recheck. */
> > > > >                       free_old_xmit_skbs(sq, false);
> > > >
> > > > This will work but the following lines are:
> > > >
> > > >                        if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
> > > >                                 netif_start_subqueue(dev, qnum);
> > > >                                 virtqueue_disable_cb(sq->vq);
> > > >                         }
> > > >
> > > >
> > > > and I thought we are supposed to keep callbacks enabled with napi?
> > >
> > > This seems to be the opposite logic of commit a7766ef18b33 that
> > > disables callbacks for NAPI.
> > >
> > > It said:
> > >
> > >     There are currently two cases where we poll TX vq not in response to a
> > >     callback: start xmit and rx napi.  We currently do this with callbacks
> > >     enabled which can cause extra interrupts from the card.  Used not to be
> > >     a big issue as we run with interrupts disabled but that is no longer the
> > >     case, and in some cases the rate of spurious interrupts is so high
> > >     linux detects this and actually kills the interrupt.
> > >
> > > My undersatnding is that it tries to disable callbacks on TX.
> >
> > I think we want to disable callbacks while polling, yes. here we are not
> > polling, and I think we want a callback because otherwise nothing will
> > orphan skbs and a socket can be blocked, not transmitting anything - a
> > deadlock.
>
> I'm not sure how I got here, did you mean a partial revert of
> a7766ef18b33 (the part that disables TX callbacks on start_xmit)?

Michael, any idea on this?

Thanks

>
> Btw, I plan to remove non NAPI mode completely, since it was disabled
> by default for years and we don't see any complaint, then we may have
> modern features like BQL and better TCP performance. In that sense we
> may simply keep tx callback open as most of modern NIC did.
>
> >
> > > > One of the ideas of napi is to free on napi callback, not here
> > > > immediately.
> > > >
> > > > I think it is easier to just do a separate branch here. Along the
> > > > lines of:
> > > >
> > > >                 if (use_napi) {
> > > >                         if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)))
> > > >                                 virtqueue_napi_schedule(napi, vq);
> > >
> > > This seems to be a new logic and it causes some delay in processing TX
> > > (unnecessary NAPI).
> >
> > That's good, we overloaded the queue so we are already going
> > too fast, deferring tx so queue has chance to drain
> > will allow better batching in the qdisc.
>
> I meant, compare to
>
> 1) schedule NAPI and poll TX
>
> The current code did
>
> 2) poll TX immediately
>
> 2) seems faster?
>
> Thanks
>
> >
> > > >                 } else {
> > > >                         ... old code ...
> > > >                 }
> > > >
> > > > also reduces chances of regressions on !napi (which is not well tested)
> > > > and keeps callbacks off while we free skbs.
> > >
> > > I think my patch doesn't change the logic of !napi? (It checks !napi || kick).
> > >
> > > Thanks
> >
> > I agree it doesn't seem to as written.
> >
> > > >
> > > > No?
> > > >
> > > >
> > > > > --
> > > > > 2.25.1
> > > >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
