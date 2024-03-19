Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5CDF9E4
	for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 16:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710866645; cv=none; b=lYyIMYKeOksk7LVMEfPHBO1k1cqIi0f/9WG0mI7DUS/bPq6tdEo707wPGTbpAw1B8Xhs+RJSndJGJkOur5xBOdY2i3g9QyE2nB+HmpDNFE6oBbRDFA75tzlANTtd4F/WCt3Ng7fZsoi8qyNN1HFAMzxdHTAuERJGCg69qnUK/eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710866645; c=relaxed/simple;
	bh=79WTgplI2tuiTAhnPDrwvZeW3HgT2XLHEgikAYJD4KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kkUfcJ2Y3YznZk8EhumzPtXuvhL1r2dK2EazKRp4NgK6Bf57xPHuPksH2gafiEmg3geDx8w15soxfbXOFf7gy7HnVAJ+KzcUwRtSUnGrGKaDziEp1DOOD3/Li5gzmSAyi0nHACe+QLd+V4OTwwRuB+Fl3jXXUHCSP57YwZkd7jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fQTN/hlL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fQTN/hlL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710866642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rwtruWOSXfzr4TFYjfBsSh6GEsS1US5e+YE2gGsnPmc=;
	b=fQTN/hlLmGjdvpq4ChoX2defJUzZ5lcddxqGnPSMuTOeTOuiYhzwdE+F7mtljMug6y5629
	PU30ikr+H1W+Zip+ieUtWXnIz5Q1qVAwg8S4lsI3Xe28ZuHUyNJiQ3j+0TxKFR2ahieTVs
	ISA++S/ulZVut+gPIneDKsG9/5D6bYw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-usGbieNLNgyQlwMg8Kwq-A-1; Tue, 19 Mar 2024 12:44:01 -0400
X-MC-Unique: usGbieNLNgyQlwMg8Kwq-A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4140a47f514so17022765e9.0
        for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 09:44:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710866640; x=1711471440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwtruWOSXfzr4TFYjfBsSh6GEsS1US5e+YE2gGsnPmc=;
        b=Af69mUCBNudfN49BNjoqjdZX7eMfr+h1xWSbKG7bUaQVzqASgXpbCips8RndRgS1Zb
         X6cbEo6skgONzNXGAKwrbPChvPlXw5XyaQAmKLc8zt1xt8eRd/zmCLXABqLY2+TkLEaQ
         s3Hfxg98Gsheinrxdiu8dYdK6goq/HN5rJljFXQ9webOmJkNP70CPISbxjPuUk7SVrOe
         oPP1QQX7m2hYPG+4rxajJhvcEX+1jqq0HTYpFEiUaa629BAvuxbddtsBIpPZdIXkGzoE
         JpnDy0UstwNdbkpP54+wpeASTLAblJsO6/ebJRSiiCuetjDRo6yluebjnLtImN6Dsub6
         qg8A==
X-Forwarded-Encrypted: i=1; AJvYcCXL3WVn2jI6R+R6fTJERkDp6pxqjS07txQGi2FH/iQIIlBRJi2EDtRWOIpI28Cv9S0rEmn5+xaKSogK0J+XIjoPx/IfcPixSKFafqVEsn0=
X-Gm-Message-State: AOJu0Yy86Tlgwre87vq2ahr3cAdbptgaRfpkHIKs12nTsLiqd8eKRIOZ
	hwaAuZbnLwsKU0297bEZ4q1r+jBg2I6WlJ6MqTWiqnvxpa/FDCV+5meRf0ODRiI9J96reWBvh47
	a7JRBJwGLkv8B1GY9VU7i4dXUDf0U3qcF++b4wghNA49yNXbHE0CyUni1Tl+8rRDy
X-Received: by 2002:a05:600c:444f:b0:414:a6d:52d8 with SMTP id v15-20020a05600c444f00b004140a6d52d8mr6494769wmn.17.1710866639933;
        Tue, 19 Mar 2024 09:43:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEv/ZMPBMMqrMqBBK1xYXWdP9JppIf+sFTnhatFL8FaL7gUAa0NXBYDRWptNF1cLK6z9XboSw==
