Return-Path: <SRS0=ogTN=GW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF3CC433E0
	for <virtualization@archiver.kernel.org>; Tue, 19 Jan 2021 11:02:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6F4B2075F
	for <virtualization@archiver.kernel.org>; Tue, 19 Jan 2021 11:02:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6F4B2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6593084E9A;
	Tue, 19 Jan 2021 11:02:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2iMcC-B6Uc9M; Tue, 19 Jan 2021 11:02:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 99C4784DF6;
	Tue, 19 Jan 2021 11:02:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8572AC08A1;
	Tue, 19 Jan 2021 11:02:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D490C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 11:02:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2472286408
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 11:02:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jh-iyCDydybZ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 11:02:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E8AC785F8E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 11:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611054156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kiLt994IXzu+B0F7u6tIkfDBkyxqYHQz7CiZ5/RLVUY=;
 b=i1Z2Qt0iHD3SdVLvWMAPrAQNaqpjSIxHwfkN6nMSBWadiJuYPFqs8W/ixmPgWpJW8hckD/
 EEu7MF/vKDsLeGYTGysoND3dZiVj+pX/dV2Bs0IcY9I5K1DEQ7M+xNfNh6npj/2lSlwcoY
 mV6C4uAnnVe+4NTmVQAIdn0BY6usoBE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-kNYQqFC7PimnD_25u6ET9g-1; Tue, 19 Jan 2021 06:02:34 -0500
X-MC-Unique: kNYQqFC7PimnD_25u6ET9g-1
Received: by mail-wr1-f70.google.com with SMTP id l10so9318877wry.16
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 03:02:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=kiLt994IXzu+B0F7u6tIkfDBkyxqYHQz7CiZ5/RLVUY=;
 b=anSXpHZ5T/VXbatVFYooNv2KTeYrNSDOM5OAQfZDS//UPS1PQVDux/z24EGwBlJrWm
 TzrKHOtITjinq4X1KXg1jCi/XjXJOptvFhTzcQuzjZhmrr+Mw/LEhsiecKj4O22UKwa/
 tv7ar2P+GfMtPFnvt8UYLUR/o2Az7j3wvXbFKxGDpxDOwI6fwOcy+z++fOwinnEo4lny
 BCXsnhk0d4b/7VRSnqII4jjJhciJJ3PYj68eZpfSksOxp1I2HO5yFQ9c2P81SmZsDvUG
 qE0ReeDpCvWgpRv5fgIn1mXrvbAUlMdUqzIuKYW6baGDP1NxwCYhHXWAqotBNk9KK0dM
 AevQ==
X-Gm-Message-State: AOAM5316P+3dmfQYAgGAb4wI3Jz6mK/FdjZBk/2600nwUsMOVow1mNSV
 NsCjWO7l93APEPbyhqVbxKzDZaAWRnFdcBrw3j0CT4WTBCKOMy8+e4rAu/TId+dbZwI8+um/kKU
 dWW1IXRQ1a60O9+LfHlG5SRUU2ytzjdxStATAoFZ1Yw==
X-Received: by 2002:a5d:4d8b:: with SMTP id b11mr3766966wru.215.1611054153256; 
 Tue, 19 Jan 2021 03:02:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxsn0QhhwxM0iUt4w960LJvOY9PG5C4qB5nxwYI6dFa+qrhGOvysE4HQc58/mKABJu2FbKe7Q==
X-Received: by 2002:a5d:4d8b:: with SMTP id b11mr3766950wru.215.1611054153065; 
 Tue, 19 Jan 2021 03:02:33 -0800 (PST)
Received: from redhat.com (bzq-79-177-39-148.red.bezeqint.net. [79.177.39.148])
 by smtp.gmail.com with ESMTPSA id p12sm4133067wmi.3.2021.01.19.03.02.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Jan 2021 03:02:32 -0800 (PST)
Date: Tue, 19 Jan 2021 06:02:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH bpf-next v2 0/3] xsk: build skb by page
Message-ID: <20210119060140-mutt-send-email-mst@kernel.org>
References: <20210119045004-mutt-send-email-mst@kernel.org>
 <1611053609.502882-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1611053609.502882-1-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Song Liu <songliubraving@fb.com>, Martin KaFai Lau <kafai@fb.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yhs@fb.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@intel.com>,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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

