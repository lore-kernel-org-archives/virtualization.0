Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C33C43334
	for <virtualization@archiver.kernel.org>; Fri, 17 Jun 2022 01:30:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C6A6460A89;
	Fri, 17 Jun 2022 01:30:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C6A6460A89
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AsBkMmdl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7ukRgtppbTh3; Fri, 17 Jun 2022 01:30:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4A18460AA5;
	Fri, 17 Jun 2022 01:30:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4A18460AA5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28676C0032;
	Fri, 17 Jun 2022 01:30:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3DB8C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 01:30:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A8F6D840CD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 01:30:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A8F6D840CD
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=AsBkMmdl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KuhagKL-NVvl
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 01:30:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 91E348405D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 91E348405D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 01:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655429453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LdXVpK4M15aXqV7NHwfDKuztrburhsd2qHWyDgt1bpM=;
 b=AsBkMmdljRHd8jk1uYTzcSBcZvCatBima8cunN8o+JPIlnQOp1CDuuQQ1XN/adzDxf71wK
 8RfVcEzyri0/HVHZLVSuDQGFxuPI7a8tpRXUuVc+Ll+7nwDURnGM7NXA2DJllsyIQhmem7
 bn7Lorkn+gE5yS6ZL4LdCqOWPC8ln1s=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-24VPxhV2OPKnxbC5b2rjZw-1; Thu, 16 Jun 2022 21:30:52 -0400
X-MC-Unique: 24VPxhV2OPKnxbC5b2rjZw-1
Received: by mail-lf1-f69.google.com with SMTP id
 l12-20020a056512110c00b0047961681d22so1577199lfg.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Jun 2022 18:30:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LdXVpK4M15aXqV7NHwfDKuztrburhsd2qHWyDgt1bpM=;
 b=WFZempnh90ygD8zrHxlMZga/kTVPJU0b6qQP0FalIFPhqFkmUIBBZ1yCZCrI0ypmxw
 XYAxfFe3bYu4TO1yg2mVFm0eIgdFvT07L+pYSS4zSoQiaOWQ+sIttAAMEyAgnkXXEyG+
 6k9ZElwXV9erPcKISBbAiiusgJBXU3iy+2OXfZUBHPTTcGCxjbi3bXsCS2jkeErUoj//
 m/Efg6n+xCEKY4PSOtKYPE9bYt2cui6//MFX8lXbAQdSkeZYK2dK2lCCfGz6enyycnK0
 oDnk8tpSqSZy20cG6jOohzV2Mnpyk8ICtYqPSY3kvK7PFnnggkO1BRrUVewv+QbB2LPo
 BusQ==
X-Gm-Message-State: AJIora8tGzkV8nZbCsa3ETPsUjeQGtQWxPlZnvGe8IO07Q3uadGkJ95S
 T3PGJ03r9ZVEWXklriqwsL8bb4iQA3KVKLSRSXKbtaqH9TfxLJ8lYdYgDTu2db4UTXR/bkGsblv
 M2J1e5p7Ch2ym8oQEWsLiIgHqfj6NaceS6yKTMF9J5cRsCctUVB8rCWPhsQ==
X-Received: by 2002:a05:6512:5cc:b0:47a:bf7:f1ab with SMTP id
 o12-20020a05651205cc00b0047a0bf7f1abmr4267456lfo.397.1655429450426; 
 Thu, 16 Jun 2022 18:30:50 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u4Qjm7Ni+jE/Bp49gsRtZ1ZAQGwI2kW6yJTksXUAOA6+4gstzTdAjJrDnXXTTXD+choWDoMfhNR+jr8WymojY=
X-Received: by 2002:a05:6512:5cc:b0:47a:bf7:f1ab with SMTP id
 o12-20020a05651205cc00b0047a0bf7f1abmr4267441lfo.397.1655429450215; Thu, 16
 Jun 2022 18:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220512112347.18717-1-andrew@daynix.com>
 <CACGkMEvH1yE0CZYdstAK32DkEucejNO+V7PEAZD_641+rp2aKA@mail.gmail.com>
 <CABcq3pFJcsoj+dDf6tirT_hfTB6rj9+f6KNFafwg+usqYwTdDA@mail.gmail.com>
 <CACGkMEtaigzuwy25rE-7N40TQGvXVmJVQivavmuwrCuw0Z=LUQ@mail.gmail.com>
 <CABcq3pFzzSHA3pqbKFEsLaFg7FkFZkdxs+N_ET_n_XLBaWVnHA@mail.gmail.com>
 <CABcq3pHkqxunsaZ8qt=FicL1361D0EktxZhqib+MGDJ=DVB6FA@mail.gmail.com>
