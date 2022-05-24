Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E966C433F5
	for <virtualization@archiver.kernel.org>; Tue, 24 May 2022 11:07:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A68AC611A9;
	Tue, 24 May 2022 11:07:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZAIEiWVhhWeC; Tue, 24 May 2022 11:07:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 34C8C605AC;
	Tue, 24 May 2022 11:07:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0792CC0032;
	Tue, 24 May 2022 11:07:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D7F0C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 11:07:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7358C402E1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 11:07:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9H66xdGeXdnU
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 11:06:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 86C82401F1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 11:06:59 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-f233f06563so10179081fac.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 04:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VKKe+6qBQIm12lCUpH0Sxp4+NXI90A0uXZAqIc10ncY=;
 b=HwVDCzwjATjlGAIJ3+JeU4cM+iRQQ0fGccnqZgJ7Dwvs7Q6IFYDh0GJqXRziKDGGJ+
 H9tvhZs5mxuIKSyQC8CFDXsKX9ogyBkEB/C1aD8YRjrHCStbKZ1iVsKD1nOiQ0QWAPWV
 JqX6sDB6TFi1tf4w85qQNxyJD6rUNFrzCCJoivsunDquhDIaodahgeZJjaW3QwR6inhe
 ISTLZAj0L19EcmGbVQEmwkVQGCiok/ehKp4L+eIeGMrwa6PmU+sPKAop8VeTZlsy26CB
 4Cjd11YnAUYOcDGo8S0E56AxsYEHrAr1H/kAB3H8yRT9WAX0cj6wDvMJ38vJpf/aqHA1
 K9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VKKe+6qBQIm12lCUpH0Sxp4+NXI90A0uXZAqIc10ncY=;
 b=wNuwzN3TacVu6PxWxv8Wc1OaG2sdnJcTRJ4sG0hu23GNc9mK09lxt7l2OEb0itINST
 9fo00jjak+hmSmdoUHTArEgSdPP3FI9NMHMKqJCCrA5CrjlCB8r3GG21iFTc/SwUK3U+
 r3H+/EfYSb20AGkKfccX9VQFuthPvs2HUmH4A1ZazY5BZ0dk4yCJLSF5gI+P7KJfS1dE
 ldovO/u8uoeAwAj4KvVIspUbn/O68tKUxwM8/QFgrVvZpn9X/Etb/HK5f7KEqZoZ8G2S
 xaakRyS/rJMFPxkmncwM/JLqkYtSs13gDXQ4ECKfcYb0k27Ye2Wi2VeWhSdTcpZK+82U
 7TTg==
X-Gm-Message-State: AOAM533HkAUu65TdbsowwCKjYKVHsyd+2DshaJjL+TOWZsk9bJnY4JaO
 qLMdwm369gIMzkGtcpAthL2mS08mvFhYuFNBpMNvBQ==
X-Google-Smtp-Source: ABdhPJzhl26EPYePCoZDxKKBpid3sxP95MD1D8lQQk/DlugmdrO4YT7uA/zZbc8AT4HaqELuAJenHw20CnIPSKMbeCQ=
X-Received: by 2002:a05:6870:4184:b0:f1:97d2:6696 with SMTP id
 y4-20020a056870418400b000f197d26696mr2104578oac.148.1653390417932; Tue, 24
 May 2022 04:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220512112347.18717-1-andrew@daynix.com>
 <CACGkMEvH1yE0CZYdstAK32DkEucejNO+V7PEAZD_641+rp2aKA@mail.gmail.com>
In-Reply-To: <CACGkMEvH1yE0CZYdstAK32DkEucejNO+V7PEAZD_641+rp2aKA@mail.gmail.com>
From: Andrew Melnichenko <andrew@daynix.com>
Date: Tue, 24 May 2022 14:06:46 +0300
Message-ID: <CABcq3pFJcsoj+dDf6tirT_hfTB6rj9+f6KNFafwg+usqYwTdDA@mail.gmail.com>
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

Hi all,

The issue is that host segments packets between guests on the same host.
Tests show that it happens because SKB_GSO_DODGY skb offload in
virtio_net_hdr_from_skb().
To do segmentation you need to remove SKB_GSO_DODGY or add SKB_GSO_PARTIAL
The solution with DODGY/PARTIAL offload looks like a dirty hack, so
for now, I've lived it as it is for further investigation.


On Tue, May 17, 2022 at 9:32 AM Jason Wang <jasowang@redhat.com> wrote:
>
> On Thu, May 12, 2022 at 7:33 PM Andrew Melnychenko <andrew@daynix.com> wrote:
> >
> > Added new offloads for TUN devices TUN_F_USO4 and TUN_F_USO6.
> > Technically they enable NETIF_F_GSO_UDP_L4
> > (and only if USO4 & USO6 are set simultaneously).
> > It allows to transmission of large UDP packets.
> >
> > Different features USO4 and USO6 are required for qemu where Windows guests can
> > enable disable USO receives for IPv4 and IPv6 separately.
> > On the other side, Linux can't really differentiate USO4 and USO6, for now.
> > For now, to enable USO for TUN it requires enabling USO4 and USO6 together.
> > In the future, there would be a mechanism to control UDP_L4 GSO separately.
> >
> > Test it WIP Qemu https://github.com/daynix/qemu/tree/Dev_USOv2
> >
> > New types for VirtioNet already on mailing:
> > https://lists.oasis-open.org/archives/virtio-comment/202110/msg00010.html
> >
> > Also, there is a known issue with transmitting packages between two guests.
>
> Could you explain this more? It looks like a bug. (Or any pointer to
> the discussion)
>
> Thanks
>
> > Without hacks with skb's GSO - packages are still segmented on the host's postrouting.
> >
> > Andrew (5):
> >   uapi/linux/if_tun.h: Added new offload types for USO4/6.
> >   driver/net/tun: Added features for USO.
> >   uapi/linux/virtio_net.h: Added USO types.
> >   linux/virtio_net.h: Support USO offload in vnet header.
> >   drivers/net/virtio_net.c: Added USO support.
> >
> >  drivers/net/tap.c               | 10 ++++++++--
> >  drivers/net/tun.c               |  8 +++++++-
> >  drivers/net/virtio_net.c        | 19 +++++++++++++++----
> >  include/linux/virtio_net.h      |  9 +++++++++
> >  include/uapi/linux/if_tun.h     |  2 ++
> >  include/uapi/linux/virtio_net.h |  4 ++++
> >  6 files changed, 45 insertions(+), 7 deletions(-)
> >
> > --
> > 2.35.1
> >
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
