Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC3FE95A67
	for <virtualization@archiver.kernel.org>; Sun,  8 Oct 2023 08:48:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B61C840168;
	Sun,  8 Oct 2023 08:48:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B61C840168
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=im5XkS4U
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CrbXcUmVOV3k; Sun,  8 Oct 2023 08:48:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C520240104;
	Sun,  8 Oct 2023 08:48:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C520240104
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D4DBC0039;
	Sun,  8 Oct 2023 08:48:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C1DBC0032
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 08:48:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CDCD980B0B
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 08:48:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CDCD980B0B
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=im5XkS4U
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H9QDqkOC6XlW
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 08:48:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 89E6980ABF
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 08:48:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 89E6980ABF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696754911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p9Q3HgtrMOMozKnNBylbk7axYBbShwB/IF1EiK8QVwQ=;
 b=im5XkS4UeEKy5l0ArVW/5EJE3IWvPLbZe2cCgY6AhL7H5NG0ZPNuKValREdoUtqG+IkPpe
 vS6m4/SDC3a+1o0rhAMaVexl1jx7n6VR4KJwPBJ69lLBGRgREOQTz4+oS3b9+E/hf1xf0O
 u5dpe1jmp+BWuN/pgXW+P8FVkVM5cJU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-Tu2d0Lt_PFCMX88ypFElVA-1; Sun, 08 Oct 2023 04:48:29 -0400
X-MC-Unique: Tu2d0Lt_PFCMX88ypFElVA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9b98bbf130cso283859866b.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 08 Oct 2023 01:48:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696754908; x=1697359708;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p9Q3HgtrMOMozKnNBylbk7axYBbShwB/IF1EiK8QVwQ=;
 b=WWpucbzgWnzvx7rU0fCQdSIE29XJzqfFKcEAfuoDr731aNPdYaAmIgJeOSbMAUR/b2
 Bwzkpbk40kSU5q7rlX7KhXdK7c6TlRMcVHG3+RwHff1nouvwAjpqiBJlqg4FHH6mLetR
 reVpYa02wOvzAHLmLUmagznvV1DVYTCNsen8G23rxsliPPg96dqscj6QYBll86MLS6fR
 +jEZwea/gpbqLsoYR47UgxUJyd751D+LBSs+vyJmnFZBuqhkMqJvtpALWrOP3ZJxEKhQ
 bCiMyQtogawlZu4OcGekdd1NCqIr0MDr44cA1v0YlMiLvROiZNpnMIqpJdY261xwDz+b
 jFZg==
X-Gm-Message-State: AOJu0YxT4F313oMzXc9/bETAvuNL7IMn1JYQzeU4jaCHIHS3vVeYMoPR
 5+9+AN/FqoJ1ZaeQjofPl3rpbve9h8YV+76pTe0z669vhMKpASopOGyczHwTzCVGddc4KGgycJk
 ueWYh8AAtltd8z58rgGM96jFiMe8gWuArPtPNvQfKHw==
X-Received: by 2002:a17:906:224c:b0:9ae:3c2f:5a99 with SMTP id
 12-20020a170906224c00b009ae3c2f5a99mr12767674ejr.51.1696754908524; 
 Sun, 08 Oct 2023 01:48:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfMpYuRxtxemuBnklGcjw/ziYDUMU/G/l66eaBk29uKGrOts6Gb1krUbleJzWBlfIhF6GJ6w==
X-Received: by 2002:a17:906:224c:b0:9ae:3c2f:5a99 with SMTP id
 12-20020a170906224c00b009ae3c2f5a99mr12767667ejr.51.1696754908154; 
 Sun, 08 Oct 2023 01:48:28 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f6:d74e:e6b1:da81:860a:5e9e])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a170906468600b009a5f7fb51dcsm5221485ejr.42.2023.10.08.01.48.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Oct 2023 01:48:27 -0700 (PDT)
Date: Sun, 8 Oct 2023 04:48:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v1 1/2] virtio_pci: fix the common map size and add
 check for vq-reset
Message-ID: <20231008040612-mutt-send-email-mst@kernel.org>
References: <20231008074535.102871-1-xuanzhuo@linux.alibaba.com>
 <20231008074535.102871-2-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20231008074535.102871-2-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

