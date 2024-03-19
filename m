Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F24520332
	for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 16:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710866680; cv=none; b=l2THDjV9EXjs08okOzN7pwvpDMnnSqKlFBsNRMrxRLGsRhknzCfjgNaJUGkpx1tc+Vr4d5ueyavNpTxz3hAnjR25fWfV0hlaysSoNSF3MkbZBT9UJ9raaDhbQDLApdrN6JqbYX/zkRFvcsPcgzfkbPPviXuQ6Bp5/Di5fEM7EZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710866680; c=relaxed/simple;
	bh=YTMPzLPcOIEdA80sj2+HVdD3u5HAS14/qieF+TuzNvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=fpjU1xxzqDsqdJfs9bfhfbK3oOAE2EnhToPxjclY++6KNuS7GaYzk9UN1MMez1MrgiStgMxhl5Zqk+4qAhXy4US3/75Z2bWo7NXSlOHccn3mPRZuKS17dxEd6kz+zMyRessCNiBUJqqSWVQaAOMeP0kX6M4beD9LYSxsFHxMJ8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ecdyyoyb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ecdyyoyb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710866678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=afdq5enLmnKou0VKJuIfQG/SiVG1qD5A8iU+PRXV5pc=;
	b=EcdyyoybWmlw1tiHEN8u3W606lndqGFcJwHzjwPnlxh9o9zJkF/1f8GGhEyAV6EnUrvSsi
	m5Fh7KcjRyi+bhsdVquR7VgVnScGyJAMUjJpSe+aXQle96sTMpqVRQ8Yb3KRrxFFxatKhe
	FCI8u6WEDdm81bpVEO6uyaVJMSeDHmk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-OeADlBQNO8qBN3IQc4NzKA-1; Tue, 19 Mar 2024 12:44:36 -0400
X-MC-Unique: OeADlBQNO8qBN3IQc4NzKA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-41413823c1bso120625e9.1
        for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 09:44:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710866675; x=1711471475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afdq5enLmnKou0VKJuIfQG/SiVG1qD5A8iU+PRXV5pc=;
        b=tB7MvqD1ddh6rRxitgifr60vLS4cBlnj+ErlEWMhi9XG8vOMcSyuUBSBGZs1q1WK58
         Wrbg6ckuAL5g9wR1yfIeuZqziaeDRHf85RvvODyFLkrhIG1PwrfKGsiQwonTyI0tJdlZ
         WOrFYjlHfGyrHdp0x+fVFyVa17PHgyBd/q9NFbNbg30pcFjjTP48tNTJDTPb/PZY9Mng
         mw87RrX3aPveeGowiSP9SU3ParJ2CKh87SV/ZsPQTVxpkgL1nkW6vUeB7mIRgoBlmKN8
         o6KXvUW4agdmWQ/3AkRIAOMVpMbFdf48z4ms5MZZ6eIIos1vlMbCats9aP0rEM7X8LMe
         BMKA==
X-Forwarded-Encrypted: i=1; AJvYcCW3xJa4SUSLunkSC5Uaju0CxyRJXDWzGDjgjVmGPeDMY5szvSBk5JHDnXIgxw2w9cqGv+zKnLq+3/Skz9jVBuCwPridKvYxQ1Emk4CA1R0=
X-Gm-Message-State: AOJu0YwkokvUfmsANNPZx7oce0Z/sIVYPyW69BjOC68QM54DaX8aQOU+
	57m2JLDZbz4yyJCt/1Wpurss/FcbLQ1MuRWDtNsunPu8LEgtyIsMcAp3phlG+MAbOtN/jyASX1Q
	vspGQQmOZI5EOsPkQMRhicnQXmopOW2wB8c1TkHZrXcIt8+tRS/aW1m5hCofKfHmK
X-Received: by 2002:a05:600c:1ca6:b0:413:2a42:8af5 with SMTP id k38-20020a05600c1ca600b004132a428af5mr3098871wms.15.1710866675145;
        Tue, 19 Mar 2024 09:44:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEX7Y1ypFnIhwg34chxKj+ExRBuZfuejHx8ti/PoEiZxG26/jvp09I3cpBpWKqvVlTSE9iIVA==
X-Received: by 2002:a05:600c:1ca6:b0:413:2a42:8af5 with SMTP id k38-20020a05600c1ca600b004132a428af5mr3098858wms.15.1710866674845;
        Tue, 19 Mar 2024 09:44:34 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-33.business.telecomitalia.it. [87.12.25.33])
        by smtp.gmail.com with ESMTPSA id bq22-20020a5d5a16000000b0033ebf702e17sm10952590wrb.21.2024.03.19.09.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:44:33 -0700 (PDT)
