Return-Path: <SRS0=tDXz=KH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41606C433B4
	for <virtualization@archiver.kernel.org>; Wed, 12 May 2021 14:33:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D9366142E
	for <virtualization@archiver.kernel.org>; Wed, 12 May 2021 14:33:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D9366142E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 25074842CB;
	Wed, 12 May 2021 14:33:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dK_ctpFH9UXJ; Wed, 12 May 2021 14:33:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E11C83ED2;
	Wed, 12 May 2021 14:33:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72A64C000D;
	Wed, 12 May 2021 14:33:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2033EC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 14:33:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EB9EF4037B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 14:33:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id csE3lBOMIRS1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 14:33:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D7F1740002
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 14:33:20 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id r11so3306196edt.13
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 07:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=v8nnd2ujlB60GPiA1lPsUn5BttskeOt6aee1p1TS5NI=;
 b=Wpp5b+dJz7p84pYFu61NJPWS4c2Iy94l38MMIIrcvuSyboDZb8mrAauO3NExSxNvxO
 gxIiCahmDKdGGZLEachs9sYewc/p5Ffh5QD8PfCExLjZ9o4ms/CuLM7muZKbmq6kgAmz
 DoReFAC9jIdpFjCoLD9tthT3L7CPfVDbJoDVUq2838G0Gl0SWXxLGu/Q7nMpaNyPR1dX
 1WWj5jqBeK0ZE76jprusRBgJ7gBIiGpZR8ajL4z4CQwT65uNBW2DDzDoEBCWOkLiTKpl
 uGDnqh2B7/aQwFYH5XPtPD83rkFQSovCQU+TH3bz/2A1RT2m5FZvOUqeeKwShBXTC5kg
 wGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=v8nnd2ujlB60GPiA1lPsUn5BttskeOt6aee1p1TS5NI=;
 b=AoI1JZfC0NvPnJQjcXuU1r85qxZLQihfLkMU6r8qFqEsj3UmHeNdIrhiFd4wB0Pz2U
 SQ6uhN5jxu0UYQ5OVQkINjVgunmCCzq/dF3z1XSx75H0K4Yl3uzm7Fj9YiGR2T2s3f6O
 +bhCarxhxvIBBJKqwvOrp1kHk7aEqM2NqZ2anPQfK3WPb0m4JGH4CCps61B3KnnmK3dQ
 yNY0soTpnZ4xZCbGzEFnB3M4kkCNBlfb1/02rnEZC+GgqWe35FIumzK4uxU7/1LIVkg3
 17g6GB9rDoFn5zeLXY4Da0wO+w746l9nZdbND6ear9hahTKBPZZtRSpUb4RC3osSfv3E
 3JuA==
X-Gm-Message-State: AOAM533AeJEeg/1t2zyzxobrVCs0S6ZqmB0mWQ3kvRcUrVhMu+af3whm
 fHzI1PHJNMmTVav/IBBOAG+IAhc1t0Kv4g==
X-Google-Smtp-Source: ABdhPJxswVJBRNjaoVYoDVoYZwIys2i+IPtrwI4e/nNLoC2/cJ8nmlzFe69p1gCgHmRu4RfxDY3nrA==
X-Received: by 2002:a05:6402:4251:: with SMTP id
 g17mr42905882edb.205.1620829998511; 
 Wed, 12 May 2021 07:33:18 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com.
 [209.85.221.54])
 by smtp.gmail.com with ESMTPSA id n11sm15208061ejg.43.2021.05.12.07.33.17
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 May 2021 07:33:17 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id t18so23873175wry.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 07:33:17 -0700 (PDT)
X-Received: by 2002:a05:6000:1787:: with SMTP id
 e7mr45453515wrg.12.1620829996861; 
 Wed, 12 May 2021 07:33:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210511044253.469034-1-yuri.benditovich@daynix.com>
 <20210511044253.469034-3-yuri.benditovich@daynix.com>
 <CA+FuTSdfA6sT68AJNpa=VPBdwRFHvEY+=C-B_mS=y=WMpTyc=Q@mail.gmail.com>
 <CAOEp5OcV-YmPFoewuCHg=ADFQ4BmVL5ioMgh3qVjUGk9mauejg@mail.gmail.com>
