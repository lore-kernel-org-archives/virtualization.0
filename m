Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ACCC120
	for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 16:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710866459; cv=none; b=dNaA6ZkXu/y3WYFiIV9z77T6A/IR4YbrEi3IZeHZi7U2GapF8FhMvgxMJxjhGBPlrKdt/qZxguPN2hLeUCda8jq2dvdKLl491mLUHMDaQoFUz8AK+GHEZqmH+JVCIUMAfs2UooKk8U2hqrl+BNcknLShFnoD4JvoKzqKsnq+SZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710866459; c=relaxed/simple;
	bh=tIXEPN2LUIuP/hXhVKBEKksUEmxcYz81cjweFruToyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=F/7CV4xKgTET23FBFTy7QZbIVthxHHWoq1oTqDMp487kmykdEIM8y64tQeQmAvfa/B3QT3zqtgp7tkL1gglHmD47wf6QV0pKNdpNVGL0cEXZSN0p24+aOFMGHCytYABJIHNWvIDVCdZM/nDNnw3oBjp3MbnhNaBAqbV3Zkc1JQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=byT3vBbU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="byT3vBbU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710866456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5XYRz6qJSWvfyLY7dgxRC6OaT6prmOYBhKAWkcUO2NM=;
	b=byT3vBbUl4osDaVYVFNZvtUoHOz4WhY6RxzfLRpmQWb7nNGrgTTKDW1dle2pTLoVfjNvu1
	RYciO7dOEa2PZWWALl+eW7eimBLVN8J7hfGyQoupyTt3cfHFoDT892jH9Vahef/JJ0YBvB
	CkLWjgaZf1siUi9k9kG3ntTA0fYz+hE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-1AryBSfzO4S35zP4G677ew-1; Tue, 19 Mar 2024 12:40:54 -0400
X-MC-Unique: 1AryBSfzO4S35zP4G677ew-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-68fa064556eso49328276d6.3
        for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 09:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710866454; x=1711471254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XYRz6qJSWvfyLY7dgxRC6OaT6prmOYBhKAWkcUO2NM=;
        b=opln+1G8D4g09A4/hBbSDvpqPRZwrB10b8Jbd/9bm14NggHi4pFTFP+1ZnWasl3RXV
         45C9or674vbhLq+5rSJLBGX4DXOb4/DLm+hASBhD02uqSaAIDN7Gdoer7/YVjaRzFxgc
         1kvb7qiinHj6dr7kAzG/cfnFH9uczJeinwAuNbuPEichcPTKuUKPYaRS+doZPNBg9gfI
         ow9vu4fklXRqPGG96jupPGT58DcfUC5SxD7Zv0zoztSacqWKQYLNC7mnmASKtykvF0Bc
         5QCBrdP728wf2kDboprSp/U+uuP2A1ifkNqkSmDMpPx/gkk2l0qnVMVmrNYVNIVC/m5j
         jPxw==
X-Forwarded-Encrypted: i=1; AJvYcCXimW6GVa/LZyIBXdj66LSfqtpPzLjxiezknku9zDzlZeWJObDR4zI14cL538vDu2yC3RXpq/41hO6Md9gDlgf6sJ801tYFitokyNLQ4W4=
X-Gm-Message-State: AOJu0Yy8YxD3/AwenYJqT35iYgcHi9VEInpQR4WzjL7r6EWVYnOWn/Va
	1FpoQ8xRJZ1lU01nHgMPOSNcDHrOyData4Prgu3rK6qszYZ+NQMKV+/ROcsXCkmYUOE9g98f/jC
	YAWXSqkZMkUZSok/80z1R7w/NuCygyEe1vEyg3ma9nIy7eYy7H0y/biqRSwHL2Pwp
X-Received: by 2002:a0c:9c8c:0:b0:696:306f:7a54 with SMTP id i12-20020a0c9c8c000000b00696306f7a54mr2455218qvf.48.1710866454499;
        Tue, 19 Mar 2024 09:40:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJTs6wf1HB0pPDrpQnqyB7TTVuxdkztDyri37TJ/ttVzx7hYvyKhPHUdCrPqD0hLZVvdUavg==
