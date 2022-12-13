Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D971C4332F
	for <virtualization@archiver.kernel.org>; Tue, 13 Dec 2022 06:58:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D55BD40400;
	Tue, 13 Dec 2022 06:58:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D55BD40400
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G/kna0ll
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BiNGeSPQgEFo; Tue, 13 Dec 2022 06:58:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C7B16402B1;
	Tue, 13 Dec 2022 06:58:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C7B16402B1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A09F0C0032;
	Tue, 13 Dec 2022 06:58:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 412A4C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 06:58:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1C4CA81C0A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 06:58:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1C4CA81C0A
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=G/kna0ll
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IpotQ9SEkNSu
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 06:58:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E937481BD6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E937481BD6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 06:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670914687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TG6nTIySLJL4GzMcoFkoHrZJOcHOyrIknDZjMAhUKq0=;
 b=G/kna0llW/rX0exl6hO8JfMxQcA7Ic27cKyK/YC1OMivds3007l9PkqiXavZnTh9T74k/N
 2y6Pkr0YFc09zlMPiJ6BcnNB5W7U8522zhSzfvjq2c6M/3p+O/6Rtryr0vR3bX8HW6jZ/D
 AueXsPvH8xsxzUfbLXwh/ZDQ/qaVdgY=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-250-K5OmFS0VMBmH-CoH1XtSGA-1; Tue, 13 Dec 2022 01:58:06 -0500
X-MC-Unique: K5OmFS0VMBmH-CoH1XtSGA-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-1446f190493so3383681fac.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 22:58:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TG6nTIySLJL4GzMcoFkoHrZJOcHOyrIknDZjMAhUKq0=;
 b=igHypYFQn++ZcX7LyNw3LozmpBGqLle/psGmyNs7+xRBNGZDEA/jqRrJdZLVi9XYbb
 cXd7OcpOWBe9QYdYXHTapaBFHb1J97OS+wLW9pWlW05Ji5cvLIpvKhEn9I/QFIk89chO
 TwVZBGu6kT+7mK7CFKSfiUWZNtVN3EWLzN4D751AovYJT+loi042fsmJOcCNHS20THH1
 8YSyeAO50iJ7XPIUb7M5f2WnHmXouo87ev6kckQlzkIRkqTTmuF5iKjBs+8yWFdYE/Ri
 RsqTDKoeppIxDii6IKzwDm2PS6dkPIP+JRhaoyciuizoL5o8zqRifmesm+f2CQ2wLWOv
 78wQ==
X-Gm-Message-State: ANoB5pl7UhDdolsudEtZQfHk18ppY4Ce+OFTcsNuHwNdSZFSdP/oNDy/
 /hjgjg54LVi+V9G7Ipc4jv0uBUaEMpVqzht7aUg27WUuZzdSIeqMT5if8DWsGF33gGwhZfXlkYi
 nXc8YGfQw32Y5h2GUxitqBqH+4ampzSmCOW/ObGYmI1XI5TY7nDo/UYxhVw==
X-Received: by 2002:a05:6870:170e:b0:144:a97b:1ae2 with SMTP id
 h14-20020a056870170e00b00144a97b1ae2mr124208oae.35.1670914685837; 
 Mon, 12 Dec 2022 22:58:05 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4q5+B7Fl7DK/u/JIISxL//DMMmbkyJdDsxO+tjxYnaAJ9f8ZhI/Xt7Ljn+PCpZVIIixCW/Btptl5YKy40YUOc=
X-Received: by 2002:a05:6870:170e:b0:144:a97b:1ae2 with SMTP id
 h14-20020a056870170e00b00144a97b1ae2mr124202oae.35.1670914685564; Mon, 12 Dec
 2022 22:58:05 -0800 (PST)
