Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB572E3397
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 07:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763537826; cv=none; b=EQHoODh2/imOtc0doJDJfy6pQnJkM60HEL8x4fCltrGEt/qgBpL/WXpECkstuTTyL0dmf/ODb3hHHYZ3Q+aHRSZH0OYFnRUCnja2jrqEAAxcdR9Fh+F7ULXCYVWaQjpuuhHcHHzc8hvxiVE7cdarLNFVNuQgZpOn6IY9D5YTxxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763537826; c=relaxed/simple;
	bh=cmtU4gPsNitt6wi6TsmuAXEhTT++xLKyo8o0jqXT8gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Gz1m62zL453kuvGuBI5tPCN0BP6DfrlsGww51hFUGyG7aOzw4vgk1TUiQvanizdMjBHoXh8d/v/H4e34Klgf0GRZVlLtBP7halzKF4LQ8sAbjTw8vhuNUc5SsCd5VKbd+VhqobGul0tUjYghEoHy7yU0+drj4oip2g7GNab8tbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LJ2Snrvy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LJ2Snrvy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763537823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f0GO7js7Nzcb9CILh+UVwGdqet9Y6vrdD2ygmkgwObQ=;
	b=LJ2SnrvyYXQ46YOQQfQsihcWSSyzEFqs2M60Utv4OJOTREv2jbW5E4PfDPtQbpaALM/mQj
	QnbpMq1q8YGUoZB3oKjBklNr4IldGrkgCBth5a4Np+z6tSqcvlS5nNyYDPoi2ZipSDh9A4
	Cj5n2wNwU9AH0nt9UrLS32bqCQpcMv4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-vmcLJl6YPUCUgIDXHZ0hCg-1; Wed, 19 Nov 2025 02:37:02 -0500
X-MC-Unique: vmcLJl6YPUCUgIDXHZ0hCg-1
X-Mimecast-MFC-AGG-ID: vmcLJl6YPUCUgIDXHZ0hCg_1763537819
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42b3c965ce5so4285513f8f.2
        for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 23:37:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763537818; x=1764142618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0GO7js7Nzcb9CILh+UVwGdqet9Y6vrdD2ygmkgwObQ=;
        b=oUVQCuKcrif4kVwD0eitp5Oz4wqsWN9PwySQJxlnvWZolaOsjNgXN+kWztD0dDS8nh
         RSb3VgDCGI+/TiYfzC2XyWrLhJ5QD9K/qPxoiwxXmNp2364hGgLMIOEu3wjD30fM1Zpx
         jpqZMr5pfW2Zwyz1qRmbFwcV/ky0uxWQXsMYoE7b76lNezpWL4wru06dphlqrXm2MDHd
         e/QbIFGUyPnykVzS4/07IJvsdzRJWIrnu3cOgirgL1v7+5cWw2bg/cSOYnjOPZHGQlE7
         YET4yZTu54x7A68I/AFJ5+uEzfR+YJY03d/Dl6tLG6lVsGuMGaukNcuzi/sVdsaIsce7
         ENmw==
X-Forwarded-Encrypted: i=1; AJvYcCW/chtWiOreGuV3jFzyu9jhDevMd80vwt+LZS5nVkPYgs03yKliFk/u+8sgGt/thiVcNiPrLee/LOxJFvWbZA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxypybOrJaTPK4eZaHLk0KxElO3o61cJXZNKTcFSAcgY4EdwJ8e
	GKgs8ngeude2tkLdtO6TwhdYdelbSnsfpZD86VyaYjbLUHHkCQyI0MFehZXsgqdWVKohJWZUDju
	re6gK9wZ9s/5/gNGKi5fNpd6gQz57qVoFpbh4HdbnVNu16lbU6mf4GFbBuDinrymwkTKn
