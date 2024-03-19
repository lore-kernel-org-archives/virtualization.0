Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E34179BF
	for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 16:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710866662; cv=none; b=ArsDaSMJdfWkSzZ75JEAu3sfPsn1YoXmXpGJfKAHJQGdM3BbqNgofUsNNS69ysHDNLfBSvAtcBub4CD9gXB7aevhVHzB7VW91+7XAuv0MGWkuGo97/bUczCpk8tFXbjOfbRSnMcGVTEvpTQJFeVsXMbfJpeA6dTN2zlLUib30Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710866662; c=relaxed/simple;
	bh=J8FiXtw52qQhBZjZ/QZdmhJ+w1FbYdF84Hefh7dcgOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JWuEG/1FoMPnXPgkGQ0AqZU+dKNSC7skcimI3lfQ72GeN1HtfeJUt+fpdVo/pmLdZ+4qiFlg8DyZjQYq4oxG59GRTwvxQA6yBoinOHCIJ6wwIOE49SVthI7/oAZBtcY9z2msa2vTo2hiqh07CvH1GUY4q6/+ymg8nNCdPbBqpyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GenQCX6R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GenQCX6R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710866659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2hxrwowLB1+/BWBXgYoIKBegzHrqX0HHsc4MvRBC9ZM=;
	b=GenQCX6RdDn826JYTDX2BdRJqAZ7FEEK/YISStP6yC2Pl1WuVutAHv+pPbM1Xn4XswUFTS
	2UD8txfSZEgkub0C6JJxSYsXOC0lVjyTUmzfuG4zOJFreVShwvDhlmfy6HUnOZfEXAgTKq
	cB1/egoTIlGB0WdX0iZ2qn/WdpVWkAU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-VDYkgES7MVKqE-7TaG2GRg-1; Tue, 19 Mar 2024 12:44:18 -0400
X-MC-Unique: VDYkgES7MVKqE-7TaG2GRg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33ec308655eso1659171f8f.0
        for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 09:44:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710866657; x=1711471457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hxrwowLB1+/BWBXgYoIKBegzHrqX0HHsc4MvRBC9ZM=;
        b=nI7qDtqQtX6xAizI60naWgZpAW4OjyApPaaDM8l5eFvz7XP7DBQO8OB8BMh9+mPCBW
         Ycr3pRVn5v+JXz39WMTKpgdorShFpRB1DBFhaIwwTrWqsD92pNOw+3TXby/MFd/3CLn4
         DaC5s4HhxCHYl8c5ENGilIo5JipJaQe2xsAHSTNjyD2gCvjf2UKmBx2v51EgYo6TKw/c
         K4VFxvSzqvb3N+e10LR0SgcOpb2ro4U4xcPERbx4sifg8D/3aE9WcwSvQCoK/Hdbr9NV
         OjT6vCQb00tYbHz/H5kFP2gu1sVVv/XiEqc9ECNH6XQgfA+uapEbO1WxpDgwxvmpX8cU
         9ARw==
X-Forwarded-Encrypted: i=1; AJvYcCXS1AlVHGUv97NJAl7148JDlrn/2veeSFcJeR4llxGCxKlJnzOAax337jBwSPnmeIQepjCM+9DTePK7dARW9bcKoGT1CCky4w99jfPFclo=
X-Gm-Message-State: AOJu0YwxApDqq7c0XguzdRhxEB54Y2JPT27BMnu3edPNgeJcjKFI8+cD
	LcSc0XuiVSi1spwc7VdPx/7TjTMoTZ1c+L1EIFX5gQiA7dcB0mU5z1hmWBQBGlriSKrcarqMQZZ
	EFxWgYM+JScBMgZoUj1mIIxprBO6FZAuMo4gyCZZrwmk9Iy8ofra4SQlrepGMNuVj
X-Received: by 2002:a05:6000:e4a:b0:33d:f3c4:6002 with SMTP id dy10-20020a0560000e4a00b0033df3c46002mr2349517wrb.1.1710866656888;
        Tue, 19 Mar 2024 09:44:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjnAOLviXebOH5yDZjLv0CjsTSEG/TW/nBZUbfetsBwSotehHK+JEc9V7aonZ6gfdWiivcNA==