MIME-Version: 1.0
References: <20221212091029.54390-1-jasowang@redhat.com>
 <20221212042144-mutt-send-email-mst@kernel.org>
 <1670902391.9610498-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEu=1CcoNvvV9M+QrG5sLUBoPYkZ3DvUe+pLc1fSvgLuHA@mail.gmail.com>
 <20221213013231-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221213013231-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 13 Dec 2022 14:57:54 +0800
Message-ID: <CACGkMEukRrOWghcBXiqPrOtNbdjdDJUW7-cg9PsdtsVs1SuCyQ@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: correctly enable callback during
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

On Tue, Dec 13, 2022 at 2:38 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Dec 13, 2022 at 11:43:36AM +0800, Jason Wang wrote:
> > On Tue, Dec 13, 2022 at 11:38 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > >
> > > On Mon, 12 Dec 2022 04:25:22 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > On Mon, Dec 12, 2022 at 05:10:29PM +0800, Jason Wang wrote:
> > > > > Commit a7766ef18b33("virtio_net: disable cb aggressively") enables
> > > > > virtqueue callback via the following statement:
> > > > >
> > > > >         do {
> > > > >            ......
> > > > >     } while (use_napi && kick &&
> > > > >                unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> > > > >
> > > > > This will cause a missing call to virtqueue_enable_cb_delayed() when
> > > > > kick is false. Fixing this by removing the checking of the kick from
> > > > > the condition to make sure callback is enabled correctly.
> > > > >
> > > > > Fixes: a7766ef18b33 ("virtio_net: disable cb aggressively")
> > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > ---
> > > > > The patch is needed for -stable.
> > > >
> > > > stable rules don't allow for theoretical fixes. Was a problem observed?
> >
> > Yes, running a pktgen sample script can lead to a tx timeout.
>
> Since April 2021 and we only noticed now? Are you sure it's the
> right Fixes tag?

Well, reverting a7766ef18b33 makes pktgen work again.

The reason we doesn't notice is probably because:

1) We don't support BQL, so no bulk dequeuing (skb list) in normal traffic
2) When burst is enabled for pktgen, it can do bulk xmit via skb list by its own

>
> > > >
> > > > > ---
> > > > >  drivers/net/virtio_net.c | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index 86e52454b5b5..44d7daf0267b 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -1834,8 +1834,8 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
> > > > >
> > > > >             free_old_xmit_skbs(sq, false);
> > > > >
> > > > > -   } while (use_napi && kick &&
> > > > > -          unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> > > > > +   } while (use_napi &&
> > > > > +            unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> > > > >
> > > >
> > > > A bit more explanation pls.  kick simply means !netdev_xmit_more -
> > > > if it's false we know there will be another packet, then transmissing
> > > > that packet will invoke virtqueue_enable_cb_delayed. No?
> > >
> > > It's just that there may be a next packet, but in fact there may not be.
> > > For example, the vq is full, and the driver stops the queue.
> >
> > Exactly, when the queue is about to be full we disable tx and wait for
> > the next tx interrupt to re-enable tx.
> >
> > Thanks
>
> OK, it's a good idea to document that.

Will do.

> And we should enable callbacks at that point, not here on data path.

I'm not sure I understand here. Are you suggesting removing the
!user_napi check here?

                if (!use_napi &&
                    unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
                        /* More just got used, free them then recheck. */
                        free_old_xmit_skbs(sq, false);
                        if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
                                netif_start_subqueue(dev, qnum);
                                virtqueue_disable_cb(sq->vq);
                        }
                }

Btw, it doesn't differ too much as kick is always true without pktgen
and that may even need more comments or make the code even harder to
read. We need a patch for -stable at least so I prefer to let this
patch go first and do optimization on top.

Thanks

>
>
> > >
> > > Thanks.
> > >
> > > >
> > > >
> > > >
> > > >
> > > >
> > > > >     /* timestamp packet in software */
> > > > >     skb_tx_timestamp(skb);
> > > > > --
> > > > > 2.25.1
> > > >
> > > > _______________________________________________
> > > > Virtualization mailing list
> > > > Virtualization@lists.linux-foundation.org
> > > > https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
