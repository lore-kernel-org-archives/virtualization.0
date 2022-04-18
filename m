Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243BBC433EF
	for <virtualization@archiver.kernel.org>; Mon, 18 Apr 2022 15:41:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8AAC783ECE;
	Mon, 18 Apr 2022 15:41:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XcagggxI9RzW; Mon, 18 Apr 2022 15:41:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 349658401E;
	Mon, 18 Apr 2022 15:41:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 000C2C002F;
	Mon, 18 Apr 2022 15:41:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B256FC002C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 15:41:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 91E908401E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 15:41:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1EYt9Emz9qxc
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 15:41:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C37B983ECE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 15:41:23 +0000 (UTC)
Received: by mail-qv1-xf2f.google.com with SMTP id h13so654884qvr.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 08:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NIlNiSkkSkgTapGfecwZRIqvyhekuiNyDyxM96ZsPI4=;
 b=POT7koJZVyf0j8gHL1RT150kUn1gZh12BE6+ykwhi2ekMHb9lLcuhssdNkfU9EKQbP
 KTVQyXsUAxGT3DnmFoWpXcZNl9zALhEWEu7dIuhij8G9o/x8U0dUhSFq1GkW8M+/s+9y
 gAWfNf4fYr8wqMpwKIho3ACE3aWTuTZeeLcyDfvTQYAbcRom7YBgM+5Wo5o+N3RE/31y
 Zjn1jyQibJg/33NOqMSuBOzXusme3ILdVzopHP2QB6giyeEAk1uQx08Tg5ViIv5bOta6
 M/CJwER9qKu6iV2k4lQzf6mBn/o5/EJSuvtzGoNwln8UBranoqu0EnOnWLN30jDsjfW5
 1F1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NIlNiSkkSkgTapGfecwZRIqvyhekuiNyDyxM96ZsPI4=;
 b=646UI7z+KJmIHH50iPIvNKle5xqtJnkoDyRBkZYhdGafPUYr7ugyHbBv1mI84/IQmu
 aZ1plPSzyJ7qwCgesyU0kpRbsku7xSqXxEQtGkGVPOmX/3Ti/UJatzXZiwNVpO5SiBaF
 hqaf+PDijG2/3XvGf2q66Vq0B11I3YAUs6Ah+SsJsd84p49PpszfZtqBQf6OkM7dg0RW
 FQ0vJ2J62lFQbrI7Ny9zM6wGDvGqixlgZZGI7u0FVrt6vaXN6atu2Pkbzj0BmS20p5k+
 kfDetc74zMBylsTeWN+orJn0k64HfIcL9AKKnUxz5ti6hfD8qhL3cWy72iFr4Rf+c5NH
 h28A==
X-Gm-Message-State: AOAM532zYzN7DlJHKctTQUv/CitMs9IWQfnDKjQ71eCtBVIRi4zAYUjB
 lXAmJssN4sgjp75Yva9nwsjNhWHbSpI=
X-Google-Smtp-Source: ABdhPJwhBHnpw227/uEZkBh4y2hoR1EA7WEN70R9AgZ9uWSAfcQdpMSitFckGq7S2emLrtqz6jWLhw==
X-Received: by 2002:a05:6214:1643:b0:429:d6fb:f309 with SMTP id
 f3-20020a056214164300b00429d6fbf309mr8221433qvw.58.1650296482456; 
 Mon, 18 Apr 2022 08:41:22 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com.
 [209.85.219.174]) by smtp.gmail.com with ESMTPSA id
 g21-20020ac85815000000b002e06e2623a7sm7920995qtg.0.2022.04.18.08.41.21
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Apr 2022 08:41:21 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id p65so26158213ybp.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 08:41:21 -0700 (PDT)
X-Received: by 2002:a25:b94a:0:b0:644:db14:ff10 with SMTP id
 s10-20020a25b94a000000b00644db14ff10mr7288155ybm.648.1650296480886; Mon, 18
 Apr 2022 08:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220418044339.127545-1-liuhangbin@gmail.com>
 <20220418044339.127545-3-liuhangbin@gmail.com>
