Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E375C433EF
	for <virtualization@archiver.kernel.org>; Thu, 25 Nov 2021 07:31:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AFA8340018;
	Thu, 25 Nov 2021 07:31:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7Efeoamf0oh7; Thu, 25 Nov 2021 07:31:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 18E764021F;
	Thu, 25 Nov 2021 07:31:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0307C002F;
	Thu, 25 Nov 2021 07:31:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A986EC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 07:31:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 92F644021F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 07:31:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EV2z3GzJERnO
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 07:31:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A276940018
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 07:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637825474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y5eJI0pmeXq/S80YZOfzijUCY3OPnAMCMR2eYYY351o=;
 b=elA0UzDo3ONd257kGBCI565NMMqxv5J2n4N9ZSBR065QKDeOi3CHwgoiwL85e5uVhMbgmd
 btLKIPzA8N1hmoS7lmeWszCHY5Sw0WAsH0Chaxwb91div5RvGAK1FgqNby8EcoxpyXHqeN
 iyd6TVCzcQVBKv8OPq3UljOouYEB764=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-309-8veaCuHZPWmNo6Pn7KEOsA-1; Thu, 25 Nov 2021 02:31:13 -0500
X-MC-Unique: 8veaCuHZPWmNo6Pn7KEOsA-1
Received: by mail-ed1-f70.google.com with SMTP id
 a3-20020a05640213c300b003e7d12bb925so4704554edx.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 23:31:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Y5eJI0pmeXq/S80YZOfzijUCY3OPnAMCMR2eYYY351o=;
 b=4V86C76hQzAjT4/C+D4jrnNJOB8BK6XZuJt8DliWiJfY0N92mSMO3DJml0Kfwc45Wc
 ZT/nCeB8Hl3VxRm3vfLRwoQhxZK6/pWZwnrghffMu/pN6Pa5M/MKW1m50dEfTEBX9iBZ
 tGBtY1+6g6hUKmPaOYtXOGU4eg5FjaZPz9k4SzSslNAvE46hayqWeIEus2uRLL4fnSs+
 wXuvXujow81TDpcbacva2SEyKkxH00s794tvaXe3QInEoYWTnCsr4HbLf5idBy3O1Mze
 fN5HvGUX2vTz/YGPpRwQpiWW211XwHLS4EovIPVshuGyMnqIV2qYcyuoswJQB/ifX3Bb
 q+3g==
X-Gm-Message-State: AOAM5307SON1JhH8d2RyAQiSYUx6kq7SJWUXsgqiscV7gBdUxdBfDLAK
 fZyWyMP1WMa/y7PvtGFQ8JIGqqjKb1OacX9nBzHnaQ6b1dbd5RufLo8ypaNfD+B37C2uMeBr0ah
 C+omeOH3H0E+FJ6TsMWJ1rprkfWJBCx/Bbeg3g7fz0g==
X-Received: by 2002:a05:6402:1768:: with SMTP id
 da8mr25711400edb.252.1637825472114; 
 Wed, 24 Nov 2021 23:31:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyFdLw5OpKsVjX5SKIvWd83t+uIMlDFgJtQwFJcoac+GAXQ+szrPYXWa/3fjvXjeKAZDLCgeA==
X-Received: by 2002:a05:6402:1768:: with SMTP id
 da8mr25711383edb.252.1637825471883; 
 Wed, 24 Nov 2021 23:31:11 -0800 (PST)
Received: from redhat.com ([45.15.18.67])
 by smtp.gmail.com with ESMTPSA id n16sm1263656edt.67.2021.11.24.23.31.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Nov 2021 23:31:11 -0800 (PST)
