Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86EC0C433EF
	for <virtualization@archiver.kernel.org>; Thu, 21 Apr 2022 14:16:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4912861369;
	Thu, 21 Apr 2022 14:16:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7-vjR2Z02_sX; Thu, 21 Apr 2022 14:16:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BBAC76135C;
	Thu, 21 Apr 2022 14:16:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B818C0033;
	Thu, 21 Apr 2022 14:16:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1785EC002C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 14:15:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F18C783689
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 14:15:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D8xIUoBTzSBX
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 14:15:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AA2D383196
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 14:15:57 +0000 (UTC)
Received: by mail-qk1-x72e.google.com with SMTP id e128so3617436qkd.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 07:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sgRgJQIriKo+0gldCYXcf1J9czouFNPq/lzf0Sf3+Go=;
 b=GkRi3mklj8SbZaBA+Pk73wqiwBIMA0328RZifBNc1s6tbEqsEzxmbM3O929vxzl7pO
 yup1LjVjvGvGPMsBlm7DRidlmyTp7smf4rulaATMIReQncfDofyFL6E8rorYBjAgiKgZ
 QXyz2nz736aMN5BCzw5ip2EQiMcoZIlkoE7RgHpbQELz2jBEKmcYEjFuRe1B5TKb5ENJ
 +BABjcGltgOjImVJ89DT9NghIWFV7x+vX7ZPhjlvJ7ndU7SQepmftq/S2wYCV1ay6Khy
 45OVKxPVHGpuqG3p0hQz0pQrrQhwkfYyrw+GtHKDA4owuyNarTjFiaq63hxaoY4FhNNY
 LIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sgRgJQIriKo+0gldCYXcf1J9czouFNPq/lzf0Sf3+Go=;
 b=S2rOokzcuWUHaJiyaRiAImKtw9dukQvItP4gj/c31EnrwzfsR7MVBjtLOX6eemzONt
 L4JRh9HkSATCTWJbHCnA1kpjH1EMK0PpQHLOkpHGmYZ5PU6vPk96PyAcVkcQxztutsXw
 i5odaEnbT18SDOmyLkXKCR1fMRla7keJf2Lp/2Sdussnd1JWUNyx1FORrvAUtwm0uf+O
 7uEci97VxWDBpaPbMCRH0Nl5+Aaf4qKydvDvbO24XT6STBEDNn46jfGnxuMYUCcfMMt2
 IPFdTkoPqZ0s1fMHvz1H7E2VRbPUUBlE9pQnAC5NevpBXweuyvwVZ9+KhPVPrEeVLUtF
 SfCQ==
X-Gm-Message-State: AOAM531rq1oj3mzSf7zQV235VpG4Y4P9lkB/lPbtvpb8HkgPArN9imnq
 cVklSLM6hoPC0QwcTcBBozoDtjE6f9Y=
X-Google-Smtp-Source: ABdhPJwP66YKpVd0iLRlKIScNCycEwl4O5K3ZS2dCKQBz3epPNATdGK5HE8/5HwB8T4YKmPRQveVow==
X-Received: by 2002:a05:620a:d:b0:69e:928b:54e1 with SMTP id
 j13-20020a05620a000d00b0069e928b54e1mr12085647qki.283.1650550556504; 
 Thu, 21 Apr 2022 07:15:56 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com.
 [209.85.128.172]) by smtp.gmail.com with ESMTPSA id
 s19-20020a05622a179300b002e1ceeb21d0sm3646493qtk.97.2022.04.21.07.15.55
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Apr 2022 07:15:55 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id
 00721157ae682-2ec05db3dfbso53442917b3.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 07:15:55 -0700 (PDT)
X-Received: by 2002:a81:3902:0:b0:2eb:f9f0:4b0c with SMTP id
 g2-20020a813902000000b002ebf9f04b0cmr25723280ywa.419.1650550554896; Thu, 21
 Apr 2022 07:15:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220420082758.581245-1-liuhangbin@gmail.com>
 <CA+FuTScyF4BKEcNSCYOv8SBA_EmB806YtKA17jb3F+fymVF-Pg@mail.gmail.com>
 <YmDCHI330AUfcYKa@Laptop-X1>
In-Reply-To: <YmDCHI330AUfcYKa@Laptop-X1>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 21 Apr 2022 10:15:16 -0400
X-Gmail-Original-Message-ID: <CA+FuTSckEJVUH1Q2vBxGbfPgVteyDVmTfjJC6hBj=qRP+JcAxA@mail.gmail.com>
Message-ID: <CA+FuTSckEJVUH1Q2vBxGbfPgVteyDVmTfjJC6hBj=qRP+JcAxA@mail.gmail.com>
Subject: Re: [PATCH net-next] net/af_packet: add VLAN support for AF_PACKET
 SOCK_RAW GSO
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Maxim Mikityanskiy <maximmi@mellanox.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, virtualization@lists.linux-foundation.org,
 Balazs Nemeth <bnemeth@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Mike Pattrick <mpattric@redhat.com>,
 "David S . Miller" <davem@davemloft.net>
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

