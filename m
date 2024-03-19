Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEA7D29E
	for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 16:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710866600; cv=none; b=YUrXxmNgqRwCcPzwgEvKikAATyy2KV7DgH4hGbdRNJAsRkw/MJ4bOULnaCH2s0gmigRMCYactIwRmCQ7j5hR1P+P67ebser6gbkul9MmUORqDEEwZhmaY1ioKXUOYzCy21Nc0uGljkwFMuJDYgneU4RnBsYvRSU0BbyUtUdWvlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710866600; c=relaxed/simple;
	bh=5Ik8Oq/XmT4BZrpFOSM7w8G+1KyMEazFVlhQS1Sv7bE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hvhsr6R1+/I/aHgbesHPMzi82XCInFB+nh8Xlv8pcatOaIQnPiSGALauswqkta4mXoQ6tpQ89uhVS+dfKhPLhcL8btoXLIErKnc6wb34b2XHqonhkZpnWMHlKAtbqQwUT9Qim3Io1Nh0qX9da2FrZklyOZmlcO3CYSoXtybjSVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TsY2JGrw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TsY2JGrw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710866597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TeOG6jhBH+atpXRPlRVYJCafcb+FIQR53wUPdAxbbmY=;
	b=TsY2JGrwLEc1/abd+tefzG1rndtMZ6ZkvORTNE3Z8ZIJgaaHlNn+gND7n3yujyVpwRby0i
	b4RuGzXU4RW6o+T4SbpiurhzGkFuTcd5DvHBsiWmZzEQjBRI0TXconcDK4JYtGHfCI91H3
	3Y7Co370c5tn4RVUgKwgmwWOnwpohKM=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-yGp5p6M-PY-izj_27H4jfA-1; Tue, 19 Mar 2024 12:43:16 -0400
X-MC-Unique: yGp5p6M-PY-izj_27H4jfA-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-513340d10ccso5040817e87.2
        for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 09:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710866595; x=1711471395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TeOG6jhBH+atpXRPlRVYJCafcb+FIQR53wUPdAxbbmY=;
        b=V4IotpS6ftnE0HLaHDrXdZqIuK9OPLb+oJGUEFOuLHentavNneF9Fv9HFX5/6pXU1N
         7As7qbnAImch6uxZCAXfrxSLy2i2LTbHeL6d6GMN5danm85YKsixFoJaYAcwMj98fDKy
         a4YTfzfgbjS4fy+RnbHKMtYiUxDg4eyffqJfkESiZqBpe5xqZl6jO/0nnMlgRQ4vhr1Y
         J9Rg2Zhoq1+joECERoZ5oUaAMRt4HhtEKjrGzcqqYmwQF7YZ8oZt0l+AS6RhfgvFrVwn
         ILlQkmfmu8nfzMajB+8msb2Z8REYNcW3y7evzgqLGP6oli/DLaCQ2oMHT9ETWD8oSoj3
         QbZA==
X-Forwarded-Encrypted: i=1; AJvYcCUM8ZiVU0iNsgRG+8K19ueJqmBko5zYyBULvupxiht50wtL2aYyZ48flD8AQ7kEwTJ2pUKXzsqHjKLlUYcces1/yAG1o4btKJFkNugldxI=
X-Gm-Message-State: AOJu0YwARI7ZfkTpKbLSI5EPKBlrPnxsOmFD8ZsccvEFrDWnAZoCxCRh
	rrAsstB9u4/JXi3jZMwnRYzBZnq4RF4NBeTsY/BLSz0jH6Zs11FO6J9l+yu7qykYD2F/N6+eoUr
	2D75ruMAh40asdIyos/GbMtaFe7gfgToq4aKKuTrdor9dl717Mbx+WrdCutsB0RjW
X-Received: by 2002:a19:3810:0:b0:513:96ff:a04a with SMTP id f16-20020a193810000000b0051396ffa04amr9035524lfa.43.1710866594891;
        Tue, 19 Mar 2024 09:43:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHm8bFDuvhHtlW3G3nKjslw8Z06/VpsfIr3bsr0TCgnw3vrSrIDbFWpEn9i5pTFbWO+DoqemA==
