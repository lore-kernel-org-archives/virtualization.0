Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B471C433F5
	for <virtualization@archiver.kernel.org>; Tue, 19 Apr 2022 13:53:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BF83E60E1E;
	Tue, 19 Apr 2022 13:53:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OuEA34OSIQFs; Tue, 19 Apr 2022 13:53:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4FCBA612FF;
	Tue, 19 Apr 2022 13:53:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22EF7C0033;
	Tue, 19 Apr 2022 13:53:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8FD91C002C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Apr 2022 13:53:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 76D5361301
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Apr 2022 13:53:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rJ43MnOAWVR0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Apr 2022 13:53:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B655760BCE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Apr 2022 13:53:25 +0000 (UTC)
Received: by mail-qv1-xf35.google.com with SMTP id c1so13154879qvl.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Apr 2022 06:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fgHgtJi2JyvqtaEhK4OrYC/rmPwWeLIz8PCQ10U4/yc=;
 b=C9M0V4Cy04uoUbtB//0phZ2HzQiEgo8DzIpSewKxIqZI5sxC1VDV6dQBcdbQTGIx7u
 6KLV7oteDB3Kp1K2on9MJ7tlZo1WpTIGuz0X0bNM6Ie/VCDrSU5/KVRGH1tgcBiQjT33
 XZ6NSpUBLhuKyCVNMnFf/Uwunm4IJJg/sWRdX6+7FJTWQdUAFyK45O9m2lemhP3j5lqE
 a4yB3ai+H7omOObdr3eAXOfEPGfF50jCtNY52nV2hTyv4gDcib+CPM7Xv9bHGKbmILPA
 R7+4n12a080WQ8LFg2x8GVp77dcIfmsw8YR+Vfydb/pZCbHg3oFxGy/k6UzniY1AIOaj
 FBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fgHgtJi2JyvqtaEhK4OrYC/rmPwWeLIz8PCQ10U4/yc=;
 b=ehc3gNFFJ8oYWFLfSgvLE5ZzWP1pE2d9GsuHVNMUP9Rq4yRbNmpzZ/hGrcWbbiamvP
 tK7d7UpyU4RHicBJwUJ1oyZEh0Kl58hhwU22NMq7+ZifTJRL4L4Zl/Z63sw3Nou6BLbn
 bFo2kXN+bLWyA9RjIPxWlyI/81ZBY0oxukuRKodONBWM86nE6dzqRm9BiJTf0exkqDYP
 kprz25+FQQlAma2WnzELVxcA620Wj7iWK4lv1mA91cCfMt2vGG8qzS+6Ba9dseZmL7J4
 R2QTlYqPPXidiohSDdWB40D4Y/TvQi39ODlqM1QCnD9fq+4XxebLWQb9VHGqRgtXpJv7
 VhCw==
X-Gm-Message-State: AOAM533fBxtYCO6Wiqi3bXZ34L7zdQaGQmyl5AU9Q4TUN8GCMiTDseBS
 CIRAF9w9lQ8t6ZwWCxl4opZnmxnFJJ8=
X-Google-Smtp-Source: ABdhPJyoG17N/Kim/AJoh7VkaIAWCZGayOlTiUm/wcRphyMibNqBcuPveoTuAvqqlVSJ4uxFLd0yrQ==
X-Received: by 2002:a05:6214:400b:b0:446:4371:8259 with SMTP id
 kd11-20020a056214400b00b0044643718259mr11409964qvb.76.1650376404563; 
 Tue, 19 Apr 2022 06:53:24 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com.
 [209.85.128.174]) by smtp.gmail.com with ESMTPSA id
 y3-20020a376403000000b0069e899ec3c7sm31546qkb.75.2022.04.19.06.53.23
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Apr 2022 06:53:23 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id
 00721157ae682-2eafabbc80aso172581027b3.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Apr 2022 06:53:23 -0700 (PDT)
