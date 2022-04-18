Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D2C2C433EF
	for <virtualization@archiver.kernel.org>; Mon, 18 Apr 2022 15:38:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2232C403C2;
	Mon, 18 Apr 2022 15:38:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xOoQwgCZApwC; Mon, 18 Apr 2022 15:38:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8ADE240B95;
	Mon, 18 Apr 2022 15:38:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5DB78C002F;
	Mon, 18 Apr 2022 15:38:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B05DCC002C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 15:38:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 86D4340B95
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 15:38:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yY3W3neDHY3M
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 15:38:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C2FE0403C2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 15:38:52 +0000 (UTC)
Received: by mail-qt1-x82f.google.com with SMTP id f22so1073095qtp.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 08:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pggPuZdJ0sh0DRZQ6dxN1mTrIZCiKodH9ePXo1UN6eE=;
 b=D85011SQWwV83FLxK51Peevvwd4ygZVvdHSSDq2iGCAnmuVu4r/QmheA0MxMwgmMKy
 jKtH66gyQ40X5rSCIC0pIsxnnVTO9w6eOD/QQljIwubCF43VGrGUdOTddMfHOYM0aY76
 p4k71idrzpokpYOY/K/iA6KNsQcz/75pbFcGvKxDurgjL26JSEcFxvSXU0Zmc9iXKDWG
 r10Rl1GDm6832/dHtfVS8JHg92I9Rf5zWOJf4abgfl3kLEihzSWSKBK4GW1oeHVZps5e
 OK7x5IYnLR0jKmTBgYQk1C6uYGB2RCx+6dkjS/G2JOJhpDmYjy0w/4eS7vw/9SgJib46
 4rYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pggPuZdJ0sh0DRZQ6dxN1mTrIZCiKodH9ePXo1UN6eE=;
 b=IE8vHtPhoSXZnIKC0nfdjuTgJUtrhU5g20IhP6WdiHTR4hei+KJ7hoLztxXImMxeeZ
 L14p/ToDWk58ZChWgjRi6y8/8ZPBcjmJcJ5+RECRe0ENY7ZBqE9daI8O0ZcXOI7vWjxB
 k6SkhhsTkJQpWt8UmOvLmt9NqfeJIeDpCU40Oq8VYS/XRPpW0QuyXeGQWS4iq6HJwKNj
 mFfFjoAZueqaaDo+KpI8n6aFUfPIu40mcT9Xa7Tt2iMoVqyBS1Waec5FHV1vziX5BsfE
 1LooUUN1wpQD3/zbD92LQDUL1KKau/vXL0W0TZzi/cDMDkcvf9Y6BXQy1mvc7FGct81U
 jiWw==
X-Gm-Message-State: AOAM531p9B5TIsSXKxAf4BufG6buyvOaRI/kPOJgzHdphC75c9DsQshB
 rTMHatABAduwCzBanTq+u7Zr1kYIJGs=
X-Google-Smtp-Source: ABdhPJwT+rJvmoUvrrN7BRW3AWQjdMM81qqHm26244VL1gFC1dZE6Rk37pT131xyTjMFhtzgZkX4UA==
X-Received: by 2002:a05:622a:1716:b0:2f2:56d:c8a8 with SMTP id
 h22-20020a05622a171600b002f2056dc8a8mr1480777qtk.26.1650296331413; 
 Mon, 18 Apr 2022 08:38:51 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com.
 [209.85.128.170]) by smtp.gmail.com with ESMTPSA id
 v3-20020a05622a014300b002e1dcd4cfa9sm8624957qtw.64.2022.04.18.08.38.50
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Apr 2022 08:38:50 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id
 00721157ae682-2eafabbc80aso142687497b3.11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 08:38:50 -0700 (PDT)
X-Received: by 2002:a81:1345:0:b0:2ec:31ea:dfdb with SMTP id
 66-20020a811345000000b002ec31eadfdbmr10771840ywt.351.1650296330562; Mon, 18
 Apr 2022 08:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220418044339.127545-1-liuhangbin@gmail.com>
 <20220418044339.127545-2-liuhangbin@gmail.com>
In-Reply-To: <20220418044339.127545-2-liuhangbin@gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 18 Apr 2022 11:38:14 -0400
X-Gmail-Original-Message-ID: <CA+FuTScQ=tP=cr5f2S97Z7ex1HMX5R-C0W6JE2Bx5UWgiGknZA@mail.gmail.com>
Message-ID: <CA+FuTScQ=tP=cr5f2S97Z7ex1HMX5R-C0W6JE2Bx5UWgiGknZA@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net/af_packet: adjust network header position for
 VLAN tagged packets
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Maxim Mikityanskiy <maximmi@mellanox.com>,
 Mike Pattrick <mailmpattric@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, virtualization@lists.linux-foundation.org,
 Balazs Nemeth <bnemeth@redhat.com>, Flavio Leitner <fbl@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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

On Mon, Apr 18, 2022 at 12:44 AM Hangbin Liu <liuhangbin@gmail.com> wrote:
>
> Flavio reported that the kernel drops GSO VLAN tagged packet if it's
> created with socket(AF_PACKET, SOCK_RAW, 0) plus virtio_net_hdr.
>
> The reason is AF_PACKET doesn't adjust the skb network header if there is
> a VLAN tag. Then after virtio_net_hdr_set_proto() called, the skb->protocol
> will be set to ETH_P_IP/IPv6. And in later inet/ipv6_gso_segment() the skb
> is dropped as network header position is invalid.
>
> Fix it by adjusting network header position in packet_parse_headers()
> and move the function before calling virtio_net_hdr_* functions.
>
> I also moved skb->no_fcs setting upper to make all skb setting together
> and keep consistence of function packet_sendmsg_spkt().
>
> No need to update tpacket_snd() as it calls packet_parse_headers() in
> tpacket_fill_skb() before calling virtio_net_hdr_* functions.
>
> Fixes: 75c65772c3d1 ("net/packet: Ask driver for protocol if not provided by user")
> Reported-by: Flavio Leitner <fbl@redhat.com>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Strictly speaking VLAN tagged GSO packets have never been supported.
The only defined types are TCP and UDP over IPv4 and IPv6:

  define VIRTIO_NET_HDR_GSO_TCPV4        1       /* GSO frame, IPv4 TCP (TSO) */
  define VIRTIO_NET_HDR_GSO_UDP          3       /* GSO frame, IPv4 UDP (UFO) */
  define VIRTIO_NET_HDR_GSO_TCPV6        4       /* GSO frame, IPv6 TCP */

I don't think this is a bug, more a stretching of the definition of those flags.

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

Moving packet_parse_headers before or after virtio_net_hdr_to_skb may
have additional subtle effects on protocol detection.

I think it's probably okay, as tpacket_snd also calls in the inverse
order. But there have been many issues in this codepath.

We should also maintain feature consistency between packet_snd,
tpacket_snd and to the limitations of its feature set to
packet_sendmsg_spkt. The no_fcs is already lacking in tpacket_snd as
far as I can tell. But packet_sendmsg_spkt also sets it and calls
packet_parse_headers.

Because this patch touches many other packets besides the ones
intended, I am a bit concerned about unintended consequences. Perhaps
stretching the definition of the flags to include VLAN is acceptable
(unlike outright tunnels), but even then I would suggest for net-next.

>         err = po->xmit(skb);
>         if (unlikely(err != 0)) {
>                 if (err > 0)
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
