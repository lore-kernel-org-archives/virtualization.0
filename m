Return-Path: <SRS0=LSNt=OE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31788C4332F
	for <virtualization@archiver.kernel.org>; Tue, 14 Sep 2021 12:58:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D244E610D1
	for <virtualization@archiver.kernel.org>; Tue, 14 Sep 2021 12:58:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D244E610D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9B8AB80F65;
	Tue, 14 Sep 2021 12:58:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2dPMAf8KXpg6; Tue, 14 Sep 2021 12:58:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2247F80C62;
	Tue, 14 Sep 2021 12:58:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08B2BC000F;
	Tue, 14 Sep 2021 12:58:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 547CAC000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 12:58:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3D72E607DA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 12:58:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id liRvgi7eiyrb
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 12:58:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CB0CD607D3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 12:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631624314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+i8tXrYj4yDnCoPDe/Tv3/7/5YA9BMLPa/F1k7LioJM=;
 b=EMTRTFVfIvGlHQ404ZTrJT6w8JHsyOGWPXbrZ4ci4RBDzd1vCRQ65jhoDY3Z6F3Gn8Ro18
 A/qDYt33ykXW5B9UWzWu7Z+SviVLnfxB4sAoSCMuuKufYjrJ4gAQKK1pbm8v1mi69aT2ij
 4nJhRzzj+0cTmRJJ+LpIltH/hNfDQHI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-Gfj3NfqJO-mubayqrF_VJw-1; Tue, 14 Sep 2021 08:58:33 -0400
X-MC-Unique: Gfj3NfqJO-mubayqrF_VJw-1
Received: by mail-wr1-f70.google.com with SMTP id
 r7-20020a5d6947000000b0015e0f68a63bso1726945wrw.22
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 05:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+i8tXrYj4yDnCoPDe/Tv3/7/5YA9BMLPa/F1k7LioJM=;
 b=bNj8ylVDcisSvb7qTLNm0Av5gsP9uc31HCjYSBXuexXhv5uIDumCPtr2zyKWk81FGy
 iJ7oB4dc8B3/TtHlgwo/o3AUa55pr6SsgCX/OJPy/YEpLDRW3IutfZLYpuQDUosxi4Rn
 8EJyrEzRPP1P4z0tGY2GJiopE4fV7dgtgkhz2MbC/FUw5J72aKKMXUwgyrPDci/MiuGy
 pnti7OIz9t8P2HuR8TRjV9rfsPZ/X//1hryMY4PPjYQWU/06mYbbXtdVB5u0zL6rX2DT
 0ToBeyzuF0m6pcCcW5fny4r/MLGU9wDXWA1eIBeN80HD0lirOHl3U1nY6B8uV1+SuaSf
 J3cw==
X-Gm-Message-State: AOAM533QAPsdxnqXLJWk3NCtXFI9r+OZ+WVwrC5GZFb075PlRd2r2iy+
 8A08LpClSkIboqUOGbpdJ5gRD3KWGGvx0DqdDnTqZMzt4CO+vqHuhHUbmFmTC4swRAFH3BSt5jA
 4cXnSGehiv3XFQqzbwW9Ya5Edw/6u7V1gYYiGF8FpvA==
X-Received: by 2002:a1c:cc03:: with SMTP id h3mr2044630wmb.73.1631624312218;
 Tue, 14 Sep 2021 05:58:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHtbUQhdNaZzLMjWktMr/Fa0pUFCfp6kfBfoBbJYkI/xrFMVITu+svlOkLkMY+p+sXXK31Tw==
X-Received: by 2002:a1c:cc03:: with SMTP id h3mr2044619wmb.73.1631624312047;
 Tue, 14 Sep 2021 05:58:32 -0700 (PDT)
Received: from redhat.com ([2.55.151.134])
 by smtp.gmail.com with ESMTPSA id c9sm11063685wrf.77.2021.09.14.05.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Sep 2021 05:58:31 -0700 (PDT)
Date: Tue, 14 Sep 2021 08:58:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Wu Zongyong <wuzongyong@linux.alibaba.com>
Subject: Re: [PATCH v2 4/5] vdpa: add new vdpa attribute
 VDPA_ATTR_DEV_F_VERSION_1
