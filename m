Return-Path: <SRS0=tDXz=KH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926DEC433B4
	for <virtualization@archiver.kernel.org>; Wed, 12 May 2021 19:54:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0CC9613F7
	for <virtualization@archiver.kernel.org>; Wed, 12 May 2021 19:54:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0CC9613F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 658C84037A;
	Wed, 12 May 2021 19:54:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EmkgmWZYQ0y6; Wed, 12 May 2021 19:53:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA0FD4035C;
	Wed, 12 May 2021 19:53:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D72EC000E;
	Wed, 12 May 2021 19:53:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1CBAAC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 19:53:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0B075606BE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 19:53:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5rdEBz_NYMmT
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 19:53:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2C22A606AE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 19:53:56 +0000 (UTC)
Received: by mail-qt1-x831.google.com with SMTP id y12so18134981qtx.11
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 12:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=syGZF7+djubx9pa7ZPTidnBUE+ock6AOR0GRlEeKssA=;
 b=Y7If/mRbIPQabIipvrYs+XR6pg0h45N6t3fp+NE68nX1LUDvs9tkhx3O9N61NQBagf
 E+DmWYzqEyvaCIwx0kFYhQAPFN/FCaDfoloPozKlx2M/CYZS8hYi/xTA6hVdJQVDZ/Ma
 tK/HUWkhjFUOBcI22gXsCCHz7aXuqGlj6/gI9sSllp3mRrsbg20y4RuhWMynXWLcPBKJ
 4JZN0KzBwKJsgIhS0Yer/pzi2KN4ly0qNS8nM9QclLr9Rn/6QCAovFzRAcFxYlQM5acj
 rAiSYvzjfT1Ac2FRzpRbPGR75Dum8zk+1aZF+npfYQk4jaRKv4bO/3pmtBdarEyhuc28
 HKfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=syGZF7+djubx9pa7ZPTidnBUE+ock6AOR0GRlEeKssA=;
 b=uUGcIqU4YE9eTIp+hVhG9CD/+rED5PR7XHkGzXYBxDDJeIIX1jPVCOMNoeNm+92Soa
 7chJ7dY+ALESATWajWA1Qm4VLK6vQHIQk6xUEeis3gjVyhfr+vqYUv6szFKlglW6azsJ
 +yWj41CWUt/9b8e9xgbRH8L3D4nY1FArIHtaqkc/wo05bWPr92cwUHzbHENAvKyIpbjv
 m50PzenULbd97COKD8DfnleAhfMT5+SiDNQt4HLEQYRKkn/Fqb5YsCXBrcjeO3p6zVP+
 YBtU2pwfSlAZJcVeAcpbjNWQZ60KKe2LGqV5X6aelOAD5+jx5foHn6/EV2TR0BPAVl5P
 ldnA==
X-Gm-Message-State: AOAM532qmNoM8kQnDsxU0qAZtfG4GaAZR3HSvaX17mNS0afD/B0tu8Pm
 kB7NYxV5BhNEy/SIXH3y1LvkcEnzVpyFJNHj3wA=
X-Google-Smtp-Source: ABdhPJz2GsrpoDaVo/3vzxZtT4sNl8dUECAGbOZy/bDG0rp34XmH/qniFMWyx+TZVmdLmOv0mVzYkJH7StGzMZdlabQ=
X-Received: by 2002:ac8:5850:: with SMTP id h16mr23134269qth.355.1620849234999; 
 Wed, 12 May 2021 12:53:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210511044253.469034-1-yuri.benditovich@daynix.com>
 <20210511044253.469034-3-yuri.benditovich@daynix.com>
 <CA+FuTSdfA6sT68AJNpa=VPBdwRFHvEY+=C-B_mS=y=WMpTyc=Q@mail.gmail.com>
 <CAOEp5OcV-YmPFoewuCHg=ADFQ4BmVL5ioMgh3qVjUGk9mauejg@mail.gmail.com>
 <CA+FuTSes20+KKhnNFHyOa_E0dp-RgUNFRj-YLHvjpqqL75zDXQ@mail.gmail.com>
 <CAOEp5OcYL8E__wpHgbFkkJJ98FG_zjhKMBLnCJym8CjkHby3eA@mail.gmail.com>
In-Reply-To: <CAOEp5OcYL8E__wpHgbFkkJJ98FG_zjhKMBLnCJym8CjkHby3eA@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 12 May 2021 15:53:17 -0400
Message-ID: <CAF=yD-+3zbEH2zUac9nOPVu3ojD7BtE=isOpoNq4GMPnvAVqsQ@mail.gmail.com>
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

