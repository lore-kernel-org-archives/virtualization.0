Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAAEBC433FE
	for <virtualization@archiver.kernel.org>; Wed, 20 Apr 2022 13:46:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D27E61127;
	Wed, 20 Apr 2022 13:46:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id encMGTHsJ36N; Wed, 20 Apr 2022 13:45:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 14B7D6103E;
	Wed, 20 Apr 2022 13:45:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA78EC002F;
	Wed, 20 Apr 2022 13:45:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2191FC002C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 13:45:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EE169418C4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 13:45:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NqxyIAHRn5z2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 13:45:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9A538418B7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 13:45:55 +0000 (UTC)
Received: by mail-qv1-xf35.google.com with SMTP id dw17so1324658qvb.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 06:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sJ9RcLP/tVKLGGcddgv1aP+nCZRY90/FrE1CfkE17Wo=;
 b=ObJYAxxv+0Jbrw5A391F9sRv3RmmwNNY6duAzbboDeK+PvuCA7ShcdBbK+IpgsXFSe
 mEOmWlho+qpTLXkljWGHJCPbmjHCF6E7S4IRistEHPITE3if+OkzwQhW1bz6EEOeKMPb
 nEEvKwjaHRcLIDTAr98URp+Aokcn34iIWr/iyRuhawJ8ywiCHKj9VhUEza8wX6Hqo8HI
 ax4CBKPQpIOy+0h9c1p4BGvEwDzLlVIH8IlLzhTijTKpULznHYxX29RIraw+/x/weZ1C
 t+NXPcb1F79rpYE5BDD3qtoUldMnlLqKF1SJfo3ROOELQtH89sBh9HMzJGkYHJsA2s6c
 ZjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sJ9RcLP/tVKLGGcddgv1aP+nCZRY90/FrE1CfkE17Wo=;
 b=pA2WY09ocyay31AI1zLmyprmdkAJDjxa/4PoUz1lfeaA3ssczD+IwC5WPR2JELLrVo
 E/YUB9Tzz8PYS7m9FTc+4NMsgGeNkhwxsr2+DPQH5JVS52k4X7yQHvQwV3jIkyYYnQHq
 TL6X448hoBFfon6uTNgicmao5NEFlqIJdxQrWuakyGFcrIG00RZn07ucu467dIDscSQr
 xM1I+e6CKXEg9gFbuJsL9pO7WOz5ywIGQd2swPPKJvurxrjJgFUjxOALecb+LxsfWaL+
 rpoaiTqQl4RcvY86Rgp7yCZqfbyCp7RbeuP9xJnCXm8oDszW4udOty1B7OVECSaxBkM8
 pCtQ==
X-Gm-Message-State: AOAM531WoKidIc5CG1Z19rH2yhmfufEH/NIx1UIxpT52fqT4ML8T/nUk
 Ewv4pwKSgZZ/jrjZE0Kg9mJH1vnfZms=
X-Google-Smtp-Source: ABdhPJwDX3HaPqtY8JWkhNcFBnfuU8+bMLK6LTmpiaNj6HLXJuPBrwgeCgMVSd5Wsvq1ba1XQSBnFw==
X-Received: by 2002:a05:6214:5282:b0:443:e161:ef4a with SMTP id
 kj2-20020a056214528200b00443e161ef4amr15337079qvb.23.1650462354235; 
 Wed, 20 Apr 2022 06:45:54 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com.
 [209.85.128.179]) by smtp.gmail.com with ESMTPSA id
 v23-20020ae9e317000000b0069ea555b54dsm1484114qkf.128.2022.04.20.06.45.53
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Apr 2022 06:45:53 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id
 00721157ae682-2ef4a241cc5so18618677b3.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 06:45:53 -0700 (PDT)
X-Received: by 2002:a81:3902:0:b0:2eb:f9f0:4b0c with SMTP id
 g2-20020a813902000000b002ebf9f04b0cmr20527581ywa.419.1650462352755; Wed, 20
 Apr 2022 06:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220420082758.581245-1-liuhangbin@gmail.com>
