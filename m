Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE14364EB2
	for <virtualization@lists.linux.dev>; Thu, 22 Jan 2026 21:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769118731; cv=none; b=NtJBOqcNuyg9yLIBuHPlYANZfUJUKzJssx8emnB5prct+0/BWv7eYbEs8WDxUqcIX6bCSf6FzslJVagAFw4DvIWDD5apiQd6ofM8ti/loZZ6VOdRlecx1oY1mXvpL3D0RVr0EcYnAa87jqFZIE2YOWD+iuKyMa/z5mDf3EXPxvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769118731; c=relaxed/simple;
	bh=vBKOE2qVFcm4p0Uyp9ThApwnQdHm19ApCeX565t096c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gFbYXBNGPGCETRYsijom8cU2l0izsHzjpOx4euTeP04L4Ccaw1NWcBZy2mkCbpvcxwszfAnp9ODHpRprpVFLKdWRe6hGXI4wa79OeXul+xT7su6OnpG1WV7uozHSYIF+iiAviRYmCbtO3ytsF3LWqroJQdbxbtHB3wh7y+7oC7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MLzD4QV1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MLzD4QV1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769118723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZW5gSdhItogFEcRflAqU8aOpgxsdIYIRekkLZQNMM3c=;
	b=MLzD4QV1zw6JEmu8gK9F8VHJtQIstoZK4RYMolX9/CG+U8SrWF8Nzw4RZ4hYNnYbFBl+qs
	WkLn3BRLEaZaFi72gMbNDBMfuEGrm4dMJts9CcT9331wY5fuJII08mFiDnsU1WEV2xVFLD
	lcagbuYu+KP+ExVNA36tlcKccQKXM84=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-kn16SJaINr-7iYeJiuEZSQ-1; Thu, 22 Jan 2026 16:52:02 -0500
X-MC-Unique: kn16SJaINr-7iYeJiuEZSQ-1
X-Mimecast-MFC-AGG-ID: kn16SJaINr-7iYeJiuEZSQ_1769118721
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47ee3dd7fc8so14930445e9.3
        for <virtualization@lists.linux.dev>; Thu, 22 Jan 2026 13:52:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769118721; x=1769723521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZW5gSdhItogFEcRflAqU8aOpgxsdIYIRekkLZQNMM3c=;
        b=FkblxVQLEWgXIU184Yr3OjUB+U1XAuDvhEN2zioBbwOZG5f31wPZuJyHT6niHXxSRv
         1L4jubuwwZsFTq3Biidrj29hE3vBoYN39RRA0527qWWCmRUNIO7xL+VXN9PJO2VLLTA+
         duaxNoooeqOy5qOpguUbbYGHeUNAgb8MXdq/K/NO4DKfb4K8D72rt9jubaxyeuXTzXAe
         c0LJUJENeRN/YudNuzrfhjhh9mu5T06wKKBlgAm0A00+5wtGsg8xC464Zhd59DgwNynT
         zJtaZh4yjUN4QGk/woUxtxkXgZHlYGHMN8Qt7o8QPHZ+LEaDhTjJ6lHxD6r01cPiBhd9
         ekLg==
X-Forwarded-Encrypted: i=1; AJvYcCWI91TX/Iu30Q8BjrwsrOLIm8J7vYrjBgMMuSUaii3lz4nGIqRERamqbvxJPkixZhKgkrKNJ/t1osq8+k5b0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxtbs4hiIxPooC/ZwJHfZsogjCRObcBJLBN4rtPRQGziOaVvelS
	qcs2hR4cDK1Fz4UJz7tU/vlNuYosN1UIt2AEOrUgvHw7lq1FHVsZOmylY9kmXwzgMg7GCyHt0uC
	0tLrvi+zJvHwAZyzQ0Nau6UezCa0m1kYOVag+75b75FnCmE5F9avnyUwiq6UApDpMsZ11
X-Gm-Gg: AZuq6aL+zS9g9n3OHcGP1qPGcoARHEzExYcSg4OJWYULzl6wQXQmhKmxgIcYYHzpPNx
	yc/Zjcv0evgAeEClbjDJYMFtYEg/AYWDevO2PgJwD5rZwXC4zo7aTXVswTq9FfS8KaMpbv54yTp
	TbDzKJd0jknraNH7FPbA3dB/gCZzEYQQdPpiQhxwCV9gnNkGmxkk67FHtWTBebmeRHpKngnings
	4SDfPjRdKBUnI4V1hNIhDfIcpkfJ1s1s3pya7rFKKONswev3UsSD2aTWgHINpTUYmmNFvYlG27N
	9CPuwo1kXQuCT9aAKTqHf0ubE0kv6QtEgpzVi9hjwyr9FrhnjOx5pVajtIcP8KVxdsNCeLUGIpH
	LNCCJRRdC7lcntHbjnJ+syojZwkQBIkcw5w==
X-Received: by 2002:a05:600c:1f84:b0:477:97c7:9be7 with SMTP id 5b1f17b1804b1-4804c947d4dmr17354495e9.1.1769118720926;
        Thu, 22 Jan 2026 13:52:00 -0800 (PST)
X-Received: by 2002:a05:600c:1f84:b0:477:97c7:9be7 with SMTP id 5b1f17b1804b1-4804c947d4dmr17354035e9.1.1769118720351;
        Thu, 22 Jan 2026 13:52:00 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1e717cbsm1597488f8f.24.2026.01.22.13.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 13:51:59 -0800 (PST)
