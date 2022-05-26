Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA558C433F5
	for <virtualization@archiver.kernel.org>; Thu, 26 May 2022 12:19:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4D431411AF;
	Thu, 26 May 2022 12:19:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gid1be7Emkmw; Thu, 26 May 2022 12:19:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CAED14056F;
	Thu, 26 May 2022 12:19:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99E1DC0039;
	Thu, 26 May 2022 12:19:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5BF23C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 12:18:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3A21C42575
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 12:18:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KpfjjMGg2oXO
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 12:18:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 08C5542573
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 12:18:57 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id y66so1920361oia.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 05:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CLSM/8kDcZbA7YFN+80uNCo9mIc7oVDwUzACPp0MJzI=;
 b=Jba9/oQ7EhCHTPj4e0T8+acAsjK8wPnCpG4E6PD7PWPG2bxQif45eY0QFnYuUayP+S
 U/h1UhF6NgQOcPS1uxcFKj1iZuY3VGP3NI+VS/ev6tYJn4rhbkbTw/IN8JLZnsymcx1Q
 uf6gVIJirlDFBCaW2j/E0dbSlEVG6lpzYvSQrJvLPW0YAUV8tUUD4o88ILfCK7Awa3Jb
 nOULVPFGhjNVsVGhEKhEqXmXcFj4J7zhTsgJAWRuPEwv1Y96HYDu7XH/lA/piToAGQ+T
 XT7NYVwZB5+e82qAevvHL78OCwHp7JbysHEF/UdHldojNWVjw0zzUbsGTXNhhPCQgVyh
 /SAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CLSM/8kDcZbA7YFN+80uNCo9mIc7oVDwUzACPp0MJzI=;
 b=a+QvEqIq/TniSxddhs+w4SrQoFBVIPJI91b52nAc0m3DrKGIOHC84Hpdv65buOIEPU
 s+GLL5I0Cx70nzAvQMWLwHXZO0CRDQipElr04cailaYGbpGwA+pDPQdpN96XM2JKSC/Q
 tedEhg0/Eh2JDESqvnbBt23RGA2oeE5CuQh+8vigO09tG43L2dh1uVG2XV508XLYMdgv
 QZhOwafotbVz91km2Ahx7z8hA+pRvpE2STYIEQByhFV7i1jsInLLjWyeFS3+7ocb1uJi
 0AnyxwjmR9TCJ7mSJbo5wCTZKkXzjghE9Bd5eAP99tIjUK+/dDVmoub94sA0BINo+JSd
 q27g==
X-Gm-Message-State: AOAM531QziAc2U0JZuQN3Cu8ZfunZk8IrNHmUSmwsH3cXAszU5QwwnOx
 mdVUxrh9Co34WhDAI/T26bLdE09EBcHkBBOBs0An1g==
X-Google-Smtp-Source: ABdhPJzrXVXApvXvTSd22hQ/EiuENto3oqBsg0ZuGXiH/dOnFKMyE6jnsagaDy+iwlBZZEnqZNGSFSznwbUC3IlCDw4=
X-Received: by 2002:aca:c182:0:b0:2ef:8fd4:7523 with SMTP id
 r124-20020acac182000000b002ef8fd47523mr987974oif.148.1653567537021; Thu, 26
 May 2022 05:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220512112347.18717-1-andrew@daynix.com>
 <CACGkMEvH1yE0CZYdstAK32DkEucejNO+V7PEAZD_641+rp2aKA@mail.gmail.com>
 <CABcq3pFJcsoj+dDf6tirT_hfTB6rj9+f6KNFafwg+usqYwTdDA@mail.gmail.com>
 <CACGkMEtaigzuwy25rE-7N40TQGvXVmJVQivavmuwrCuw0Z=LUQ@mail.gmail.com>