Date: Tue, 19 Mar 2024 17:44:31 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Cc: jasowang@redhat.com, mst@redhat.com, virtualization@lists.linux.dev
Subject: Re: [PATCH 06/10] vDPA: report virtio-block topology info to user
 space
Message-ID: <rm4hpf53q42dtijvvrsl3wx4clqvavow542xmregmwhojoqat6@lxwdz2ps2ls2>
References: <20240218185606.13509-1-lingshan.zhu@intel.com>
 <20240218185606.13509-7-lingshan.zhu@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240218185606.13509-7-lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Feb 19, 2024 at 02:56:02AM +0800, Zhu Lingshan wrote:
>This commit allows vDPA reporting topology information of
>virtio-blk devices to user space, includes:
>1) the number of logical blocks per physical block
>2) offset of first aligned logical block
>3) suggested minimum I/O size in blocks
>4) optimal (suggested maximum) I/O size in blocks
>
>Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>---
> drivers/vdpa/vdpa.c       | 32 ++++++++++++++++++++++++++++++++
> include/uapi/linux/vdpa.h |  4 ++++
> 2 files changed, 36 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>index 26e8768b869a..dfd9aa5779dc 100644
>--- a/drivers/vdpa/vdpa.c
>+++ b/drivers/vdpa/vdpa.c
>@@ -1012,6 +1012,35 @@ static int vdpa_dev_blk_mq_config_fill(struct sk_buff *msg, u64 features,
> 	return nla_put_u16(msg, VDPA_ATTR_DEV_BLK_CFG_NUM_QUEUES, val_u16);
> }
>
>+static int vdpa_dev_blk_topology_config_fill(struct sk_buff *msg, u64 features,
>+				       const struct virtio_blk_config *config)
>+{
>+	u16 min_io_size;
>+	u32 opt_io_size;
>+
>+	if ((features & BIT_ULL(VIRTIO_BLK_F_TOPOLOGY)) == 0)
>+		return 0;
>+
>+	min_io_size = __virtio16_to_cpu(true, config->min_io_size);
>+	opt_io_size = __virtio32_to_cpu(true, config->opt_io_size);
>+
>+	if (nla_put_u8(msg, VDPA_ATTR_DEV_BLK_CFG_PHY_BLK_EXP,
>+	    config->physical_block_exp))
>+		return -EMSGSIZE;
>+
>+	if (nla_put_u8(msg, VDPA_ATTR_DEV_BLK_CFG_ALIGN_OFFSET,
>+	    config->alignment_offset))
>+		return -EMSGSIZE;
>+
>+	if (nla_put_u16(msg, VDPA_ATTR_DEV_BLK_CFG_MIN_IO_SIZE, min_io_size))
>+		return -EMSGSIZE;
>+
>+	if (nla_put_u32(msg, VDPA_ATTR_DEV_BLK_CFG_OPT_IO_SIZE, opt_io_size))
>+		return -EMSGSIZE;
>+
>+	return 0;
>+}
>+
> static int vdpa_dev_blk_config_fill(struct vdpa_device *vdev,
> 				    struct sk_buff *msg)
> {
>@@ -1041,6 +1070,9 @@ static int vdpa_dev_blk_config_fill(struct vdpa_device *vdev,
> 	if (vdpa_dev_blk_mq_config_fill(msg, features_device, &config))
> 		return -EMSGSIZE;
>
>+	if (vdpa_dev_blk_topology_config_fill(msg, features_device, &config))
>+		return -EMSGSIZE;
>+
> 	return 0;
> }
>
>diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
>index 3c8e3c87a864..5cc70614c97a 100644
>--- a/include/uapi/linux/vdpa.h
>+++ b/include/uapi/linux/vdpa.h
>@@ -61,6 +61,10 @@ enum vdpa_attr {
> 	VDPA_ATTR_DEV_BLK_CFG_BLK_SIZE,		/* u32 */
> 	VDPA_ATTR_DEV_BLK_CFG_SEG_MAX,		/* u32 */
> 	VDPA_ATTR_DEV_BLK_CFG_NUM_QUEUES,	/* u16 */
>+	VDPA_ATTR_DEV_BLK_CFG_PHY_BLK_EXP,	/* u8 */
>+	VDPA_ATTR_DEV_BLK_CFG_ALIGN_OFFSET,	/* u8 */
>+	VDPA_ATTR_DEV_BLK_CFG_MIN_IO_SIZE,	/* u16 */
>+	VDPA_ATTR_DEV_BLK_CFG_OPT_IO_SIZE,	/* u32 */
>
> 	/* new attributes must be added above here */
> 	VDPA_ATTR_MAX,
>-- 
>2.39.3
>
>

