Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711C710953
	for <virtualization@lists.linux.dev>; Fri, 23 Aug 2024 07:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724396666; cv=none; b=qKoT16CHr2Gp/HdtMG/0BrO71GFgl0C9PN7vAN6HA/dj9cMecJ0XQnbevMHj0UuC7AIgcUjzHgM/h2a0opXtnREUTQgmS4J8pD9kwejapfQ7pisgkpPfGhWtvoEJZCoOPhFw1NvDmWv8X2asA9aNQQCAbSqXEvfTwiTqDQXNE3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724396666; c=relaxed/simple;
	bh=10dJkZmJLKRX1TSqlZvXZCZ5bG8XvZiEhB0six3b+TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UPe387fPNpnRwNnduMQCT3FyLO5x0q7Qe/Fwie6nfoD4ItbfGb2+m4SNsT8sN5IbD5JtizHHiJqly1h9OWL9vIrA1ppP7a+w/ck7rNeOh97XVmOw8E36c4mhzmtVumwUfIKS5myONzZZw9Z/pSZqvU74gFJV0sfBGYGm4BPPRUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZUbtFeuf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZUbtFeuf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724396663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pDT0JRgI2md7crLLm9P6/RlRyF91EoM9zgMo2dMluV0=;
	b=ZUbtFeufjT6VGt5rbJsmyxf3ofVjMzz5kcO8zVUUYB0kKSXNtSnAgdeGZGu8ScgM3b/6gG
	ZcodupnrcyWNr0vgpdfVWvk6SGUGz+9h4Uu4ILNrbDLKbqDXz5v7yhlL3G/m3/qJApoyal
	SJW7Dvzg0olxPH/MPARuf+Or10HG/bg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-fg5V0--HM5aejzr-tRIEmA-1; Fri,
 23 Aug 2024 03:04:22 -0400
X-MC-Unique: fg5V0--HM5aejzr-tRIEmA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3EC701955D4A;
	Fri, 23 Aug 2024 07:04:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.194.20])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CDCCE19560A3;
	Fri, 23 Aug 2024 07:04:18 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 84F001800629; Fri, 23 Aug 2024 09:04:16 +0200 (CEST)
Date: Fri, 23 Aug 2024 09:04:16 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: David Airlie <airlied@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Daniel Vetter <daniel@ffwll.ch>, 
	Javier Martinez Canillas <javierm@redhat.com>, dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev
Subject: Re: [PATCH 1/2] drm/virtio: Defer the host dumb buffer creation
Message-ID: <mlqofcqa2yki43bkcl2kq6wfwchmkisnybbadd32khln5tv4ux@u4xuf6gumcqa>
References: <20240822172338.698922-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240822172338.698922-1-jfalempe@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> +static void virtio_gpu_deferred_create(struct virtio_gpu_object *bo,
> +				       struct virtio_gpu_device *vgdev,
> +				       const struct drm_mode_fb_cmd2 *mode_cmd)
> +{
> +	struct virtio_gpu_object_params params = { 0 };
> +
> +	params.format = virtio_gpu_translate_format(mode_cmd->pixel_format);
> +	params.width = mode_cmd->width;
> +	params.height = mode_cmd->height;
> +	params.size = params.height * params.width * 4;
> +	params.size = ALIGN(params.size, PAGE_SIZE);
> +	params.dumb = true;

I'd suggest to simply store the complete virtio_gpu_object_params struct
in virtio_gpu_object instead of re-creating it here.

> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index 64c236169db88..8d1e8dcfa8c15 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -93,6 +93,9 @@ struct virtio_gpu_object {
>  	bool dumb;
>  	bool created;
>  	bool host3d_blob, guest_blob;
> +	bool deferred;
> +	struct virtio_gpu_mem_entry *ents;
> +	unsigned int nents;
>  	uint32_t blob_mem, blob_flags;

Put them into a new block separated by newline, add a comment saying
those are needed for virtio_gpu_deferred_create?

> @@ -229,9 +231,14 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
>  						  objs, fence);
>  		virtio_gpu_object_attach(vgdev, bo, ents, nents);
>  	} else {
> -		virtio_gpu_cmd_create_resource(vgdev, bo, params,
> -					       objs, fence);
> -		virtio_gpu_object_attach(vgdev, bo, ents, nents);
> +		/* Fence is used only with blob or virgl */
> +		WARN_ONCE(fence != NULL, "deferred doesn't support fence\n");

Additionally check for param->dumb to take the deferred code path?  That
should make sure there is no fence.

take care,
  Gerd