Date: Thu, 25 Nov 2021 02:31:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net] virtio-net: enable big mode correctly
Message-ID: <20211125022736-mutt-send-email-mst@kernel.org>
References: <20211125060547.11961-1-jasowang@redhat.com>
 <20211125070939.GC211101@mtl-vdi-166.wap.labs.mlnx>
 <CACGkMEsNsQ_XWTvdjaCEdo8sYaLew24zU1UUCJrokM-Koxj4fw@mail.gmail.com>
 <20211125072040.GA213301@mtl-vdi-166.wap.labs.mlnx>
 <CACGkMEuYWoL4x5o_OO2a27X4Ah8Y2ggBjy0XFHe3Onmj4RhFFg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuYWoL4x5o_OO2a27X4Ah8Y2ggBjy0XFHe3Onmj4RhFFg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

On Thu, Nov 25, 2021 at 03:26:22PM +0800, Jason Wang wrote:
> On Thu, Nov 25, 2021 at 3:20 PM Eli Cohen <elic@nvidia.com> wrote:
> >
> > On Thu, Nov 25, 2021 at 03:15:33PM +0800, Jason Wang wrote:
> > > On Thu, Nov 25, 2021 at 3:09 PM Eli Cohen <elic@nvidia.com> wrote:
> > > >
> > > > On Thu, Nov 25, 2021 at 02:05:47PM +0800, Jason Wang wrote:
> > > > > When VIRTIO_NET_F_MTU feature is not negotiated, we assume a very
> > > > > large max_mtu. In this case, using small packet mode is not correct
> > > > > since it may breaks the networking when MTU is grater than
> > > > > ETH_DATA_LEN.
> > > > >
> > > > > To have a quick fix, simply enable the big packet mode when
> > > > > VIRTIO_NET_F_MTU is not negotiated. We can do optimization on top.
> > > > >
> > > > > Reported-by: Eli Cohen <elic@nvidia.com>
> > > > > Cc: Eli Cohen <elic@nvidia.com>
> > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > ---
> > > > >  drivers/net/virtio_net.c | 7 ++++---
> > > > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index 7c43bfc1ce44..83ae3ef5eb11 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -3200,11 +3200,12 @@ static int virtnet_probe(struct virtio_device *vdev)
> > > > >               dev->mtu = mtu;
> > > > >               dev->max_mtu = mtu;
> > > > >
> > > > > -             /* TODO: size buffers correctly in this case. */
> > > > > -             if (dev->mtu > ETH_DATA_LEN)
> > > > > -                     vi->big_packets = true;
> > > > >       }
> > > > >
> > > > > +     /* TODO: size buffers correctly in this case. */
> > > > > +     if (dev->max_mtu > ETH_DATA_LEN)
> > > > > +             vi->big_packets = true;
> > > > > +
> > > >
> > > > If VIRTIO_NET_F_MTU is provided, then dev->max_mtu is going to equal
> > > > ETH_DATA_LEN (will be set in ether_setup()) so I don't think it will set
> > > > big_packets to true.
> > >
> > > I may miss something, the dev->max_mtu is just assigned to the mtu
> > > value read from the config space in the code block above  (inside the
> > > feature check of VIRTIO_NET_F_MTU).
> >
> > Sorry, I meant "If VIRTIO_NET_F_MTU is ***NOT*** provided". In that case
> > dev->max_mtu eauals ETH_DATA_LEN so you won't set vi->big_packets to
> > true.
> 
> I see but in this case, the above assignment:
> 
>         /* MTU range: 68 - 65535 */
>         dev->min_mtu = MIN_MTU;
>         dev->max_mtu = MAX_MTU;
> 
> happens after alloc_etherdev_mq() which calls ether_setup(), so we are
> probably fine here.
> 
> Thanks

Actually the issue with VIRTIO_NET_F_MTU is that devices might be
tempted to expose 9k here simply because they support jumbo frames,
if they also don't support mergeable buffers this will force big
packet mode.


> >
> > >
> > > Thanks
> > >
> > > >
> > > >
> > > > >       if (vi->any_header_sg)
> > > > >               dev->needed_headroom = vi->hdr_len;
> > > > >
> > > > > --
> > > > > 2.25.1
> > > > >
> > > >
> > >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
