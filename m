Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65CD1CAB2
	for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 16:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710866172; cv=none; b=ZLJJNk5x9B3L9uBSaSTdHsvpsZOdxgRP6wwY/cmHnSh9ZGmKLgfMfjwkwZrfCy0+ikL0i5q6/2O+cNId8YP0wysdktclMlpoctnIGGZzUdcVZI9t4jLvN2noHOQyq4y89/l+DrgIi7pS2Ln2wPHgQHhSPMp46aY27JI38jOJB1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710866172; c=relaxed/simple;
	bh=QyJ0MFX0Suf+U+cV1hcmUbR73ilIbzBwpu3S3Wn3vRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=MyeRoOyS9m6ZwYSxvSw/HQxZCdGxbIWlS9NWkkX6PjK7HRudGwE9oJrs7q0QbESKXa6yNfh9ebre8/DzWbX9k8IlrSxaYgR0E6GMvH4pNzw0z6miVIH0iADcrJRBYONfvxNNHsI9HSb0RCj7VeMW/Ra6R57aFoEFsUAcpGUAuh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XykPr0xt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XykPr0xt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710866169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cwRmdfNR12zSLEPRKiwCn8QhewuQKA59LJ2FEJ+4fV0=;
	b=XykPr0xtUPIj9eVC0DrX1cJ8N1q0FIdBawUn3/JLuZLX025TYmSgCYUnjbp+0GKhFB0GOJ
	2rcUOrD4Cvz0xasSFw4IQcyEmnQYRURVDRHKjvrJ+VErUlfj2Mj2OfyQ3nzl0BpWc7y7C9
	nbdyXfBrOYiLV70oofjVv39qafk58WY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-jPYcuyusPl6M3b_MSKNF9w-1; Tue, 19 Mar 2024 12:36:08 -0400
X-MC-Unique: jPYcuyusPl6M3b_MSKNF9w-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-41407d66b11so16613035e9.1
        for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 09:36:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710866166; x=1711470966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwRmdfNR12zSLEPRKiwCn8QhewuQKA59LJ2FEJ+4fV0=;
        b=GRoLqwwGIZdglLesGlOIJLNC6FtbloMkU+dLGqzhrlQtGCuwTTyIyemMju624Zeyr8
         CKQZ4vqQ66nRtBd6HRmsFfNry4nGUivEiW0ibIFJgDUl8aE3piB828QwPNmV3o6GoUsH
         5KlZwLRxWw11hXAXJDWDTw8AvBN+a3jaDy+6IMJeG/BWQG5LnPl+9cxBLVfJryTYdjnU
         EbS/9e6VO7Ct7DPqhhvHQfEXZcZ26cKmD8f5aen0QrxN1q/uLYtQAuMxdCu9QSi2bzv+
         GqX0a4EoaJf/gJLjR8Xjki3L7nZbxV42gdJ9ieSKpL3l3/puU9CgLf/jqrMHy0ZLRvDx
         NBbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVi1np74BBzNK3HrkRFEbevYOygETA4GmlSWa9xsE9a/99TK5hfGfsmirT2FA67yKu9xu5NdDMk8ssATpw9leDRYkO8e9moSHqTntEsJ98=
X-Gm-Message-State: AOJu0Yx2fX8uzEe+nh26pX9uUpt8CVsVuFjIfE5QaFgZZtGWuc/pXTEA
	Hq27nQSeNpjB4OnXyQf1My1jsErLoKUrHk7wsZn998g+RJqkEsrD7U+ZkP/kKpGAAq3QmrCFaZd
	BVUx5uk7+yNkIsMr3A6ObJWBobpkn0df/N+/7h3WrgJoLP7tCquZ0DJqoStq2l7+j
X-Received: by 2002:a05:600c:444f:b0:414:835:6ed2 with SMTP id v15-20020a05600c444f00b0041408356ed2mr2121314wmn.35.1710866166482;
        Tue, 19 Mar 2024 09:36:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH53e2BgY2zXtcEMyi4ZXExIYDJWgvTeQg2HqWKgpzxcoO9K0JTLkImCEXfXui2abRQMA/p+g==
