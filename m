Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C7D8C433F5
	for <virtualization@archiver.kernel.org>; Thu, 25 Nov 2021 07:12:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D38F34021F;
	Thu, 25 Nov 2021 07:12:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PzMXpoUrXaY9; Thu, 25 Nov 2021 07:12:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3600A40018;
	Thu, 25 Nov 2021 07:12:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2C6CC002F;
	Thu, 25 Nov 2021 07:12:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10D5BC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 07:12:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EA86B4019B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 07:12:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XgL-id8xL9dS
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 07:12:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BE0E240018
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 07:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637824332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nC8TAYilw4eO6qk6TmC4Zgxkm1cFgxZk3ttBumo2rHs=;
 b=S3MGCFb6U4mxvisdvaGyiI9kFg2FK9OSMERFeCbmEwAxR3HdsQ3XLjoeCI8nkwsjyQCWFD
 ZeQIovvyYygUlI0y32fnQLgJTlVYuwXF4HPVz2bsq1F5JCf1o3vmvacpASqfFrkbMl4ids
 yfsKnUhbS0GZyKhQH+uOEFw6qo11r8g=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-310-Dq2yOrXZOGGbnUHUyjmBig-1; Thu, 25 Nov 2021 02:12:10 -0500
X-MC-Unique: Dq2yOrXZOGGbnUHUyjmBig-1
Received: by mail-lf1-f72.google.com with SMTP id
 q26-20020ac2515a000000b0040adfeb8132so2752069lfd.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 23:12:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nC8TAYilw4eO6qk6TmC4Zgxkm1cFgxZk3ttBumo2rHs=;
 b=wyfcFUx6E8rXTIH81y3LAq36/BSgGj3kyqSQeGyK419qfFqb66JPxLIprIZYeS5VEa
 p9I36OVRRqhws14fA+joJRZVSrkhce5vXMVpjs0ibVjteaWKlZJK4+rm5a5S0FE4i926
 1sYaZLVPBhvOsi9RasCHee5h2c3iLI3fZjZFD9BS/MEn4sm9CIuZHP+b/MtbZCS/F4Nl
 1UryuxoK/QJtAdBaRLYFt0yggLlrdRv4sr6/lLfyFtcjcqz8Ri7I4NcX6tQl9tq82WIi
 I6A5PR2u5TFuc/bG3rtE9EbcVOZoNDmOUcl3VYN7wTTbRRHZZXVYpr/l76aTAmcQwe+9
 Vc1Q==
X-Gm-Message-State: AOAM532kXwsO96P7pwQIB1mEEctLH8njuG7Bib/z03PvHycgvmElHGiT
 RtG6uZYUeYRu/VPwSkjniJfNQy5xOV7AETwtQJaCHujwNE3ccb4E6hLJXb6qN3LYGrh9JfkPPX5
 E8l98QNz+yD/r9b7ummRqftAM5nWQB5gDYQFWnJGxPd889UbIErQQWcGIGA==
X-Received: by 2002:a2e:915a:: with SMTP id q26mr22426555ljg.277.1637824329434; 
 Wed, 24 Nov 2021 23:12:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxeFz9HHABX6i5h6gRcn7nboD1zkLDLVn4pgHX8pSwTiW54CFKdWcSQ/ukSK+/hSpgPW0KT1r7HGC5agHABEKc=
X-Received: by 2002:a2e:915a:: with SMTP id q26mr22426527ljg.277.1637824329157; 
 Wed, 24 Nov 2021 23:12:09 -0800 (PST)
MIME-Version: 1.0
References: <20211125060547.11961-1-jasowang@redhat.com>
 <20211125015532-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211125015532-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 25 Nov 2021 15:11:58 +0800
Message-ID: <CACGkMEv+hehZazXRG9mavv=KZ76XfCrkeNqB8CPOnkwRF9cdHA@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: enable big mode correctly
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev <netdev@vger.kernel.org>, Eli Cohen <elic@nvidia.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Thu, Nov 25, 2021 at 3:00 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Nov 25, 2021 at 02:05:47PM +0800, Jason Wang wrote:
> > When VIRTIO_NET_F_MTU feature is not negotiated, we assume a very
> > large max_mtu. In this case, using small packet mode is not correct
> > since it may breaks the networking when MTU is grater than
> > ETH_DATA_LEN.
> >
> > To have a quick fix, simply enable the big packet mode when
> > VIRTIO_NET_F_MTU is not negotiated.
>
> This will slow down dpdk hosts which disable mergeable buffers
> and send standard MTU sized packets.
>
> > We can do optimization on top.
>
> I don't think it works like this, increasing mtu
> from guest >4k never worked,

Looking at add_recvbuf_small() it's actually GOOD_PACKET_LEN if I was not wrong.

> we can't regress everyone's
> performance with a promise to maybe sometime bring it back.

So consider it never work before I wonder if we can assume a 1500 as
max_mtu value instead of simply using MAX_MTU?

Thanks

>
> > Reported-by: Eli Cohen <elic@nvidia.com>
> > Cc: Eli Cohen <elic@nvidia.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> >
> > ---
> >  drivers/net/virtio_net.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 7c43bfc1ce44..83ae3ef5eb11 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3200,11 +3200,12 @@ static int virtnet_probe(struct virtio_device *vdev)
> >               dev->mtu = mtu;
> >               dev->max_mtu = mtu;
> >
> > -             /* TODO: size buffers correctly in this case. */
> > -             if (dev->mtu > ETH_DATA_LEN)
> > -                     vi->big_packets = true;
> >       }
> >
> > +     /* TODO: size buffers correctly in this case. */
> > +     if (dev->max_mtu > ETH_DATA_LEN)
> > +             vi->big_packets = true;
> > +
> >       if (vi->any_header_sg)
> >               dev->needed_headroom = vi->hdr_len;
> >
> > --
> > 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
