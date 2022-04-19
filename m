Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDE1C433EF
	for <virtualization@archiver.kernel.org>; Tue, 19 Apr 2022 13:56:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9693D41894;
	Tue, 19 Apr 2022 13:56:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9d1N3-ILY314; Tue, 19 Apr 2022 13:56:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E529841873;
	Tue, 19 Apr 2022 13:56:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF308C0033;
	Tue, 19 Apr 2022 13:56:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1484DC002C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Apr 2022 13:56:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F004983EA8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Apr 2022 13:56:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Acrl5uSgCDRX
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Apr 2022 13:56:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 267C283E88
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Apr 2022 13:56:42 +0000 (UTC)
Received: by mail-qt1-x835.google.com with SMTP id x24so3785574qtq.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Apr 2022 06:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZkyYghRCM6NN1bxcGAJI+XSXJeWJUcrbGzjK/o46+BA=;
 b=fLGJJK8l17FO2RP0wAoLOOlbMW1xVpJXB1wxoVgetBwcJQ3z/osj1Dm+VMB7Gn5Kbf
 r9L4lKS87Qnt/DwbgUONGZDh5LztZrY4voP1HALGhJZgMnaCqlxXde4pu9NuxA0QCUhk
 DVsK0v26hgIRDmCZvPWUzUMUxHA8R5YeUPRu4OD1vsldQzAiSZj9UkSRCY5s7q1BVaWm
 e1iXnkVaXeMaK10Om44rsFJ0GCmbTx1WBcz7nu65dn9xnTwmZuhhEyFpHm2LqI/iYhLP
 M3X5xSgpyDMtt0A1J4Um3jXpj3B1b8F4XUFOKdQlDmHyKWmz5oLUZrPyUdK8nvnsERkd
 E1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZkyYghRCM6NN1bxcGAJI+XSXJeWJUcrbGzjK/o46+BA=;
 b=r/m8Y+rlpITo9sOv8+f9/OVDdvtz6dpUutSjaIpcxBTPhiO1ObtaTIhhob2I7SKoKW
 5O9e6EukC0WM8ypxj/kBQSH6EAptWgSJxDdwid6/xF5D9snTmOgC8YmTMjVUOUXML2HR
 hUo5++6jLLMEK+2RtBdGyH7oUGoJY+J10cBYuu3GSVYXB1Uw1InHXc69/6kAZayfC2e2
 UoX+95nQzr5DukgO0VZ6U7xDNwpcssOSd6TYWYvKl9JJ70R337TNazF/b0ICgxq+lRXK
 ZXfyxHBqvo89LGxxbmTc0AOBNuO3ddhIY5v23wxD6Xn7KjYv3r/tCi8M7Ht94ZjPCnmc
 ykvg==
X-Gm-Message-State: AOAM531CIeQUngKV+X7YsbtWLfa8Kg6/oty1IB+pur8FLC/pSYd2M7iz
 ny9NNZke1UMyLQcL02Vv22jRoYL3Ogg=
X-Google-Smtp-Source: ABdhPJwN8BcYTrC89BwP5zSehcZ6lmwd5KJw2w3xHuvcxB2BfbvvVBRUeqZtBu+uTYeZnx7DMW9xug==
X-Received: by 2002:ac8:5d8a:0:b0:2e2:f0f:4308 with SMTP id
 d10-20020ac85d8a000000b002e20f0f4308mr10554598qtx.618.1650376600993; 
 Tue, 19 Apr 2022 06:56:40 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com.
 [209.85.219.173]) by smtp.gmail.com with ESMTPSA id
 e15-20020a05622a110f00b002f33d65b065sm40914qty.73.2022.04.19.06.56.38
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Apr 2022 06:56:39 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id x200so31074974ybe.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Apr 2022 06:56:38 -0700 (PDT)
X-Received: by 2002:a5b:247:0:b0:624:4d24:94ee with SMTP id
 g7-20020a5b0247000000b006244d2494eemr14673744ybp.197.1650376598119; Tue, 19
 Apr 2022 06:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220418044339.127545-1-liuhangbin@gmail.com>
 <20220418044339.127545-2-liuhangbin@gmail.com>
 <CA+FuTScQ=tP=cr5f2S97Z7ex1HMX5R-C0W6JE2Bx5UWgiGknZA@mail.gmail.com>
 <Yl4mU0XLmPukG0WO@Laptop-X1>
