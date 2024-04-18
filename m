Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28893B79F
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Apr 2024 07:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713424488; cv=none; b=pnlKUk3fjT0H7gEuMX78GHvp3mVfkKDOgsFIK13c/IYLEAwg1MAkTfU94jPErq8t9cmLoBVQyKcJ2I/d5EtYE/QI0gL3ox/GCtNuTtouJW3/DSDNMvlHNVW/Q2+MixFDZpWAk+vHxOlk8LqKA4d06DI4+Wr0SU8r6Oyl36oBhpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713424488; c=relaxed/simple;
	bh=cbIMRI+x+AE/hoz/da/ZJt9M4223DOG5M56T+jFdBnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FT/fWm+wZu55PWpV7oBXbhT2nJ2khfsQE1c4JnYJ0xmx28QgK0bNX1EfuyXGAoyMXssFFqDOhW3C1jzNv8H3/qlPVyBS3uHfjqbc2/C5zo8pMO1YSHp5PHi6CqiIGHlnPtavQBzs/BH2ZduMkWl+PAnEAptYgfCd9Xd74U7IWoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kvXcs8+N; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kvXcs8+N"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 81CA6404EF
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Apr 2024 07:14:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TWRcCCpy6p2e for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Apr 2024 07:14:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=lingshan.zhu@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3F341404E8
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3F341404E8
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kvXcs8+N
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3F341404E8
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Apr 2024 07:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713424486; x=1744960486;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cbIMRI+x+AE/hoz/da/ZJt9M4223DOG5M56T+jFdBnM=;
  b=kvXcs8+NkqoB8Nb9krJcms7aDjpZN9W7OEsHZ1Y9qdMzCCHgWeLSQqOj
   /hJcclvpKoVWHsvgn83k1juthpLQ0mZF6qbyLgDxOALeLN5I13I4zP3AC
   3UFYAcpqJzfuW4jk6W7GPcv9DMdCd/o3H/L7pfWo2CQjDwTriXzeCjL7g
   UMWinLHsVnPQAAv9jnw4ugvsCAnP7lJztKuWBVMpnpGxOadF0Ae7zpeh3
   M+kecOGEe7d6FcKKSv0zW0bOyNpdTkHklyGJfK5C14iN5lzYQp/Ry25rf
   9XMH4N8qBDRr3tSKw9Cc7n4xN/Fobb6rKFmQZs8hOCZ1Bxm3jz9WW+grV
   w==;
X-CSE-ConnectionGUID: o/kzTy3pQtG0scwYdYjfZw==
X-CSE-MsgGUID: uvRPwaZZQsyMtLlNgd7UFQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="8787061"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="8787061"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 00:14:44 -0700
X-CSE-ConnectionGUID: 2+sjzn6+TUy9wxZxV5tZKw==
X-CSE-MsgGUID: ZyqcBl9rQ+CnlU9ZiIIxBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="23492978"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.124.226.64]) ([10.124.226.64])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 00:14:40 -0700
Message-ID: <a123f8da-a6b9-4923-95ff-7814804cdabb@intel.com>
Date: Thu, 18 Apr 2024 15:14:37 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] virtio: Add support for the virtio suspend feature
To: David Stevens <stevensd@chromium.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Eugenio Perez <eperezma@redhat.com>, virtio-dev@lists.oasis-open.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
References: <20240417085440.4036535-1-stevensd@chromium.org>
 <20240417085440.4036535-2-stevensd@chromium.org>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <20240417085440.4036535-2-stevensd@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/17/2024 4:54 PM, David Stevens wrote:
