Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8233144D28
	for <virtualization@lists.linux.dev>; Fri,  5 Jul 2024 07:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720165434; cv=none; b=cAs8ZdY46qy1VZ1iUjBhgIZukiMX/5fyxRUevTttVG9yb9pj8m/dtAPMrJtcj77OlXfJF0bm+k2BS6sBj3DHF0hGRkkpQGmkQIz4uAW5xK/qTUiWd0XIhwpJwzRVbtfPhirBubM0Fpa/FbbkvHjJfsxE64kR4RzOaM8km+BLEV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720165434; c=relaxed/simple;
	bh=yMp/o0KF8sghb6QN7Ue1yHs/a2gkTVGWHyhUq8x+MHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=cnxU4XWTaW20wg2V9D+8W4q4to1IFm92TQHHr6cCDLQC/buqWVzVyW/Dfztf2/cO/EYPMOdCJOND6MmkQBw8YvTLsVJpGv8i6M9+Ll/YnlgqdSEwudDsObHa6x4kZgEPr7iqp1cKk7ot1rYHSgdunzPmLxUKKo8VxpLsToE1t7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SFatCeo0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SFatCeo0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720165431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=guw6UvRHl1c29uTh913l6v1VFnnOUH4SsG9WmrFlG+A=;
	b=SFatCeo0+oQ/FxStEdUHJHjAwmIUzwYRyZLsCLy8ad9Eu5wqCzXfNzeW2eJQtjhMJ41n0d
	8pfvcEs7+bsAEObpeLyumI7pRvZv3x+MSapJwbWX2zD9chTBRR+HBcoJznJtQbdmHqOS1X
	gwShp2kY/Dj3R1RTjpjEdA5Jv6urgRQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-kqLSJ4jTMnCjGHnPICVAuQ-1; Fri, 05 Jul 2024 03:43:49 -0400
X-MC-Unique: kqLSJ4jTMnCjGHnPICVAuQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4246cf4c87dso9399105e9.2
        for <virtualization@lists.linux.dev>; Fri, 05 Jul 2024 00:43:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720165428; x=1720770228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=guw6UvRHl1c29uTh913l6v1VFnnOUH4SsG9WmrFlG+A=;
        b=WG2zcl6cBqRfwoYYWimJju4BjNrBBorndJFktUH6qe5FnNfYlzMzdYeOxy4yszCL4r
         1mqxrT+K3PrBGcrHvFRN5+O4FsG262EMV9IaX+g3nqzDQxlhRvbG3JcR2Vvt75750sLw
         uBJ9hQkNGeoMHiwXXG/4kh2fiXaOepHyhWmlQ5kbxnyp7Fu2hv8x6Cs1zN2PRtjSQZoI
         p9Tyad52qDaK4l4ue8YIacUc4oNiv2nr0AH9f2yjahl00y6e7XANRNKlMYhv249KwTha
         bWesSNF8aIKp1Cwk2NHt4r7Xi5cAhBIo0NP1UOVP4KRUeIG8Q17nEz6DJtE5sQUwlaKR
         mPhg==
X-Gm-Message-State: AOJu0YwJNa7/f+o/lrn1cv3HNcK9lF/qppYaEqq5LMeTSbSXgm4vb4qr
	86sRfhWEAYeOLOPkaWdJI7+zYiAw/cNE87tEYg4wS5zzTNOwnIybXZMm/j0vomKvGwAfhIq6wTg
	g8nC6iD0Nt3st1NOFoVc9COezXlYdNaefcE9StKGxT2hwF4BLYKt+T+NwXtG5NbYO
X-Received: by 2002:a05:600c:4c15:b0:426:59ec:17a2 with SMTP id 5b1f17b1804b1-42659ec1a4cmr799975e9.33.1720165428065;
        Fri, 05 Jul 2024 00:43:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZzlAmCnztwRkJ0GinlEBF8QW5JES4RQryz9Ycm8Yk0TjPYvdANpXxNeeNN8rA85BLwhEo+w==
X-Received: by 2002:a05:600c:4c15:b0:426:59ec:17a2 with SMTP id 5b1f17b1804b1-42659ec1a4cmr799795e9.33.1720165427352;
        Fri, 05 Jul 2024 00:43:47 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:1b5b:ac5c:b82e:a18c:2c6e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36788e37b53sm8643748f8f.45.2024.07.05.00.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 00:43:46 -0700 (PDT)
Date: Fri, 5 Jul 2024 03:43:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, parav@nvidia.com,
	feliu@nvidia.com, hengqi@linux.alibaba.com
Subject: Re: [PATCH virtio v2 06/19] virtio: convert find_vqs() op
 implementations to find_vqs_info()
