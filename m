Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DC25915E
	for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 16:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864305; cv=none; b=QQHiBw8dtkdy+QQZN2Zquc1EevxUy/JbZ/Vx27kO0pV08sAqm2QzCtngqAi7gFbOmalSPcJVbQzjUg6ROTN70IkbAh7Jpvr4UTTO8c8rJ+NMXNMkyWOHYFDSOBBAf38G089jA0LbMEUpvggjG6axnZS7OF2OsLMCP5fsJ3ISv7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864305; c=relaxed/simple;
	bh=wd2kotEU4+NV46zBwHOnAc6q+O57rHDgbCGcnVkk5As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=fMJLuVMktzVRvFsyAwG8s8VKZ/9vQXbYjEEgXOECMK9O7TFBAh8SivSxUeStEm2nZJXmCC/Eyv2/M0w92b1e1/xZ7YGvEJUeW+RuwHyF3yDoFoHXI0Co1ct4WW+Ajzz0pC9Dycbf7pk/StbHcW16faNkpQSKVAMHeyvGiZ3il30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bmEfqL0f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bmEfqL0f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710864301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=15s/C56ODRym9kta7gLOhHOx5AT1fdwfDUQsPKBzp58=;
	b=bmEfqL0fDi3lFX+WLRWKwmLQhc4pWez4dA1MIH7lPaEReK/j3u/5UCCZ/w/ncA3nFd/K9E
	xQnYuOrc3GKiWIb5sHiZrmIbVY1i/RZV16n/Dm3XVg4cp2AzQX7K0uyq4VySA11a4ddz7l
	5WvHahNsgm/sGnQhFksZ3M0OXflUIIA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-Z5F0eoffNHCETPKAqa47ZQ-1; Tue, 19 Mar 2024 12:04:59 -0400
X-MC-Unique: Z5F0eoffNHCETPKAqa47ZQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40e4478a3afso30565455e9.1
        for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 09:04:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710864298; x=1711469098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15s/C56ODRym9kta7gLOhHOx5AT1fdwfDUQsPKBzp58=;
        b=sElw0Pfhvuom4t0klv4PNTF2fTYEu63h+E7vvkt+GKhB5Z/a6CPbNBwwOnQsqYUJwN
         laY0qLTsEvPAW8PT5ea+cLlC14SJerdq/zNgQMWO1MHrVRtFy/3iWQ9uPtEaIhwmC/Dg
         VHJPrdOWk+Jtr9s0/R4L00mjD8qG/Ffa4KtEWeZW2hWJ1yzq0M+WWVk9kFBOKigWvZQF
         /kq/siqPUVeNEEZYiYejwe+cPjm6tSQbonV22FIf+QLvFexc+5gfO3bIPKyk7W5Y2UPU
         BJiwq93IWeZSP/QxiBP52yI1hCVxNf4Ln8PTsQnTcjJtnzKDk8s39PhpULFwb/za0kXk
         hpxw==
X-Forwarded-Encrypted: i=1; AJvYcCUo9tpsczirxhx1pBNv4hv2hwPnuVDdo2BZzQJLDheVa9fkUoOA8Rn3tdXTZwjWHdwmhRxKCGyTtBdgxfl7RExNVWwvdqwfp6DJytKKv4E=
X-Gm-Message-State: AOJu0YxxlxF+Cj5ggKv5nMClhV4JVcDti5BgmSFg+6sQoI1n08vJSQsc
	eip2UWzCr/ldIigPe88qHV58tuXjE6NvHqQweJxS0tqLDKZBcLEr3VfnBG3mV9KZCuMLVn8uq6X
	HycuOmKMrUvRJxllvpFM8xvbbWPF0s/yb+wXKMkkKSV17cGaafhY/WnJFZ8h2WyYM
