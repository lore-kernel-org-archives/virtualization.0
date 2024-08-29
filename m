Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8733116B753
	for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 07:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724915591; cv=none; b=M0M7OPd3IpO269oC6Q0JEk7mLsuOUCcpEQC9xzrg11eNW45aUWF1FWAxZbtym+IQstyRzHSwr1sGppABL6vb7SS2CMTx3TRA9vK4FsCeqCL7w+m1+2kgID44Fel2j5BgOsdtA4YrcOIhpMSyhDQ5UtvdpZmeKIijFM/lsWRDmRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724915591; c=relaxed/simple;
	bh=nlIlAL2zaBMHnx800P6wF6aqRBkokcHL0Mf3is8S1CU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Mo+U5wSaRNf+OddNsXr5sp0mVq71AZg/3P9d6LhCSGmUTuJY7EcexnAZZTFayMo6KqmnS7Sz3wkuMA2f19PYhd52j5tBs8YcOo20xW6zmt1QNDpW7+/H0YX8SvsZtRMcidDeOBo09ZJSXP3+eNKWXfiRLso8V2KHsyiVJCd7Vh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gKZgVLoo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gKZgVLoo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724915587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hDa/BfPlYfgncY5T1ouEOXs9QAiEyNsHZ78FmWi0H8w=;
	b=gKZgVLoofRNSV0Ia7imXk73X7TOhZgho/PEl8w6cEbBnPuOfiCxs07ExaODpV1nz6S/koD
	Hg9wMMCq51M9+n4mEF+CyoQNXyd5X0Q6EVUWDOvIQeCvoXBz4zWFGJYOOjthKOQZoVzBTe
	mhqTs3fH49ytUoQxJbX/HwSQsyjHLCE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-M4YwRSvGOH-Zpzp_PgiScg-1; Thu, 29 Aug 2024 03:13:05 -0400
X-MC-Unique: M4YwRSvGOH-Zpzp_PgiScg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a866fe9875bso10496666b.3
        for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 00:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724915584; x=1725520384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDa/BfPlYfgncY5T1ouEOXs9QAiEyNsHZ78FmWi0H8w=;
        b=Q9hkYVy4PKp4GulfdxvKGpRMjnZsGlNoC0qS3rsk4OfdjR1p1DrOdHXkQcfANTGG2x
         NZ+nhl22WDlB9gQTPXxOBycTygy7yE58i5iZT+DIvChMyRVdNnpxjHqYf1/ML+HR6N4a
         tad+KJNlyf9Qt783YoM4CMXpNqfDiChkTV2k8VD6ZMQbsdGvjmI7vWNl4FYcH+cKHKJW
         gh36dme1RsMmbXPKWuyZaVsBZSCGzU/QTnlkMh3fkotU13AF9d9DPTy2yZ+4eOoEWbBW
         VLv1fksRxHB/KV8CSA4AWGkwDabeIofkyK0bMyjFzNVJ1gEs1b/j89gs0IwJBVt2T76E
         15EA==
X-Forwarded-Encrypted: i=1; AJvYcCVTtWiigA8PlVsjIiBWFl+hMIoSlblU02E0w76kTJ/QTFEtk2+ST7xWi1EDdfr3t6KVaxiVxzP7Y+sdeKI8qA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxeajmGPqsKOVRb/7ZLENe0H1PMt+y8Sl68tyixSvw+wwp3+Qx8
	xPZYUi+vishGm756AaAolltsXMwrI6lDT00DGNMBzUULmwk2wnVSIqtnuk6LaWUzRy0nB4aitDU
	Bf6g7k37d5Qu/8cyhPcJWKSIixXQ1QJBtVwJ6Nrw2emuLS86++ZKhan8+Q+zkgr7+
X-Received: by 2002:a05:6402:2755:b0:5be:fc2e:b7ce with SMTP id 4fb4d7f45d1cf-5c21ed54a32mr1858402a12.19.1724915584616;
        Thu, 29 Aug 2024 00:13:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr2Co8m4VGY5qkWIO+/TWxMIHT/EfuU5z5cPxSrB5C2LnjsmaqWkBFFu5KqhIgn7z9eIMK2g==
X-Received: by 2002:a05:6402:2755:b0:5be:fc2e:b7ce with SMTP id 4fb4d7f45d1cf-5c21ed54a32mr1858363a12.19.1724915583662;
        Thu, 29 Aug 2024 00:13:03 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ed:a269:8195:851e:f4b1:ff5d])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226ccfeb7sm331942a12.63.2024.08.29.00.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 00:13:03 -0700 (PDT)