On Tue, Jan 19, 2021 at 06:53:29PM +0800, Xuan Zhuo wrote:
> On Tue, 19 Jan 2021 04:50:30 -0500, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Tue, Jan 19, 2021 at 05:45:09PM +0800, Xuan Zhuo wrote:
> > > v2:
> > >     1. add priv_flags IFF_TX_SKB_NO_LINEAR instead of netdev_feature
> > >     2. split the patch to three:
> > >         a. add priv_flags IFF_TX_SKB_NO_LINEAR
> > >         b. virtio net add priv_flags IFF_TX_SKB_NO_LINEAR
> > >         c. When there is support this flag, construct skb without linear space
> > >     3. use ERR_PTR() and PTR_ERR() to handle the err
> > >
> > >
> > > v1 message log:
> > > ---------------
> > >
> > > This patch is used to construct skb based on page to save memory copy
> > > overhead.
> > >
> > > This has one problem:
> > >
> > > We construct the skb by fill the data page as a frag into the skb. In
> > > this way, the linear space is empty, and the header information is also
> > > in the frag, not in the linear space, which is not allowed for some
> > > network cards. For example, Mellanox Technologies MT27710 Family
> > > [ConnectX-4 Lx] will get the following error message:
> > >
> > >     mlx5_core 0000:3b:00.1 eth1: Error cqe on cqn 0x817, ci 0x8, qn 0x1dbb, opcode 0xd, syndrome 0x1, vendor syndrome 0x68
> > >     00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > >     00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > >     00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > >     00000030: 00 00 00 00 60 10 68 01 0a 00 1d bb 00 0f 9f d2
> > >     WQE DUMP: WQ size 1024 WQ cur size 0, WQE index 0xf, len: 64
> > >     00000000: 00 00 0f 0a 00 1d bb 03 00 00 00 08 00 00 00 00
> > >     00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > >     00000020: 00 00 00 2b 00 08 00 00 00 00 00 05 9e e3 08 00
> > >     00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > >     mlx5_core 0000:3b:00.1 eth1: ERR CQE on SQ: 0x1dbb
> > >
> > > I also tried to use build_skb to construct skb, but because of the
> > > existence of skb_shinfo, it must be behind the linear space, so this
> > > method is not working. We can't put skb_shinfo on desc->addr, it will be
> > > exposed to users, this is not safe.
> > >
> > > Finally, I added a feature NETIF_F_SKB_NO_LINEAR to identify whether the
> > > network card supports the header information of the packet in the frag
> > > and not in the linear space.
> > >
> > > ---------------- Performance Testing ------------
> > >
> > > The test environment is Aliyun ECS server.
> > > Test cmd:
> > > ```
> > > xdpsock -i eth0 -t  -S -s <msg size>
> > > ```
> > >
> > > Test result data:
> > >
> > > size    64      512     1024    1500
> > > copy    1916747 1775988 1600203 1440054
> > > page    1974058 1953655 1945463 1904478
> > > percent 3.0%    10.0%   21.58%  32.3%
> >
> > Just making sure, are these test results with v2?
> 
> The data was tested at v1,
> but v2 did not modify the performance-related code.
> 
> Thanks.

Looks like v1 wouldn't even build, or did I miss anything?
It would be nicer if you retested it ...

> 
> >
> > >
> > > Xuan Zhuo (3):
> > >   net: add priv_flags for allow tx skb without linear
> > >   virtio-net: support IFF_TX_SKB_NO_LINEAR
> > >   xsk: build skb by page
> > >
> > >  drivers/net/virtio_net.c  |   3 +-
> > >  include/linux/netdevice.h |   3 ++
> > >  net/xdp/xsk.c             | 112 ++++++++++++++++++++++++++++++++++++++--------
> > >  3 files changed, 99 insertions(+), 19 deletions(-)
> > >
> > > --
> > > 1.8.3.1
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
