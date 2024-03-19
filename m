Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED77E24B2F
	for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 16:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710866700; cv=none; b=QACGRPLUOlRtiV+EAO5xalMtbB1jJyp/Pnob6QCqLFrjjAg09PYF3bJmxpohIsZKEfhLfLUdNBhPQDkkZfwMsMQVQ8Ut58fcFTa+1+FwUfoc0x/ILcd/B9sdvgQMRk9VOWDrIThxEkfgi78gaAcNis9UVusLzCCwwZ9ZO5QFUVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710866700; c=relaxed/simple;
	bh=bduGRPTd4Wwel6NDz4cwL53x+fglzQLCiehD8CLJfNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UCs8qJ30I7QwrP2TdLEVSSoDRiXkGR1FopBy2LtyfQwPvTi6dtWjpEYUB73W4HOSNsJ3a9Ai+47zt3eVntnzB21yRgEf6W0Xi+b1aTejub0CidG4PNW5uFFZvvARDLrPVTcdDIPhuNUUKQ0bTwlI0k11o8hsRfO3avZMfiasVNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YmMBvDxC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YmMBvDxC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710866698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eeP/EXDPyJ2tb3A8T06elX+OAOUf4ftAT9aXLPv4rv8=;
	b=YmMBvDxCyfr1ML2ZH1POLCAycVSMzg0B0hXGlrMahZZQKilO2xYS3mOMVWEt+8IPjiLf3K
	QSyB0ln9ssBQTTP5bIAdpXDHSAWY5iwtGrZWLU2Dg4vvv0zeK+dnrXr2slyPqrMVMywZbx
	GeiGZPrB/3OoO/tGF+NScH5SFFaaUIc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-D0D5A7pdMtC5cBPXSuPtjg-1; Tue, 19 Mar 2024 12:44:56 -0400
X-MC-Unique: D0D5A7pdMtC5cBPXSuPtjg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33e4397540bso3552643f8f.3
        for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 09:44:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710866695; x=1711471495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eeP/EXDPyJ2tb3A8T06elX+OAOUf4ftAT9aXLPv4rv8=;
        b=EFur39DF9FABRg6hk+dWoQ3R5oWF6mfocXsiNAL9psZLKezoE6n8l50Anc1CwGmHkl
         e1iwG+E2G3ljoB0dSr7JhHpMH8jKV4KtQSBgqqwQaQoFKF9yBXWzH47ZLZYoEPJxpVTq
         FFD1n8Si85w9rLtqqAO0dDMz8ZDLBl45DWEODCue4tVWXHHO7WITduk6q2E+/Pwl+4BK
         OgJ9ineJcHieQoYfb/kXJH9OObGkrfVDEJ0bDCsmBBeMHSO6dL1RknSGtFubi0EvucS2
         lrbnpinGtU1APB+gk72ZBpGWB3M/m9I7gDTodtvzojfLd+9ZBP+ad+h+ZvHWDYgc3AVh
         05MA==
X-Forwarded-Encrypted: i=1; AJvYcCXAoBef5KqWBes9CQwDX8s4TXH3o7oowcuc/shYVyHqfSdtTZMb136fuR+6P1bHHaj4r5mauu2ZJJ0hO7dkSehLdHnhJF3UTCs7ehnrp/s=
X-Gm-Message-State: AOJu0YzNtN4bPy6eRwDvCVB2IDvgvuzYT3CzMvQ7ILcYeyZdcNONXPu8
	4PJKAwpr+nAB8nvk19xXpAzoB084a6/T12JZcMfmPHBAxJfKJ5KkHscHq8Pm+JBg3571zyiedFj
	u+3UJoXH+nCth21ZqZVlbt67pJv9VG/D8ecdEE+6k/ln6d6l0RHzDTWe0e/X9Ql7C
X-Received: by 2002:a5d:5005:0:b0:33d:4966:fa8f with SMTP id e5-20020a5d5005000000b0033d4966fa8fmr12696993wrt.46.1710866695242;
        Tue, 19 Mar 2024 09:44:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQ8yBei4hlOfPYsxE+owtdb4kY6RqqcNb21f8Lc/zCfNAc8oBhGD86n0PgQYq7KJPRQRTzeA==
X-Received: by 2002:a5d:5005:0:b0:33d:4966:fa8f with SMTP id e5-20020a5d5005000000b0033d4966fa8fmr12696986wrt.46.1710866694931;
        Tue, 19 Mar 2024 09:44:54 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-33.business.telecomitalia.it. [87.12.25.33])
        by smtp.gmail.com with ESMTPSA id bu9-20020a056000078900b0034082c782c0sm8177820wrb.0.2024.03.19.09.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:44:54 -0700 (PDT)