On Wed, May 12, 2021 at 2:56 PM Yuri Benditovich
<yuri.benditovich@daynix.com> wrote:
>
> On Wed, May 12, 2021 at 5:33 PM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > On Wed, May 12, 2021 at 2:10 AM Yuri Benditovich
> > <yuri.benditovich@daynix.com> wrote:
> > >
> > > On Tue, May 11, 2021 at 8:48 PM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > On Tue, May 11, 2021 at 12:43 AM Yuri Benditovich
> > > > <yuri.benditovich@daynix.com> wrote:
> > > > >
> > > > > Large UDP packet provided by the guest with GSO type set to
> > > > > VIRTIO_NET_HDR_GSO_UDP_L4 will be divided to several UDP
> > > > > packets according to the gso_size field.
> > > > >
> > > > > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > > > > ---
> > > > >  include/linux/virtio_net.h | 5 +++++
> > > > >  1 file changed, 5 insertions(+)
> > > > >
> > > > > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > > > > index b465f8f3e554..4ecf9a1ca912 100644
> > > > > --- a/include/linux/virtio_net.h
> > > > > +++ b/include/linux/virtio_net.h
> > > > > @@ -51,6 +51,11 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
> > > > >                         ip_proto = IPPROTO_UDP;
> > > > >                         thlen = sizeof(struct udphdr);
> > > > >                         break;
> > > > > +               case VIRTIO_NET_HDR_GSO_UDP_L4:
> > > > > +                       gso_type = SKB_GSO_UDP_L4;
> > > > > +                       ip_proto = IPPROTO_UDP;
> > > > > +                       thlen = sizeof(struct udphdr);
> > > > > +                       break;
> > > >
> > > > If adding a new VIRTIO_NET_HDR type I suggest adding separate IPv4 and
> > > > IPv6 variants, analogous to VIRTIO_NET_HDR_GSO_TCPV[46]. To avoid
> > > > having to infer protocol again, as for UDP fragmentation offload (the
> > > > retry case below this code).
> > >
> > > Thank you for denoting this important point of distinguishing between v4 and v6.
> > > Let's try to take a deeper look to see what is the correct thing to do
> > > and please correct me if I'm wrong:
> > > 1. For USO we do not need to guess the protocol as it is used with
> > > VIRTIO_NET_HDR_F_NEEDS_CSUM (unlike UFO)
> >
> > Enforcing that is a good start. We should also enforce that
> > skb->protocol is initialized to one of htons(ETH_P_IP) or
> > htons(ETH_P_IPV6), so that it does not have to be inferred by parsing.
>
> As this feature is new and is not used in any public release of any
> misbehaving driver, probably it is enough to state in the spec that
> VIRTIO_NET_HDR_F_NEEDS_CSUM is required for USO packets.
> The spec states that the USO feature requires checksumming feature.

The spec is not sufficient. These rules need to be enforced in the
kernel code, too.

> >
> > These requirements were not enforced for previous values, and cannot
> > be introduced afterwards, which has led to have to add that extra code
> > to handle these obscure edge cases.
> >
> > I agree that with well behaved configurations, the need for separate
> > _V4 and _V6 variants is not needed.
> >
> > > and the USO packets
> > > transmitted by the guest are under the same clause as both
> > > VIRTIO_NET_HDR_GSO_TCP, i.e. under if (hdr->flags &
> > > VIRTIO_NET_HDR_F_NEEDS_CSUM) {
> > > 2. If we even define VIRTIO_NET_HDR_GSO_UDPv4_L4 and
> > > VIRTIO_NET_HDR_GSO_UDPv6_L4 - both will be translated to
> > > SKB_GSO_UDP_L4, so this information is immediately lost (the code will
> > > look like:
> > > case VIRTIO_NET_HDR_GSO_UDP4_L4: case VIRTIO_NET_HDR_GSO_UDP6_L4
> > >     gso_type = SKB_GSO_UDP;
> > >
> > > 3. When we will define the respective guest features (like
> > > VIRTIO_NET_F_HOST_USO4 VIRTIO_NET_F_HOST_USO6) we will need to
> This is my typo: VIRTIO_NET_F_GUEST_USO4...
> > > recreate the virtio_net header from the skb when both v4 and v6 have
> > > the same SKB_GSO_UDP_L4, (see virtio_net_hdr_from_skb) and I'm not
> > > sure whether somebody needs the exact v4 or v6 information on guest RX
> > > path.
> >
> > FWIW, it is good to keep in mind that virtio_net_hdr is also used
> > outside virtio, in both ingress and egress paths.
>
> Can you please elaborate in which scenarios we do not have any virtio
> device in path but need virtio_net_hdr?

Packet sockets, tuntap.

> > > 4. What is completely correct is that when we will start working with
> > > the guest RX path we will need to define something like NETIF_F_USO4
> > > and NETIF_F_USO6 and configure them according to exact guest offload
> > > capabilities.
> > > Do you agree?
> >
> > I don't immediately see the need for advertising this device feature
> > on a per-protocol basis. Can you elaborate?
>
> Separate offload setting (controlled by the guest) for v4 and v6 in
> guest RX path is mandatory, at least Windows always requires this for
> any offload.
> In this case it seems easy to have also virtio-net device features to
> be indicated separately (the TAP/TUN should report its capabilities).

Ah, ok.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