In-Reply-To: <20220420082758.581245-1-liuhangbin@gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 20 Apr 2022 09:45:15 -0400
X-Gmail-Original-Message-ID: <CA+FuTScyF4BKEcNSCYOv8SBA_EmB806YtKA17jb3F+fymVF-Pg@mail.gmail.com>
Message-ID: <CA+FuTScyF4BKEcNSCYOv8SBA_EmB806YtKA17jb3F+fymVF-Pg@mail.gmail.com>
Subject: Re: [PATCH net-next] net/af_packet: add VLAN support for AF_PACKET
 SOCK_RAW GSO
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Maxim Mikityanskiy <maximmi@mellanox.com>,
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

On Wed, Apr 20, 2022 at 4:28 AM Hangbin Liu <liuhangbin@gmail.com> wrote:
>
> Currently, the kernel drops GSO VLAN tagged packet if it's created with
> socket(AF_PACKET, SOCK_RAW, 0) plus virtio_net_hdr.
>
> The reason is AF_PACKET doesn't adjust the skb network header if there is
> a VLAN tag. Then after virtio_net_hdr_set_proto() called, the skb->protocol
> will be set to ETH_P_IP/IPv6. And in later inet/ipv6_gso_segment() the skb
> is dropped as network header position is invalid.
>
> Let's handle VLAN packets by adjusting network header position in
> packet_parse_headers(), and move the function in packet_snd() before
> calling virtio_net_hdr_set_proto().

The network header is set in

        skb_reset_network_header(skb);

        err = -EINVAL;
        if (sock->type == SOCK_DGRAM) {
                offset = dev_hard_header(skb, dev, ntohs(proto), addr,
NULL, len);
                if (unlikely(offset < 0))
                        goto out_free;
        } else if (reserve) {
                skb_reserve(skb, -reserve);
                if (len < reserve + sizeof(struct ipv6hdr) &&
                    dev->min_header_len != dev->hard_header_len)
                        skb_reset_network_header(skb);
        }

If all that is needed is to move the network header beyond an optional
VLAN tag in the case of SOCK_RAW, then this can be done in the else
for Ethernet packets.

It is not safe to increase reserve, as that would eat into the
reserved hlen LL_RESERVED_SPACE(dev), which does not account for
optional VLAN headers.

Instead of setting here first, then patching up again later in
packet_parse_headers.

This change affects all packets with VLAN headers, not just those with
GSO. I imagine that moving the network header is safe for all, but
don't know that code well enough to verify that it does not have
unintended side effects. Does dev_queue_xmit expect the network header
to point to the start of the VLAN headers or after, for instance?

> No need to update tpacket_snd() as it calls packet_parse_headers() in
> tpacket_fill_skb(), which is already before calling virtio_net_hdr_*
> functions.
>
> skb->no_fcs setting is also moved upper to make all skb settings together
> and keep consistence with function packet_sendmsg_spkt().
>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  net/packet/af_packet.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 002d2b9c69dd..cfdbda28ef82 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -1924,12 +1924,20 @@ static int packet_rcv_spkt(struct sk_buff *skb, struct net_device *dev,
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
> +       /* Move network header to the right position for VLAN tagged packets */
> +       if (likely(skb->dev->type == ARPHRD_ETHER) &&
> +           eth_type_vlan(skb->protocol) &&
> +           __vlan_get_protocol(skb, skb->protocol, &depth) != 0)
> +               skb_set_network_header(skb, depth);
> +
>         skb_probe_transport_header(skb);
>  }
>
> @@ -3047,6 +3055,11 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
>         skb->mark = sockc.mark;
>         skb->tstamp = sockc.transmit_time;
>
> +       if (unlikely(extra_len == 4))
> +               skb->no_fcs = 1;
> +
> +       packet_parse_headers(skb, sock);
> +
>         if (has_vnet_hdr) {
>                 err = virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le());
>                 if (err)
> @@ -3055,11 +3068,6 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
>                 virtio_net_hdr_set_proto(skb, &vnet_hdr);
>         }
>
> -       packet_parse_headers(skb, sock);
> -
> -       if (unlikely(extra_len == 4))
> -               skb->no_fcs = 1;
> -
>         err = po->xmit(skb);
>         if (unlikely(err != 0)) {
>                 if (err > 0)
> --
> 2.35.1
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