X-Received: by 2002:a05:600c:3549:b0:412:e8f5:c368 with SMTP id i9-20020a05600c354900b00412e8f5c368mr2972241wmq.8.1710864298153;
        Tue, 19 Mar 2024 09:04:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGy9AQxl/PxRcdKYu42VuFZ9eAfvxR4sdCSilJk4srz+SscCAOc540dUoBEKrGBWv/KtOU12g==
X-Received: by 2002:a05:600c:3549:b0:412:e8f5:c368 with SMTP id i9-20020a05600c354900b00412e8f5c368mr2972211wmq.8.1710864297831;
        Tue, 19 Mar 2024 09:04:57 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-33.business.telecomitalia.it. [87.12.25.33])
        by smtp.gmail.com with ESMTPSA id p22-20020a05600c359600b0041404f017easm12902033wmq.0.2024.03.19.09.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:04:57 -0700 (PDT)
Date: Tue, 19 Mar 2024 17:04:52 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Cc: jasowang@redhat.com, mst@redhat.com, virtualization@lists.linux.dev
Subject: Re: [PATCH 02/10] vDPA: report virtio-block max segment size to user
 space
Message-ID: <etmgf3zcsnuz5hoj26g2nr7qunc7dxqg5p5hb43oe2mefkgyk5@4dofowgn4vcy>
References: <20240218185606.13509-1-lingshan.zhu@intel.com>
 <20240218185606.13509-3-lingshan.zhu@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240218185606.13509-3-lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Feb 19, 2024 at 02:55:58AM +0800, Zhu Lingshan wrote:
>This commit allows reporting the max size of any
>single segment of virtio-block devices to user space.
>
>Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>---
> drivers/vdpa/vdpa.c       | 17 +++++++++++++++++
> include/uapi/linux/vdpa.h |  1 +
> 2 files changed, 18 insertions(+)
>
>diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>index d5ccb618de2b..ee1472d32b0d 100644
>--- a/drivers/vdpa/vdpa.c
>+++ b/drivers/vdpa/vdpa.c
>@@ -956,6 +956,20 @@ vdpa_dev_blk_capacity_config_fill(struct sk_buff *msg,
> 				 val_u64, VDPA_ATTR_PAD);
> }
>
>+static int
>+vdpa_dev_blk_seg_size_config_fill(struct sk_buff *msg, u64 features,
>+				  const struct virtio_blk_config *config)
>+{
>+	u32 val_u32;
>+
>+	if ((features & BIT_ULL(VIRTIO_BLK_F_SIZE_MAX)) == 0)
>+		return 0;
>+
>+	val_u32 = __virtio32_to_cpu(true, config->size_max);
>+
>+	return nla_put_u32(msg, VDPA_ATTR_DEV_BLK_CFG_SEG_SIZE, val_u32);

Should we call this VDPA_ATTR_DEV_BLK_CFG_SIZE_MAX ?

>+}
>+
> static int vdpa_dev_blk_config_fill(struct vdpa_device *vdev,
> 				    struct sk_buff *msg)
> {
>@@ -973,6 +987,9 @@ static int vdpa_dev_blk_config_fill(struct vdpa_device *vdev,
> 	if (vdpa_dev_blk_capacity_config_fill(msg, &config))
> 		return -EMSGSIZE;
>
>+	if (vdpa_dev_blk_seg_size_config_fill(msg, features_device, &config))
>+		return -EMSGSIZE;
>+
> 	return 0;
> }
>
>diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
>index 1bf69226cb96..586bce3c906a 100644
>--- a/include/uapi/linux/vdpa.h
>+++ b/include/uapi/linux/vdpa.h
>@@ -57,6 +57,7 @@ enum vdpa_attr {
> 	VDPA_ATTR_DEV_FEATURES,                 /* u64 */
>
> 	VDPA_ATTR_DEV_BLK_CFG_CAPACITY,		/* u64 */
>+	VDPA_ATTR_DEV_BLK_CFG_SEG_SIZE,		/* u32 */
>
> 	/* new attributes must be added above here */
> 	VDPA_ATTR_MAX,
>-- 
>2.39.3
>
>

