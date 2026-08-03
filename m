Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B808C331203
	for <virtualization@lists.linux.dev>; Mon,  3 Aug 2026 16:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785774449; cv=none; b=FH+AH9TqbG5KCK7JZZx4oM2yV0ugF8j21C/m+AGoZsuh9lGc04h5rzqA15W6TOxlpu3eeSROh2kyqvzKrVG9RsoniH97SA/iIw0AydMv6dMxkYC43WjAGiPyWw6E0n5wkN6K3uo74NJMJfkPG8xpH1Uw26u29T/xOJ9G2hZANxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785774449; c=relaxed/simple;
	bh=UF6O9F39J8n8fKJc/y8OVNohdfFt+8aJyoZuzER7254=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=GtHK8vZO/IWSL3AzKNJfRMwob6qzUOLUa2owV6t+AV+SuoGaW49zoP6UxRyJocu6OIOCF36c3qSV7mxFSsbg7QqsLwIKHu9puBaLGjO9hd4RKjuveBNsIzH0e5a2YBQqJvXQyosyAEFe7WnBGS5BfiruRCotUifDPX1YLKtBPC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DDnr5TTc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DDnr5TTc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785774446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IUqgLCxIKnIX8Jqf3kKgChjSUuGf8d0wCJjX0G98IIE=;
	b=DDnr5TTcI0juMBZhbOj2NxkIxKm6HqVbJpMlQAsWW7LIVspKJzMsxpIfNCMprUbkhAU9Yh
	ryXDkt9lHCSHW6bM4LQzzaMyHvcEyMgmII03Xa5ICRcAuGMkv8QS8jV9VCN+zB2IAl0eVu
	iKFULN9Hu0eaAYU6aYtmAiUUFif9PiA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-5hggbtx8OPm5BYdJFpe-lg-1; Mon, 03 Aug 2026 12:27:20 -0400
X-MC-Unique: 5hggbtx8OPm5BYdJFpe-lg-1
X-Mimecast-MFC-AGG-ID: 5hggbtx8OPm5BYdJFpe-lg_1785774439
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4955fd77c18so14444375e9.2
        for <virtualization@lists.linux.dev>; Mon, 03 Aug 2026 09:27:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785774439; x=1786379239;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IUqgLCxIKnIX8Jqf3kKgChjSUuGf8d0wCJjX0G98IIE=;
        b=R7Ptdov37Fa6r+LCQ8dtn8QlGENSrHGdWXHm50DkdMjTp78vjhiADreUVdh6dy9hdi
         nqq1hP4CaCnr8YS+TanQgunA7LTnRd5WsVmpCRZrVQUoKHvxhoevT2oap//nHHiYYEI9
         QfTHyhQXLmEEvx+LFKlVjqbE1/sE+jw32UsVG9mnCNxaFHyHhBdqM8FHyjozZZihp91/
         4aUYeIkQvEr6yDcNCKENt5DHFX8iJByyHQk6YuMEcNZVmoI5YNxKItAF32mO+DEU9EJ4
         pRk7oURuF8voG3GVuYvcfNgpzAtprymIue+9uVydiYC2TcdxAvJYPDT3AIyXod6tNsIp
         03Kw==
X-Forwarded-Encrypted: i=1; AHgh+RoMZtTMu1ixpGUYJ5ZM3suAQfbuIN/1O1Oy8oKAAImEM2IQlV3cfJ/3QhNDps5JMrzaOKhM6czasF1zypp6PA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5ozUZl4RuWYTBxCxan7UzFEa4hzm34RDLg48FgLUDZr6w0OU1
	BATPtWeLP8OdqLNEis23/12uvU0y4r/nvrBQ2IIqtsJX0j750iVAEFU4qYzcUusdqiwC/7KCyxE
	QN5oPtK+Xk2OYY/mxAAKhEo16ZgPkN5Z6aHfwM0WwfIF2dvn0KbgKvATylZUmCchGWzrL
