Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B4F1DF261
	for <virtualization@lists.linux.dev>; Fri, 26 Sep 2025 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758898799; cv=none; b=SGWYYRfcZkCqktcXys3CMFIBkeJ3nACm/vkIMORUabhhQVGWWWjkFfEaFgFJM+WHJsq8562QDVCjz+yFAbmAalJO4Ajhcj2KTW170boYMCeWHxYRYQgPVszj/Uytqkm+eiDJo22B0v8Sy9j84Mt1SMIb/tcu2uT69GDrQln9MDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758898799; c=relaxed/simple;
	bh=KI7kp6WM2WzZ9+hspxmsiOeR2W34s6buSt0JdUpZ46g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=EwiBveMOFW4NPAZIFTwB4EBmSzEsALHSdGMndMoS/DekE8383R+nZgs2OdYylFXJQltrd8Vt8lQrsW20f6lPRUbxdE4X7I9tCjHyJcqwMaFX0fzfQO8uKCrDs//Ws3y61KNQpQhLr7HEiPzvracPL9Q0R+lMaapI7NlotfVWvy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CgWC0AMz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CgWC0AMz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758898794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6I7dZDs73n8U+ResplTjCjySoUe7cbKd7TavFeUOHrU=;
	b=CgWC0AMzb/DNa/YvP2r6Mr36SsAyujoMYukq81E+NbIPswiUGH80h1072h76bSJPGutQdG
	V4ccge+tGqITrxggInasC96B38sppnBFkDbd7B6pi/YCk7w2NVlAejAL/l7+fUwS2HT/Gb
	jZONHwt53j7suNDnPkncSSRzxFhKISs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-MgTJUtAmMgCGNf8yQhJtdA-1; Fri, 26 Sep 2025 10:59:53 -0400
X-MC-Unique: MgTJUtAmMgCGNf8yQhJtdA-1
X-Mimecast-MFC-AGG-ID: MgTJUtAmMgCGNf8yQhJtdA_1758898792
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ee13e43dd9so1129071f8f.1
        for <virtualization@lists.linux.dev>; Fri, 26 Sep 2025 07:59:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758898792; x=1759503592;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6I7dZDs73n8U+ResplTjCjySoUe7cbKd7TavFeUOHrU=;
        b=ejO1Uc8YhW2hWUYFJFxe2emRKM/R0pCb8oaCwvlsn8as/RQ2fA89svdFT7fBpcZxps
         R2DCLGCYM5Bdqs5ysthdUO4vF5tnjIw3I7wnj6baO45G/EdvlIE0ueZQaszUnTUd8yTm
         f4rW2DBl2bvVgCR2GQcj5Ycg0Jquige+dn1O+4AOiHAvD3S+wzypH6S9LgEQqRUhsrIE
         PAimjNzlRgPa0P+C649bPYUdzWkK9mqrKpZo0H5OJcmBrVL1Ib9UTlpdnpJ9/S5LhQWp
         TezTg5HUZalTgcvwnJZV0FbnoK198/YxhvUkYw6F0cga1OBE1v2qmteHSNAWM1AGHH95
         iGug==
X-Forwarded-Encrypted: i=1; AJvYcCXGyNlh9O8b9EfFxKFNmV8QgX+vu2QyKX6rBjzQifE3xpk4UUFfEyDIN/9qZNmcz11bDON1yvWoGIaLVsPLwA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzYr+XayYPCxQynH131x/YVJDTjxiUIRg0tr/OfHxEKIimg8x0g
	AVbii6SYKx2jb21kujXJPR4s3KgrnyoN4YfeZO6to7xCWlA9g+ChZZwu/68Q+vdKAvM/0IMts/y
	uX2KF5A8uXN3+h5qFgKGtHoUxnhd8NzcUrY1QD7NBt8svo2D5C9h9j+2i7FXSWwkzGlQv
X-Gm-Gg: ASbGncsc3QHNfgCE0HoRUrNy1RX60k68viChip/ocy6rK8y0fIYALtidJ/vvrkldL2Q
	Baw0ejGSX20riEgTzu7ZInrrdS6Xtp5POzEnQLY6ygXDMOQy11cyP3TJ6BQqRxHl07o5tpn4KMp
	dqH+cXmUDjdfrdgz2W0jkdWjgbmruaOwNN2WGuq6ye/gmmEpyUHyu+NtZFxX7hVQkF2i13La50V
	TRHtFYb7YuQcbIFM1vP6OycRTLIKKHAm0CYH+asxsgWbYjdMf/KhR63CMq53KLnc7uKEMOQC97V
	D54In49fCN84muia+yh0NzL5mXhuoRKMv30=
X-Received: by 2002:a05:6000:25c3:b0:3ec:6259:5096 with SMTP id ffacd0b85a97d-40e45b8770fmr6452394f8f.21.1758898791563;
        Fri, 26 Sep 2025 07:59:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKbeikSLSfJK1LRxBBJjYur1fJkipbe+xVUW/caJ5fRdhGYcv5hRM+HYX2542boZmkN/QnQA==