In-Reply-To: <CAOEp5OcV-YmPFoewuCHg=ADFQ4BmVL5ioMgh3qVjUGk9mauejg@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 12 May 2021 10:32:39 -0400
X-Gmail-Original-Message-ID: <CA+FuTSes20+KKhnNFHyOa_E0dp-RgUNFRj-YLHvjpqqL75zDXQ@mail.gmail.com>
Message-ID: <CA+FuTSes20+KKhnNFHyOa_E0dp-RgUNFRj-YLHvjpqqL75zDXQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] virtio-net: add support of UDP segmentation (USO) on
 the host
To: Yuri Benditovich <yuri.benditovich@daynix.com>
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

On Wed, May 12, 2021 at 2:10 AM Yuri Benditovich
<yuri.benditovich@daynix.com> wrote:
>
> On Tue, May 11, 2021 at 8:48 PM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > On Tue, May 11, 2021 at 12:43 AM Yuri Benditovich
> > <yuri.benditovich@daynix.com> wrote:
> > >
> > > Large UDP packet provided by the guest with GSO type set to
> > > VIRTIO_NET_HDR_GSO_UDP_L4 will be divided to several UDP
> > > packets according to the gso_size field.
> > >
> > > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > > ---
> > >  include/linux/virtio_net.h | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > > index b465f8f3e554..4ecf9a1ca912 100644
> > > --- a/include/linux/virtio_net.h
> > > +++ b/include/linux/virtio_net.h
> > > @@ -51,6 +51,11 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
> > >                         ip_proto = IPPROTO_UDP;
> > >                         thlen = sizeof(struct udphdr);
> > >                         break;
> > > +               case VIRTIO_NET_HDR_GSO_UDP_L4:
> > > +                       gso_type = SKB_GSO_UDP_L4;
> > > +                       ip_proto = IPPROTO_UDP;
> > > +                       thlen = sizeof(struct udphdr);
> > > +                       break;
> >
> > If adding a new VIRTIO_NET_HDR type I suggest adding separate IPv4 and
> > IPv6 variants, analogous to VIRTIO_NET_HDR_GSO_TCPV[46]. To avoid
> > having to infer protocol again, as for UDP fragmentation offload (the
> > retry case below this code).
>
> Thank you for denoting this important point of distinguishing between v4 and v6.
> Let's try to take a deeper look to see what is the correct thing to do
> and please correct me if I'm wrong:
> 1. For USO we do not need to guess the protocol as it is used with
> VIRTIO_NET_HDR_F_NEEDS_CSUM (unlike UFO)

Enforcing that is a good start. We should also enforce that
skb->protocol is initialized to one of htons(ETH_P_IP) or
htons(ETH_P_IPV6), so that it does not have to be inferred by parsing.

These requirements were not enforced for previous values, and cannot
be introduced afterwards, which has led to have to add that extra code
to handle these obscure edge cases.

I agree that with well behaved configurations, the need for separate
_V4 and _V6 variants is not needed.

> and the USO packets
> transmitted by the guest are under the same clause as both
> VIRTIO_NET_HDR_GSO_TCP, i.e. under if (hdr->flags &
> VIRTIO_NET_HDR_F_NEEDS_CSUM) {
> 2. If we even define VIRTIO_NET_HDR_GSO_UDPv4_L4 and
> VIRTIO_NET_HDR_GSO_UDPv6_L4 - both will be translated to
> SKB_GSO_UDP_L4, so this information is immediately lost (the code will
> look like:
> case VIRTIO_NET_HDR_GSO_UDP4_L4: case VIRTIO_NET_HDR_GSO_UDP6_L4
>     gso_type = SKB_GSO_UDP;
>
> 3. When we will define the respective guest features (like
> VIRTIO_NET_F_HOST_USO4 VIRTIO_NET_F_HOST_USO6) we will need to
> recreate the virtio_net header from the skb when both v4 and v6 have
> the same SKB_GSO_UDP_L4, (see virtio_net_hdr_from_skb) and I'm not
> sure whether somebody needs the exact v4 or v6 information on guest RX
> path.

FWIW, it is good to keep in mind that virtio_net_hdr is also used
outside virtio, in both ingress and egress paths.

> 4. What is completely correct is that when we will start working with
> the guest RX path we will need to define something like NETIF_F_USO4
> and NETIF_F_USO6 and configure them according to exact guest offload
> capabilities.
> Do you agree?

I don't immediately see the need for advertising this device feature
on a per-protocol basis. Can you elaborate?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