Date: Thu, 22 Jan 2026 16:51:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v16 06/12] virtio_net: Create a FF group for
 ethtool steering
Message-ID: <20260122165014-mutt-send-email-mst@kernel.org>
References: <20260121220652.894364-1-danielj@nvidia.com>
 <20260121220652.894364-7-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260121220652.894364-7-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NgMJXGr-GU6MSvf8R6CN5g7l2SFrgn05xYoA0AVdVO8_1769118721
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 21, 2026 at 04:06:46PM -0600, Daniel Jurgens wrote:
> All ethtool steering rules will go in one group, create it during
> initialization.
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> 
> ---
> v4: Documented UAPI
> ---
> ---
>  drivers/net/virtio_net.c           | 29 +++++++++++++++++++++++++++++
>  include/uapi/linux/virtio_net_ff.h | 15 +++++++++++++++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 03bd3d2c2b0e..b406f5f1c75e 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -286,6 +286,9 @@ static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc_qstat[] = {
>  	VIRTNET_STATS_DESC_TX_QSTAT(speed, ratelimit_packets, hw_drop_ratelimits),
>  };
>  
> +#define VIRTNET_FF_ETHTOOL_GROUP_PRIORITY 1
> +#define VIRTNET_FF_MAX_GROUPS 1
> +
>  struct virtnet_ff {
>  	struct virtio_device *vdev;
>  	bool ff_supported;
> @@ -5724,6 +5727,7 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
>  	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
>  			      sizeof(struct virtio_net_ff_selector) *
>  			      VIRTIO_NET_FF_MASK_TYPE_MAX;
> +	struct virtio_net_resource_obj_ff_group ethtool_group = {};
>  	struct virtio_admin_cmd_query_cap_id_result *cap_id_list;
>  	struct virtio_net_ff_selector *sel;
>  	unsigned long sel_types = 0;
> @@ -5808,6 +5812,12 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
>  	if (err)
>  		goto err_ff_action;
>  
> +	if (le32_to_cpu(ff->ff_caps->groups_limit) < VIRTNET_FF_MAX_GROUPS) {
> +		err = -ENOSPC;
> +		goto err_ff_action;
> +	}
> +	ff->ff_caps->groups_limit = cpu_to_le32(VIRTNET_FF_MAX_GROUPS);
> +
>  	err = virtio_admin_cap_set(vdev,
>  				   VIRTIO_NET_FF_RESOURCE_CAP,
>  				   ff->ff_caps,
> @@ -5854,6 +5864,19 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
>  	if (err)
>  		goto err_ff_action;
>  
> +	ethtool_group.group_priority = cpu_to_le16(VIRTNET_FF_ETHTOOL_GROUP_PRIORITY);
> +
> +	/* Use priority for the object ID. */
> +	err = virtio_admin_obj_create(vdev,
> +				      VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
> +				      VIRTNET_FF_ETHTOOL_GROUP_PRIORITY,

This (3rd param to virtio_admin_obj_create)
is the object ID actually. Setting this to 1 means it is outside
of range for group limit which should be 0...limit - 1 and limit is 1.

don't you mean 0?


> +				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
> +				      0,
> +				      &ethtool_group,
> +				      sizeof(ethtool_group));
> +	if (err)
> +		goto err_ff_action;
> +
>  	ff->vdev = vdev;
>  	ff->ff_supported = true;
>  
> @@ -5881,6 +5904,12 @@ static void virtnet_ff_cleanup(struct virtnet_ff *ff)
>  	if (!ff->ff_supported)
>  		return;
>  
> +	virtio_admin_obj_destroy(ff->vdev,
> +				 VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
> +				 VIRTNET_FF_ETHTOOL_GROUP_PRIORITY,
> +				 VIRTIO_ADMIN_GROUP_TYPE_SELF,


same

> +				 0);
> +
>  	kfree(ff->ff_actions);
>  	kfree(ff->ff_mask);
>  	kfree(ff->ff_caps);
> diff --git a/include/uapi/linux/virtio_net_ff.h b/include/uapi/linux/virtio_net_ff.h
> index d025e252ee26..66af9ecdb674 100644
> --- a/include/uapi/linux/virtio_net_ff.h
> +++ b/include/uapi/linux/virtio_net_ff.h
> @@ -11,6 +11,8 @@
>  #define VIRTIO_NET_FF_SELECTOR_CAP 0x801
>  #define VIRTIO_NET_FF_ACTION_CAP 0x802
>  
> +#define VIRTIO_NET_RESOURCE_OBJ_FF_GROUP 0x0200
> +
>  /**
>   * struct virtio_net_ff_cap_data - Flow filter resource capability limits
>   * @groups_limit: maximum number of flow filter groups supported by the device
> @@ -87,4 +89,17 @@ struct virtio_net_ff_actions {
>  	__u8 reserved[7];
>  	__u8 actions[];
>  };
> +
> +/**
> + * struct virtio_net_resource_obj_ff_group - Flow filter group object
> + * @group_priority: priority of the group used to order evaluation
> + *
> + * This structure is the payload for the VIRTIO_NET_RESOURCE_OBJ_FF_GROUP
> + * administrative object. Devices use @group_priority to order flow filter
> + * groups. Multi-byte fields are little-endian.
> + */
> +struct virtio_net_resource_obj_ff_group {
> +	__le16 group_priority;
> +};
> +
>  #endif
> -- 
> 2.50.1