Date: Thu, 29 Aug 2024 03:12:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Cc: dtatulea@nvidia.com, jasowang@redhat.com, bilbao@vt.edu,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, cratiu@nvidia.com,
	lingshan.zhu@intel.com, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Carlos Bilbao <cbilbao@digitalocean.com>
Subject: Re: [PATCH] vdpa: Set speed and duplex of mlx5_vnet to UNKNOWN
Message-ID: <20240829031227-mutt-send-email-mst@kernel.org>
References: <20240828181625.7831-1-carlos.bilbao.osdev@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240828181625.7831-1-carlos.bilbao.osdev@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 28, 2024 at 01:16:25PM -0500, Carlos Bilbao wrote:
> From: Carlos Bilbao <cbilbao@digitalocean.com>
> 
> mlx5_vdpa vDPA devices currently don't support reporting or setting the
> speed and duplex and hence should be UNKNOWN instead of zero.
> 
> Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>


As Jason points out, commit log and subject should says what
the patch does.

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c |  7 +++++++
>  drivers/vdpa/vdpa.c               | 23 +++++++++++++++++++++++
>  include/uapi/linux/vdpa.h         |  2 ++
>  3 files changed, 32 insertions(+)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index fa78e8288ebb..319f5c6121de 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3795,6 +3795,13 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>  	init_rwsem(&ndev->reslock);
>  	config = &ndev->config;
>  
> +	/*
> +	 * mlx5_vdpa vDPA devices currently don't support reporting or
> +	 * setting the speed or duplex.
> +	 */
> +	config->speed  = SPEED_UNKNOWN;
> +	config->duplex = DUPLEX_UNKNOWN;
> +
>  	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) {
>  		err = config_func_mtu(mdev, add_config->net.mtu);
>  		if (err)
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 4dbd2e55a288..abde23e0041d 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -15,6 +15,7 @@
>  #include <net/genetlink.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/virtio_ids.h>
> +#include <uapi/linux/ethtool.h>
>  
>  static LIST_HEAD(mdev_head);
>  /* A global mutex that protects vdpa management device and device level operations. */
> @@ -919,6 +920,22 @@ static int vdpa_dev_net_status_config_fill(struct sk_buff *msg, u64 features,
>  	return nla_put_u16(msg, VDPA_ATTR_DEV_NET_STATUS, val_u16);
>  }
>  
> +static int vdpa_dev_net_speed_config_fill(struct sk_buff *msg, u64 features,
> +					struct virtio_net_config *config)
> +{
> +	__le32 speed = cpu_to_le32(SPEED_UNKNOWN);
> +
> +	return nla_put(msg, VDPA_ATTR_DEV_NET_CFG_SPEED, sizeof(speed), &speed);
> +}
> +
> +static int vdpa_dev_net_duplex_config_fill(struct sk_buff *msg, u64 features,
> +					struct virtio_net_config *config)
> +{
> +	u8 duplex = DUPLEX_UNKNOWN;
> +
> +	return nla_put(msg, VDPA_ATTR_DEV_NET_CFG_DUPLEX, sizeof(duplex), &duplex);
> +}
> +
>  static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *msg)
>  {
>  	struct virtio_net_config config = {};
> @@ -941,6 +958,12 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
>  	if (vdpa_dev_net_status_config_fill(msg, features_device, &config))
>  		return -EMSGSIZE;
>  
> +	if (vdpa_dev_net_speed_config_fill(msg, features_device, &config))
> +		return -EMSGSIZE;
> +
> +	if (vdpa_dev_net_duplex_config_fill(msg, features_device, &config))
> +		return -EMSGSIZE;
> +
>  	return vdpa_dev_net_mq_config_fill(msg, features_device, &config);
>  }
>  
> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> index 842bf1201ac4..1c64ee0dd7b1 100644
> --- a/include/uapi/linux/vdpa.h
> +++ b/include/uapi/linux/vdpa.h
> @@ -43,6 +43,8 @@ enum vdpa_attr {
>  	VDPA_ATTR_DEV_NET_STATUS,		/* u8 */
>  	VDPA_ATTR_DEV_NET_CFG_MAX_VQP,		/* u16 */
>  	VDPA_ATTR_DEV_NET_CFG_MTU,		/* u16 */
> +	VDPA_ATTR_DEV_NET_CFG_SPEED,		/* u32 */
> +	VDPA_ATTR_DEV_NET_CFG_DUPLEX,		/* u8 */
>  
>  	VDPA_ATTR_DEV_NEGOTIATED_FEATURES,	/* u64 */
>  	VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,		/* u32 */
> -- 
> 2.34.1

