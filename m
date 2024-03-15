Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6FE199B0
	for <virtualization@lists.linux.dev>; Fri, 15 Mar 2024 11:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710500883; cv=none; b=d2ZgLb4cTT0mGGhtz4IvmkaUR8a0W/+0I2KZ3Pje7ngRZPx8A7R8pibkoRISjtLtqC8zGv/9AUgq11mgwbBxjvLbjpWTLxtVLGvo/ovJYCs7ALs/wDB/3aFxYm21ev2YHgzLNVCawbp1iXu5WF9+IG4zVR+EkDH4xdYBsa7UHsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710500883; c=relaxed/simple;
	bh=c4wYEZog0PRJdHImcM2djdT+hyrOHIVSPdATKeYj3MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DuFpFD4FJR7k9wOkCRln6xhiJr8NyQBh0Vl5RLgWMUnQEpmSGZn1k5efdpjplkuoMfJo/Hq/nLJ/fO1KUM/Wf3S/+GfP2jV4RvbZ0RVmpCZxj5BpSldFE2E7KpHzXIspIGxahgLt7zqc7uF+ePmT1ONSvJRHMWBCakAtcOVZEIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RmCGZqta; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RmCGZqta"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710500880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i6UwHobYGHdZn3NTbBWvSTPbK7asvqgJeqq7UigoLXg=;
	b=RmCGZqtabr0HuOAH7WbfzjggtlX8C8meC9F1/7Ogzj6IEs8QI3NcNkR+vLrRSSvXI+WJls
	SfZLd3MZ6O0u/+DvZEaI2eUBYwiGbixXhXGtnbu1Rt77oTZanPYPnssD5vF94VvUFJDo38
	3xuoCX6si6RZwgXmRq9A/P7gtueRo+8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-OTkyTVGuOByQei1OLWWneg-1; Fri, 15 Mar 2024 07:07:59 -0400
X-MC-Unique: OTkyTVGuOByQei1OLWWneg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-513c9f60a60so1931425e87.3
        for <virtualization@lists.linux.dev>; Fri, 15 Mar 2024 04:07:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710500877; x=1711105677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6UwHobYGHdZn3NTbBWvSTPbK7asvqgJeqq7UigoLXg=;
        b=FeiELnUDfnwk0LdDM2K8V8jDsGf6D3ZPfQ1K0ezc9bEUWDUvX1Gwv4npIrDrZua1AH
         sGrX/h7mvUnurrA+uuyoqn0ekcneKFcyPT7lZOCsviMHnIOoRp9rsWX7abqkMCYOXLOz
         gy9A1KxUhn6Wu7hzXwrbZmw0eYHZxcp5Rqoc5ooCWMUNBkf85112pt0+Udq9LfS3kGvD
         Ngy/SdGOCJK5XyIlmS4gNSpAR3KcbDM5/+qBFXdH5ADpOPum1uQbbWflCeW3Dgh0SjvS
         eNJImJPiEX5deCLyN7OhLDvewetViD7IRZOZTXNnfGyeCZTKKx8BZOGMvxzgRj7YwYfG
         evkg==
X-Forwarded-Encrypted: i=1; AJvYcCW3mXtK0v4WkUat/BEngiphk7gD5t8V5+IB8xbsUsynSCusKaV7snRe6O0cvI9Laq1lzat/Pu6v3ZNISpK2LOu9pRkZPqsG/E2kWY58YK4=
X-Gm-Message-State: AOJu0YzdsGaIEkyvtR1DNpFrSaTk16VG8njP4ZfE5VBByRFSSO+FRXyS
	Rm6BDJVvLorrXl2pjP1ZzCozjxIcCkZ+Tgi84Gq77XIyCCzFZnCpLiHCHHsN0BQ0KED1sblOYct
	9g018nypWXsYlMWGjbO+GHmb4o8Srd5nnukwJkPYAuaBYwIH5p8oRRC7LUHKj4UXG2kghrcAw