Date: Tue, 19 Mar 2024 17:44:52 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Cc: jasowang@redhat.com, mst@redhat.com, virtualization@lists.linux.dev
Subject: Re: [PATCH 07/10] vDPA: report virtio-block discarding configuration
 to user space
Message-ID: <76tdg3fu7mb2uszcynxlxlhixfszgfpmczljahyqnalzu5bvjw@adgfbwi4l4gg>
References: <20240218185606.13509-1-lingshan.zhu@intel.com>
 <20240218185606.13509-8-lingshan.zhu@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240218185606.13509-8-lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Feb 19, 2024 at 02:56:03AM +0800, Zhu Lingshan wrote:
>This commit reports virtio-blk discarding configuration
>to user space,includes:
>1) the maximum discard sectors
>2) maximum number of discard segments for the block driver to use
>3) the alignment for splitting a discarding request
>
>Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>---
> drivers/vdpa/vdpa.c       | 26 ++++++++++++++++++++++++++
> include/uapi/linux/vdpa.h |  3 +++
> 2 files changed, 29 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>index dfd9aa5779dc..bf3fa90908a7 100644
>--- a/drivers/vdpa/vdpa.c
>+++ b/drivers/vdpa/vdpa.c
>@@ -1041,6 +1041,29 @@ static int vdpa_dev_blk_topology_config_fill(struct sk_buff *msg, u64 features,
> 	return 0;
> }
>
>+static int vdpa_dev_blk_discard_config_fill(struct sk_buff *msg, u64 features,
>+				       const struct virtio_blk_config *config)
>+{
>+	u32 val_u32;
>+
>+	if ((features & BIT_ULL(VIRTIO_BLK_F_DISCARD)) == 0)
>+		return 0;
>+
>+	val_u32 = __virtio32_to_cpu(true, config->max_discard_sectors);
>+	if (nla_put_u32(msg, VDPA_ATTR_DEV_BLK_CFG_MAX_DISCARD_SEC, val_u32))
>+		return -EMSGSIZE;
>+
>+	val_u32 = __virtio32_to_cpu(true, config->max_discard_seg);
>+	if (nla_put_u32(msg, VDPA_ATTR_DEV_BLK_CFG_MAX_DISCARD_SEG, val_u32))
>+		return -EMSGSIZE;
>+
>+	val_u32 = __virtio32_to_cpu(true, config->discard_sector_alignment);
>+	if (nla_put_u32(msg, VDPA_ATTR_DEV_BLK_CFG_DISCARD_SEC_ALIGN, val_u32))
>+		return -EMSGSIZE;
>+
>+	return 0;
>+}
>+
> static int vdpa_dev_blk_config_fill(struct vdpa_device *vdev,
> 				    struct sk_buff *msg)
> {
>@@ -1073,6 +1096,9 @@ static int vdpa_dev_blk_config_fill(struct vdpa_device *vdev,
> 	if (vdpa_dev_blk_topology_config_fill(msg, features_device, &config))
> 		return -EMSGSIZE;
>
>+	if (vdpa_dev_blk_discard_config_fill(msg, features_device, &config))
>+		return -EMSGSIZE;
>+
> 	return 0;
> }
>
>diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
>index 5cc70614c97a..30887931a220 100644
>--- a/include/uapi/linux/vdpa.h
>+++ b/include/uapi/linux/vdpa.h
>@@ -65,6 +65,9 @@ enum vdpa_attr {
> 	VDPA_ATTR_DEV_BLK_CFG_ALIGN_OFFSET,	/* u8 */
> 	VDPA_ATTR_DEV_BLK_CFG_MIN_IO_SIZE,	/* u16 */
> 	VDPA_ATTR_DEV_BLK_CFG_OPT_IO_SIZE,	/* u32 */
>+	VDPA_ATTR_DEV_BLK_CFG_MAX_DISCARD_SEC,	/* u32 */
>+	VDPA_ATTR_DEV_BLK_CFG_MAX_DISCARD_SEG,	/* u32 */
>+	VDPA_ATTR_DEV_BLK_CFG_DISCARD_SEC_ALIGN,/* u32 */
>
> 	/* new attributes must be added above here */
> 	VDPA_ATTR_MAX,
>-- 
>2.39.3
>
>

