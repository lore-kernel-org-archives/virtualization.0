Return-Path: <SRS0=9pi5=QE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACEFC4332F
	for <virtualization@archiver.kernel.org>; Wed, 17 Nov 2021 06:01:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 024906139F
	for <virtualization@archiver.kernel.org>; Wed, 17 Nov 2021 06:01:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 024906139F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B7EFE80FFF;
	Wed, 17 Nov 2021 06:01:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RHq--3KVT-Ib; Wed, 17 Nov 2021 06:01:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5827780FFE;
	Wed, 17 Nov 2021 06:01:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C566C001E;
	Wed, 17 Nov 2021 06:01:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37301C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 06:01:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 24F9C405C1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 06:01:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TGcUDjS-mw0H
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 06:01:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 86895405A6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 06:01:45 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id t19so4079514oij.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 22:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VlZH+SjArM/+ypAkd0GkqnF+/8X0/LANVS817tn/Z6M=;
 b=uh8qtTLsquh/EZx+E9fM9iwATsMXMExVvsfTsH2Dx4lGVp8ngZnDfySMn+twM2jJyZ
 I/M5mWXJDABMPKRcDGW69gLwYu4xB6BTxQayphm/gDensbt5NojFMj9o6A9mnvkL1M11
 hHOPCtglWmO/FgubeQ/StiOjmeZ/xeXsHBbyXCBEcyBlqIyYjc3mqTaMLjK+svLedqG6
 r0PMecG3kbB4CQMkJSoP4CIQtNyKHdU/Sn8GfvPsP0sDnY05RejHXZbg4i4Xin67Dzlc
 DhRvSYl1Ti/HtCpwOT3vAtg4SAKzYqOEEbfWk7fHDHwPHkdE7Dn18d5xMdzfTDIEHNCB
 h2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VlZH+SjArM/+ypAkd0GkqnF+/8X0/LANVS817tn/Z6M=;
 b=YyakvrZHcBMMkAjq49wceg+C9Q508El59tDXThGRT3d3lBrCX478M+4YKprQexqWVM
 OktiUpi+pgKoyTR9R9DL/Sj+4PLxwtUPN26mlm92yvJgEQfnVHE7ioJOEOEUTfEzUeig
 pFkyzNs1eYfDs+RZIWBe6KtJqELGYapjUkvKdWxJgsiinsLrr0X53lpC14R93KgwYGwE
 /DoPowdjizTspLUC3cNHL/kGMKfuadpHVJgC/wqb1fKJ47rC6Ndq1KvytJErWujKrBsx
 Y/7fD1csj+sfykf5InoPAIPG1nYq8EAo2JhYSTPu0g30AtfQI44A2QJs1hGIiwwxoXJc
 S74g==
X-Gm-Message-State: AOAM530PLUbVDBZSGny4mhFWNN+W+rReIQlIPymgdBcVDHr/FuXiKdu2
 OkLDK8F99ZKZi+ViI/R/lvGrD7LBELoE7mVW3qrGvg==
X-Google-Smtp-Source: ABdhPJzRwMxi5Vhil0B4DEUfMMuTRi3VY7MLIEvgxCf9w8HuketPjUr+oWOSEK3nH61Fv5xXVvtfGeDjDQDbTozG4bM=
X-Received: by 2002:a05:6808:171c:: with SMTP id
 bc28mr58754765oib.18.1637128904727; 
 Tue, 16 Nov 2021 22:01:44 -0800 (PST)
MIME-Version: 1.0
References: <20211031045959.143001-1-andrew@daynix.com>
 <20211031045959.143001-2-andrew@daynix.com>
 <20211101043723-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211101043723-mutt-send-email-mst@kernel.org>
From: Andrew Melnichenko <andrew@daynix.com>
Date: Wed, 17 Nov 2021 08:00:00 +0200
Message-ID: <CABcq3pH8PCJwDQyusjQbW4Ds08YMjn8NSRM+Cf6NjA0hZHHMtw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] drivers/net/virtio_net: Fixed vheader to use v1.
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Yan Vugenfirer <yan@daynix.com>, kuba@kernel.org, davem@davemloft.net
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

On Mon, Nov 1, 2021 at 10:40 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Sun, Oct 31, 2021 at 06:59:56AM +0200, Andrew Melnychenko wrote:
> > The header v1 provides additional info about RSS.
> > Added changes to computing proper header length.
> > In the next patches, the header may contain RSS hash info
> > for the hash population.
> >
> > Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> > ---
> >  drivers/net/virtio_net.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 4ad25a8b0870..b72b21ac8ebd 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -240,13 +240,13 @@ struct virtnet_info {
> >  };
> >
> >  struct padded_vnet_hdr {
> > -     struct virtio_net_hdr_mrg_rxbuf hdr;
> > +     struct virtio_net_hdr_v1_hash hdr;
> >       /*
> >        * hdr is in a separate sg buffer, and data sg buffer shares same page
> >        * with this header sg. This padding makes next sg 16 byte aligned
> >        * after the header.
> >        */
> > -     char padding[4];
> > +     char padding[12];
> >  };
> >
> >  static bool is_xdp_frame(void *ptr)
>
>
> This is not helpful as a separate patch, just reserving extra space.
> better squash with the patches making use of the change.

Ok.


>
> > @@ -1636,7 +1636,7 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
> >       const unsigned char *dest = ((struct ethhdr *)skb->data)->h_dest;
> >       struct virtnet_info *vi = sq->vq->vdev->priv;
> >       int num_sg;
> > -     unsigned hdr_len = vi->hdr_len;
> > +     unsigned int hdr_len = vi->hdr_len;
> >       bool can_push;
>
>
> if we want this, pls make it a separate patch.

Ok. I've added that change after checkpatch warnings. Technically,
checkpatch should not fail on the patch without that line.

>
>
> >
> >       pr_debug("%s: xmit %p %pM\n", vi->dev->name, skb, dest);
> > --
> > 2.33.1
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