X-Received: by 2002:a19:644e:0:b0:512:c8f0:1954 with SMTP id b14-20020a19644e000000b00512c8f01954mr2982726lfj.0.1710500876817;
        Fri, 15 Mar 2024 04:07:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhJKkwhy+bsmkfKleXijIj/MlY0bxu7Yj1iuhmf7e6R7u0XC2hvAuYIjMdXb55v3fiyOFfJQ==
X-Received: by 2002:a19:644e:0:b0:512:c8f0:1954 with SMTP id b14-20020a19644e000000b00512c8f01954mr2982706lfj.0.1710500876284;
        Fri, 15 Mar 2024 04:07:56 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:3a04:e2ee:42e3:ba74:3b8e])
        by smtp.gmail.com with ESMTPSA id fb4-20020a05600c520400b004132901d73asm5376699wmb.46.2024.03.15.04.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 04:07:55 -0700 (PDT)
Date: Fri, 15 Mar 2024 07:07:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "gavin.liu" <gavin.liu@jaguarmicro.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, pbonzini@redhat.com,
	stefanha@redhat.com, virtualization@lists.linux.dev,
	angus.chen@jaguarmicro.com, yuxue.liu@jaguarmicro.com
Subject: Re: [PATCH] virtio_config: add device ready status check
Message-ID: <20240315070641-mutt-send-email-mst@kernel.org>
References: <20240315103125.1817-1-gavin.liu@jaguarmicro.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240315103125.1817-1-gavin.liu@jaguarmicro.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 15, 2024 at 06:31:25PM +0800, gavin.liu wrote:
> From: Yuxue Liu <yuxue.liu@jaguarmicro.com>
> 
> Under the VDPA framework, when the VDPA driver of a device sets the status
> to DRIVER OK,success is not guaranteed. The virtio driver should provide
> some protection or notification.
> 
> Signed-off-by: Yuxue Liu <yuxue.liu@jaguarmicro.com>
> ---
>  drivers/block/virtio_blk.c    |  4 +++-
>  drivers/net/virtio_net.c      |  7 ++++++-
>  include/linux/virtio_config.h | 14 ++++++++++++++
>  3 files changed, 23 insertions(+), 2 deletions(-)


And then what we are expected to change all drivers for this hack to
work? Suggest you instead have vdpa set broken flag and be done with it.

> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 42dea7601d87..14cabf662705 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1535,7 +1535,9 @@ static int virtblk_probe(struct virtio_device *vdev)
>  		set_disk_ro(vblk->disk, 1);
>  
>  	virtblk_update_capacity(vblk, false);
> -	virtio_device_ready(vdev);
> +	err = virtio_device_ready_safe(vdev);
> +	if (err)
> +		goto out_cleanup_disk;
>  
>  	/*
>  	 * All steps that follow use the VQs therefore they need to be
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index d7ce4a1011ea..0431fc9095ae 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -4808,7 +4808,12 @@ static int virtnet_probe(struct virtio_device *vdev)
>  		goto free_failover;
>  	}
>  
> -	virtio_device_ready(vdev);
> +	err = virtio_device_ready_safe(vdev);
> +	if (err) {
> +		pr_debug("virtio_net: setting device ready failed\n");
> +		rtnl_unlock();
> +		goto free_unregister_netdev;
> +	}
>  
>  	_virtnet_set_queues(vi, vi->curr_queue_pairs);
>  
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index da9b271b54db..de4e864952ef 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -301,6 +301,20 @@ void virtio_device_ready(struct virtio_device *dev)
>  	dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
>  }
>  
> +static inline
> +int virtio_device_ready_safe(struct virtio_device *dev)
> +{
> +	u8 status;
> +
> +	virtio_device_ready(dev);
> +	status = dev->config->get_status(dev);
> +	if (!(status & VIRTIO_CONFIG_S_DRIVER_OK)) {
> +		WARN_ON(1);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
>  static inline
>  const char *virtio_bus_name(struct virtio_device *vdev)
>  {
> -- 
> 2.43.0

