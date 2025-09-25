Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D061917FB
	for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 21:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758834938; cv=none; b=Rad3jOO81gYuKQUaqBCvwi8UCg8R+1FcZNDPhZSaDCAwU/pwBbQw0q4cduZGXwl+KunGBQGLS6JwDXvoE864XVg+NVAjgsVefnOqKMxSfEeSwZElUMBX9svoKIPewydtr7o+L0QDtcquGffSmsBGW+WnKD0gl6O2n+AOXdI+/WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758834938; c=relaxed/simple;
	bh=67sXkd/kZkyYEB3zDBgSHObSu79lmesE6k8OCRZWSZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rhsPmDfSWEDWWzRWsbeLJAEwTKxgFKSO53O85WzFx9REBaGp+PdEb23HxWkqwxZ1ko7clHezi4FTnCKoNmvZxKSqLPzf/ZFnvgT7+9JCHWR9XgJzf5uVd++C5YGMlfnmcb8CQueUV5oAt/cyz1Oqvf4Yz2uHri/7JADZ6CpmgV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=enqmhRCo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="enqmhRCo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758834935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ig3nBeCUwloN4LvzwfZMbkgJCfvy/bic/b84bOETkhM=;
	b=enqmhRCoPGrxEFJd7hUs23hFi3gz5Tznfe/G7fsZyPG2vsNW/UrGgNJzUALeNmpZ8xnsz7
	nVDbW0iZeyGpowMJyjcn23Fn2Mc92STrDhXlKRGvPaUZTg50rtTAnIECznhnAdDI/dyIwp
	uB/hNp0iN5cm3AG0JcU36xnXIuYJKsI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-NQC1iKC1MVmhQbjULbrTEw-1; Thu, 25 Sep 2025 17:13:24 -0400
X-MC-Unique: NQC1iKC1MVmhQbjULbrTEw-1
X-Mimecast-MFC-AGG-ID: NQC1iKC1MVmhQbjULbrTEw_1758834803
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e35baddc1so9100945e9.2
        for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 14:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758834803; x=1759439603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ig3nBeCUwloN4LvzwfZMbkgJCfvy/bic/b84bOETkhM=;
        b=bU8CFis0JNS3GjbTO3rqOkFZpGyFJz3Dlnt9DnZeobr5DGXREwd7x0xEMTm+VmXZb3
         FeCw0U1pUjzv9r7d4+U38OUmkN1g6T2oMO04Zj8llgMpo6IuiVczvVZJEBRcLhBV698T
         j8e29ZqK/Z6h391KnT+GiFXUHXB2DAVaeztJ4vLrtH9vFRJs4sgh87i3to1jyhXB0yCr
         gRNEQvOnJHkv4Sm23OelkzYJuOsRAV0sp6vyLGlv5W/9qHx2h+i8LObPSbEJNfNzyi6B
         KaZszE38wHETIapKfymeVJf62+zXOExLZQNKe9rM0Q9MiR10Iqg8Snu5Y0Fhjzk5aTUs
         0ZPA==
X-Forwarded-Encrypted: i=1; AJvYcCXQRRnqhJQ30pt9eZAQhPkoYU3UBf2CJUSuh/cP6GsnchGDIx8DjBttu30S+A8z0iMHhanLXI829s22g05Ztg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyA49JrnVMEYlv1qoEIJmlcVdWUiL9h9wrU5mR+1I4qXel7Bz6H
	H4jMzOPHwCIOCnDTSXWA2/B2tJOtdrXL7zMW7ZhSW/UTFgPHx1kHdW8p7jI5+NsIJ/nHa/d9Lpt
	KOnwHS6wUSW9O3Fil5dRGRmSPWX4PQqsm6/lVNICPqwTs9mUe5e9O+6uj6QVAu4s1nScl
X-Gm-Gg: ASbGncvKwZYw7s/jfdubJ9Ooonvox/pMcSQEBcIQ8UwizZulAb7K66j5Tq7LBjqTP9f
	OUEJgRZ4uKda56+D49Lp4gIteyFE1u2JCwfvXBeSGLG4owDRaDBCCAls2W78wI3lTw3c7om2qtF
	1KMn+xzqrLrOcorKKWSN8z+FKS1GIjgFuOfGd+9OsyUxnL920kE/jxA1dEY7vEEj97UsRB8Ptqh
	GEAa+/jFR/DQbWyOp61U9CFMhrof0dy5OzR8TnfnOxTW6HZuukOdkZIV4lalJoTA+tV6XIH2ng0
	JQZNGGmdWOIemof5XHOKyVFuqqWuaiYDBg==
X-Received: by 2002:a05:600c:1d01:b0:45d:d9ab:b86d with SMTP id 5b1f17b1804b1-46e32a0bda9mr62544435e9.31.1758834803287;
        Thu, 25 Sep 2025 14:13:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFHV5Q07RhN0juNlqporSm4E3ydRkAdaK/psjGehjTm2V7fiQhfIUNkC+PlQ7T9FIaIwtYHg==
