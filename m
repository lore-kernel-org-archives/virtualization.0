Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C1FC433EF
	for <virtualization@archiver.kernel.org>; Tue,  8 Feb 2022 13:09:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BF09C81BE3;
	Tue,  8 Feb 2022 13:09:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DrYoQgRDZK_k; Tue,  8 Feb 2022 13:09:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 65DEB81BC6;
	Tue,  8 Feb 2022 13:09:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37AB4C0011;
	Tue,  8 Feb 2022 13:09:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0039AC000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 13:09:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E27304059D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 13:09:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v-phvXfrLWg9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 13:09:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D86AD4059B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 13:09:34 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id ay7so6490855oib.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Feb 2022 05:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SbtrRuHy+NSlAeGtvroJmD9+7e6TK8yWL1WcOGDbT60=;
 b=ipB2P1DX/pWgxuTpermK6N6bN/NM8fq3jGkEyjPKIkXcJpx6XjJ9MZa/NKoDWwrzzR
 H9zOo26gGXSh73UucCAB3b8IrpsW1y9z8bWdX9TuGNUEUL6P7BodxWlew7CktkYe46lB
 mTSdFCPQ3OkT1RP1x/cWc1BBjlCdCs9vkvqtGoNIO1KIyvUoux1SlJZUjb+j4n02gssA
 tpx4yKREirT9e4vk7X0IQqZIvUbeUkL8uwPIArNFxbd4OjMiyavTrZuTe4VqePCEvIIW
 C/es6W9/nRSRO9vZv0UYJzlCUwVtwQXGAEyGo2tiEFSLhexMFTuNnQ6mlfn+EXqCeeBl
 yteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SbtrRuHy+NSlAeGtvroJmD9+7e6TK8yWL1WcOGDbT60=;
 b=3bQHzMnTpGyMbFTBBK0q1euymYjV6DBEiCE7+yOA8s8ELIaB7tf6fZkoxlHZcZkCmz
 ooZiF1zixoMqkkyjyhqvTaJooG854Ful3EecFDEZkKUfAoZ+tqJj5Gg4/vlKqMvcImuT
 I7Heip73EaI1N/BaqxEEncjiJH0g9PRr2RtuD+YI53i+UemsCRFmrGYOWYHfZeYMsckJ
 jPGQmOo1Ptw5GH/UUXjHjKvvLvsS36UHRHngLedC0n08gO260ilO4VtBtcDigddZ3u+0
 6nItY23cF6bfWTbo5rVt154//ABNsSultVilRMHCfQkuPvv71rbiDOFYZPM8ojtzImJh
 tsdg==
X-Gm-Message-State: AOAM530YBBlJYvIxrfzXIKz9r9FQHNOAK6pNSvxRIso31Xc8EJ03Abz7
 GRzSO14HcqjIDCqLwgmo5VM4ozsNSTSuIvf1ul9v/A==
X-Google-Smtp-Source: ABdhPJyJ9Zma2ZEin8GNpdoeNj2ZN7XXaEM/ArByR8cTF7OFgqG6jNtpwnZynRpkSVBbmdgOEJlE7ZQrWSvJLj3ECJY=
X-Received: by 2002:a05:6808:1819:: with SMTP id
 bh25mr454334oib.35.1644325772109; 
 Tue, 08 Feb 2022 05:09:32 -0800 (PST)
MIME-Version: 1.0
References: <20220125084702.3636253-1-andrew@daynix.com>
 <1643183537.4001389-1-xuanzhuo@linux.alibaba.com>
 <CAOEp5OcwLiLZuVOAxx+pt6uztP-cGTgqsUSQj7N7HKTZgmyN3w@mail.gmail.com>
In-Reply-To: <CAOEp5OcwLiLZuVOAxx+pt6uztP-cGTgqsUSQj7N7HKTZgmyN3w@mail.gmail.com>
From: Andrew Melnichenko <andrew@daynix.com>
Date: Tue, 8 Feb 2022 15:09:21 +0200
Message-ID: <CABcq3pE43rYojwUCAmpW-FKv5=ABcS47B944Y-3kDqr-PeqLwQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] TUN/VirtioNet USO features support.
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
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

Hi people,
Can you please review this series?

On Wed, Jan 26, 2022 at 10:32 AM Yuri Benditovich
<yuri.benditovich@daynix.com> wrote:
>
> On Wed, Jan 26, 2022 at 9:54 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > On Tue, 25 Jan 2022 10:46:57 +0200, Andrew Melnychenko <andrew@daynix.com> wrote:
> > > Added new offloads for TUN devices TUN_F_USO4 and TUN_F_USO6.
> > > Technically they enable NETIF_F_GSO_UDP_L4
> > > (and only if USO4 & USO6 are set simultaneously).
> > > It allows to transmission of large UDP packets.
> > >
> > > Different features USO4 and USO6 are required for qemu where Windows guests can
> > > enable disable USO receives for IPv4 and IPv6 separately.
> > > On the other side, Linux can't really differentiate USO4 and USO6, for now.
> > > For now, to enable USO for TUN it requires enabling USO4 and USO6 together.
> > > In the future, there would be a mechanism to control UDP_L4 GSO separately.
> > >
> > > Test it WIP Qemu https://github.com/daynix/qemu/tree/Dev_USOv2
> > >
> > > New types for VirtioNet already on mailing:
> > > https://lists.oasis-open.org/archives/virtio-comment/202110/msg00010.html
> >
> > Seems like this hasn't been upvoted yet.
> >
> >         https://github.com/oasis-tcs/virtio-spec#use-of-github-issues
>
> Yes, correct. This is a reason why this series of patches is RFC.
>
> >
> > Thanks.
> >
> > >
> > > Also, there is a known issue with transmitting packages between two guests.
> > > Without hacks with skb's GSO - packages are still segmented on the host's postrouting.
> > >
> > > Andrew Melnychenko (5):
> > >   uapi/linux/if_tun.h: Added new ioctl for tun/tap.
> > >   driver/net/tun: Added features for USO.
> > >   uapi/linux/virtio_net.h: Added USO types.
> > >   linux/virtio_net.h: Added Support for GSO_UDP_L4 offload.
> > >   drivers/net/virtio_net.c: Added USO support.
> > >
> > >  drivers/net/tap.c               | 18 ++++++++++++++++--
> > >  drivers/net/tun.c               | 15 ++++++++++++++-
> > >  drivers/net/virtio_net.c        | 22 ++++++++++++++++++----
> > >  include/linux/virtio_net.h      | 11 +++++++++++
> > >  include/uapi/linux/if_tun.h     |  3 +++
> > >  include/uapi/linux/virtio_net.h |  4 ++++
> > >  6 files changed, 66 insertions(+), 7 deletions(-)
> > >
> > > --
> > > 2.34.1
> > >
> > > _______________________________________________
> > > Virtualization mailing list
> > > Virtualization@lists.linux-foundation.org
> > > https://lists.linuxfoundation.org/mailman/listinfo/virtualization
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
