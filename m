Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7ECFC77B73
	for <virtualization@archiver.kernel.org>; Wed, 19 Apr 2023 03:48:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5DC60813BC;
	Wed, 19 Apr 2023 03:48:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5DC60813BC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0oVz5uvhX7MY; Wed, 19 Apr 2023 03:48:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D8886812CD;
	Wed, 19 Apr 2023 03:48:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D8886812CD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4972C007A;
	Wed, 19 Apr 2023 03:48:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1EE76C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 03:48:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E8959408D5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 03:48:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E8959408D5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jM20TESurg2y
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 03:48:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1E95640156
Received: from out30-118.freemail.mail.aliyun.com
 (out30-118.freemail.mail.aliyun.com [115.124.30.118])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1E95640156
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 03:48:29 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R451e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046051;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=12; SR=0;
 TI=SMTPD_---0VgTAsnt_1681876102; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VgTAsnt_1681876102) by smtp.aliyun-inc.com;
 Wed, 19 Apr 2023 11:48:23 +0800
Message-ID: <1681876092.206569-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] MAINTAINERS: make me a reviewer of VIRTIO CORE AND NET
 DRIVERS
Date: Wed, 19 Apr 2023 11:48:12 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230413071610.43659-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230413071610.43659-1-xuanzhuo@linux.alibaba.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, 13 Apr 2023 15:16:10 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> First of all, I personally love open source, linux and virtio. I have
> also participated in community work such as virtio for a long time.
>
> I think I am familiar enough with virtio/virtio-net and is adequate as a
> reviewer.
>
> Every time there is some patch/bug, I wish I can get pinged
> and I will feedback on that.
>
> For me personally, being a reviewer is an honor and a responsibility,
> and it also makes it easier for me to participate in virtio-related
> work. And I will spend more time reviewing virtio patch. Better advance
> virtio development
>
> I had some contributions to virtio/virtio-net and some support for it.
>
> * per-queue reset
> * virtio-net xdp
> * some bug fix
> * ......
>
> I make a humble request to grant the reviewer role for the virtio core
> and net drivers.

ping!!

>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cacd6074fb89..700b00a9e225 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22064,6 +22064,7 @@ F:	include/uapi/linux/virtio_console.h
>  VIRTIO CORE AND NET DRIVERS
>  M:	"Michael S. Tsirkin" <mst@redhat.com>
>  M:	Jason Wang <jasowang@redhat.com>
> +R:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>  L:	virtualization@lists.linux-foundation.org
>  S:	Maintained
>  F:	Documentation/ABI/testing/sysfs-bus-vdpa
> --
> 2.32.0.3.g01195cf9f
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