In-Reply-To: <CACGkMEtaigzuwy25rE-7N40TQGvXVmJVQivavmuwrCuw0Z=LUQ@mail.gmail.com>
From: Andrew Melnichenko <andrew@daynix.com>
Date: Thu, 26 May 2022 15:18:46 +0300
Message-ID: <CABcq3pFzzSHA3pqbKFEsLaFg7FkFZkdxs+N_ET_n_XLBaWVnHA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/5] TUN/VirtioNet USO features support.
To: Jason Wang <jasowang@redhat.com>
Cc: mst <mst@redhat.com>, netdev <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Eric Dumazet <edumazet@google.com>, Yan Vugenfirer <yan@daynix.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 davem <davem@davemloft.net>
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

I'll check it, thank you!

On Thu, May 26, 2022 at 9:56 AM Jason Wang <jasowang@redhat.com> wrote:
>
> On Tue, May 24, 2022 at 7:07 PM Andrew Melnichenko <andrew@daynix.com> wrote:
> >
> > Hi all,
> >
> > The issue is that host segments packets between guests on the same host.
> > Tests show that it happens because SKB_GSO_DODGY skb offload in
> > virtio_net_hdr_from_skb().
> > To do segmentation you need to remove SKB_GSO_DODGY or add SKB_GSO_PARTIAL
> > The solution with DODGY/PARTIAL offload looks like a dirty hack, so
> > for now, I've lived it as it is for further investigation.
>
> Ok, I managed to find the previous discussion. It looks to me the
> reason is that __udp_gso_segment will segment dodgy packets
> unconditionally.
>
> I wonder if the attached patch works? (compile test only).
>
> Thanks
>
> >
> >
> > On Tue, May 17, 2022 at 9:32 AM Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > On Thu, May 12, 2022 at 7:33 PM Andrew Melnychenko <andrew@daynix.com> wrote:
> > > >
> > > > Added new offloads for TUN devices TUN_F_USO4 and TUN_F_USO6.
> > > > Technically they enable NETIF_F_GSO_UDP_L4
> > > > (and only if USO4 & USO6 are set simultaneously).
> > > > It allows to transmission of large UDP packets.
> > > >
> > > > Different features USO4 and USO6 are required for qemu where Windows guests can
> > > > enable disable USO receives for IPv4 and IPv6 separately.
> > > > On the other side, Linux can't really differentiate USO4 and USO6, for now.
> > > > For now, to enable USO for TUN it requires enabling USO4 and USO6 together.
> > > > In the future, there would be a mechanism to control UDP_L4 GSO separately.
> > > >
> > > > Test it WIP Qemu https://github.com/daynix/qemu/tree/Dev_USOv2
> > > >
> > > > New types for VirtioNet already on mailing:
> > > > https://lists.oasis-open.org/archives/virtio-comment/202110/msg00010.html
> > > >
> > > > Also, there is a known issue with transmitting packages between two guests.
> > >
> > > Could you explain this more? It looks like a bug. (Or any pointer to
> > > the discussion)
> > >
> > > Thanks
> > >
> > > > Without hacks with skb's GSO - packages are still segmented on the host's postrouting.
> > > >
> > > > Andrew (5):
> > > >   uapi/linux/if_tun.h: Added new offload types for USO4/6.
> > > >   driver/net/tun: Added features for USO.
> > > >   uapi/linux/virtio_net.h: Added USO types.
> > > >   linux/virtio_net.h: Support USO offload in vnet header.
> > > >   drivers/net/virtio_net.c: Added USO support.
> > > >
> > > >  drivers/net/tap.c               | 10 ++++++++--
> > > >  drivers/net/tun.c               |  8 +++++++-
> > > >  drivers/net/virtio_net.c        | 19 +++++++++++++++----
> > > >  include/linux/virtio_net.h      |  9 +++++++++
> > > >  include/uapi/linux/if_tun.h     |  2 ++
> > > >  include/uapi/linux/virtio_net.h |  4 ++++
> > > >  6 files changed, 45 insertions(+), 7 deletions(-)
> > > >
> > > > --
> > > > 2.35.1
> > > >
> > >
> >
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