X-Received: by 2002:a81:8304:0:b0:2ef:1922:c82 with SMTP id
 t4-20020a818304000000b002ef19220c82mr15468842ywf.348.1650376402709; Tue, 19
 Apr 2022 06:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220418044339.127545-1-liuhangbin@gmail.com>
 <20220418044339.127545-3-liuhangbin@gmail.com>
 <CA+FuTSdTbpYGJo6ec2Ti+djXCj=gBAQpv9ZVaTtaJA-QUNNgYQ@mail.gmail.com>
 <Yl4pG8MN7jxVybPB@Laptop-X1>
In-Reply-To: <Yl4pG8MN7jxVybPB@Laptop-X1>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 19 Apr 2022 09:52:46 -0400
X-Gmail-Original-Message-ID: <CA+FuTSdLGUgbkP3U+zmqoFzrewnUUN3pci8q8oNfHzo11ZhRZg@mail.gmail.com>
Message-ID: <CA+FuTSdLGUgbkP3U+zmqoFzrewnUUN3pci8q8oNfHzo11ZhRZg@mail.gmail.com>
Subject: Re: [PATCH net 2/2] virtio_net: check L3 protocol for VLAN packets
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Maxim Mikityanskiy <maximmi@mellanox.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 Balazs Nemeth <bnemeth@redhat.com>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
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

On Mon, Apr 18, 2022 at 11:14 PM Hangbin Liu <liuhangbin@gmail.com> wrote:
>
> On Mon, Apr 18, 2022 at 11:40:44AM -0400, Willem de Bruijn wrote:
> > On Mon, Apr 18, 2022 at 12:44 AM Hangbin Liu <liuhangbin@gmail.com> wrote:
> > >
> > > For gso packets, virtio_net_hdr_to_skb() will check the protocol via
> > > virtio_net_hdr_match_proto(). But a packet may come from a raw socket
> > > with a VLAN tag. Checking the VLAN protocol for virtio net_hdr makes no
> > > sense. Let's check the L3 protocol if it's a VLAN packet.
> > >
> > > Make the virtio_net_hdr_match_proto() checking for all skbs instead of
> > > only skb without protocol setting.
> > >
> > > Also update the data, protocol parameter for
> > > skb_flow_dissect_flow_keys_basic() as the skb->protocol may not IP or IPv6.
> > >
> > > Fixes: 7e5cced9ca84 ("net: accept UFOv6 packages in virtio_net_hdr_to_skb")
> > > Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> > > ---
> > >  include/linux/virtio_net.h | 26 +++++++++++++++++++-------
> > >  1 file changed, 19 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > > index a960de68ac69..97b4f9680786 100644
> > > --- a/include/linux/virtio_net.h
> > > +++ b/include/linux/virtio_net.h
> > > @@ -3,6 +3,7 @@
> > >  #define _LINUX_VIRTIO_NET_H
> > >
> > >  #include <linux/if_vlan.h>
> > > +#include <uapi/linux/if_arp.h>
> > >  #include <uapi/linux/tcp.h>
> > >  #include <uapi/linux/udp.h>
> > >  #include <uapi/linux/virtio_net.h>
> > > @@ -102,25 +103,36 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
> > >                  */
> > >                 if (gso_type && skb->network_header) {
> >
> > This whole branch should not be taken by well formed packets. It is
> > inside the else clause of
> >
> >        if (hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
> >           ..
> >        } else {
> >
> > GSO packets should always request checksum offload. The fact that we
> > try to patch up some incomplete packets should not have to be expanded
> > if we expand support to include VLAN.
>
> Hi Willem,
>
> I'm not sure if I understand correctly. Do you mean we don't need to check
> L3 protocols for VLAN packet without NEEDS_CSUM flag? Which like
>
> if (hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
>         ...
> } else if (!eth_type_vlan(skb->protocol)) {
>         ...
> }

Segmentation offload requires checksum offload. Packets that request
GSO but not NEEDS_CSUM are an aberration. We had to go out of our way
to handle them because the original implementation did not explicitly
flag and drop these. But we should not extend that to new types.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
