Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 610BEC4332F
	for <virtualization@archiver.kernel.org>; Wed,  1 Nov 2023 01:45:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DBB0D8443B;
	Wed,  1 Nov 2023 01:45:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DBB0D8443B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NuS534Ycec2L; Wed,  1 Nov 2023 01:45:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A76C883E0D;
	Wed,  1 Nov 2023 01:45:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A76C883E0D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C85EC0071;
	Wed,  1 Nov 2023 01:45:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6530C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Nov 2023 01:45:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B875841736
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Nov 2023 01:45:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B875841736
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3HBb6uT5ZLil
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Nov 2023 01:45:17 +0000 (UTC)
Received: from out30-101.freemail.mail.aliyun.com
 (out30-101.freemail.mail.aliyun.com [115.124.30.101])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 188B5408D7
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Nov 2023 01:45:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 188B5408D7
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0VvIssn4_1698803110; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VvIssn4_1698803110) by smtp.aliyun-inc.com;
 Wed, 01 Nov 2023 09:45:11 +0800
Message-ID: <1698803104.3925707-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio_pci: move structure to a header
Date: Wed, 1 Nov 2023 09:45:04 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <110d3058179284b092722827bef4f74f8ba0c622.1698769192.git.mst@redhat.com>
In-Reply-To: <110d3058179284b092722827bef4f74f8ba0c622.1698769192.git.mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Tue, 31 Oct 2023 12:19:54 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> These are guest/host interfaces so belong in the header
> where e.g. qemu will know to find them.
> Note: we added a new structure as opposed to extending existing one
> because someone might be relying on the size of the existing structure
> staying unchanged.  Add a warning to avoid using sizeof.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
>  drivers/virtio/virtio_pci_modern_dev.c |  7 ++++---
>  include/linux/virtio_pci_modern.h      |  7 -------
>  include/uapi/linux/virtio_pci.h        | 11 +++++++++++
>  3 files changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> index e2a1fe7bb66c..7de8b1ebabac 100644
> --- a/drivers/virtio/virtio_pci_modern_dev.c
> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> @@ -294,9 +294,10 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
>
>  	err = -EINVAL;
>  	mdev->common = vp_modern_map_capability(mdev, common,
> -				      sizeof(struct virtio_pci_common_cfg), 4,
> -				      0, sizeof(struct virtio_pci_modern_common_cfg),
> -				      &mdev->common_len, NULL);
> +			      sizeof(struct virtio_pci_common_cfg), 4, 0,
> +			      offsetofend(struct virtio_pci_modern_common_cfg,
> +					  queue_reset),
> +			      &mdev->common_len, NULL);
>  	if (!mdev->common)
>  		goto err_map_common;
>  	mdev->isr = vp_modern_map_capability(mdev, isr, sizeof(u8), 1,
> diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
> index d0f2797420f7..a09e13a577a9 100644
> --- a/include/linux/virtio_pci_modern.h
> +++ b/include/linux/virtio_pci_modern.h
> @@ -5,13 +5,6 @@
>  #include <linux/pci.h>
>  #include <linux/virtio_pci.h>
>
> -struct virtio_pci_modern_common_cfg {
> -	struct virtio_pci_common_cfg cfg;
> -
> -	__le16 queue_notify_data;	/* read-write */
> -	__le16 queue_reset;		/* read-write */
> -};
> -
>  /**
>   * struct virtio_pci_modern_device - info for modern PCI virtio
>   * @pci_dev:	    Ptr to the PCI device struct
> diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
> index f703afc7ad31..44f4dd2add18 100644
> --- a/include/uapi/linux/virtio_pci.h
> +++ b/include/uapi/linux/virtio_pci.h
> @@ -166,6 +166,17 @@ struct virtio_pci_common_cfg {
>  	__le32 queue_used_hi;		/* read-write */
>  };
>
> +/*
> + * Warning: do not use sizeof on this: use offsetofend for
> + * specific fields you need.
> + */
> +struct virtio_pci_modern_common_cfg {
> +	struct virtio_pci_common_cfg cfg;
> +
> +	__le16 queue_notify_data;	/* read-write */
> +	__le16 queue_reset;		/* read-write */
> +};
> +
>  /* Fields in VIRTIO_PCI_CAP_PCI_CFG: */
>  struct virtio_pci_cfg_cap {
>  	struct virtio_pci_cap cap;
> --
> MST
>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