Message-ID: <20240705034127-mutt-send-email-mst@kernel.org>
References: <20240704064350.1097716-1-jiri@resnulli.us>
 <20240704064350.1097716-7-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240704064350.1097716-7-jiri@resnulli.us>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This is the riskiest patch.
Jiri, I'd ask you to cross-build it before posting,
wasn't done here.

On Thu, Jul 04, 2024 at 08:43:37AM +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Convert existing find_vqs() transport implementations
> to use find_vqs_info() config op.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
> v1->v2:
> - s/virtio_queue_info/virtqueue_info/
> ---
>  arch/um/drivers/virtio_uml.c             | 14 ++++++++------
>  drivers/platform/mellanox/mlxbf-tmfifo.c | 12 ++++++------
>  drivers/remoteproc/remoteproc_virtio.c   | 14 +++++++-------
>  drivers/s390/virtio/virtio_ccw.c         | 15 +++++++--------
>  drivers/virtio/virtio_mmio.c             | 14 +++++++-------
>  drivers/virtio/virtio_vdpa.c             | 15 +++++++--------
>  6 files changed, 42 insertions(+), 42 deletions(-)
> 
> diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
> index 77faa2cf3a13..c32a51017f9f 100644
> --- a/arch/um/drivers/virtio_uml.c
> +++ b/arch/um/drivers/virtio_uml.c
> @@ -1014,11 +1014,12 @@ static struct virtqueue *vu_setup_vq(struct virtio_device *vdev,
>  }
>  
>  static int vu_find_vqs(struct virtio_device *vdev, unsigned nvqs,
> -		       struct virtqueue *vqs[], vq_callback_t *callbacks[],
> -		       const char * const names[], const bool *ctx,
> +		       struct virtqueue *vqs[],
> +		       struct virtqueue_info vqs_info[],
>  		       struct irq_affinity *desc)
>  {
>  	struct virtio_uml_device *vu_dev = to_virtio_uml_device(vdev);
> +	struct virtqueue_info *vqi;
>  	int i, queue_idx = 0, rc;
>  	struct virtqueue *vq;
>  
> @@ -1031,13 +1032,14 @@ static int vu_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>  		return rc;
>  
>  	for (i = 0; i < nvqs; ++i) {
> -		if (!names[i]) {
> +		vqi = &vqs_info[i];

vqi better declared here, it's unused outside the loop.
same elsewhere.

> +		if (!vqi->name) {
>  			vqs[i] = NULL;
>  			continue;
>  		}
>  
> -		vqs[i] = vu_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
> -				     ctx ? ctx[i] : false);
> +		vqs[i] = vu_setup_vq(vdev, queue_idx++, vqi->callback,
> +				     vqi->name, vqi->ctx);
>  		if (IS_ERR(vqs[i])) {
>  			rc = PTR_ERR(vqs[i]);
>  			goto error_setup;
> @@ -1097,7 +1099,7 @@ static const struct virtio_config_ops virtio_uml_config_ops = {
>  	.get_status = vu_get_status,
>  	.set_status = vu_set_status,
>  	.reset = vu_reset,
> -	.find_vqs = vu_find_vqs,
> +	.find_vqs_info = vu_find_vqs,
>  	.del_vqs = vu_del_vqs,
>  	.get_features = vu_get_features,
>  	.finalize_features = vu_finalize_features,
> diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
> index b8d1e32e97eb..1497a5a0a68f 100644
> --- a/drivers/platform/mellanox/mlxbf-tmfifo.c
> +++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
> @@ -1058,13 +1058,12 @@ static void mlxbf_tmfifo_virtio_del_vqs(struct virtio_device *vdev)
>  static int mlxbf_tmfifo_virtio_find_vqs(struct virtio_device *vdev,
>  					unsigned int nvqs,
>  					struct virtqueue *vqs[],
> -					vq_callback_t *callbacks[],
> -					const char * const names[],
> -					const bool *ctx,
> +					struct virtqueue_info vqs_info[],
>  					struct irq_affinity *desc)
>  {
>  	struct mlxbf_tmfifo_vdev *tm_vdev = mlxbf_vdev_to_tmfifo(vdev);
>  	struct mlxbf_tmfifo_vring *vring;
> +	struct virtqueue_info *vqi;
>  	struct virtqueue *vq;
>  	int i, ret, size;
>  
> @@ -1072,7 +1071,8 @@ static int mlxbf_tmfifo_virtio_find_vqs(struct virtio_device *vdev,
>  		return -EINVAL;
>  
>  	for (i = 0; i < nvqs; ++i) {
> -		if (!names[i]) {
> +		vqi = &vqs_info[i];
> +		if (!vqi->name) {
>  			ret = -EINVAL;
>  			goto error;
>  		}
> @@ -1084,7 +1084,7 @@ static int mlxbf_tmfifo_virtio_find_vqs(struct virtio_device *vdev,
>  		vq = vring_new_virtqueue(i, vring->num, vring->align, vdev,
>  					 false, false, vring->va,
>  					 mlxbf_tmfifo_virtio_notify,
> -					 callbacks[i], names[i]);
> +					 vqi->callback, vqi->name);
>  		if (!vq) {
>  			dev_err(&vdev->dev, "vring_new_virtqueue failed\n");
>  			ret = -ENOMEM;
> @@ -1175,7 +1175,7 @@ static void tmfifo_virtio_dev_release(struct device *device)
>  static const struct virtio_config_ops mlxbf_tmfifo_virtio_config_ops = {
>  	.get_features = mlxbf_tmfifo_virtio_get_features,
>  	.finalize_features = mlxbf_tmfifo_virtio_finalize_features,
> -	.find_vqs = mlxbf_tmfifo_virtio_find_vqs,
> +	.find_vqs_info = mlxbf_tmfifo_virtio_find_vqs,
>  	.del_vqs = mlxbf_tmfifo_virtio_del_vqs,
>  	.reset = mlxbf_tmfifo_virtio_reset,
>  	.set_status = mlxbf_tmfifo_virtio_set_status,
> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> index 25b66b113b69..a82a7c13bdc5 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
> @@ -182,21 +182,21 @@ static void rproc_virtio_del_vqs(struct virtio_device *vdev)
>  
>  static int rproc_virtio_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>  				 struct virtqueue *vqs[],
> -				 vq_callback_t *callbacks[],
> -				 const char * const names[],
> -				 const bool * ctx,
> +				 struct virtqueue_info vqs_info[],
>  				 struct irq_affinity *desc)
>  {
> +	struct virtqueue_info *vqi;
>  	int i, ret, queue_idx = 0;
>  
>  	for (i = 0; i < nvqs; ++i) {
> -		if (!names[i]) {
> +		vqi = &vqs_info[i];
> +		if (!vqi->name) {
>  			vqs[i] = NULL;
>  			continue;
>  		}
>  
> -		vqs[i] = rp_find_vq(vdev, queue_idx++, callbacks[i], names[i],
> -				    ctx ? ctx[i] : false);
> +		vqs[i] = rp_find_vq(vdev, queue_idx++, vqi->callback,
> +				    vqi->name, vqi->ctx);
>  		if (IS_ERR(vqs[i])) {
>  			ret = PTR_ERR(vqs[i]);
>  			goto error;
> @@ -327,7 +327,7 @@ static void rproc_virtio_set(struct virtio_device *vdev, unsigned int offset,
>  static const struct virtio_config_ops rproc_virtio_config_ops = {
>  	.get_features	= rproc_virtio_get_features,
>  	.finalize_features = rproc_virtio_finalize_features,
> -	.find_vqs	= rproc_virtio_find_vqs,
> +	.find_vqs_info	= rproc_virtio_find_vqs,
>  	.del_vqs	= rproc_virtio_del_vqs,
>  	.reset		= rproc_virtio_reset,
>  	.set_status	= rproc_virtio_set_status,
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index d6491fc84e8c..1f1fa70cf09d 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -689,12 +689,11 @@ static int virtio_ccw_register_adapter_ind(struct virtio_ccw_device *vcdev,
>  
>  static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>  			       struct virtqueue *vqs[],
> -			       vq_callback_t *callbacks[],
> -			       const char * const names[],
> -			       const bool *ctx,
> +			       struct virtqueue_info vqs_info[],
>  			       struct irq_affinity *desc)
>  {
>  	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
> +	struct virtqueue_info *vqi;
>  	dma64_t *indicatorp = NULL;
>  	int ret, i, queue_idx = 0;
>  	struct ccw1 *ccw;
> @@ -705,14 +704,14 @@ static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>  		return -ENOMEM;
>  
>  	for (i = 0; i < nvqs; ++i) {
> -		if (!names[i]) {
> +		vqi = &vqs_info[i];
> +		if (!vq_info->name) {

typo. we got lucky you didn't write vqs_info otherwise
it would build but not work correctly.


>  			vqs[i] = NULL;
>  			continue;
>  		}
>  
> -		vqs[i] = virtio_ccw_setup_vq(vdev, queue_idx++, callbacks[i],
> -					     names[i], ctx ? ctx[i] : false,
> -					     ccw);
> +		vqs[i] = virtio_ccw_setup_vq(vdev, queue_idx++, vqi->callback,
> +					     vqi->name, vqi->ctx, ccw);
>  		if (IS_ERR(vqs[i])) {
>  			ret = PTR_ERR(vqs[i]);
>  			vqs[i] = NULL;
> @@ -1079,7 +1078,7 @@ static const struct virtio_config_ops virtio_ccw_config_ops = {
>  	.get_status = virtio_ccw_get_status,
>  	.set_status = virtio_ccw_set_status,
>  	.reset = virtio_ccw_reset,
> -	.find_vqs = virtio_ccw_find_vqs,
> +	.find_vqs_info = virtio_ccw_find_vqs,
>  	.del_vqs = virtio_ccw_del_vqs,
>  	.bus_name = virtio_ccw_bus_name,
>  	.synchronize_cbs = virtio_ccw_synchronize_cbs,
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 173596589c71..533aca85b745 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -489,13 +489,12 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned int in
>  
>  static int vm_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>  		       struct virtqueue *vqs[],
> -		       vq_callback_t *callbacks[],
> -		       const char * const names[],
> -		       const bool *ctx,
> +		       struct virtqueue_info vqs_info[],
>  		       struct irq_affinity *desc)
>  {
>  	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
>  	int irq = platform_get_irq(vm_dev->pdev, 0);
> +	struct virtqueue_info *vqi;
>  	int i, err, queue_idx = 0;
>  
>  	if (irq < 0)
> @@ -510,13 +509,14 @@ static int vm_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>  		enable_irq_wake(irq);
>  
>  	for (i = 0; i < nvqs; ++i) {
> -		if (!names[i]) {
> +		vqi = &vqs_info[i];
> +		if (!vqi->name) {
>  			vqs[i] = NULL;
>  			continue;
>  		}
>  
> -		vqs[i] = vm_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
> -				     ctx ? ctx[i] : false);
> +		vqs[i] = vm_setup_vq(vdev, queue_idx++, vqi->callback,
> +				     vqi->name, vqi->ctx);
>  		if (IS_ERR(vqs[i])) {
>  			vm_del_vqs(vdev);
>  			return PTR_ERR(vqs[i]);
> @@ -570,7 +570,7 @@ static const struct virtio_config_ops virtio_mmio_config_ops = {
>  	.get_status	= vm_get_status,
>  	.set_status	= vm_set_status,
>  	.reset		= vm_reset,
> -	.find_vqs	= vm_find_vqs,
> +	.find_vqs_info	= vm_find_vqs,
>  	.del_vqs	= vm_del_vqs,
>  	.get_features	= vm_get_features,
>  	.finalize_features = vm_finalize_features,
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index e803db0da307..dcf0c2b19a44 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -358,15 +358,14 @@ create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
>  
>  static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>  				struct virtqueue *vqs[],
> -				vq_callback_t *callbacks[],
> -				const char * const names[],
> -				const bool *ctx,
> +				struct virtqueue_info vqs_info[],
>  				struct irq_affinity *desc)
>  {
>  	struct virtio_vdpa_device *vd_dev = to_virtio_vdpa_device(vdev);
>  	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
>  	const struct vdpa_config_ops *ops = vdpa->config;
>  	struct irq_affinity default_affd = { 0 };
> +	struct virtqueue_info *vqi;
>  	struct cpumask *masks;
>  	struct vdpa_callback cb;
>  	bool has_affinity = desc && ops->set_vq_affinity;
> @@ -379,14 +378,14 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>  	}
>  
>  	for (i = 0; i < nvqs; ++i) {
> -		if (!names[i]) {
> +		vqi = &vqs_info[i];
> +		if (!vqi->name) {
>  			vqs[i] = NULL;
>  			continue;
>  		}
>  
> -		vqs[i] = virtio_vdpa_setup_vq(vdev, queue_idx++,
> -					      callbacks[i], names[i], ctx ?
> -					      ctx[i] : false);
> +		vqs[i] = virtio_vdpa_setup_vq(vdev, queue_idx++, vqi->callback,
> +					      vqi->name, vqi->ctx);
>  		if (IS_ERR(vqs[i])) {
>  			err = PTR_ERR(vqs[i]);
>  			goto err_setup_vq;
> @@ -470,7 +469,7 @@ static const struct virtio_config_ops virtio_vdpa_config_ops = {
>  	.get_status	= virtio_vdpa_get_status,
>  	.set_status	= virtio_vdpa_set_status,
>  	.reset		= virtio_vdpa_reset,
> -	.find_vqs	= virtio_vdpa_find_vqs,
> +	.find_vqs_info	= virtio_vdpa_find_vqs,
>  	.del_vqs	= virtio_vdpa_del_vqs,
>  	.get_features	= virtio_vdpa_get_features,
>  	.finalize_features = virtio_vdpa_finalize_features,
> -- 
> 2.45.2