X-Gm-Gg: ASbGncvrzAfL91iNz6ym5482Uk++6xKS2kztDYqItLEWGDm/foJ+8whaZBr7JlH5ayL
	hfRotTakYjGmfQ+8QnIxVgBsolUroTFGsMjpkUEI4qW6FSdZgICZFqDPh/orA9f3NOpb0kKgrom
	MQyECw3I5uqhhy4LHrveWo0x6jpom9TU+Wl5ZegcufLvYxLu6agpRMoLtAjpmFUTzPD/gXe2oSZ
	FiU4jQ7ktEL3tQOyaspo9GQYGqYnRjw+OXP5oW5NUXP/a7BKUwDil3E0TUE6lo9YBF4jpgBe2Cm
	bxv02+kpzaGMS7nRtrt3icKNWkae8QX0OdG65DP1eg3Fr4JySpRfv/xIxP029Qv752sYBa2trYk
	gdJIHwj1mnoHSY5/AF7+yD3QRftA7cQ==
X-Received: by 2002:a05:6000:1ace:b0:429:d6dc:ae10 with SMTP id ffacd0b85a97d-42b59385bc3mr19572577f8f.29.1763537818435;
        Tue, 18 Nov 2025 23:36:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE38OxUIXqfpq4weRteGFX8sC7MBmLIWf7WZAfGxmzVD/+o9SG94zeJxoMbsiZGgOokbhQwrQ==
X-Received: by 2002:a05:6000:1ace:b0:429:d6dc:ae10 with SMTP id ffacd0b85a97d-42b59385bc3mr19572540f8f.29.1763537817915;
        Tue, 18 Nov 2025 23:36:57 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e845bdsm35079172f8f.12.2025.11.18.23.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 23:36:57 -0800 (PST)
Date: Wed, 19 Nov 2025 02:36:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 02/12] virtio: Add config_op for admin
 commands
Message-ID: <20251119023455-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-3-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251118143903.958844-3-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YuWPFVj2_MqKsh-3-OiW14l79ks9F7Qsviv7uTAnQmQ_1763537819
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 18, 2025 at 08:38:52AM -0600, Daniel Jurgens wrote:
> This will allow device drivers to issue administration commands.
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> 
> ---
> v4: New patch for v4
> ---
>  drivers/virtio/virtio_pci_modern.c | 2 ++
>  include/linux/virtio_config.h      | 6 ++++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index ff11de5b3d69..acc3f958f96a 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -1236,6 +1236,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
>  	.get_shm_region  = vp_get_shm_region,
>  	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
>  	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
> +	.admin_cmd_exec = vp_modern_admin_cmd_exec,
>  };
>  
>  static const struct virtio_config_ops virtio_pci_config_ops = {
> @@ -1256,6 +1257,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
>  	.get_shm_region  = vp_get_shm_region,
>  	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
>  	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
> +	.admin_cmd_exec = vp_modern_admin_cmd_exec,
>  };
>  
>  /* the PCI probing function */
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 16001e9f9b39..19606609254e 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -108,6 +108,10 @@ struct virtqueue_info {
>   *	Returns 0 on success or error status
>   *	If disable_vq_and_reset is set, then enable_vq_after_reset must also be
>   *	set.
> + * @admin_cmd_exec: Execute an admin VQ command.

should say (optional) since only pci implements this so far
and callers check it.


> + *	vdev: the virtio_device
> + *	cmd: the command to execute
> + *	Returns 0 on success or error status
>   */
>  struct virtio_config_ops {
>  	void (*get)(struct virtio_device *vdev, unsigned offset,
> @@ -137,6 +141,8 @@ struct virtio_config_ops {
>  			       struct virtio_shm_region *region, u8 id);
>  	int (*disable_vq_and_reset)(struct virtqueue *vq);
>  	int (*enable_vq_after_reset)(struct virtqueue *vq);
> +	int (*admin_cmd_exec)(struct virtio_device *vdev,
> +			      struct virtio_admin_cmd *cmd);
>  };
>  
>  /**
> -- 
> 2.50.1