In-Reply-To: <CABcq3pHkqxunsaZ8qt=FicL1361D0EktxZhqib+MGDJ=DVB6FA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 17 Jun 2022 09:30:39 +0800
Message-ID: <CACGkMEscbjvSD3prC9WMSPD=vembZ2ZtKiAcekqAeDnWgXND3Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/5] TUN/VirtioNet USO features support.
To: Andrew Melnichenko <andrew@daynix.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

On Thu, Jun 16, 2022 at 7:59 PM Andrew Melnichenko <andrew@daynix.com> wrote:
>
> Hi, Jason
> Apparently, your patch should work.
> For now, I have an issue where segmentation between two guests on one
> host still occurs.
> Neither previous "hack" nor your patch helps.
> Now I'm looking what the issue may be.
> If you have some suggestions on where may I look, it would be helpful, thanks!

I think maybe it's worth tracking which function did the segmentation.

Thanks

>
> On Thu, May 26, 2022 at 3:18 PM Andrew Melnichenko <andrew@daynix.com> wrote:
> >
> > I'll check it, thank you!
> >
> > On Thu, May 26, 2022 at 9:56 AM Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > On Tue, May 24, 2022 at 7:07 PM Andrew Melnichenko <andrew@daynix.com> wrote:
> > > >
> > > > Hi all,
> > > >
> > > > The issue is that host segments packets between guests on the same host.
> > > > Tests show that it happens because SKB_GSO_DODGY skb offload in
> > > > virtio_net_hdr_from_skb().
> > > > To do segmentation you need to remove SKB_GSO_DODGY or add SKB_GSO_PARTIAL
> > > > The solution with DODGY/PARTIAL offload looks like a dirty hack, so
> > > > for now, I've lived it as it is for further investigation.
> > >
> > > Ok, I managed to find the previous discussion. It looks to me the
> > > reason is that __udp_gso_segment will segment dodgy packets
> > > unconditionally.
> > >
> > > I wonder if the attached patch works? (compile test only).
> > >
> > > Thanks
> > >
> > > >
> > > >
> > > > On Tue, May 17, 2022 at 9:32 AM Jason Wang <jasowang@redhat.com> wrote:
> > > > >
> > > > > On Thu, May 12, 2022 at 7:33 PM Andrew Melnychenko <andrew@daynix.com> wrote:
> > > > > >
> > > > > > Added new offloads for TUN devices TUN_F_USO4 and TUN_F_USO6.
> > > > > > Technically they enable NETIF_F_GSO_UDP_L4
> > > > > > (and only if USO4 & USO6 are set simultaneously).
> > > > > > It allows to transmission of large UDP packets.
> > > > > >
> > > > > > Different features USO4 and USO6 are required for qemu where Windows guests can
> > > > > > enable disable USO receives for IPv4 and IPv6 separately.
> > > > > > On the other side, Linux can't really differentiate USO4 and USO6, for now.
> > > > > > For now, to enable USO for TUN it requires enabling USO4 and USO6 together.
> > > > > > In the future, there would be a mechanism to control UDP_L4 GSO separately.
> > > > > >
> > > > > > Test it WIP Qemu https://github.com/daynix/qemu/tree/Dev_USOv2
> > > > > >
> > > > > > New types for VirtioNet already on mailing:
> > > > > > https://lists.oasis-open.org/archives/virtio-comment/202110/msg00010.html
> > > > > >
> > > > > > Also, there is a known issue with transmitting packages between two guests.
> > > > >
> > > > > Could you explain this more? It looks like a bug. (Or any pointer to
> > > > > the discussion)
> > > > >
> > > > > Thanks
> > > > >
> > > > > > Without hacks with skb's GSO - packages are still segmented on the host's postrouting.
> > > > > >
> > > > > > Andrew (5):
> > > > > >   uapi/linux/if_tun.h: Added new offload types for USO4/6.
> > > > > >   driver/net/tun: Added features for USO.
> > > > > >   uapi/linux/virtio_net.h: Added USO types.
> > > > > >   linux/virtio_net.h: Support USO offload in vnet header.
> > > > > >   drivers/net/virtio_net.c: Added USO support.
> > > > > >
> > > > > >  drivers/net/tap.c               | 10 ++++++++--
> > > > > >  drivers/net/tun.c               |  8 +++++++-
> > > > > >  drivers/net/virtio_net.c        | 19 +++++++++++++++----
> > > > > >  include/linux/virtio_net.h      |  9 +++++++++
> > > > > >  include/uapi/linux/if_tun.h     |  2 ++
> > > > > >  include/uapi/linux/virtio_net.h |  4 ++++
> > > > > >  6 files changed, 45 insertions(+), 7 deletions(-)
> > > > > >
> > > > > > --
> > > > > > 2.35.1
> > > > > >
> > > > >
> > > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
