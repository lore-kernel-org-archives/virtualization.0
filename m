Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61893C76196
	for <virtualization@archiver.kernel.org>; Fri, 31 Mar 2023 04:21:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C725E4053F;
	Fri, 31 Mar 2023 04:21:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C725E4053F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4kKPAnlMSO8m; Fri, 31 Mar 2023 04:21:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6242E40A86;
	Fri, 31 Mar 2023 04:21:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6242E40A86
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2FE6EC0037;
	Fri, 31 Mar 2023 04:21:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1247C002F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 04:20:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D374540A86
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 04:20:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D374540A86
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Bu6V1dc5Prsl
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 04:20:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1E0D14053F
Received: from out30-110.freemail.mail.aliyun.com
 (out30-110.freemail.mail.aliyun.com [115.124.30.110])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1E0D14053F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 04:20:56 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046049;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=5; SR=0;
 TI=SMTPD_---0Vf0pWkJ_1680236450; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vf0pWkJ_1680236450) by smtp.aliyun-inc.com;
 Fri, 31 Mar 2023 12:20:50 +0800
Message-ID: <1680236421.322672-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v2 0/3] virtio_ring: Clean up code for virtio ring and pci
Date: Fri, 31 Mar 2023 12:20:21 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Feng Liu via Virtualization <virtualization@lists.linux-foundation.org>
References: <20230315185458.11638-1-feliu@nvidia.com>
In-Reply-To: <20230315185458.11638-1-feliu@nvidia.com>
Cc: Bodong Wang <bodong@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
 virtualization@lists.linux-foundation.org, Gavin Li <gavinl@nvidia.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
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

Series:

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Thanks.

On Wed, 15 Mar 2023 20:54:55 +0200, Feng Liu via Virtualization <virtualization@lists.linux-foundation.org> wrote:
> This patch series performs a clean up of the code in virtio_ring and
> virtio_pci, modifying it to conform with the Linux kernel coding style
> guidance [1]. The modifications ensure the code easy to read and
> understand. This small series does few short cleanups in the code.
>
> Patch-1 Allow non power of 2 sizes for packed virtqueues.
> Patch-2 Avoid using inline for small functions.
> Patch-3 Use const to annotate read-only pointer params.
>
> [1]
> https://www.kernel.org/doc/html/v6.2-rc3/process/coding-style.html#the-inline-disease
>
> All of the patches have been verified based on the kernel code
> commit 81ff855485a3 ("Merge tag 'i2c-for-6.3-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux")
>
> Feng Liu (3):
>   virtio_ring: Allow non power of 2 sizes for packed virtqueue
>   virtio_ring: Avoid using inline for small functions
>   virtio_ring: Use const to annotate read-only pointer params
>
>  drivers/virtio/virtio_pci_modern.c |  5 ----
>  drivers/virtio/virtio_ring.c       | 48 +++++++++++++++---------------
>  include/linux/virtio.h             | 14 ++++-----
>  3 files changed, 31 insertions(+), 36 deletions(-)
>
> --
> 2.34.1
>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