X-Received: by 2002:a19:3810:0:b0:513:96ff:a04a with SMTP id f16-20020a193810000000b0051396ffa04amr9035474lfa.43.1710866592645;
        Tue, 19 Mar 2024 09:43:12 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-33.business.telecomitalia.it. [87.12.25.33])
        by smtp.gmail.com with ESMTPSA id w16-20020adfcd10000000b0033e5c54d0d9sm12790637wrm.38.2024.03.19.09.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:43:12 -0700 (PDT)
Date: Tue, 19 Mar 2024 17:43:10 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Cc: jasowang@redhat.com, mst@redhat.com, virtualization@lists.linux.dev
Subject: Re: [PATCH 01/10] vDPA: report virtio-block capacity to user space
Message-ID: <eq3xsuxspqb4szwwk3iogtxdggs4kl5nnirwajua7p6yyr262f@dz6czkmicvgm>
References: <20240218185606.13509-1-lingshan.zhu@intel.com>
 <20240218185606.13509-2-lingshan.zhu@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240218185606.13509-2-lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Feb 19, 2024 at 02:55:57AM +0800, Zhu Lingshan wrote:
>This commit allows userspace to query capacity of
>a virtio-block device.
>
>Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>---
> drivers/vdpa/vdpa.c       | 35 +++++++++++++++++++++++++++++++++++
> include/linux/vdpa.h      |  1 +
> include/uapi/linux/vdpa.h |  2 ++
> 3 files changed, 38 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>index d0695680b282..d5ccb618de2b 100644
>--- a/drivers/vdpa/vdpa.c
>+++ b/drivers/vdpa/vdpa.c
>@@ -944,6 +944,38 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
> 	return vdpa_dev_net_mq_config_fill(msg, features_device, &config);
> }
>
>+static int
>+vdpa_dev_blk_capacity_config_fill(struct sk_buff *msg,
>+				  const struct virtio_blk_config *config)
>+{
>+	u64 val_u64;
>+
>+	val_u64 = __virtio64_to_cpu(true, config->capacity);
>+
>+	return nla_put_u64_64bit(msg, VDPA_ATTR_DEV_BLK_CFG_CAPACITY,
>+				 val_u64, VDPA_ATTR_PAD);
>+}
>+
>+static int vdpa_dev_blk_config_fill(struct vdpa_device *vdev,
>+				    struct sk_buff *msg)
>+{
>+	struct virtio_blk_config config = {};
>+	u64 features_device;
>+
>+	vdev->config->get_config(vdev, 0, &config, sizeof(config));
>+
>+	features_device = vdev->config->get_device_features(vdev);
>+
>+	if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_FEATURES, features_device,
>+			      VDPA_ATTR_PAD))
>+		return -EMSGSIZE;
>+
>+	if (vdpa_dev_blk_capacity_config_fill(msg, &config))
>+		return -EMSGSIZE;
>+
>+	return 0;
>+}
>+
> static int
> vdpa_dev_config_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq,
> 		     int flags, struct netlink_ext_ack *extack)
>@@ -988,6 +1020,9 @@ vdpa_dev_config_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid,
> 	case VIRTIO_ID_NET:
> 		err = vdpa_dev_net_config_fill(vdev, msg);
> 		break;
>+	case VIRTIO_ID_BLOCK:
>+		err = vdpa_dev_blk_config_fill(vdev, msg);
>+		break;
> 	default:
> 		err = -EOPNOTSUPP;
> 		break;
>diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>index db15ac07f8a6..a184aa6538cb 100644
>--- a/include/linux/vdpa.h
>+++ b/include/linux/vdpa.h
>@@ -7,6 +7,7 @@
> #include <linux/interrupt.h>
> #include <linux/vhost_iotlb.h>
> #include <linux/virtio_net.h>
>+#include <linux/virtio_blk.h>
> #include <linux/if_ether.h>
>
> /**
>diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
>index 54b649ab0f22..1bf69226cb96 100644
>--- a/include/uapi/linux/vdpa.h
>+++ b/include/uapi/linux/vdpa.h
>@@ -56,6 +56,8 @@ enum vdpa_attr {
> 	/* virtio features that are provisioned to the vDPA device */
> 	VDPA_ATTR_DEV_FEATURES,                 /* u64 */
>
>+	VDPA_ATTR_DEV_BLK_CFG_CAPACITY,		/* u64 */
>+
> 	/* new attributes must be added above here */
> 	VDPA_ATTR_MAX,
> };
>-- 
>2.39.3
>
>

