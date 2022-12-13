Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 017FAC4332F
	for <virtualization@archiver.kernel.org>; Tue, 13 Dec 2022 06:38:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 74C96416C2;
	Tue, 13 Dec 2022 06:38:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 74C96416C2
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WPv/CugN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p_kTMiHErKkK; Tue, 13 Dec 2022 06:38:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A7E59416D4;
	Tue, 13 Dec 2022 06:38:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A7E59416D4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75FE6C0032;
	Tue, 13 Dec 2022 06:38:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 904FDC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 06:38:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 695FA81D4D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 06:38:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 695FA81D4D
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WPv/CugN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OWHsyV8pjU6h
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 06:38:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 645F581D47
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 645F581D47
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 06:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670913513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pG8pk6806WunH38LK3XOKaKNRvcbToIEcrDuqWIIVJA=;
 b=WPv/CugNotPkU+9cXluW0NQxlp2YZPVS4xulEBtd3ycVegMfgnqJJmkyJ7w7TXO57qHwha
 Rjxw8ojjRz7oS5TFR6IFcaHByY0i/cWRoS7g7J5jUAOBCi8Bnbh+w6g3hFX1GZNMubfBBm
 4LczDlgmO0MD6cgAq4espswqjnju3so=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-39-ZQu12tbmOBae7m_sh7szJA-1; Tue, 13 Dec 2022 01:38:32 -0500
X-MC-Unique: ZQu12tbmOBae7m_sh7szJA-1
Received: by mail-wm1-f70.google.com with SMTP id
 a6-20020a05600c224600b003d1f3ed49adso2594433wmm.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 22:38:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pG8pk6806WunH38LK3XOKaKNRvcbToIEcrDuqWIIVJA=;
 b=tETP3gRhOwya5GPkKxui/KstpYQd8ZMBcZHCFXJUwTpo5QoUl8NUAr37pzqogNxg5q
 bfCjo7Ts3lmutmkOgPoewLNadkWiprvo2UEjjaFC2HUnRnA1bDB6TMlGhjW5f/jM16qu
 2nrdzXHpUo0KUsKy4ISXwC2/UzuV1DVr4rYY7jVVS1NAXAU/gEuGvmlFT+d4Y/svbUcK
 n7icNTUFWc2lY2Qcg/afpcbKLu9FXxBEwyFJ03SrwKBCKOY2MDhzDRuUcvc1fWaRk7ow
 qCcil8/TKIrJOYVeffXzf460l/M2oGjFcUtbDWc90dWcpv49U9uF1L34w9tdkAqaa+dy
 Qagg==
X-Gm-Message-State: ANoB5pmXMF69UZSxdrGYiFWtxnc/tcnK1xp+k5i2Qp9Dxnzt1hGROxgb
 KXw5BiXywRyg8BArwdHSF8Aajeez/IUUP51xJDYW2jjjwPmRRar3i7No6Amfj9Z7ZsFcNDois14
 hKoFIQNP/oHBHykVTJN4XcqMcExMjBHNjLJxufX9DQg==
X-Received: by 2002:a05:600c:5011:b0:3cf:91e9:f771 with SMTP id
 n17-20020a05600c501100b003cf91e9f771mr14680176wmr.36.1670913511086; 
 Mon, 12 Dec 2022 22:38:31 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7a0Jg5I3qlu4+RONkY5PwQtc+kv3pnp/OWxrJYOaFho0Wyum/OG/OEnozMktADLH8herMaKg==
X-Received: by 2002:a05:600c:5011:b0:3cf:91e9:f771 with SMTP id
 n17-20020a05600c501100b003cf91e9f771mr14680167wmr.36.1670913510863; 
 Mon, 12 Dec 2022 22:38:30 -0800 (PST)
Received: from redhat.com ([2.52.138.183]) by smtp.gmail.com with ESMTPSA id
 g23-20020a05600c4c9700b003cf4ec90938sm11063543wmp.21.2022.12.12.22.38.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Dec 2022 22:38:30 -0800 (PST)
Date: Tue, 13 Dec 2022 01:38:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net] virtio-net: correctly enable callback during
 start_xmit
Message-ID: <20221213013231-mutt-send-email-mst@kernel.org>
References: <20221212091029.54390-1-jasowang@redhat.com>
 <20221212042144-mutt-send-email-mst@kernel.org>
 <1670902391.9610498-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEu=1CcoNvvV9M+QrG5sLUBoPYkZ3DvUe+pLc1fSvgLuHA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEu=1CcoNvvV9M+QrG5sLUBoPYkZ3DvUe+pLc1fSvgLuHA@mail.gmail.com>
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

On Tue, Dec 13, 2022 at 11:43:36AM +0800, Jason Wang wrote:
> On Tue, Dec 13, 2022 at 11:38 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > On Mon, 12 Dec 2022 04:25:22 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > On Mon, Dec 12, 2022 at 05:10:29PM +0800, Jason Wang wrote:
> > > > Commit a7766ef18b33("virtio_net: disable cb aggressively") enables
> > > > virtqueue callback via the following statement:
> > > >
> > > >         do {
> > > >            ......
> > > >     } while (use_napi && kick &&
> > > >                unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> > > >
> > > > This will cause a missing call to virtqueue_enable_cb_delayed() when
> > > > kick is false. Fixing this by removing the checking of the kick from
> > > > the condition to make sure callback is enabled correctly.
> > > >
> > > > Fixes: a7766ef18b33 ("virtio_net: disable cb aggressively")
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > ---
> > > > The patch is needed for -stable.
> > >
> > > stable rules don't allow for theoretical fixes. Was a problem observed?
> 
> Yes, running a pktgen sample script can lead to a tx timeout.

Since April 2021 and we only noticed now? Are you sure it's the
right Fixes tag?

> > >
> > > > ---
> > > >  drivers/net/virtio_net.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index 86e52454b5b5..44d7daf0267b 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -1834,8 +1834,8 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
> > > >
> > > >             free_old_xmit_skbs(sq, false);
> > > >
> > > > -   } while (use_napi && kick &&
> > > > -          unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> > > > +   } while (use_napi &&
> > > > +            unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> > > >
> > >
> > > A bit more explanation pls.  kick simply means !netdev_xmit_more -
> > > if it's false we know there will be another packet, then transmissing
> > > that packet will invoke virtqueue_enable_cb_delayed. No?
> >
> > It's just that there may be a next packet, but in fact there may not be.
> > For example, the vq is full, and the driver stops the queue.
> 
> Exactly, when the queue is about to be full we disable tx and wait for
> the next tx interrupt to re-enable tx.
> 
> Thanks

OK, it's a good idea to document that.
And we should enable callbacks at that point, not here on data path.


> >
> > Thanks.
> >
> > >
> > >
> > >
> > >
> > >
> > > >     /* timestamp packet in software */
> > > >     skb_tx_timestamp(skb);
> > > > --
> > > > 2.25.1
> > >
> > > _______________________________________________
> > > Virtualization mailing list
> > > Virtualization@lists.linux-foundation.org
> > > https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
