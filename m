Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9390C7EE25
	for <virtualization@archiver.kernel.org>; Wed, 17 May 2023 01:33:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4CE64403FB;
	Wed, 17 May 2023 01:33:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4CE64403FB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZDmsAFBcG3ct; Wed, 17 May 2023 01:32:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F205F40134;
	Wed, 17 May 2023 01:32:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F205F40134
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C839EC0037;
	Wed, 17 May 2023 01:32:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64360C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 01:32:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 24FC242024
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 01:32:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 24FC242024
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AgekxJr8jWoN
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 01:32:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6D61A41FE7
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6D61A41FE7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 01:32:53 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0ViqT6U4_1684287167; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0ViqT6U4_1684287167) by smtp.aliyun-inc.com;
 Wed, 17 May 2023 09:32:48 +0800
Message-ID: <1684287159.5055063-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v1] virtio_pci: Optimize virtio_pci_device structure size
Date: Wed, 17 May 2023 09:32:39 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Feng Liu <feliu@nvidia.com>
References: <20230516135446.16266-1-feliu@nvidia.com>
In-Reply-To: <20230516135446.16266-1-feliu@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Jiri Pirko <jiri@nvidia.com>, Bodong Wang <bodong@nvidia.com>
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

On Tue, 16 May 2023 09:54:46 -0400, Feng Liu <feliu@nvidia.com> wrote:
> Improve the size of the virtio_pci_device structure, which is commonly
> used to represent a virtio PCI device. A given virtio PCI device can
> either of legacy type or modern type, with the
> struct virtio_pci_legacy_device occupying 32 bytes and the
> struct virtio_pci_modern_device occupying 88 bytes. Make them a union,
> thereby save 32 bytes of memory as shown by the pahole tool. This
> improvement is particularly beneficial when dealing with numerous
> devices, as it helps conserve memory resources.
>
> Before the modification, pahole tool reported the following:
> struct virtio_pci_device {
> [...]
>         struct virtio_pci_legacy_device ldev;            /*   824    32 */
>         /* --- cacheline 13 boundary (832 bytes) was 24 bytes ago --- */
>         struct virtio_pci_modern_device mdev;            /*   856    88 */
>
>         /* XXX last struct has 4 bytes of padding */
> [...]
>         /* size: 1056, cachelines: 17, members: 19 */
> [...]
> };
>
> After the modification, pahole tool reported the following:
> struct virtio_pci_device {
> [...]
>         union {
>                 struct virtio_pci_legacy_device ldev;    /*   824    32 */
>                 struct virtio_pci_modern_device mdev;    /*   824    88 */
>         };                                               /*   824    88 */
> [...]
> 	/* size: 1024, cachelines: 16, members: 18 */
> [...]
> };
>
> Signed-off-by: Feng Liu <feliu@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Thanks.

> ---
>  drivers/virtio/virtio_pci_common.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> index 23112d84218f..4b773bd7c58c 100644
> --- a/drivers/virtio/virtio_pci_common.h
> +++ b/drivers/virtio/virtio_pci_common.h
> @@ -45,9 +45,10 @@ struct virtio_pci_vq_info {
>  struct virtio_pci_device {
>  	struct virtio_device vdev;
>  	struct pci_dev *pci_dev;
> -	struct virtio_pci_legacy_device ldev;
> -	struct virtio_pci_modern_device mdev;
> -
> +	union {
> +		struct virtio_pci_legacy_device ldev;
> +		struct virtio_pci_modern_device mdev;
> +	};
>  	bool is_legacy;
>
>  	/* Where to read and clear interrupt */
> --
> 2.37.1 (Apple Git-137.1)
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