X-Received: by 2002:a0c:9c8c:0:b0:696:306f:7a54 with SMTP id i12-20020a0c9c8c000000b00696306f7a54mr2455203qvf.48.1710866454216;
        Tue, 19 Mar 2024 09:40:54 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-33.business.telecomitalia.it. [87.12.25.33])
        by smtp.gmail.com with ESMTPSA id pn4-20020a056214130400b006961c1d2b6fsm2555913qvb.80.2024.03.19.09.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:40:53 -0700 (PDT)
Date: Tue, 19 Mar 2024 17:40:48 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Cc: jasowang@redhat.com, mst@redhat.com, virtualization@lists.linux.dev
Subject: Re: [PATCH 09/10] vDPA: report virtio-block read-only info to user
 space
Message-ID: <ms2roqd326s5j5ynksciz4tdijqx4taeoyjvtzelbttkt4vich@b4geobrynwj5>
References: <20240218185606.13509-1-lingshan.zhu@intel.com>
 <20240218185606.13509-10-lingshan.zhu@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240218185606.13509-10-lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Feb 19, 2024 at 02:56:05AM +0800, Zhu Lingshan wrote:
>This commit report read-only information of
>virtio-blk devices to user space.
>
>Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>---
> drivers/vdpa/vdpa.c       | 14 ++++++++++++++
> include/uapi/linux/vdpa.h |  1 +
> 2 files changed, 15 insertions(+)
>
>diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>index adbcbc7b18b2..d6fd3cadc44f 100644
>--- a/drivers/vdpa/vdpa.c
>+++ b/drivers/vdpa/vdpa.c
>@@ -1084,6 +1084,17 @@ vdpa_dev_blk_write_zeroes_config_fill(struct sk_buff *msg, u64 features,
> 	return 0;
> }
>
>+static int vdpa_dev_blk_ro_config_fill(struct sk_buff *msg, u64 features)
>+{
>+	u8 ro;
>+
>+	ro = ((features & BIT_ULL(VIRTIO_BLK_F_RO)) == 0) ? 0 : 1;
>+	if (nla_put_u8(msg, VDPA_ATTR_DEV_BLK_CFG_READ_ONLY, ro))

This is not really related to the config space, what about renaming it
to VDPA_ATTR_DEV_BLK_READ_ONLY ?

Also the type, maybe better to use "flag" and set it through
`nla_put_flag()`.

Not a strong opinion on that, it just seems a little more consistent to
me.

Thanks,
Stefano

>+		return -EMSGSIZE;
>+
>+	return 0;
>+}
>+
> static int vdpa_dev_blk_config_fill(struct vdpa_device *vdev,
> 				    struct sk_buff *msg)
> {
>@@ -1122,6 +1133,9 @@ static int vdpa_dev_blk_config_fill(struct vdpa_device *vdev,
> 	if (vdpa_dev_blk_write_zeroes_config_fill(msg, features_device, &config))
> 		return -EMSGSIZE;
>
>+	if (vdpa_dev_blk_ro_config_fill(msg, features_device))
>+		return -EMSGSIZE;
>+
> 	return 0;
> }
>
>diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
>index 797d5708492f..4be8e3a15874 100644
>--- a/include/uapi/linux/vdpa.h
>+++ b/include/uapi/linux/vdpa.h
>@@ -70,6 +70,7 @@ enum vdpa_attr {
> 	VDPA_ATTR_DEV_BLK_CFG_DISCARD_SEC_ALIGN,/* u32 */
> 	VDPA_ATTR_DEV_BLK_CFG_MAX_WRITE_ZEROES_SEC,	/* u32 */
> 	VDPA_ATTR_DEV_BLK_CFG_MAX_WRITE_ZEROES_SEG,	/* u32 */
>+	VDPA_ATTR_DEV_BLK_CFG_READ_ONLY,		/* u8 */
>
> 	/* new attributes must be added above here */
> 	VDPA_ATTR_MAX,
>-- 
>2.39.3
>
>

