Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13966FBED
	for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710866624; cv=none; b=Ub2/pRqcGNtIimpwSNgcxY6+ohVyG3cI8l3CQLxCHHpz2PHkavzDbMB45+2PIUUQ2VV+smISLXfxm6AnGNkq98zr0nBJhbgtiluBJtHVrBxAKKaOMPIba6CKH101OxK6vegqTsaBdLU/qkujqnHD94xENPC6hipMCya51Z03+bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710866624; c=relaxed/simple;
	bh=h5M8YRjxyYd+FJy2W2rfd4t3yS965XiHimzzMJ8VV3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Xo+AwAhvYdH35rMvZ079sUhjCgqA0kdqd6cKdfaJFqRDqFm/yN5glC/5L1WfDxT7YQhATlG69fgHtvPSyVNw0JAE+9BcoEqKCD4lRHHkXyhvviJLms03j/22B6oUUoBV1B2yoOLjVOTBGGdkIhvSQItgVRjxfKqT+rIVJhBGZks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gOlf+4+I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gOlf+4+I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710866621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=puGCD0LbZ02Lmi0hswFeQWeOhlSNuUVskSzFQYO/KeM=;
	b=gOlf+4+IDtuA74ZW9Z00i2M6VAduI9YGuCp2p+fzC1UsUy9v/YfCzj0diuwlFdsJKpmudU
	6bmKme+yCNy1lMRdBcV7Z02Wi9n0/Q1h4PFpfnmei3ARO91UTXAmNHN3G2gajNW+IwP3TM
	BeHnBTbCMxYxpYiaotURGetShndEBug=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-zMUIb2GrMKGwzgolTp6Q1g-1; Tue, 19 Mar 2024 12:43:40 -0400
X-MC-Unique: zMUIb2GrMKGwzgolTp6Q1g-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3418f237c0bso230648f8f.3
        for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 09:43:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710866619; x=1711471419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puGCD0LbZ02Lmi0hswFeQWeOhlSNuUVskSzFQYO/KeM=;
        b=qxOIn/8Jde57Jd93E3ZckCpfsvBBi6s8CqzG0M/+2yXXthoQO00rV/JtQCExsKQHtj
         YYza+69TWa98pbojq8iwwNejD1avyvarRiTc9Hc/H+H0TCYvESabl+vGU96EI32ghRgJ
         ZNWKtGIhmbud4+NHvGW9ouMSqk80gqSYHvaUTmeUDq9YqMGDBSrhUfKNFYO6u5Kl+ibE
         jV1BFo6szQgRv8yBH0gsgVfdNpvVx/u4nYow9BA6a+AoIBSqU5p5BCVXeefLahcIN6F5
         nMg3ksgjAs7m/Qu4zoHL28iezfOvL0aJZM5g06dWUmrjKgT3/0RmmIhs/ACsWV+dRY1E
         6GrA==
X-Forwarded-Encrypted: i=1; AJvYcCU+E9OObEDzVa3oaOBI2PPnUW0yQ8KAhAJ3sniQJ0eseL52PXuAVm0djIdiMWY+XF5xQFDkHJxUugbx5yKvxeaRt5xHLqe12hnXlsCAg3s=
X-Gm-Message-State: AOJu0Ywxw7su8ueXmsuvx6i54dXRb7h8pgotYOoUHEgJk4XJwYXSdpwH
	XDA8p+7CyqSp8MMk3HFVho9vGlkcxpTydfm3/SvkpfBETHCFsvKT1rfs+BCrkQm6hfTWTvsnjBS
	OYMeGd6NXZvTR86+6rchyc9ewwqrhqhwWC9gydpijL1RFMRI/MDy2jfGJEr5j/PZy
X-Received: by 2002:a5d:518f:0:b0:33e:c522:a075 with SMTP id k15-20020a5d518f000000b0033ec522a075mr9912272wrv.48.1710866619359;
        Tue, 19 Mar 2024 09:43:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IER8FWBNLmoE6LXjYgRS+VQQPHPEhC/fkmn1s8Ph5pEkaGw88VXGdTDJ4cmVl5peFu5B24cvg==