> Add support for the VIRTIO_F_SUSPEND feature. When this feature is
> negotiated, power management can use it to suspend virtio devices
> instead of resorting to resetting the devices entirely.
>
> Signed-off-by: David Stevens <stevensd@chromium.org>
> ---
>   drivers/virtio/virtio.c            | 32 ++++++++++++++++++++++++++++++
>   drivers/virtio/virtio_pci_common.c | 29 +++++++++++----------------
>   drivers/virtio/virtio_pci_modern.c | 19 ++++++++++++++++++
>   include/linux/virtio.h             |  2 ++
>   include/uapi/linux/virtio_config.h | 10 +++++++++-
>   5 files changed, 74 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index f4080692b351..cd11495a5098 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -1,5 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   #include <linux/virtio.h>
> +#include <linux/delay.h>
>   #include <linux/spinlock.h>
>   #include <linux/virtio_config.h>
>   #include <linux/virtio_anchor.h>
> @@ -580,6 +581,37 @@ int virtio_device_restore(struct virtio_device *dev)
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(virtio_device_restore);
> +
> +static int virtio_device_set_suspend_bit(struct virtio_device *dev, bool enabled)
> +{
> +	u8 status, target;
> +
> +	status = dev->config->get_status(dev);
> +	if (enabled)
> +		target = status | VIRTIO_CONFIG_S_SUSPEND;
> +	else
> +		target = status & ~VIRTIO_CONFIG_S_SUSPEND;
> +	dev->config->set_status(dev, target);
I think it is better to verify whether the device SUSPEND bit is
already set or clear, we can just return if status == target.

Thanks
Zhu Lingshan
> +
> +	while ((status = dev->config->get_status(dev)) != target) {
> +		if (status & VIRTIO_CONFIG_S_NEEDS_RESET)
> +			return -EIO;
> +		mdelay(10);
> +	}
> +	return 0;
> +}
> +
> +int virtio_device_suspend(struct virtio_device *dev)
> +{
> +	return virtio_device_set_suspend_bit(dev, true);
> +}
> +EXPORT_SYMBOL_GPL(virtio_device_suspend);
> +
> +int virtio_device_resume(struct virtio_device *dev)
> +{
> +	return virtio_device_set_suspend_bit(dev, false);
> +}
> +EXPORT_SYMBOL_GPL(virtio_device_resume);
>   #endif
>   
>   static int virtio_init(void)
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index b655fccaf773..4d542de05970 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -495,31 +495,26 @@ static int virtio_pci_restore(struct device *dev)
>   	return virtio_device_restore(&vp_dev->vdev);
>   }
>   
> -static bool vp_supports_pm_no_reset(struct device *dev)
> +static int virtio_pci_suspend(struct device *dev)
>   {
>   	struct pci_dev *pci_dev = to_pci_dev(dev);
> -	u16 pmcsr;
> -
> -	if (!pci_dev->pm_cap)
> -		return false;
> -
> -	pci_read_config_word(pci_dev, pci_dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> -	if (PCI_POSSIBLE_ERROR(pmcsr)) {
> -		dev_err(dev, "Unable to query pmcsr");
> -		return false;
> -	}
> +	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
>   
> -	return pmcsr & PCI_PM_CTRL_NO_SOFT_RESET;
> -}
> +	if (virtio_has_feature(&vp_dev->vdev, VIRTIO_F_SUSPEND))
> +		return virtio_device_suspend(&vp_dev->vdev);
>   
> -static int virtio_pci_suspend(struct device *dev)
> -{
> -	return vp_supports_pm_no_reset(dev) ? 0 : virtio_pci_freeze(dev);
> +	return virtio_pci_freeze(dev);
>   }
>   
>   static int virtio_pci_resume(struct device *dev)
>   {
> -	return vp_supports_pm_no_reset(dev) ? 0 : virtio_pci_restore(dev);
> +	struct pci_dev *pci_dev = to_pci_dev(dev);
> +	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
> +
> +	if (virtio_has_feature(&vp_dev->vdev, VIRTIO_F_SUSPEND))
> +		return virtio_device_resume(&vp_dev->vdev);
> +
> +	return virtio_pci_restore(dev);
>   }
>   
>   static const struct dev_pm_ops virtio_pci_pm_ops = {
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index f62b530aa3b5..ac8734526b8d 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -209,6 +209,22 @@ static void vp_modern_avq_deactivate(struct virtio_device *vdev)
>   	__virtqueue_break(admin_vq->info.vq);
>   }
>   
> +static bool vp_supports_pm_no_reset(struct pci_dev *pci_dev)
> +{
> +	u16 pmcsr;
> +
> +	if (!pci_dev->pm_cap)
> +		return false;
> +
> +	pci_read_config_word(pci_dev, pci_dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> +	if (PCI_POSSIBLE_ERROR(pmcsr)) {
> +		dev_err(&pci_dev->dev, "Unable to query pmcsr");
> +		return false;
> +	}
> +
> +	return pmcsr & PCI_PM_CTRL_NO_SOFT_RESET;
> +}
> +
>   static void vp_transport_features(struct virtio_device *vdev, u64 features)
>   {
>   	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> @@ -223,6 +239,9 @@ static void vp_transport_features(struct virtio_device *vdev, u64 features)
>   
>   	if (features & BIT_ULL(VIRTIO_F_ADMIN_VQ))
>   		__virtio_set_bit(vdev, VIRTIO_F_ADMIN_VQ);
> +
> +	if (features & BIT_ULL(VIRTIO_F_SUSPEND) && vp_supports_pm_no_reset(pci_dev))
> +		__virtio_set_bit(vdev, VIRTIO_F_SUSPEND);
>   }
>   
>   static int __vp_check_common_size_one_feature(struct virtio_device *vdev, u32 fbit,
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index b0201747a263..8e456b04114e 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -160,6 +160,8 @@ void virtio_config_changed(struct virtio_device *dev);
>   #ifdef CONFIG_PM_SLEEP
>   int virtio_device_freeze(struct virtio_device *dev);
>   int virtio_device_restore(struct virtio_device *dev);
> +int virtio_device_suspend(struct virtio_device *dev);
> +int virtio_device_resume(struct virtio_device *dev);
>   #endif
>   void virtio_reset_device(struct virtio_device *dev);
>   
> diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
> index 2445f365bce7..4a6e2c28ea76 100644
> --- a/include/uapi/linux/virtio_config.h
> +++ b/include/uapi/linux/virtio_config.h
> @@ -40,6 +40,8 @@
>   #define VIRTIO_CONFIG_S_DRIVER_OK	4
>   /* Driver has finished configuring features */
>   #define VIRTIO_CONFIG_S_FEATURES_OK	8
> +/* Driver has suspended the device */
> +#define VIRTIO_CONFIG_S_SUSPEND		0x10
>   /* Device entered invalid state, driver must reset it */
>   #define VIRTIO_CONFIG_S_NEEDS_RESET	0x40
>   /* We've given up on this device. */
> @@ -52,7 +54,7 @@
>    * rest are per-device feature bits.
>    */
>   #define VIRTIO_TRANSPORT_F_START	28
> -#define VIRTIO_TRANSPORT_F_END		42
> +#define VIRTIO_TRANSPORT_F_END		43
>   
>   #ifndef VIRTIO_CONFIG_NO_LEGACY
>   /* Do we get callbacks when the ring is completely used, even if we've
> @@ -120,4 +122,10 @@
>    */
>   #define VIRTIO_F_ADMIN_VQ		41
>   
> +/*
> + * This feature indicates that the driver can suspend the device via the
> + * suspend bit in the device status byte.
> + */
> +#define VIRTIO_F_SUSPEND		42
> +
>   #endif /* _UAPI_LINUX_VIRTIO_CONFIG_H */