X-Received: by 2002:a05:600c:444f:b0:414:835:6ed2 with SMTP id v15-20020a05600c444f00b0041408356ed2mr2121302wmn.35.1710866166065;
        Tue, 19 Mar 2024 09:36:06 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-33.business.telecomitalia.it. [87.12.25.33])
        by smtp.gmail.com with ESMTPSA id s9-20020a05600c45c900b00412e3717ae6sm22311861wmo.36.2024.03.19.09.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:36:05 -0700 (PDT)
Date: Tue, 19 Mar 2024 17:36:01 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Cc: jasowang@redhat.com, mst@redhat.com, virtualization@lists.linux.dev
Subject: Re: [PATCH 08/10] vDPA: report virtio-block write zeroes
 configuration to user space
Message-ID: <kr2l5cuwdblc5o3xae324uxc2gmphe4wffgunthvhnjfbhqkmz@erwxl3v22gdy>
References: <20240218185606.13509-1-lingshan.zhu@intel.com>
 <20240218185606.13509-9-lingshan.zhu@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240218185606.13509-9-lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Feb 19, 2024 at 02:56:04AM +0800, Zhu Lingshan wrote:
>This commits reports write zeroes configuration of
>virtio-block devices to user space, includes:
>1)maximum write zeroes sectors size
>2)maximum write zeroes segment number
>
>Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>---
> drivers/vdpa/vdpa.c       | 23 +++++++++++++++++++++++
> include/uapi/linux/vdpa.h |  2 ++
> 2 files changed, 25 insertions(+)
>
>diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>index bf3fa90908a7..adbcbc7b18b2 100644
>--- a/drivers/vdpa/vdpa.c
>+++ b/drivers/vdpa/vdpa.c
>@@ -1064,6 +1064,26 @@ static int vdpa_dev_blk_discard_config_fill(struct sk_buff *msg, u64 features,
> 	return 0;
> }
>
>+static int
>+vdpa_dev_blk_write_zeroes_config_fill(struct sk_buff *msg, u64 features,
>+				     const struct virtio_blk_config *config)
>+{
>+	u32 val_u32;
>+
>+	if ((features & BIT_ULL(VIRTIO_BLK_F_WRITE_ZEROES)) == 0)
>+		return 0;
>+
>+	val_u32 = __virtio32_to_cpu(true, config->max_write_zeroes_sectors);
>+	if (nla_put_u32(msg, VDPA_ATTR_DEV_BLK_CFG_MAX_WRITE_ZEROES_SEC, val_u32))
>+		return -EMSGSIZE;
>+
>+	val_u32 = __virtio32_to_cpu(true, config->max_write_zeroes_seg);
>+	if (nla_put_u32(msg, VDPA_ATTR_DEV_BLK_CFG_MAX_WRITE_ZEROES_SEG, val_u32))
>+		return -EMSGSIZE;

Should we cover also `config->write_zeroes_may_unmap` ?

>+
>+	return 0;
>+}
>+
> static int vdpa_dev_blk_config_fill(struct vdpa_device *vdev,
> 				    struct sk_buff *msg)
> {
>@@ -1099,6 +1119,9 @@ static int vdpa_dev_blk_config_fill(struct vdpa_device *vdev,
> 	if (vdpa_dev_blk_discard_config_fill(msg, features_device, &config))
> 		return -EMSGSIZE;
>
>+	if (vdpa_dev_blk_write_zeroes_config_fill(msg, features_device, &config))
>+		return -EMSGSIZE;
>+
> 	return 0;
> }
>
>diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
>index 30887931a220..797d5708492f 100644
>--- a/include/uapi/linux/vdpa.h
>+++ b/include/uapi/linux/vdpa.h
>@@ -68,6 +68,8 @@ enum vdpa_attr {
> 	VDPA_ATTR_DEV_BLK_CFG_MAX_DISCARD_SEC,	/* u32 */
> 	VDPA_ATTR_DEV_BLK_CFG_MAX_DISCARD_SEG,	/* u32 */
> 	VDPA_ATTR_DEV_BLK_CFG_DISCARD_SEC_ALIGN,/* u32 */
>+	VDPA_ATTR_DEV_BLK_CFG_MAX_WRITE_ZEROES_SEC,	/* u32 */
>+	VDPA_ATTR_DEV_BLK_CFG_MAX_WRITE_ZEROES_SEG,	/* u32 */
>
> 	/* new attributes must be added above here */
> 	VDPA_ATTR_MAX,
>-- 
>2.39.3
>
>

