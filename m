Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0C9340298
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 09:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763545007; cv=none; b=pZcubnQo91H33tjhA9cihWlOTzjsnRZ0dklOq4SpUC8fpKYgvrY+2CDblhpp4WrzBpsZQAdi87vYiXKmr6rCswXnuRqpU7tQN9iuCEY9YE54WNwVXFA6mhY3AUx1hkUwORXEoZQRw8nCDxayCAcT1umrWRnz37tIwe+smufOzl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763545007; c=relaxed/simple;
	bh=ddbxYFNYyxO0crczqbpFFeeu60pejIjeVYJrf2gzAO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=bHch1p1unh6DR6mYOtIO52Pn01RD6Wr4Ae7lColx6RIamWmLhoPnBOmL6vulvHou1YFmDJ7TzgkyMYcSdKq3v2P7QKVPZUDqhfQLu9HgkZ44AtjG+uAcU0ieBI55AugUaptY5/TVq9jilOg+AgKcgIQD9Vag/61At7YZku5qMus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qjhe9rZ7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qjhe9rZ7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763545004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bKG1jT74K/MRXdmPINAtGMWDRUANM+Qsoq8JeULmVME=;
	b=Qjhe9rZ7mRo28prql2ATC6jRFQvOi1kmhO2fs2s/PKJtUjW4+4aLvix4KtgOnJU7N/AZWz
	L60+JEJM9ItKFr2rItKOCHkw3Rx8Is/NVN/fUjmDAyEolBUUCeFfzCTnmXmTSTSqDZjz/N
	caKCjZWXQQtREFcrBFICkYwmphuR45Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-YlsnznsFNeOWqaf2A8lB-A-1; Wed, 19 Nov 2025 04:36:42 -0500
X-MC-Unique: YlsnznsFNeOWqaf2A8lB-A-1
X-Mimecast-MFC-AGG-ID: YlsnznsFNeOWqaf2A8lB-A_1763545001
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-429ca3e7245so2702506f8f.3
        for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 01:36:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763545001; x=1764149801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bKG1jT74K/MRXdmPINAtGMWDRUANM+Qsoq8JeULmVME=;
        b=hjRC6oUuZYJ4CHDiSVfdq1dKIA/sQXrBHBXsFZlv3KWERgjtW07CybGtOGNadDXV+u
         RlXJq4ecCJXgJoKjzVD2JCktyVOAZml9xjAhXG607FMAX+sb+dP4skRwRF+Axq/nPDb+
         aQ6GxZ3s/sy+iAi4KNlX5hAsjaF/MUs48DyYWn8ajmMYaLImZ8KGtKxWdi8XtDMdNfBB
         GB1hWVgEcbmzkt3EdX0Jg6ptT3ekuu6Y2eE9iQGQw2eSow7VYLwLEWMpiqDkPU3oTHQE
         HPb/ZEU7sC4lBDQA1MVPinwvrEY6ycxNINxxeM1JDhgfLmmgR//6YyPfKE2y7OqUnKwu
         CTbg==
X-Forwarded-Encrypted: i=1; AJvYcCVH/Pkrxbg3r7CV8JyHFin45LeVyacesWPGqrNYW5bKtCxdctEisiXSEuLZjagytIDmeW3AzNjeQtJgLJgvmQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyIReHk9V4ZDYBihPAQgl1buLqJCQfaF1PVfihbgtyEqTf+iisf
	RIvJE/6A9uWplje0KY9xbFZOKS9HwOVb/GQwDS3OjxXLHY5Az//gjDjZPi6jRphuQopl94Cvkxe
	SLLq6kNSMNumUJvloYNN8LleQ2TbZ4f+KVy56OKgOlN/ftZQo+stKs6Pq2Slb9oG8EIjr
X-Gm-Gg: ASbGncu0MmllylqtC05/ZY1tGK6QlcEdXFLDgEnyraSWebcS4H3fLvlFZhFTZARszxM
	USAV5VfN93FnHUExQbmL8k74NZ50OnH3Vi2sgiTBxnrJSDSH5FmDKhWoxAqD1sMMWRHWotDPLSJ
	HOQEnB7WGC4s6u4VAK1gAubD9Au3lDijbfggCfptZ9Ay3JiJov3iQCWA+RDblZuuYQBabb84RRw
	RQ0Mdp7PBreGGLj9tNyLYHhzwGjgIh6G4Kl+P4g87cW1vt/4NI7NyawYxgRfMXb4HsaWSBAK//7
	FXSmEFZpl7vc5u0OBzPfD/j8k7SZuYIsl4NR7DLjB4BtXcgwBuLfA+uz+zx0ZuRKIyuCn3WBgAd
	clMAFGpg+sof25Ip3kH5Fqg/4i6HkBg==
