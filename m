Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84075C28CF5
	for <virtualization@archiver.kernel.org>; Wed, 26 Jan 2022 08:32:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1598482FA5;
	Wed, 26 Jan 2022 08:32:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jHppBFkRv1TV; Wed, 26 Jan 2022 08:32:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9C50682FE7;
	Wed, 26 Jan 2022 08:32:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48E28C0039;
	Wed, 26 Jan 2022 08:32:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 970E0C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jan 2022 08:32:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6B17E40515
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jan 2022 08:32:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fpMWgJd-HJse
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jan 2022 08:32:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4FDB640183
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jan 2022 08:32:37 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 z25-20020a0568301db900b005946f536d85so28858938oti.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jan 2022 00:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=e2BGPbgxNsjIOcq9lLJ9KQzQO0Zg9McVWQ2H+KEkY/8=;
 b=IuF0OHqM0YtU+6Ni8u9RjwmM75GrCxWoyVk4PDoMariwcrvsfp2YuifnjJWjufDcSm
 13iUSKEGxgEBLZDhNb4mS4ESnWp0l5FqFxXXR7ZrFQR1Z9VbnMhuAyCgTxQ66ab3u1S3
 Q/2W/tHwp7TRz4fIFQrRy0/V1tj8qRxQ+m52iMOYuS7RSQFQbRt/lLECdvi6ER/UdiO6
 MmnGb4Ijjut54FHIVE1ufzmRWGeCI6glhHhYTf3EUTJgGY46r7c7EEF0WIXRjhQ63Jne
 qRrHeYfCKZQRP/pd1cS9ONanSzhHaI0f+8ZT9YnU4nmPiIV1ETutvIXdnFOsI1XbG+YF
 bBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=e2BGPbgxNsjIOcq9lLJ9KQzQO0Zg9McVWQ2H+KEkY/8=;
 b=KIzsLH968pa/zQxaxpM2Sc/8u3XxhOEl4um3paQEX/YtHh3T4+lK+I0Vd8yDt4hCdQ
 pkGS719gslgqCI716EJSyL2DRm+++nwRS4fukKbM/XPdiI8w+syFY4FcHREbrfoEPHNH
 qaZf+pg/+Dgxxv+pVPZJ6x4dRYh47yXpUPQ7KzPf4d1OrLjrapZ3JNDBVEFr9eERrpl8
 c0fmU35Bi34/FvAgQxrr65ZU6QgQaXvx0ZUj+I0yH4DScZIFDuzQsVdJeRcz/2yD5doL
 MZ4g45yx0KVrviaupDGg61L3dNkEJ/4DO68JvxVKjOUsJ+9lkW80fG2i1+9pLZ44C2RW
 kUlg==
X-Gm-Message-State: AOAM5333vyuQOkE2NodXOZgVxXdpD40Lla+FYH1DHyuRX+oNFS+n3Dhh
 vhPCn+51Xu6ZdICNn9mc+wIYkU5+xBI2TVNdxKg3lw==
X-Google-Smtp-Source: ABdhPJz1eMtqPc7zF2TNXjxiyxOoImyr6IMt5tZ8nz4RKJOIHml02NLosf18hu6uaIzph0k5GPQaTnHAFDmrKNtyTEo=
X-Received: by 2002:a05:6830:4013:: with SMTP id
 h19mr11781846ots.153.1643185956172; 
 Wed, 26 Jan 2022 00:32:36 -0800 (PST)
MIME-Version: 1.0
References: <20220125084702.3636253-1-andrew@daynix.com>
 <1643183537.4001389-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1643183537.4001389-1-xuanzhuo@linux.alibaba.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Wed, 26 Jan 2022 10:32:24 +0200
Message-ID: <CAOEp5OcwLiLZuVOAxx+pt6uztP-cGTgqsUSQj7N7HKTZgmyN3w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] TUN/VirtioNet USO features support.
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Network Development <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Yan Vugenfirer <yan@daynix.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
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

On Wed, Jan 26, 2022 at 9:54 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> On Tue, 25 Jan 2022 10:46:57 +0200, Andrew Melnychenko <andrew@daynix.com> wrote:
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
>
> Seems like this hasn't been upvoted yet.
>
>         https://github.com/oasis-tcs/virtio-spec#use-of-github-issues

Yes, correct. This is a reason why this series of patches is RFC.

>
> Thanks.
>
> >
> > Also, there is a known issue with transmitting packages between two guests.
> > Without hacks with skb's GSO - packages are still segmented on the host's postrouting.
> >
> > Andrew Melnychenko (5):
> >   uapi/linux/if_tun.h: Added new ioctl for tun/tap.
> >   driver/net/tun: Added features for USO.
> >   uapi/linux/virtio_net.h: Added USO types.
> >   linux/virtio_net.h: Added Support for GSO_UDP_L4 offload.
> >   drivers/net/virtio_net.c: Added USO support.
> >
> >  drivers/net/tap.c               | 18 ++++++++++++++++--
> >  drivers/net/tun.c               | 15 ++++++++++++++-
> >  drivers/net/virtio_net.c        | 22 ++++++++++++++++++----
> >  include/linux/virtio_net.h      | 11 +++++++++++
> >  include/uapi/linux/if_tun.h     |  3 +++
> >  include/uapi/linux/virtio_net.h |  4 ++++
> >  6 files changed, 66 insertions(+), 7 deletions(-)
> >
> > --
> > 2.34.1
> >
> > _______________________________________________
> > Virtualization mailing list
> > Virtualization@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/virtualization
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
