Return-Path: <SRS0=tDXz=KH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C080C433B4
	for <virtualization@archiver.kernel.org>; Wed, 12 May 2021 18:57:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D8CB613B5
	for <virtualization@archiver.kernel.org>; Wed, 12 May 2021 18:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D8CB613B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F1E9B84431;
	Wed, 12 May 2021 18:57:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4TSrq7kC5Ucu; Wed, 12 May 2021 18:57:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7C2E98442B;
	Wed, 12 May 2021 18:57:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53A1BC000D;
	Wed, 12 May 2021 18:57:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1882CC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 18:57:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F12B760DE2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 18:56:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZlsyMVWS14cs
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 18:56:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 139606075A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 18:56:58 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 g15-20020a9d128f0000b02902a7d7a7bb6eso21480464otg.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 11:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mpQjVx+/QfqR0pn4o8Ju928QdaYbFB0kBBz4UV+mn+0=;
 b=SO9+8FKxgXRbGu3ebKZVHcMv2fHMN11i9e2GIHiUUEWuipjAgmqzD0xjct7DE0mWko
 UiElZx9az7Cf9zBMIYrjXkI26jKpsqe+muetUiU9TT4ubLiJ7Ux2XKpdTlN+v8M/IGMj
 REQo3H1HQaxfYmHZYriH/Csa5rloabyfBbvMXQlorWjEd6fuCPMq0MtzBgM9VaHjYCk4
 eRy0HntmJkNnOaq9EhaNJc8QIDYR8GfumoBQ46ASk7vsI4lOqiiA2jVmcl7oMyj0iDGh
 VR8VGIQmPldE6YuSyLDLIzOQKUmrW7Aa3YwKXsZQvH5cvoW2pQRnVFGl+Q/dpOQ+xXk1
 UKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mpQjVx+/QfqR0pn4o8Ju928QdaYbFB0kBBz4UV+mn+0=;
 b=Yd6r1duEMufiO5RSrh3VnOvekObMB9cBUJA3br4FFHeidXojY2urft7xImcajTOhXW
 LPTIhxqDTOo7hs5IKmjLETFJnzlBNKyZELIKH0RZOIAXEYeG4CzbP9LcZ3XNloBOa7JX
 E6EejlVBwJqdwMkBX0iywiMxFL4e124YRd/LJTQY5A9UU+2rVHs6TXseX3zGI42BfTXu
 NpCaCwg5H3isfBMCW8psBvK5tNbzTZKec4MWjby/CX9pISWFbe0XJ7w2syeIWDw041VZ
 iveOrLwIPzE3UOMgguyJswFswFruEL15mF6putoZ5u4zVepha4ACm64I9wkGCtj7AUcA
 4+6g==
X-Gm-Message-State: AOAM530AUX6Wq6x9s+XV9Y0Z9v/YGxq+RX6Bnt5qbjrRPFySuMCtt9+Q
 Q4QCWfmHYaS8jecMjSRkcQiF5e40kQ6zITBciOfEYA==
X-Google-Smtp-Source: ABdhPJwoj7rGQhAWz07iMzr5AvnqbEBRfn+tnercciMQG8rZChJyhzYEf595qy8/+DcEpmjtdLdZvMOxhvdTwTmumG4=
X-Received: by 2002:a9d:8ce:: with SMTP id 72mr33114920otf.220.1620845817949; 
 Wed, 12 May 2021 11:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210511044253.469034-1-yuri.benditovich@daynix.com>
 <20210511044253.469034-3-yuri.benditovich@daynix.com>
 <CA+FuTSdfA6sT68AJNpa=VPBdwRFHvEY+=C-B_mS=y=WMpTyc=Q@mail.gmail.com>
 <CAOEp5OcV-YmPFoewuCHg=ADFQ4BmVL5ioMgh3qVjUGk9mauejg@mail.gmail.com>
 <CA+FuTSes20+KKhnNFHyOa_E0dp-RgUNFRj-YLHvjpqqL75zDXQ@mail.gmail.com>
In-Reply-To: <CA+FuTSes20+KKhnNFHyOa_E0dp-RgUNFRj-YLHvjpqqL75zDXQ@mail.gmail.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Wed, 12 May 2021 21:56:46 +0300
Message-ID: <CAOEp5OcYL8E__wpHgbFkkJJ98FG_zjhKMBLnCJym8CjkHby3eA@mail.gmail.com>
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