X-Gm-Gg: AR+sD134jAH7U7klUOg69CJlyVwh9jp164KNZ6khmhKAdMSgI/BELcrAkofNZbSV4K6
	Zxqo8rIY6fWgpXx88ky8bnYUbArawT5yZ2wtS7k1QmqCvXuZoxyxEPUNzOf/WCR7X5c5fBxnJrc
	3we/n91HEsZLCBgGoqzbs2dUuubTXFHf4nJHzz2aCq0/+hqi6Mzz2JEki8OYUg6N2AFv4DFyumL
	78+QGfHx5lr3fX5QUuwRHEqgc7Ib/c3MDuyIDgANI2SHVp7nLkt+uNTEB3h9ChjoorL8dxxTWaL
	Ahf3tqFGW+sCB5W95CW1QRBM02SNL1mlWq6+DWX9gY+aWmRpXjC2/bxyD7qpCtC1OIGg311kD7D
	DFSy6LRXVqA+5l1NsAiG6xA==
X-Received: by 2002:a05:600c:8b54:b0:495:4859:8f9b with SMTP id 5b1f17b1804b1-4980c674f25mr283760775e9.9.1785774438903;
        Mon, 03 Aug 2026 09:27:18 -0700 (PDT)
X-Received: by 2002:a05:600c:8b54:b0:495:4859:8f9b with SMTP id 5b1f17b1804b1-4980c674f25mr283759915e9.9.1785774438409;
        Mon, 03 Aug 2026 09:27:18 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd458adc9sm36574846f8f.27.2026.08.03.09.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 09:27:17 -0700 (PDT)
Date: Mon, 3 Aug 2026 12:27:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shahar Shitrit <shshitrit@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com, yohadt@nvidia.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgg@ziepe.ca,
	kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
	edumazet@google.com, danielj@nvidia.com
Subject: Re: [PATCH net-next v21 06/13] virtio_net: Create a FF group for
 ethtool steering
Message-ID: <20260803122249-mutt-send-email-mst@kernel.org>
References: <20260803140721.1871678-1-shshitrit@nvidia.com>
 <20260803140721.1871678-7-shshitrit@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260803140721.1871678-7-shshitrit@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: u0U5IDaC3GoWIJOBZxiW4AY7exJNbf5p7iCSd1c5aTo_1785774439
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 03, 2026 at 05:07:14PM +0300, Shahar Shitrit wrote:
> From: Daniel Jurgens <danielj@nvidia.com>
> 
> All ethtool steering rules will go in one group, create it during
> initialization.
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
> ---
>  drivers/net/virtio_net.c           | 29 +++++++++++++++++++++++++++++
>  include/uapi/linux/virtio_net_ff.h | 15 +++++++++++++++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0d1f5a6cfd12..e11e42583243 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -287,6 +287,9 @@ static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc_qstat[] = {
>  	VIRTNET_STATS_DESC_TX_QSTAT(speed, ratelimit_packets, hw_drop_ratelimits),
>  };
>  
> +#define VIRTNET_FF_ETHTOOL_GROUP_PRIORITY 1

why 1 and not 0?

> +#define VIRTNET_FF_MAX_GROUPS 1
> +
>  struct virtnet_ff {
>  	struct virtio_device *vdev;
>  	bool ff_supported;
> @@ -5749,6 +5752,7 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
>  	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
>  			      sizeof(struct virtio_net_ff_selector) *
>  			      VIRTIO_NET_FF_MASK_TYPE_MAX;
> +	struct virtio_net_resource_obj_ff_group ethtool_group = {};
>  	struct virtio_admin_cmd_query_cap_id_result *cap_id_list;
>  	struct virtio_net_ff_selector *sel;
>  	unsigned long sel_types = 0;
> @@ -5839,6 +5843,12 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
>  	ff->ff_actions->count = min_t(u8, ff->ff_actions->count,
>  				      VIRTIO_NET_FF_ACTION_MAX);
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
> @@ -5886,6 +5896,19 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
>  	if (err)
>  		goto err_ff_action;
>  
> +	ethtool_group.group_priority = cpu_to_le16(VIRTNET_FF_ETHTOOL_GROUP_PRIORITY);
> +
> +	/* Use priority for the object ID. */

and how is this ok?
spec says:
 Each resource object has a unique resource object ID - a driver-assigned number
  in the range of 0 to \field{limit - 1}, where the \field{limit} is the maximum
  number set by the driver for this resource object type.

and limit here is 1, right?

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
> @@ -5913,6 +5936,12 @@ static void virtnet_ff_cleanup(struct virtnet_ff *ff)
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
> index f9e771a0baff..b0780e49df9f 100644
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
>  	__u8 actions[] __counted_by(count);
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
> 2.49.0