X-Received: by 2002:a05:6000:1786:b0:42b:3dbe:3a54 with SMTP id ffacd0b85a97d-42b59367325mr20283208f8f.17.1763545001397;
        Wed, 19 Nov 2025 01:36:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHusiVJhfbm3D902mT/wCPD/6mngLbvmdkL4QEKPOFz754t3oVY53OB2o+PC3ldDQcTxltm/A==
X-Received: by 2002:a05:6000:1786:b0:42b:3dbe:3a54 with SMTP id ffacd0b85a97d-42b59367325mr20283166f8f.17.1763545000872;
        Wed, 19 Nov 2025 01:36:40 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f206aasm37291606f8f.40.2025.11.19.01.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 01:36:40 -0800 (PST)
Date: Wed, 19 Nov 2025 04:36:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 06/12] virtio_net: Create a FF group for
 ethtool steering
Message-ID: <20251119043412-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-7-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251118143903.958844-7-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FXLVjbjr3SytMPZp0iK8465AuxZnXHybY3O4tWRo9c8_1763545001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 18, 2025 at 08:38:56AM -0600, Daniel Jurgens wrote:
> All ethtool steering rules will go in one group, create it during
> initialization.
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
> v4: Documented UAPI
> ---
>  drivers/net/virtio_net.c           | 29 +++++++++++++++++++++++++++++
>  include/uapi/linux/virtio_net_ff.h | 15 +++++++++++++++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 3615f45ac358..900d597726f7 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -284,6 +284,9 @@ static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc_qstat[] = {
>  	VIRTNET_STATS_DESC_TX_QSTAT(speed, ratelimit_packets, hw_drop_ratelimits),
>  };
>  
> +#define VIRTNET_FF_ETHTOOL_GROUP_PRIORITY 1
> +#define VIRTNET_FF_MAX_GROUPS 1
> +
>  struct virtnet_ff {
>  	struct virtio_device *vdev;
>  	bool ff_supported;
> @@ -6812,6 +6815,7 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
>  	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
>  			      sizeof(struct virtio_net_ff_selector) *
>  			      VIRTIO_NET_FF_MASK_TYPE_MAX;
> +	struct virtio_net_resource_obj_ff_group ethtool_group = {};
>  	struct virtio_admin_cmd_query_cap_id_result *cap_id_list;
>  	struct virtio_net_ff_selector *sel;
>  	size_t real_ff_mask_size;
> @@ -6895,6 +6899,12 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
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
> @@ -6932,6 +6942,19 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
>  	if (err)
>  		goto err_ff_action;
>  
> +	ethtool_group.group_priority = cpu_to_le16(VIRTNET_FF_ETHTOOL_GROUP_PRIORITY);
> +
> +	/* Use priority for the object ID. */
> +	err = virtio_admin_obj_create(vdev,
> +				      VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
> +				      VIRTNET_FF_ETHTOOL_GROUP_PRIORITY,
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

So this is set here and never cleared.

But we never recreate the group on restore (after suspend).

sounds like we need virtnet_ff_cleanup/virtnet_ff_init on the
suspend/restore path?

> @@ -6959,6 +6982,12 @@ static void virtnet_ff_cleanup(struct virtnet_ff *ff)
>  	if (!ff->ff_supported)
>  		return;
>  
> +	virtio_admin_obj_destroy(ff->vdev,
> +				 VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
> +				 VIRTNET_FF_ETHTOOL_GROUP_PRIORITY,
> +				 VIRTIO_ADMIN_GROUP_TYPE_SELF,
> +				 0);
> +
>  	kfree(ff->ff_actions);
>  	kfree(ff->ff_mask);
>  	kfree(ff->ff_caps);
> diff --git a/include/uapi/linux/virtio_net_ff.h b/include/uapi/linux/virtio_net_ff.h
> index bd7a194a9959..6d1f953c2b46 100644
> --- a/include/uapi/linux/virtio_net_ff.h
> +++ b/include/uapi/linux/virtio_net_ff.h
> @@ -12,6 +12,8 @@
>  #define VIRTIO_NET_FF_SELECTOR_CAP 0x801
>  #define VIRTIO_NET_FF_ACTION_CAP 0x802
>  
> +#define VIRTIO_NET_RESOURCE_OBJ_FF_GROUP 0x0200
> +
>  /**
>   * struct virtio_net_ff_cap_data - Flow filter resource capability limits
>   * @groups_limit: maximum number of flow filter groups supported by the device
> @@ -88,4 +90,17 @@ struct virtio_net_ff_actions {
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