Message-ID: <20210914085711-mutt-send-email-mst@kernel.org>
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
 <cover.1631621507.git.wuzongyong@linux.alibaba.com>
 <834528d24c839080215b2e077f100e9ed5073edc.1631621507.git.wuzongyong@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <834528d24c839080215b2e077f100e9ed5073edc.1631621507.git.wuzongyong@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: wei.yang1@linux.alibaba.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On Tue, Sep 14, 2021 at 08:24:51PM +0800, Wu Zongyong wrote:
> This new attribute advertises whether the vdpa device is legacy or not.
> Users can pick right virtqueue size if the vdpa device is legacy which
> doesn't support to change virtqueue size.
> 
> Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>

So if we are bothering with legacy, I think there are
several things to do when building the interface
- support transitional devices, that is allow userspace
  to tell device it's in legacy mode
- support reporting/setting supporting endian-ness

> ---
>  drivers/vdpa/vdpa.c          | 6 ++++++
>  drivers/virtio/virtio_vdpa.c | 7 ++++++-
>  include/uapi/linux/vdpa.h    | 1 +
>  3 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 1dc121a07a93..533d7f589eee 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -12,6 +12,7 @@
>  #include <linux/slab.h>
>  #include <linux/vdpa.h>
>  #include <uapi/linux/vdpa.h>
> +#include <uapi/linux/virtio_config.h>
>  #include <net/genetlink.h>
>  #include <linux/mod_devicetable.h>
>  
> @@ -494,6 +495,7 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
>  	u16 max_vq_size;
>  	u32 device_id;
>  	u32 vendor_id;
> +	u64 features;
>  	void *hdr;
>  	int err;
>  
> @@ -508,6 +510,7 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
>  	device_id = vdev->config->get_device_id(vdev);
>  	vendor_id = vdev->config->get_vendor_id(vdev);
>  	max_vq_size = vdev->config->get_vq_num_max(vdev);
> +	features = vdev->config->get_features(vdev);
>  
>  	err = -EMSGSIZE;
>  	if (nla_put_string(msg, VDPA_ATTR_DEV_NAME, dev_name(&vdev->dev)))
> @@ -520,6 +523,9 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
>  		goto msg_err;
>  	if (nla_put_u16(msg, VDPA_ATTR_DEV_MAX_VQ_SIZE, max_vq_size))
>  		goto msg_err;
> +	if (features & BIT_ULL(VIRTIO_F_VERSION_1) &&
> +	    nla_put_flag(msg, VDPA_ATTR_DEV_VERSION_1))
> +		goto msg_err;
>  
>  	genlmsg_end(msg, hdr);
>  	return 0;
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index 72eaef2caeb1..1cba957c4cdc 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -7,6 +7,7 @@
>   *
>   */
>  
> +#include "linux/virtio_config.h"
>  #include <linux/init.h>
>  #include <linux/module.h>
>  #include <linux/device.h>
> @@ -145,6 +146,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
>  	/* Assume split virtqueue, switch to packed if necessary */
>  	struct vdpa_vq_state state = {0};
>  	unsigned long flags;
> +	bool may_reduce_num = false;
>  	u32 align, num;
>  	int err;
>  
> @@ -169,10 +171,13 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
>  		goto error_new_virtqueue;
>  	}
>  
> +	if (ops->get_features(vdpa) & BIT_ULL(VIRTIO_F_VERSION_1))
> +		may_reduce_num = true;
> +
>  	/* Create the vring */
>  	align = ops->get_vq_align(vdpa);
>  	vq = vring_create_virtqueue(index, num, align, vdev,
> -				    true, true, ctx,
> +				    true, may_reduce_num, ctx,
>  				    virtio_vdpa_notify, callback, name);
>  	if (!vq) {
>  		err = -ENOMEM;
> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> index 66a41e4ec163..ce0b74276a5b 100644
> --- a/include/uapi/linux/vdpa.h
> +++ b/include/uapi/linux/vdpa.h
> @@ -32,6 +32,7 @@ enum vdpa_attr {
>  	VDPA_ATTR_DEV_VENDOR_ID,		/* u32 */
>  	VDPA_ATTR_DEV_MAX_VQS,			/* u32 */
>  	VDPA_ATTR_DEV_MAX_VQ_SIZE,		/* u16 */
> +	VDPA_ATTR_DEV_VERSION_1,		/* flag */
>  
>  	/* new attributes must be added above here */
>  	VDPA_ATTR_MAX,
> -- 
> 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