On Sun, Oct 08, 2023 at 03:45:34PM +0800, Xuan Zhuo wrote:
> Now, the function vp_modern_map_capability() takes the size parameter,
> which corresponds to the size of virtio_pci_common_cfg. As a result,
> this indicates the size of memory area to map.
> 
> However, if the _F_RING_RESET is negotiated, the extra items will be
> used. Therefore, we need to use the size of virtio_pci_modre_common_cfg

typo

> to map more space.
> 
> Meanwhile, this patch checks the common cfg size when _F_RING_ERSET is
> negotiated.
> 

Fixes: tag please?

> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_pci_modern_dev.c | 27 ++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> index aad7d9296e77..45d41e6c7799 100644
> --- a/drivers/virtio/virtio_pci_modern_dev.c
> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  
>  #include <linux/virtio_pci_modern.h>
> +#include <linux/virtio_config.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/delay.h>
> @@ -142,6 +143,22 @@ static inline int virtio_pci_find_capability(struct pci_dev *dev, u8 cfg_type,
>  	return 0;
>  }
>  
> +static inline int check_common_size(struct virtio_pci_modern_device *mdev,
> +				     size_t common_len)
> +{
> +	u64 features;
> +
> +	features = vp_modern_get_features(mdev);

Better to combine this assignment into definition.
Or even better just drop the variable.

But more importantly this is called before DRIVER is set, right?
Not good then, this is a spec violation to read feature bits
before setting DRIVER:

The driver MUST follow this sequence to initialize a device:

\begin{enumerate}
\item Reset the device.

\item Set the ACKNOWLEDGE status bit: the guest OS has noticed the device.

\item Set the DRIVER status bit: the guest OS knows how to drive the device.

\item\label{itm:General Initialization And Device Operation /
Device Initialization / Read feature bits} Read device feature bits, and write the subset of feature bits
   understood by the OS and driver to the device.  During this step the
   driver MAY read (but MUST NOT write) the device-specific configuration fields to check that it can support the device before accepting it.


I guess we can add common_len alongside notify_len and device_len?

I think would also prefer to just clear VIRTIO_F_RING_RESET and not
fail probe.




> +
> +	if (features & BIT_ULL(VIRTIO_F_RING_RESET)) {
> +		if (unlikely(common_len < offsetofend(struct virtio_pci_modern_common_cfg,
> +						      queue_reset)))
> +			return -ENOENT;

Why ENOENT?


Also as long as you are doing this, please give the same
treatment to VIRTIO_F_NOTIFICATION_DATA.

> +	}
> +
> +	return 0;
> +}
> +
>  /* This is part of the ABI.  Don't screw with it. */
>  static inline void check_offsets(void)
>  {
> @@ -218,6 +235,7 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
>  	int err, common, isr, notify, device;
>  	u32 notify_length;
>  	u32 notify_offset;
> +	size_t common_len;
>  	int devid;
>  
>  	check_offsets();
> @@ -291,10 +309,14 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
>  	err = -EINVAL;
>  	mdev->common = vp_modern_map_capability(mdev, common,
>  				      sizeof(struct virtio_pci_common_cfg), 4,
> -				      0, sizeof(struct virtio_pci_common_cfg),
> -				      NULL, NULL);
> +				      0, sizeof(struct virtio_pci_modern_common_cfg),
> +				      &common_len, NULL);
>  	if (!mdev->common)
>  		goto err_map_common;
> +
> +	if (check_common_size(mdev, common_len))
> +		goto err_common_size;
> +
>  	mdev->isr = vp_modern_map_capability(mdev, isr, sizeof(u8), 1,
>  					     0, 1,
>  					     NULL, NULL);
> @@ -353,6 +375,7 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
>  err_map_notify:
>  	pci_iounmap(pci_dev, mdev->isr);
>  err_map_isr:
> +err_common_size:
>  	pci_iounmap(pci_dev, mdev->common);
>  err_map_common:
>  	pci_release_selected_regions(pci_dev, mdev->modern_bars);
> -- 
> 2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