X-Received: by 2002:a05:6000:e4a:b0:33d:f3c4:6002 with SMTP id dy10-20020a0560000e4a00b0033df3c46002mr2349506wrb.1.1710866656616;
        Tue, 19 Mar 2024 09:44:16 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-33.business.telecomitalia.it. [87.12.25.33])
        by smtp.gmail.com with ESMTPSA id bq24-20020a5d5a18000000b0033ed8643638sm9446827wrb.106.2024.03.19.09.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:44:16 -0700 (PDT)
Date: Tue, 19 Mar 2024 17:44:14 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Cc: jasowang@redhat.com, mst@redhat.com, virtualization@lists.linux.dev
Subject: Re: [PATCH 05/10] vDPA: report virtio-block MQ info to user space
Message-ID: <s5mjdvs3h7opv6qefhhix3gjubkc256l6smnomll5x2mvspzpf@h6rlhf6hxfua>
References: <20240218185606.13509-1-lingshan.zhu@intel.com>
 <20240218185606.13509-6-lingshan.zhu@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240218185606.13509-6-lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Feb 19, 2024 at 02:56:01AM +0800, Zhu Lingshan wrote:
>This commits allows vDPA reporting virtio-block multi-queue
>configuration to user sapce.
>
>Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>---
> drivers/vdpa/vdpa.c       | 16 ++++++++++++++++
> include/uapi/linux/vdpa.h |  1 +
> 2 files changed, 17 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>index 8d00e9976aba..26e8768b869a 100644
>--- a/drivers/vdpa/vdpa.c
>+++ b/drivers/vdpa/vdpa.c
>@@ -999,6 +999,19 @@ vdpa_dev_blk_seg_max_config_fill(struct sk_buff *msg, u64 features,
> 	return nla_put_u32(msg, VDPA_ATTR_DEV_BLK_CFG_SEG_MAX, val_u32);
> }
>
>+static int vdpa_dev_blk_mq_config_fill(struct sk_buff *msg, u64 features,
>+				       const struct virtio_blk_config *config)
>+{
>+	u16 val_u16;
>+
>+	if ((features & BIT_ULL(VIRTIO_BLK_F_MQ)) == 0)
>+		return 0;
>+
>+	val_u16 = __virtio16_to_cpu(true, config->num_queues);
>+
>+	return nla_put_u16(msg, VDPA_ATTR_DEV_BLK_CFG_NUM_QUEUES, val_u16);
>+}
>+
> static int vdpa_dev_blk_config_fill(struct vdpa_device *vdev,
> 				    struct sk_buff *msg)
> {
>@@ -1025,6 +1038,9 @@ static int vdpa_dev_blk_config_fill(struct vdpa_device *vdev,
> 	if (vdpa_dev_blk_seg_max_config_fill(msg, features_device, &config))
> 		return -EMSGSIZE;
>
>+	if (vdpa_dev_blk_mq_config_fill(msg, features_device, &config))
>+		return -EMSGSIZE;
>+
> 	return 0;
> }
>
>diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
>index 2dc92fca2052..3c8e3c87a864 100644
>--- a/include/uapi/linux/vdpa.h
>+++ b/include/uapi/linux/vdpa.h
>@@ -60,6 +60,7 @@ enum vdpa_attr {
> 	VDPA_ATTR_DEV_BLK_CFG_SEG_SIZE,		/* u32 */
> 	VDPA_ATTR_DEV_BLK_CFG_BLK_SIZE,		/* u32 */
> 	VDPA_ATTR_DEV_BLK_CFG_SEG_MAX,		/* u32 */
>+	VDPA_ATTR_DEV_BLK_CFG_NUM_QUEUES,	/* u16 */
>
> 	/* new attributes must be added above here */
> 	VDPA_ATTR_MAX,
>-- 
>2.39.3
>
>