On Wed, Apr 20, 2022 at 10:32 PM Hangbin Liu <liuhangbin@gmail.com> wrote:
>
> On Wed, Apr 20, 2022 at 09:45:15AM -0400, Willem de Bruijn wrote:
> > On Wed, Apr 20, 2022 at 4:28 AM Hangbin Liu <liuhangbin@gmail.com> wrote:
> > >
> > > Currently, the kernel drops GSO VLAN tagged packet if it's created with
> > > socket(AF_PACKET, SOCK_RAW, 0) plus virtio_net_hdr.
> > >
> > > The reason is AF_PACKET doesn't adjust the skb network header if there is
> > > a VLAN tag. Then after virtio_net_hdr_set_proto() called, the skb->protocol
> > > will be set to ETH_P_IP/IPv6. And in later inet/ipv6_gso_segment() the skb
> > > is dropped as network header position is invalid.
> > >
> > > Let's handle VLAN packets by adjusting network header position in
> > > packet_parse_headers(), and move the function in packet_snd() before
> > > calling virtio_net_hdr_set_proto().
> >
> > The network header is set in
> >
> >         skb_reset_network_header(skb);
> >
> >         err = -EINVAL;
> >         if (sock->type == SOCK_DGRAM) {
> >                 offset = dev_hard_header(skb, dev, ntohs(proto), addr,
> > NULL, len);
> >                 if (unlikely(offset < 0))
> >                         goto out_free;
> >         } else if (reserve) {
> >                 skb_reserve(skb, -reserve);
> >                 if (len < reserve + sizeof(struct ipv6hdr) &&
> >                     dev->min_header_len != dev->hard_header_len)
> >                         skb_reset_network_header(skb);
> >         }
> >
> > If all that is needed is to move the network header beyond an optional
> > VLAN tag in the case of SOCK_RAW, then this can be done in the else
> > for Ethernet packets.
>
> Before we set network position, we need to check the skb->protocol to make
> sure it's a VLAN packet.
>
> If we set skb->protocol and adjust network header here, like
> packet_parse_headers() does. How should we do with later
>
>         skb->protocol = proto;
>         skb->dev = dev;
>
> settings?
>
> If you are afraid that skb_probe_transport_header(skb) would affect the
> virtio_net_hdr operation. How about split the skb_probe_transport_header()
> from packet_parse_headers()? Something like
>
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -1924,13 +1924,19 @@ static int packet_rcv_spkt(struct sk_buff *skb, struct net_device *dev,
>
>  static void packet_parse_headers(struct sk_buff *skb, struct socket *sock)
>  {
> +       int depth;
> +
>         if ((!skb->protocol || skb->protocol == htons(ETH_P_ALL)) &&
>             sock->type == SOCK_RAW) {
>                 skb_reset_mac_header(skb);
>                 skb->protocol = dev_parse_header_protocol(skb);
>         }
>
> -       skb_probe_transport_header(skb);
> +       /* Move network header to the right position for VLAN tagged packets */
> +       if (likely(skb->dev->type == ARPHRD_ETHER) &&
> +           eth_type_vlan(skb->protocol) &&
> +           __vlan_get_protocol(skb, skb->protocol, &depth) != 0)
> +               skb_set_network_header(skb, depth);
>  }
>
>  /*
> @@ -3047,6 +3055,8 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
>         skb->mark = sockc.mark;
>         skb->tstamp = sockc.transmit_time;
>
> +       packet_parse_headers(skb, sock);
> +
>         if (has_vnet_hdr) {
>                 err = virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le());
>                 if (err)
> @@ -3055,7 +3065,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
>                 virtio_net_hdr_set_proto(skb, &vnet_hdr);
>         }
>
> -       packet_parse_headers(skb, sock);
> +       skb_probe_transport_header(skb);
>
>         if (unlikely(extra_len == 4))
>                 skb->no_fcs = 1;
>
>
> >
> > It is not safe to increase reserve, as that would eat into the
> > reserved hlen LL_RESERVED_SPACE(dev), which does not account for
> > optional VLAN headers.
> >
> > Instead of setting here first, then patching up again later in
> > packet_parse_headers.
> >
> > This change affects all packets with VLAN headers, not just those with
> > GSO. I imagine that moving the network header is safe for all, but
> > don't know that code well enough to verify that it does not have
> > unintended side effects. Does dev_queue_xmit expect the network header
> > to point to the start of the VLAN headers or after, for instance?
>
> I think adjust the network position should be safe, as tap device also did that.

Oh, it's great to be able to point to such prior art. Can you mention
that in the commit message?

Your approach does sound simpler than the above. Thanks for looking
into that alternative, though.

>
> Thanks
> Hangbin
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