On Wed, May 12, 2021 at 5:33 PM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Wed, May 12, 2021 at 2:10 AM Yuri Benditovich
> <yuri.benditovich@daynix.com> wrote:
> >
> > On Tue, May 11, 2021 at 8:48 PM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > On Tue, May 11, 2021 at 12:43 AM Yuri Benditovich
> > > <yuri.benditovich@daynix.com> wrote:
> > > >
> > > > Large UDP packet provided by the guest with GSO type set to
> > > > VIRTIO_NET_HDR_GSO_UDP_L4 will be divided to several UDP
> > > > packets according to the gso_size field.
> > > >
> > > > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > > > ---
> > > >  include/linux/virtio_net.h | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > > > index b465f8f3e554..4ecf9a1ca912 100644
> > > > --- a/include/linux/virtio_net.h
> > > > +++ b/include/linux/virtio_net.h
> > > > @@ -51,6 +51,11 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
> > > >                         ip_proto = IPPROTO_UDP;
> > > >                         thlen = sizeof(struct udphdr);
> > > >                         break;
> > > > +               case VIRTIO_NET_HDR_GSO_UDP_L4:
> > > > +                       gso_type = SKB_GSO_UDP_L4;
> > > > +                       ip_proto = IPPROTO_UDP;
> > > > +                       thlen = sizeof(struct udphdr);
> > > > +                       break;
> > >
> > > If adding a new VIRTIO_NET_HDR type I suggest adding separate IPv4 and
> > > IPv6 variants, analogous to VIRTIO_NET_HDR_GSO_TCPV[46]. To avoid
> > > having to infer protocol again, as for UDP fragmentation offload (the
> > > retry case below this code).
> >
> > Thank you for denoting this important point of distinguishing between v4 and v6.
> > Let's try to take a deeper look to see what is the correct thing to do
> > and please correct me if I'm wrong:
> > 1. For USO we do not need to guess the protocol as it is used with
> > VIRTIO_NET_HDR_F_NEEDS_CSUM (unlike UFO)
>
> Enforcing that is a good start. We should also enforce that
> skb->protocol is initialized to one of htons(ETH_P_IP) or
> htons(ETH_P_IPV6), so that it does not have to be inferred by parsing.

As this feature is new and is not used in any public release of any
misbehaving driver, probably it is enough to state in the spec that
VIRTIO_NET_HDR_F_NEEDS_CSUM is required for USO packets.
The spec states that the USO feature requires checksumming feature.

>
> These requirements were not enforced for previous values, and cannot
> be introduced afterwards, which has led to have to add that extra code
> to handle these obscure edge cases.
>
> I agree that with well behaved configurations, the need for separate
> _V4 and _V6 variants is not needed.
>
> > and the USO packets
> > transmitted by the guest are under the same clause as both
> > VIRTIO_NET_HDR_GSO_TCP, i.e. under if (hdr->flags &
> > VIRTIO_NET_HDR_F_NEEDS_CSUM) {
> > 2. If we even define VIRTIO_NET_HDR_GSO_UDPv4_L4 and
> > VIRTIO_NET_HDR_GSO_UDPv6_L4 - both will be translated to
> > SKB_GSO_UDP_L4, so this information is immediately lost (the code will
> > look like:
> > case VIRTIO_NET_HDR_GSO_UDP4_L4: case VIRTIO_NET_HDR_GSO_UDP6_L4
> >     gso_type = SKB_GSO_UDP;
> >
> > 3. When we will define the respective guest features (like
> > VIRTIO_NET_F_HOST_USO4 VIRTIO_NET_F_HOST_USO6) we will need to
This is my typo: VIRTIO_NET_F_GUEST_USO4...
> > recreate the virtio_net header from the skb when both v4 and v6 have
> > the same SKB_GSO_UDP_L4, (see virtio_net_hdr_from_skb) and I'm not
> > sure whether somebody needs the exact v4 or v6 information on guest RX
> > path.
>
> FWIW, it is good to keep in mind that virtio_net_hdr is also used
> outside virtio, in both ingress and egress paths.

Can you please elaborate in which scenarios we do not have any virtio
device in path but need virtio_net_hdr?

>
> > 4. What is completely correct is that when we will start working with
> > the guest RX path we will need to define something like NETIF_F_USO4
> > and NETIF_F_USO6 and configure them according to exact guest offload
> > capabilities.
> > Do you agree?
>
> I don't immediately see the need for advertising this device feature
> on a per-protocol basis. Can you elaborate?

Separate offload setting (controlled by the guest) for v4 and v6 in
guest RX path is mandatory, at least Windows always requires this for
any offload.
In this case it seems easy to have also virtio-net device features to
be indicated separately (the TAP/TUN should report its capabilities).
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
