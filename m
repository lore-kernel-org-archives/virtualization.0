Return-Path: <SRS0=ogTN=GW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E4EC433DB
	for <virtualization@archiver.kernel.org>; Tue, 19 Jan 2021 09:50:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DADD2313F
	for <virtualization@archiver.kernel.org>; Tue, 19 Jan 2021 09:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DADD2313F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CE40F860FC;
	Tue, 19 Jan 2021 09:50:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Uc08aRn3OZYr; Tue, 19 Jan 2021 09:50:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4D19C860DC;
	Tue, 19 Jan 2021 09:50:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30B55C088B;
	Tue, 19 Jan 2021 09:50:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1753C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 09:50:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id AC33A847D5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 09:50:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WYTuVTXYkpFi
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 09:50:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BDEB8847A7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 09:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611049840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MDToM82xeMKamVLIGfz7Nyf28zoLDtL7EisG0SsbIaw=;
 b=SlzwdxFveynrtX4X005ueDmaDycGAKknjHVXxWz9UkXg+/awBtchswKw66ZwmQ8wSoMpwL
 XcxDsnYIDbCWQhOSB3rFf+vHkI0tyx4rdN/wyofhKkaKkDysmFz7VD6aMRtibv/UVDLcRM
 9iimXA3eo+aKBhgdAxxI6gynjL0BzXA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-JDzJ2Ph4P2W34S53WRN2cA-1; Tue, 19 Jan 2021 04:50:37 -0500
X-MC-Unique: JDzJ2Ph4P2W34S53WRN2cA-1
Received: by mail-wr1-f69.google.com with SMTP id u14so9658893wrr.15
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 01:50:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=MDToM82xeMKamVLIGfz7Nyf28zoLDtL7EisG0SsbIaw=;
 b=ks9tUZupPj24PUBFKP0eDgwB394tQE3hzR11pZZRuTcmbbpudGGjfyaj03HSu5EEPm
 2kBwlQ0/ci8WdQ4kvbjk+gr/Jz6K01tvRbJ+Ul692oZDCDxgp1BojrolglaZoDfS+npP
 0OJo4cylgXKQ3PvGE+UiTPTwt4X4O1dCiChPB8uAC/Hppcz72SCndCjEHTVyOGUOU8TV
 uR+gfNMsC+vCDGpHorEUjBaYOWLa3duZJne9Qf3WkfpgXQ+0dwulRYs4pm/xgwfn9WSF
 N2PLEOr/BBJEPXY/Y29IuqdcNdKPmlDgESUF9NzSNxPlz8MN5QyE7a52OOfRwX9OIxDd
 /wlg==
X-Gm-Message-State: AOAM531RY4M8FkzDPcr6qGROPbw0XKQ91REoZhLyCDeXiOax6sN1glxC
 0O24+Z3sOp8gm7vGD+NrNixjXhqPfZ2Lu4VHXFeNCjvilHdBgSG7KTzJw2SaIqhCFZxSs55qcYH
 8Iq9rhGxSvhEx6BfB9MFh1U0zPmh01K6/DUQDc1uzCg==
X-Received: by 2002:a5d:6749:: with SMTP id l9mr3480142wrw.395.1611049835236; 
 Tue, 19 Jan 2021 01:50:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxQA3wzZZMN3tnDPlscHS6t87wN39DxSkIQdglcuApSG944ZAiQro8EcY9yc+c5nyrHouGySA==
X-Received: by 2002:a5d:6749:: with SMTP id l9mr3480112wrw.395.1611049834999; 
 Tue, 19 Jan 2021 01:50:34 -0800 (PST)
Received: from redhat.com (bzq-79-177-39-148.red.bezeqint.net. [79.177.39.148])
 by smtp.gmail.com with ESMTPSA id s1sm35531280wrv.97.2021.01.19.01.50.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Jan 2021 01:50:34 -0800 (PST)
Date: Tue, 19 Jan 2021 04:50:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH bpf-next v2 0/3] xsk: build skb by page
Message-ID: <20210119045004-mutt-send-email-mst@kernel.org>
References: <cover.1611048724.git.xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <cover.1611048724.git.xuanzhuo@linux.alibaba.com>
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

On Tue, Jan 19, 2021 at 05:45:09PM +0800, Xuan Zhuo wrote:
> v2:
>     1. add priv_flags IFF_TX_SKB_NO_LINEAR instead of netdev_feature
>     2. split the patch to three:
>         a. add priv_flags IFF_TX_SKB_NO_LINEAR
>         b. virtio net add priv_flags IFF_TX_SKB_NO_LINEAR
>         c. When there is support this flag, construct skb without linear space
>     3. use ERR_PTR() and PTR_ERR() to handle the err
> 
> 
> v1 message log:
> ---------------
> 
> This patch is used to construct skb based on page to save memory copy
> overhead.
> 
> This has one problem:
> 
> We construct the skb by fill the data page as a frag into the skb. In
> this way, the linear space is empty, and the header information is also
> in the frag, not in the linear space, which is not allowed for some
> network cards. For example, Mellanox Technologies MT27710 Family
> [ConnectX-4 Lx] will get the following error message:
> 
>     mlx5_core 0000:3b:00.1 eth1: Error cqe on cqn 0x817, ci 0x8, qn 0x1dbb, opcode 0xd, syndrome 0x1, vendor syndrome 0x68
>     00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>     00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>     00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>     00000030: 00 00 00 00 60 10 68 01 0a 00 1d bb 00 0f 9f d2
>     WQE DUMP: WQ size 1024 WQ cur size 0, WQE index 0xf, len: 64
>     00000000: 00 00 0f 0a 00 1d bb 03 00 00 00 08 00 00 00 00
>     00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>     00000020: 00 00 00 2b 00 08 00 00 00 00 00 05 9e e3 08 00
>     00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>     mlx5_core 0000:3b:00.1 eth1: ERR CQE on SQ: 0x1dbb
> 
> I also tried to use build_skb to construct skb, but because of the
> existence of skb_shinfo, it must be behind the linear space, so this
> method is not working. We can't put skb_shinfo on desc->addr, it will be
> exposed to users, this is not safe.
> 
> Finally, I added a feature NETIF_F_SKB_NO_LINEAR to identify whether the
> network card supports the header information of the packet in the frag
> and not in the linear space.
> 
> ---------------- Performance Testing ------------
> 
> The test environment is Aliyun ECS server.
> Test cmd:
> ```
> xdpsock -i eth0 -t  -S -s <msg size>
> ```
> 
> Test result data:
> 
> size    64      512     1024    1500
> copy    1916747 1775988 1600203 1440054
> page    1974058 1953655 1945463 1904478
> percent 3.0%    10.0%   21.58%  32.3%

Just making sure, are these test results with v2?

> 
> Xuan Zhuo (3):
>   net: add priv_flags for allow tx skb without linear
>   virtio-net: support IFF_TX_SKB_NO_LINEAR
>   xsk: build skb by page
> 
>  drivers/net/virtio_net.c  |   3 +-
>  include/linux/netdevice.h |   3 ++
>  net/xdp/xsk.c             | 112 ++++++++++++++++++++++++++++++++++++++--------
>  3 files changed, 99 insertions(+), 19 deletions(-)
> 
> --
> 1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
