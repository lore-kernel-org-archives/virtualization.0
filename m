Return-Path: <SRS0=5FLU=GI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC05C433DB
	for <virtualization@archiver.kernel.org>; Tue,  5 Jan 2021 12:25:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDA60229F0
	for <virtualization@archiver.kernel.org>; Tue,  5 Jan 2021 12:25:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDA60229F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4BCDF8710F;
	Tue,  5 Jan 2021 12:25:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ckqn6hYrujlN; Tue,  5 Jan 2021 12:25:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id AEF5586D85;
	Tue,  5 Jan 2021 12:25:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98055C088B;
	Tue,  5 Jan 2021 12:25:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56D75C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 12:25:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4F0D6854E5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 12:25:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DsjXglNmifto
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 12:25:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id AF3E684C9F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 12:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609849521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C6qUNvQUkXdw/sySXAScAycZjE4SmiBEPqohhGFSYUA=;
 b=RTQFOnYKcCL9qikVjFsTPpaUtnLH4WEWI0F11sIpROZPa7H01DR54iNyiyRLDZg2MmDRlW
 uHwXev4prEBp5L6kq5wNN4CZS/0hFvuDc1QtWVi7KYmPtubpRoo9OdZNIh7FonFdPPF5HP
 T67B6KZZ6f5JjZpqr5UsWqYecJ5l8X8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-xKEmau06PEWGwoY69o-cWw-1; Tue, 05 Jan 2021 07:25:18 -0500
X-MC-Unique: xKEmau06PEWGwoY69o-cWw-1
Received: by mail-wr1-f69.google.com with SMTP id o12so14744504wrq.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 05 Jan 2021 04:25:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=C6qUNvQUkXdw/sySXAScAycZjE4SmiBEPqohhGFSYUA=;
 b=YL2mhOYf33r5o7mabuLlBh60HCt3liIFWf53BeIbumtzdnoKRDHqEDzZQ46Nrbyz8l
 OSo2KS6unmF1z6NHgWtzYtJctU429gdNz0PnY+m9QGyHV1x/3cYhrE9rRysQP+ld0+Fd
 BaRSjoYzkyh1ttbMpsefKaIDyzqjYqF8e5dJ9Jr7z0G1bsY8Yu9lJ2XdVL1FEfVgeazj
 M+u1kmymhl4oTBqhjMPtl6/Y2fvGZAezeeKrRo5ZMNH0hrJEt6diQhSxeNm9Jsfz50A3
 iZhWUzBV6bsVIQTjGD8OnrEDJRx0egTgXgdgXxAvJv94BohYAGgR1iNBVYvQlFZ5I1Ko
 sYIQ==
X-Gm-Message-State: AOAM530ucThh0RK9W4D/fADhuo5lzqD4vVaSc2IhX2EPkJ87HRD4lvrd
 dhkpGs9t9QfzbboI5NXbl98xHI+QcfThl3zZsvzu6p/23tkYHUi2qMnt4Io+Tl12/koMCRDIqil
 zftTIFxxsJU/xZwjT/avv6L7Vkjc/mt/qry9Sf78+Dw==
X-Received: by 2002:a7b:c052:: with SMTP id u18mr3219909wmc.139.1609849517013; 
 Tue, 05 Jan 2021 04:25:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz2goxvm/vsk8E0XbHSlB3QZqCWkZVDQXKjwx5I6g+NamkUIWMgQNyLV5/lPhj5fdUxvUxiqQ==
X-Received: by 2002:a7b:c052:: with SMTP id u18mr3219882wmc.139.1609849516880; 
 Tue, 05 Jan 2021 04:25:16 -0800 (PST)
Received: from redhat.com (bzq-79-178-32-166.red.bezeqint.net. [79.178.32.166])
 by smtp.gmail.com with ESMTPSA id o83sm4030933wme.21.2021.01.05.04.25.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Jan 2021 04:25:16 -0800 (PST)
Date: Tue, 5 Jan 2021 07:25:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH netdev 0/5] virtio-net support xdp socket zero copy xmit
Message-ID: <20210105072316-mutt-send-email-mst@kernel.org>
References: <cover.1609837120.git.xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <cover.1609837120.git.xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Song Liu <songliubraving@fb.com>, Martin KaFai Lau <kafai@fb.com>,
 open list <linux-kernel@vger.kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 "open list:VIRTIO CORE AND NET DRIVERS"
 <virtualization@lists.linux-foundation.org>,
 Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yhs@fb.com>,
 dust.li@linux.alibaba.com, Jonathan Lemon <jonathan.lemon@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 "open list:XDP SOCKETS \(AF_XDP\)" <bpf@vger.kernel.org>,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@intel.com>,
 tonylu@linux.alibaba.com, "David S. Miller" <davem@davemloft.net>,
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

On Tue, Jan 05, 2021 at 05:11:38PM +0800, Xuan Zhuo wrote:
> The first patch made some adjustments to xsk.
> 
> The second patch itself can be used as an independent patch to solve the problem
> that XDP may fail to load when the number of queues is insufficient.
> 
> The third to last patch implements support for xsk in virtio-net.
> 
> A practical problem with virtio is that tx interrupts are not very reliable.
> There will always be some missing or delayed tx interrupts.

Would appreciate a bit more data on this one. Is this a host bug? Device bug?
Can we limit the work around somehow?

> So I specially added
> a point timer to solve this problem. Of course, considering performance issues,
> The timer only triggers when the ring of the network card is full.
> 
> Regarding the issue of virtio-net supporting xsk's zero copy rx, I am also
> developing it, but I found that the modification may be relatively large, so I
> consider this patch set to be separated from the code related to xsk zero copy
> rx.
> 
> Xuan Zhuo (5):
>   xsk: support get page for drv
>   virtio-net: support XDP_TX when not more queues
>   virtio-net, xsk: distinguish XDP_TX and XSK XMIT ctx
>   xsk, virtio-net: prepare for support xsk
>   virtio-net, xsk: virtio-net support xsk zero copy tx
> 
>  drivers/net/virtio_net.c    | 643 +++++++++++++++++++++++++++++++++++++++-----
>  include/linux/netdevice.h   |   1 +
>  include/net/xdp_sock_drv.h  |  10 +
>  include/net/xsk_buff_pool.h |   1 +
>  net/xdp/xsk_buff_pool.c     |  10 +-
>  5 files changed, 597 insertions(+), 68 deletions(-)
> 
> --
> 1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