X-Received: by 2002:a05:6000:25c3:b0:3ec:6259:5096 with SMTP id ffacd0b85a97d-40e45b8770fmr6452358f8f.21.1758898790914;
        Fri, 26 Sep 2025 07:59:50 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-410f2007372sm6491991f8f.16.2025.09.26.07.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 07:59:50 -0700 (PDT)
Date: Fri, 26 Sep 2025 10:59:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cindy Lu <lulu@redhat.com>,
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>,
	jasowang@redhat.com
Subject: Re: [PATCH v5 3/6] vduse: add vq group support
Message-ID: <20250926105938-mutt-send-email-mst@kernel.org>
References: <20250926101432.2251301-1-eperezma@redhat.com>
 <20250926101432.2251301-4-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250926101432.2251301-4-eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fLiZsFvscO3I_L_7e991uJXq7U172IoveWdQjlx3yvw_1758898792
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Sep 26, 2025 at 12:14:29PM +0200, Eugenio Pérez wrote:
> This allows sepparate the different virtqueues in groups that shares the

separate

> same address space.  Asking the VDUSE device for the groups of the vq at
> the beginning as they're needed for the DMA API.
> 
> Allocating 3 vq groups as net is the device that need the most groups:
> * Dataplane (guest passthrough)
> * CVQ
> * Shadowed vrings.
> 
> Future versions of the series can include dynamic allocation of the
> groups array so VDUSE can declare more groups.
> 
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> ---
> v5:
> * Revert core vdpa changes (Jason).
> * Fix group == ngroup case in checking VQ_SETUP argument (Jason).
> 
> v4:
> * Revert the "invalid vq group" concept and assume 0 if not set (Jason).
> * Make config->ngroups == 0 invalid (Jason).
> 
> v3:
> * Make the default group an invalid group as long as VDUSE device does
>   not set it to some valid u32 value.  Modify the vdpa core to take that
>   into account (Jason).
> * Create the VDUSE_DEV_MAX_GROUPS instead of using a magic number
> 
> v2:
> * Now the vq group is in vduse_vq_config struct instead of issuing one
>   VDUSE message per vq.
> 
> v1:
> * Fix: Remove BIT_ULL(VIRTIO_S_*), as _S_ is already the bit (Maxime)
> 
> RFC v3:
> * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason).  It was set to a lower
>   value to reduce memory consumption, but vqs are already limited to
>   that value and userspace VDUSE is able to allocate that many vqs.
> * Remove the descs vq group capability as it will not be used and we can
>   add it on top.
> * Do not ask for vq groups in number of vq groups < 2.
> * Move the valid vq groups range check to vduse_validate_config.
> 
> RFC v2:
> * Cache group information in kernel, as we need to provide the vq map
>   tokens properly.
> * Add descs vq group to optimize SVQ forwarding and support indirect
>   descriptors out of the box.
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 46 ++++++++++++++++++++++++++----
>  include/uapi/linux/vduse.h         | 12 ++++++--
>  2 files changed, 50 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 2b6a8958ffe0..99e37def7a83 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -40,6 +40,7 @@
>  #define DRV_LICENSE  "GPL v2"
>  
>  #define VDUSE_DEV_MAX (1U << MINORBITS)
> +#define VDUSE_DEV_MAX_GROUPS 0xffff
>  #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
>  #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
>  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> @@ -59,6 +60,7 @@ struct vduse_virtqueue {
>  	struct vdpa_vq_state state;
>  	bool ready;
>  	bool kicked;
> +	u32 vq_group;
>  	spinlock_t kick_lock;
>  	spinlock_t irq_lock;
>  	struct eventfd_ctx *kickfd;
> @@ -115,6 +117,7 @@ struct vduse_dev {
>  	u8 status;
>  	u32 vq_num;
>  	u32 vq_align;
> +	u32 ngroups;
>  	struct vduse_umem *umem;
>  	struct mutex mem_lock;
>  	unsigned int bounce_size;
> @@ -456,6 +459,7 @@ static void vduse_dev_reset(struct vduse_dev *dev)
>  		vq->driver_addr = 0;
>  		vq->device_addr = 0;
>  		vq->num = 0;
> +		vq->vq_group = 0;
>  		memset(&vq->state, 0, sizeof(vq->state));
>  
>  		spin_lock(&vq->kick_lock);
> @@ -593,6 +597,16 @@ static int vduse_vdpa_set_vq_state(struct vdpa_device *vdpa, u16 idx,
>  	return 0;
>  }
>  
> +static u32 vduse_get_vq_group(struct vdpa_device *vdpa, u16 idx)
> +{
> +	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> +
> +	if (dev->api_version < VDUSE_API_VERSION_1)
> +		return 0;
> +
> +	return dev->vqs[idx]->vq_group;
> +}
> +
>  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
>  				struct vdpa_vq_state *state)
>  {
> @@ -790,6 +804,7 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
>  	.set_vq_cb		= vduse_vdpa_set_vq_cb,
>  	.set_vq_num             = vduse_vdpa_set_vq_num,
>  	.get_vq_size		= vduse_vdpa_get_vq_size,
> +	.get_vq_group		= vduse_get_vq_group,
>  	.set_vq_ready		= vduse_vdpa_set_vq_ready,
>  	.get_vq_ready		= vduse_vdpa_get_vq_ready,
>  	.set_vq_state		= vduse_vdpa_set_vq_state,
> @@ -1253,12 +1268,24 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>  		if (config.index >= dev->vq_num)
>  			break;
>  
> -		if (!is_mem_zero((const char *)config.reserved,
> -				 sizeof(config.reserved)))
> +		if (dev->api_version < VDUSE_API_VERSION_1 && config.group)
> +			break;
> +
> +		if (dev->api_version >= VDUSE_API_VERSION_1) {
> +			if (config.group >= dev->ngroups)
> +				break;
> +			if (dev->status & VIRTIO_CONFIG_S_DRIVER_OK)
> +				break;
> +		}
> +
> +		if (config.reserved1 ||
> +		    !is_mem_zero((const char *)config.reserved2,
> +				 sizeof(config.reserved2)))
>  			break;
>  
>  		index = array_index_nospec(config.index, dev->vq_num);
>  		dev->vqs[index]->num_max = config.max_size;
> +		dev->vqs[index]->vq_group = config.group;
>  		ret = 0;
>  		break;
>  	}
> @@ -1738,12 +1765,20 @@ static bool features_is_valid(struct vduse_dev_config *config)
>  	return true;
>  }
>  
> -static bool vduse_validate_config(struct vduse_dev_config *config)
> +static bool vduse_validate_config(struct vduse_dev_config *config,
> +				  u64 api_version)
>  {
>  	if (!is_mem_zero((const char *)config->reserved,
>  			 sizeof(config->reserved)))
>  		return false;
>  
> +	if (api_version < VDUSE_API_VERSION_1 && config->ngroups)
> +		return false;
> +
> +	if (api_version >= VDUSE_API_VERSION_1 &&
> +	    (!config->ngroups || config->ngroups > VDUSE_DEV_MAX_GROUPS))
> +		return false;
> +
>  	if (config->vq_align > PAGE_SIZE)
>  		return false;
>  
> @@ -1859,6 +1894,7 @@ static int vduse_create_dev(struct vduse_dev_config *config,
>  	dev->device_features = config->features;
>  	dev->device_id = config->device_id;
>  	dev->vendor_id = config->vendor_id;
> +	dev->ngroups = (dev->api_version < 1) ? 1 : config->ngroups;
>  	dev->name = kstrdup(config->name, GFP_KERNEL);
>  	if (!dev->name)
>  		goto err_str;
> @@ -1937,7 +1973,7 @@ static long vduse_ioctl(struct file *file, unsigned int cmd,
>  			break;
>  
>  		ret = -EINVAL;
> -		if (vduse_validate_config(&config) == false)
> +		if (!vduse_validate_config(&config, control->api_version))
>  			break;
>  
>  		buf = vmemdup_user(argp + size, config.config_size);
> @@ -2018,7 +2054,7 @@ static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name)
>  
>  	vdev = vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->dev,
>  				 &vduse_vdpa_config_ops, &vduse_map_ops,
> -				 1, 1, name, true);
> +				 dev->ngroups, 1, name, true);
>  	if (IS_ERR(vdev))
>  		return PTR_ERR(vdev);
>  
> diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> index ccb92a1efce0..a3d51cf6df3a 100644
> --- a/include/uapi/linux/vduse.h
> +++ b/include/uapi/linux/vduse.h
> @@ -31,6 +31,7 @@
>   * @features: virtio features
>   * @vq_num: the number of virtqueues
>   * @vq_align: the allocation alignment of virtqueue's metadata
> + * @ngroups: number of vq groups that VDUSE device declares
>   * @reserved: for future use, needs to be initialized to zero
>   * @config_size: the size of the configuration space
>   * @config: the buffer of the configuration space
> @@ -45,7 +46,8 @@ struct vduse_dev_config {
>  	__u64 features;
>  	__u32 vq_num;
>  	__u32 vq_align;
> -	__u32 reserved[13];
> +	__u32 ngroups; /* if VDUSE_API_VERSION >= 1 */
> +	__u32 reserved[12];
>  	__u32 config_size;
>  	__u8 config[];
>  };
> @@ -122,14 +124,18 @@ struct vduse_config_data {
>   * struct vduse_vq_config - basic configuration of a virtqueue
>   * @index: virtqueue index
>   * @max_size: the max size of virtqueue
> - * @reserved: for future use, needs to be initialized to zero
> + * @reserved1: for future use, needs to be initialized to zero
> + * @group: virtqueue group
> + * @reserved2: for future use, needs to be initialized to zero
>   *
>   * Structure used by VDUSE_VQ_SETUP ioctl to setup a virtqueue.
>   */
>  struct vduse_vq_config {
>  	__u32 index;
>  	__u16 max_size;
> -	__u16 reserved[13];
> +	__u16 reserved1;
> +	__u32 group;
> +	__u16 reserved2[10];
>  };
>  
>  /*
> -- 
> 2.51.0