In-Reply-To: <Yl4mU0XLmPukG0WO@Laptop-X1>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 19 Apr 2022 09:56:02 -0400
X-Gmail-Original-Message-ID: <CA+FuTSfBU7ck91ayf_t9=7eRGJZHuWSeXzX2SxFAQMPSitY9SA@mail.gmail.com>
Message-ID: <CA+FuTSfBU7ck91ayf_t9=7eRGJZHuWSeXzX2SxFAQMPSitY9SA@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net/af_packet: adjust network header position for
 VLAN tagged packets
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Maxim Mikityanskiy <maximmi@mellanox.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, Balazs Nemeth <bnemeth@redhat.com>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Flavio Leitner <fbl@redhat.com>,
 Mike Pattrick <mpattric@redhat.com>, "David S . Miller" <davem@davemloft.net>
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

On Mon, Apr 18, 2022 at 11:02 PM Hangbin Liu <liuhangbin@gmail.com> wrote:
>
> On Mon, Apr 18, 2022 at 11:38:14AM -0400, Willem de Bruijn wrote:
> > Strictly speaking VLAN tagged GSO packets have never been supported.
>
> OK, I thought we just forgot to handle the VLAN header for RAW af socket.
> As in the later path skb_mac_gso_segment() deal with VLAN correctly.
>
> If you think this should be a new feature instead of fixes. I can remove the
> fixes tag and re-post it to net-next, as you said.
>
> > The only defined types are TCP and UDP over IPv4 and IPv6:
> >
> >   define VIRTIO_NET_HDR_GSO_TCPV4        1       /* GSO frame, IPv4 TCP (TSO) */
> >   define VIRTIO_NET_HDR_GSO_UDP          3       /* GSO frame, IPv4 UDP (UFO) */
> >   define VIRTIO_NET_HDR_GSO_TCPV6        4       /* GSO frame, IPv6 TCP */
> >
> > I don't think this is a bug, more a stretching of the definition of those flags.
>
> I think VLAN is a L2 header, so I just reset the network header position.
>
> I'm not familiar with virtio coded. Do you mean to add a new flag like VIRTIO_NET_HDR_GSO_VLAN?
> > > @@ -3055,11 +3068,6 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
> > >                 virtio_net_hdr_set_proto(skb, &vnet_hdr);
> > >         }
> > >
> > > -       packet_parse_headers(skb, sock);
> > > -
> > > -       if (unlikely(extra_len == 4))
> > > -               skb->no_fcs = 1;
> > > -
> >
> > Moving packet_parse_headers before or after virtio_net_hdr_to_skb may
> > have additional subtle effects on protocol detection.
> >
> > I think it's probably okay, as tpacket_snd also calls in the inverse
> > order. But there have been many issues in this codepath.
>
> Yes
>
> >
> > We should also maintain feature consistency between packet_snd,
> > tpacket_snd and to the limitations of its feature set to
> > packet_sendmsg_spkt. The no_fcs is already lacking in tpacket_snd as
> > far as I can tell. But packet_sendmsg_spkt also sets it and calls
> > packet_parse_headers.
>
> Yes, I think we could fix the tpacket_snd() in another patch.
>
> There are also some duplicated codes in these *_snd functions.
> I think we can move them out to one single function.

Please don't refactor this code. It will complicate future backports
of stable fixes.

> > Because this patch touches many other packets besides the ones
> > intended, I am a bit concerned about unintended consequences. Perhaps
>
> Yes, makes sense.
>
> > stretching the definition of the flags to include VLAN is acceptable
> > (unlike outright tunnels), but even then I would suggest for net-next.
>
> As I asked, I'm not familiar with virtio code. Do you think if I should
> add a new VIRTIO_NET_HDR_GSO_VLAN flag? It's only a L2 flag without any L3
> info. If I add something like VIRTIO_NET_HDR_GSO_VLAN_TCPV4/TCPV6/UDP. That
> would add more combinations. Which doesn't like a good idea.

I would prefer a new flag to denote this type, so that we can be
strict and only change the datapath for packets that have this flag
set (and thus express the intent).

But the VIRTIO_NET_HDR types are defined in the virtio spec. The
maintainers should probably chime in.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
