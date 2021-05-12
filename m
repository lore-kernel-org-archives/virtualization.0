Return-Path: <SRS0=tDXz=KH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB3FC433ED
	for <virtualization@archiver.kernel.org>; Wed, 12 May 2021 06:09:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 539666162B
	for <virtualization@archiver.kernel.org>; Wed, 12 May 2021 06:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 539666162B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 080BC60724;
	Wed, 12 May 2021 06:09:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id emsgzxWgJlFw; Wed, 12 May 2021 06:09:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 98AD36072C;
	Wed, 12 May 2021 06:09:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65B53C000E;
	Wed, 12 May 2021 06:09:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53391C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 06:09:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 425104027E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 06:09:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Axpvf3GlSupJ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 06:09:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4F3B940015
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 06:09:49 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id c3so21255336oic.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 23:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NPvm8NafxYzbmgPT1/KnpbyytRpdTESXUP6H+J3SyAo=;
 b=ggF7RmO/OPDJ7AQgIQ0iAERaZHJ5C488AblpYNQs+6RcXH8iQfaDsO9WAjqnEaNu3B
 vyg1bJF5Dd+pO6xB6zaGtHpjIxqB59k77WjABh4PU9nrp0kIwPHpeWegKXpB+6IUtixB
 kDmOjvtzodcTA+FiAE9bTJ6XPyGiZiwQRttA/ssbvAZQCu2t8r9O10j7y/V7kItmstEa
 BF1of08PkuFFYGp0Z4JEzekK26g65DCBOBDmsek68B00SsXAy6isjmx/FxnAp2BoSMz2
 w5KdGBqWSWJ+RjIJ+OinIUCBsjjHwkvspW/xdGmKKO9dPL7//7vDRtvZdx0niDy2vHc8
 sJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NPvm8NafxYzbmgPT1/KnpbyytRpdTESXUP6H+J3SyAo=;
 b=tPnG0Yo9CBNj1Pp5417CqyCUJhek+1CM+X/MLz2te0eSxyl0U1bm6iC7hDN/R9UVzM
 vgmW8W/q58Q/9kF8p2a/nIkLUX30ZimcOysjIQtiOOXviXwxmEDym3zTJ5HsQsUJedZr
 NyM2x9gRqPpe42zHApBWKXdGpJVx3oDErZwuqVmE6pq22YeUqqySU1kZ0bI++qAAX2/f
 6C0ch+AVBuYXgrrfkYDR8LMXbAJmdpvhxaoVfiVj6ef8I3Kyqy4qCLEWC5hxBA7E5C5/
 Ses7DD7o46KJavjhX/Z2Q2FfW4s4A3b4S+TQUmzi7MetpU7lUwaAWh0GKcr0MZVt5N6Y
 zzzg==
X-Gm-Message-State: AOAM5335ak8yIcdtVghc6cvHCHaDr8uD9A0sQ5bvd1joC/8L6fM2wckm
 Maz9hVxH7l8XDcfh6hBaKyQxhaGBgIrEAJFZOmPK0g==
X-Google-Smtp-Source: ABdhPJy9KOo+CF+jCVW3yBOXeKSl4RA9geS2kvTEhrUha9vxQ2cd7c36nf442Z3jotBZ/m00l78Ai/Z/tD82YEPUGHc=
X-Received: by 2002:aca:ad06:: with SMTP id w6mr6422169oie.54.1620799788219;
 Tue, 11 May 2021 23:09:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210511044253.469034-1-yuri.benditovich@daynix.com>
 <20210511044253.469034-3-yuri.benditovich@daynix.com>
 <CA+FuTSdfA6sT68AJNpa=VPBdwRFHvEY+=C-B_mS=y=WMpTyc=Q@mail.gmail.com>
In-Reply-To: <CA+FuTSdfA6sT68AJNpa=VPBdwRFHvEY+=C-B_mS=y=WMpTyc=Q@mail.gmail.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Wed, 12 May 2021 09:09:36 +0300
Message-ID: <CAOEp5OcV-YmPFoewuCHg=ADFQ4BmVL5ioMgh3qVjUGk9mauejg@mail.gmail.com>
Subject: Re: [PATCH 2/4] virtio-net: add support of UDP segmentation (USO) on
 the host
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Network Development <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Yan Vugenfirer <yan@daynix.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>
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

On Tue, May 11, 2021 at 8:48 PM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Tue, May 11, 2021 at 12:43 AM Yuri Benditovich
> <yuri.benditovich@daynix.com> wrote:
> >
> > Large UDP packet provided by the guest with GSO type set to
> > VIRTIO_NET_HDR_GSO_UDP_L4 will be divided to several UDP
> > packets according to the gso_size field.
> >
> > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > ---
> >  include/linux/virtio_net.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > index b465f8f3e554..4ecf9a1ca912 100644
> > --- a/include/linux/virtio_net.h
> > +++ b/include/linux/virtio_net.h
> > @@ -51,6 +51,11 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
> >                         ip_proto = IPPROTO_UDP;
> >                         thlen = sizeof(struct udphdr);
> >                         break;
> > +               case VIRTIO_NET_HDR_GSO_UDP_L4:
> > +                       gso_type = SKB_GSO_UDP_L4;
> > +                       ip_proto = IPPROTO_UDP;
> > +                       thlen = sizeof(struct udphdr);
> > +                       break;
>
> If adding a new VIRTIO_NET_HDR type I suggest adding separate IPv4 and
> IPv6 variants, analogous to VIRTIO_NET_HDR_GSO_TCPV[46]. To avoid
> having to infer protocol again, as for UDP fragmentation offload (the
> retry case below this code).

Thank you for denoting this important point of distinguishing between v4 and v6.
Let's try to take a deeper look to see what is the correct thing to do
and please correct me if I'm wrong:
1. For USO we do not need to guess the protocol as it is used with
VIRTIO_NET_HDR_F_NEEDS_CSUM (unlike UFO) and the USO packets
transmitted by the guest are under the same clause as both
VIRTIO_NET_HDR_GSO_TCP, i.e. under if (hdr->flags &
VIRTIO_NET_HDR_F_NEEDS_CSUM) {
2. If we even define VIRTIO_NET_HDR_GSO_UDPv4_L4 and
VIRTIO_NET_HDR_GSO_UDPv6_L4 - both will be translated to
SKB_GSO_UDP_L4, so this information is immediately lost (the code will
look like:
case VIRTIO_NET_HDR_GSO_UDP4_L4: case VIRTIO_NET_HDR_GSO_UDP6_L4
    gso_type = SKB_GSO_UDP;

3. When we will define the respective guest features (like
VIRTIO_NET_F_HOST_USO4 VIRTIO_NET_F_HOST_USO6) we will need to
recreate the virtio_net header from the skb when both v4 and v6 have
the same SKB_GSO_UDP_L4, (see virtio_net_hdr_from_skb) and I'm not
sure whether somebody needs the exact v4 or v6 information on guest RX
path.
4. What is completely correct is that when we will start working with
the guest RX path we will need to define something like NETIF_F_USO4
and NETIF_F_USO6 and configure them according to exact guest offload
capabilities.
Do you agree?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