X-Received: by 2002:a05:600c:1d01:b0:45d:d9ab:b86d with SMTP id 5b1f17b1804b1-46e32a0bda9mr62544155e9.31.1758834802798;
        Thu, 25 Sep 2025 14:13:22 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1538:2200:56d4:5975:4ce3:246f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5603365sm4468039f8f.37.2025.09.25.14.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 14:13:22 -0700 (PDT)
Date: Thu, 25 Sep 2025 17:13:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, alex.williamson@redhat.com,
	pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v3 05/11] virtio_net: Create a FF group for
 ethtool steering
Message-ID: <20250925171105-mutt-send-email-mst@kernel.org>
References: <20250923141920.283862-1-danielj@nvidia.com>
 <20250923141920.283862-6-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250923141920.283862-6-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Csn6nrY1OodsbznWHNDPvgTnNrCqLmIIuhMi_rUu_ks_1758834803
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 23, 2025 at 09:19:14AM -0500, Daniel Jurgens wrote:
> All ethtool steering rules will go in one group, create it during
> initialization.


document uapi changes pls.

> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> ---
>  drivers/net/virtio_net/virtio_net_ff.c | 25 +++++++++++++++++++++++++
>  include/uapi/linux/virtio_net_ff.h     |  7 +++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/net/virtio_net/virtio_net_ff.c b/drivers/net/virtio_net/virtio_net_ff.c
> index 61cb45331c97..0036c2db9f77 100644
> --- a/drivers/net/virtio_net/virtio_net_ff.c
> +++ b/drivers/net/virtio_net/virtio_net_ff.c
> @@ -6,6 +6,9 @@
>  #include <net/ip.h>
>  #include "virtio_net_ff.h"
>  
> +#define VIRTNET_FF_ETHTOOL_GROUP_PRIORITY 1
> +#define VIRTNET_FF_MAX_GROUPS 1
> +
>  static size_t get_mask_size(u16 type)
>  {
>  	switch (type) {
> @@ -30,6 +33,7 @@ void virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
>  	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
>  			      sizeof(struct virtio_net_ff_selector) *
>  			      VIRTIO_NET_FF_MASK_TYPE_MAX;
> +	struct virtio_net_resource_obj_ff_group ethtool_group = {};
>  	struct virtio_net_ff_selector *sel;
>  	int err;
>  	int i;
> @@ -92,6 +96,12 @@ void virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
>  	if (err)
>  		goto err_ff_action;
>  
> +	if (le32_to_cpu(ff->ff_caps->groups_limit) < VIRTNET_FF_MAX_GROUPS) {
> +		err = -ENOSPC;
> +		goto err_ff_action;
> +	}
> +	ff->ff_caps->groups_limit = cpu_to_le32(VIRTNET_FF_MAX_GROUPS);
> +
>  	err = virtio_device_cap_set(vdev,
>  				    VIRTIO_NET_FF_RESOURCE_CAP,
>  				    ff->ff_caps,
> @@ -121,6 +131,17 @@ void virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
>  	if (err)
>  		goto err_ff_action;
>  
> +	ethtool_group.group_priority = cpu_to_le16(VIRTNET_FF_ETHTOOL_GROUP_PRIORITY);
> +
> +	/* Use priority for the object ID. */
> +	err = virtio_device_object_create(vdev,
> +					  VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
> +					  VIRTNET_FF_ETHTOOL_GROUP_PRIORITY,
> +					  &ethtool_group,
> +					  sizeof(ethtool_group));
> +	if (err)
> +		goto err_ff_action;
> +
>  	ff->vdev = vdev;
>  	ff->ff_supported = true;
>  
> @@ -139,6 +160,10 @@ void virtnet_ff_cleanup(struct virtnet_ff *ff)
>  	if (!ff->ff_supported)
>  		return;
>  
> +	virtio_device_object_destroy(ff->vdev,
> +				     VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
> +				     VIRTNET_FF_ETHTOOL_GROUP_PRIORITY);
> +
>  	kfree(ff->ff_actions);
>  	kfree(ff->ff_mask);
>  	kfree(ff->ff_caps);
> diff --git a/include/uapi/linux/virtio_net_ff.h b/include/uapi/linux/virtio_net_ff.h
> index a35533bf8377..662693e1fefd 100644
> --- a/include/uapi/linux/virtio_net_ff.h
> +++ b/include/uapi/linux/virtio_net_ff.h
> @@ -12,6 +12,8 @@
>  #define VIRTIO_NET_FF_SELECTOR_CAP 0x801
>  #define VIRTIO_NET_FF_ACTION_CAP 0x802
>  
> +#define VIRTIO_NET_RESOURCE_OBJ_FF_GROUP 0x0200
> +
>  struct virtio_net_ff_cap_data {
>  	__le32 groups_limit;
>  	__le32 classifiers_limit;
> @@ -52,4 +54,9 @@ struct virtio_net_ff_actions {
>  	__u8 reserved[7];
>  	__u8 actions[];
>  };
> +
> +struct virtio_net_resource_obj_ff_group {
> +	__le16 group_priority;
> +};
> +
>  #endif
> -- 
> 2.45.0

