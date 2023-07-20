Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3062AC001DE
	for <virtualization@archiver.kernel.org>; Thu, 20 Jul 2023 02:06:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9A96760FE0;
	Thu, 20 Jul 2023 02:06:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9A96760FE0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jOS-bf9LmHHa; Thu, 20 Jul 2023 02:06:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1212660AFF;
	Thu, 20 Jul 2023 02:06:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1212660AFF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DABB9C0072;
	Thu, 20 Jul 2023 02:06:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B92AC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 02:06:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F0D0341B48
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 02:06:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F0D0341B48
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r0t8JvqHKliV
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 02:06:48 +0000 (UTC)
Received: from out30-113.freemail.mail.aliyun.com
 (out30-113.freemail.mail.aliyun.com [115.124.30.113])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3AAD2418F4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 02:06:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3AAD2418F4
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046059;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0Vnnt3WB_1689818801; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vnnt3WB_1689818801) by smtp.aliyun-inc.com;
 Thu, 20 Jul 2023 10:06:42 +0800
Message-ID: <1689818793.8129647-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v1] virtio-pci: Fix legacy device flag setting error in
 probe
Date: Thu, 20 Jul 2023 10:06:33 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Feng Liu <feliu@nvidia.com>
References: <20230719154550.79536-1-feliu@nvidia.com>
In-Reply-To: <20230719154550.79536-1-feliu@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Jiri Pirko <jiri@nvidia.com>,
 Bodong Wang <bodong@nvidia.com>
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

On Wed, 19 Jul 2023 11:45:50 -0400, Feng Liu <feliu@nvidia.com> wrote:
> The 'is_legacy' flag is used to differentiate between legacy vs modern
> device. Currently, it is based on the value of vp_dev->ldev.ioaddr.
> However, due to the shared memory of the union between struct
> virtio_pci_legacy_device and struct virtio_pci_modern_device, when
> virtio_pci_modern_probe modifies the content of struct
> virtio_pci_modern_device, it affects the content of struct
> virtio_pci_legacy_device, and ldev.ioaddr is no longer zero, causing
> the 'is_legacy' flag to be set as true. To resolve issue, when legacy
> device is probed, mark 'is_legacy' as true, when modern device is
> probed, keep 'is_legacy' as false.
>
> Fixes: 4f0fc22534e3 ("virtio_pci: Optimize virtio_pci_device structure size")
> Signed-off-by: Feng Liu <feliu@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


> ---
>  drivers/virtio/virtio_pci_common.c | 2 --
>  drivers/virtio/virtio_pci_legacy.c | 1 +
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index a6c86f916dbd..c2524a7207cf 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -557,8 +557,6 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
>
>  	pci_set_master(pci_dev);
>
> -	vp_dev->is_legacy = vp_dev->ldev.ioaddr ? true : false;
> -
>  	rc = register_virtio_device(&vp_dev->vdev);
>  	reg_dev = vp_dev;
>  	if (rc)
> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> index 2257f1b3d8ae..d9cbb02b35a1 100644
> --- a/drivers/virtio/virtio_pci_legacy.c
> +++ b/drivers/virtio/virtio_pci_legacy.c
> @@ -223,6 +223,7 @@ int virtio_pci_legacy_probe(struct virtio_pci_device *vp_dev)
>  	vp_dev->config_vector = vp_config_vector;
>  	vp_dev->setup_vq = setup_vq;
>  	vp_dev->del_vq = del_vq;
> +	vp_dev->is_legacy = true;
>
>  	return 0;
>  }
> --
> 2.37.1 (Apple Git-137.1)
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