X-Received: by 2002:a5d:518f:0:b0:33e:c522:a075 with SMTP id k15-20020a5d518f000000b0033ec522a075mr9912262wrv.48.1710866618747;
        Tue, 19 Mar 2024 09:43:38 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-33.business.telecomitalia.it. [87.12.25.33])
        by smtp.gmail.com with ESMTPSA id i9-20020a5d6309000000b0033e0dd83be1sm12546068wru.91.2024.03.19.09.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:43:38 -0700 (PDT)
Date: Tue, 19 Mar 2024 17:43:36 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Cc: jasowang@redhat.com, mst@redhat.com, virtualization@lists.linux.dev
Subject: Re: [PATCH 03/10] vDPA: report virtio-block block-size to user space
Message-ID: <st7y2zcnxmoq45i47qqc4lsn3dc7fxlkoyn3ap7gxnlqk2tam6@3p6fkmp6wwy6>
References: <20240218185606.13509-1-lingshan.zhu@intel.com>
 <20240218185606.13509-4-lingshan.zhu@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240218185606.13509-4-lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Feb 19, 2024 at 02:55:59AM +0800, Zhu Lingshan wrote:
>This commit allows reporting the block size of a
>virtio-block device to user space.
>
>Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>---
> drivers/vdpa/vdpa.c       | 18 ++++++++++++++++++
> include/uapi/linux/vdpa.h |  1 +
> 2 files changed, 19 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>index ee1472d32b0d..cc8f41d24c9c 100644
>--- a/drivers/vdpa/vdpa.c
>+++ b/drivers/vdpa/vdpa.c
>@@ -970,6 +970,21 @@ vdpa_dev_blk_seg_size_config_fill(struct sk_buff *msg, u64 features,
> 	return nla_put_u32(msg, VDPA_ATTR_DEV_BLK_CFG_SEG_SIZE, val_u32);
> }
>
>+/* fill the block size*/
>+static int
>+vdpa_dev_blk_block_size_config_fill(struct sk_buff *msg, u64 features,
>+				    const struct virtio_blk_config *config)
>+{
>+	u32 val_u32;
>+
>+	if ((features & BIT_ULL(VIRTIO_BLK_F_BLK_SIZE)) == 0)
>+		return 0;
>+
>+	val_u32 = __virtio32_to_cpu(true, config->blk_size);
>+
>+	return nla_put_u32(msg, VDPA_ATTR_DEV_BLK_CFG_BLK_SIZE, val_u32);
>+}
>+
> static int vdpa_dev_blk_config_fill(struct vdpa_device *vdev,
> 				    struct sk_buff *msg)
> {
>@@ -990,6 +1005,9 @@ static int vdpa_dev_blk_config_fill(struct vdpa_device *vdev,
> 	if (vdpa_dev_blk_seg_size_config_fill(msg, features_device, &config))
> 		return -EMSGSIZE;
>
>+	if (vdpa_dev_blk_block_size_config_fill(msg, features_device, &config))
>+		return -EMSGSIZE;
>+
> 	return 0;
> }
>
>diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
>index 586bce3c906a..f3baf7ea7d6d 100644
>--- a/include/uapi/linux/vdpa.h
>+++ b/include/uapi/linux/vdpa.h
>@@ -58,6 +58,7 @@ enum vdpa_attr {
>
> 	VDPA_ATTR_DEV_BLK_CFG_CAPACITY,		/* u64 */
> 	VDPA_ATTR_DEV_BLK_CFG_SEG_SIZE,		/* u32 */
>+	VDPA_ATTR_DEV_BLK_CFG_BLK_SIZE,		/* u32 */
>
> 	/* new attributes must be added above here */
> 	VDPA_ATTR_MAX,
>-- 
>2.39.3
>
>