X-Received: by 2002:a05:600c:444f:b0:414:a6d:52d8 with SMTP id v15-20020a05600c444f00b004140a6d52d8mr6494755wmn.17.1710866639619;
        Tue, 19 Mar 2024 09:43:59 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-33.business.telecomitalia.it. [87.12.25.33])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c1d8c00b004146895086esm1164248wms.8.2024.03.19.09.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:43:59 -0700 (PDT)
Date: Tue, 19 Mar 2024 17:43:57 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Cc: jasowang@redhat.com, mst@redhat.com, virtualization@lists.linux.dev
Subject: Re: [PATCH 04/10] vDPA: report virtio-block max segments in a
 request to user space
Message-ID: <msb34qftopn35qfhbqpslghzc4rbm6fb5sxyd7wwn2rpmsqxfc@gwiozq52trvn>
References: <20240218185606.13509-1-lingshan.zhu@intel.com>
 <20240218185606.13509-5-lingshan.zhu@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240218185606.13509-5-lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Feb 19, 2024 at 02:56:00AM +0800, Zhu Lingshan wrote:
>This commit allows vDPA reporting the maximum number of
>segments in a request of virtio-block devices to
>user space.
>
>Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>---
> drivers/vdpa/vdpa.c       | 17 +++++++++++++++++
> include/uapi/linux/vdpa.h |  1 +
> 2 files changed, 18 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>index cc8f41d24c9c..8d00e9976aba 100644
>--- a/drivers/vdpa/vdpa.c
>+++ b/drivers/vdpa/vdpa.c
>@@ -985,6 +985,20 @@ vdpa_dev_blk_block_size_config_fill(struct sk_buff *msg, u64 features,
> 	return nla_put_u32(msg, VDPA_ATTR_DEV_BLK_CFG_BLK_SIZE, val_u32);
> }
>
>+static int
>+vdpa_dev_blk_seg_max_config_fill(struct sk_buff *msg, u64 features,
>+				 const struct virtio_blk_config *config)
>+{
>+	u32 val_u32;
>+
>+	if ((features & BIT_ULL(VIRTIO_BLK_F_SEG_MAX)) == 0)
>+		return 0;
>+
>+	val_u32 = __virtio32_to_cpu(true, config->seg_max);
>+
>+	return nla_put_u32(msg, VDPA_ATTR_DEV_BLK_CFG_SEG_MAX, val_u32);
>+}
>+
> static int vdpa_dev_blk_config_fill(struct vdpa_device *vdev,
> 				    struct sk_buff *msg)
> {
>@@ -1008,6 +1022,9 @@ static int vdpa_dev_blk_config_fill(struct vdpa_device *vdev,
> 	if (vdpa_dev_blk_block_size_config_fill(msg, features_device, &config))
> 		return -EMSGSIZE;
>
>+	if (vdpa_dev_blk_seg_max_config_fill(msg, features_device, &config))
>+		return -EMSGSIZE;
>+
> 	return 0;
> }
>
>diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
>index f3baf7ea7d6d..2dc92fca2052 100644
>--- a/include/uapi/linux/vdpa.h
>+++ b/include/uapi/linux/vdpa.h
>@@ -59,6 +59,7 @@ enum vdpa_attr {
> 	VDPA_ATTR_DEV_BLK_CFG_CAPACITY,		/* u64 */
> 	VDPA_ATTR_DEV_BLK_CFG_SEG_SIZE,		/* u32 */
> 	VDPA_ATTR_DEV_BLK_CFG_BLK_SIZE,		/* u32 */
>+	VDPA_ATTR_DEV_BLK_CFG_SEG_MAX,		/* u32 */
>
> 	/* new attributes must be added above here */
> 	VDPA_ATTR_MAX,
>-- 
>2.39.3
>
>