In-Reply-To: <20220418044339.127545-3-liuhangbin@gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 18 Apr 2022 11:40:44 -0400
X-Gmail-Original-Message-ID: <CA+FuTSdTbpYGJo6ec2Ti+djXCj=gBAQpv9ZVaTtaJA-QUNNgYQ@mail.gmail.com>
Message-ID: <CA+FuTSdTbpYGJo6ec2Ti+djXCj=gBAQpv9ZVaTtaJA-QUNNgYQ@mail.gmail.com>
Subject: Re: [PATCH net 2/2] virtio_net: check L3 protocol for VLAN packets
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Maxim Mikityanskiy <maximmi@mellanox.com>,
 Mike Pattrick <mailmpattric@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, virtualization@lists.linux-foundation.org,
 Balazs Nemeth <bnemeth@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>
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
> For gso packets, virtio_net_hdr_to_skb() will check the protocol via
> virtio_net_hdr_match_proto(). But a packet may come from a raw socket
> with a VLAN tag. Checking the VLAN protocol for virtio net_hdr makes no
> sense. Let's check the L3 protocol if it's a VLAN packet.
>
> Make the virtio_net_hdr_match_proto() checking for all skbs instead of
> only skb without protocol setting.
>
> Also update the data, protocol parameter for
> skb_flow_dissect_flow_keys_basic() as the skb->protocol may not IP or IPv6.
>
> Fixes: 7e5cced9ca84 ("net: accept UFOv6 packages in virtio_net_hdr_to_skb")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  include/linux/virtio_net.h | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index a960de68ac69..97b4f9680786 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -3,6 +3,7 @@
>  #define _LINUX_VIRTIO_NET_H
>
>  #include <linux/if_vlan.h>
> +#include <uapi/linux/if_arp.h>
>  #include <uapi/linux/tcp.h>
>  #include <uapi/linux/udp.h>
>  #include <uapi/linux/virtio_net.h>
> @@ -102,25 +103,36 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
>                  */
>                 if (gso_type && skb->network_header) {

This whole branch should not be taken by well formed packets. It is
inside the else clause of

       if (hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
          ..
       } else {

GSO packets should always request checksum offload. The fact that we
try to patch up some incomplete packets should not have to be expanded
if we expand support to include VLAN.

>                         struct flow_keys_basic keys;
> +                       __be16 protocol;
>
>                         if (!skb->protocol) {
> -                               __be16 protocol = dev_parse_header_protocol(skb);
> +                               protocol = dev_parse_header_protocol(skb);
>
>                                 if (!protocol)
>                                         virtio_net_hdr_set_proto(skb, hdr);
> -                               else if (!virtio_net_hdr_match_proto(protocol, hdr->gso_type))
> -                                       return -EINVAL;
>                                 else
>                                         skb->protocol = protocol;
> +                       } else {
> +                               protocol = skb->protocol;
>                         }
> +
> +                       /* Get L3 protocol if current protocol is VLAN */
> +                       if (likely(skb->dev->type == ARPHRD_ETHER) &&
> +                           eth_type_vlan(protocol))
> +                               protocol = vlan_get_protocol(skb);
> +
> +                       if (!virtio_net_hdr_match_proto(protocol, hdr->gso_type))
> +                               return -EINVAL;
> +
>  retry:
>                         if (!skb_flow_dissect_flow_keys_basic(NULL, skb, &keys,
> -                                                             NULL, 0, 0, 0,
> -                                                             0)) {
> +                                                             skb->data, protocol,
> +                                                             skb_network_offset(skb),
> +                                                             skb_headlen(skb), 0)) {
>                                 /* UFO does not specify ipv4 or 6: try both */
>                                 if (gso_type & SKB_GSO_UDP &&
> -                                   skb->protocol == htons(ETH_P_IP)) {
> -                                       skb->protocol = htons(ETH_P_IPV6);
> +                                   protocol == htons(ETH_P_IP)) {
> +                                       protocol = htons(ETH_P_IPV6);
>                                         goto retry;
>                                 }
>                                 return -EINVAL;
> --
> 2.35.1
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
