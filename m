Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16CD18EB8
	for <virtualization@lists.linux.dev>; Wed,  3 Jul 2024 13:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720012323; cv=none; b=VxMtvPZlADjteDEjl/0IB5Cf+yyrfibi16razZjOh7zvV3ype/EDUIJHzH4oRh00enx0GHtj+azdDE4Q5oAj8c+CATL2k2kDb1HV6qD3GzPRI6bAKH3WkmOCyW9KMZ3peWrkBAeARm6ySzy9FNI6oXoihH6uTcOtg5sGSdx5R1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720012323; c=relaxed/simple;
	bh=8tct8RQTq/M7XlSlViXMgBrKEtxv0TRs6ewg+sITpkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=c63SMBg01J8Oqan/dDaF4mv+IpKJHW9Mb+eLTYfbbQU7qvqmPisFiPQQUgPB2dcwVFEZxO7K11FYRRf51pDzrDogNJpHW4V/5jZ2AROQIjIg/G2g425C2Sjp2Jodf6avVf+H2iv9RNkzkSpk2lmx1y/7DFmkPf/Qh6jebuP+6R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GNIhOtp/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GNIhOtp/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720012320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uVJdkDLjazJoF86nswRCXwcQ6H/UArSkg99ENtvvrxQ=;
	b=GNIhOtp/zvUsbebM+bD+/4HqtH4wB5o7iKmki4Cis6SNRrIsIvAn8QZAvvHQraOJpdTjFE
	FWJX6X9qMIf1g/YFq0bWgl+DsSJ8N6bwFYnfZ8f5msi78FGwf6qKkfmimGh7cw8msimoiQ
	ZGGWEMQg88q7FeL+D/fq5HrKcB1ZvdM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-FBOmXKSYN4iI6qobrIuNlA-1; Wed, 03 Jul 2024 09:11:58 -0400
X-MC-Unique: FBOmXKSYN4iI6qobrIuNlA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42490ae735dso49278195e9.0
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 06:11:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720012317; x=1720617117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVJdkDLjazJoF86nswRCXwcQ6H/UArSkg99ENtvvrxQ=;
        b=Aen4Sv96VYD/JRD8RXtsAqsQgApi23E9yj/4BwK8SqSNKPfHW3NsqoX2ANjV4AHMxR
         d1qbZbZQVzsnIqxkJmmbjnl2ZxuMxSTJSvRyc5l42tEcCKm2UpkKEH8mnxa/XldyjfJm
         Jj7J1wx7Wxb+Ve56v9A1RPMXBAbvDVrqKd/HVJoBAC28BFh6kjrWGqbuIst9cjh+lAKX
         976TRszW2hUg9pMihKJjRH6l4OipqDN2lKhkS71G2gMUC2I7LtJDsqCMvKosYkLfNmg1
         alKaVtv6iNWQD3y67hHCcK82S3XAOBNW5vuOjGryAiKUYUk6+f91slBZf1v7TJQ/XZso
         SoBg==
X-Gm-Message-State: AOJu0YxU2y2l9if3v0a1/jYET1J23NYwqORgXQYwE1JvPVr4huGsHd5S
	HrmgRzU7S5Bodhkm2UkUw7vMoATQ4+p+GNkABZd9QeV66gZncZSCWstYUNqj9RZmVhFDiTk0JR9
	lTQr90ANvRYoyQ3cSdP5O3vnNBJhUhmRd2Y2HUAl5qEs3vX8P3/AdNueKyvjoB6+N
X-Received: by 2002:a05:600c:458e:b0:425:88cb:1741 with SMTP id 5b1f17b1804b1-42588cb1985mr54924955e9.36.1720012316926;
        Wed, 03 Jul 2024 06:11:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLQyye+J3aGcjCLwtKxuSI4MLLRrko52E4wzOK7vaOrwBX51fy95LTz4gP1R4oIFbR08rInQ==
X-Received: by 2002:a05:600c:458e:b0:425:88cb:1741 with SMTP id 5b1f17b1804b1-42588cb1985mr54924585e9.36.1720012316220;
        Wed, 03 Jul 2024 06:11:56 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36793b39ef6sm1581145f8f.82.2024.07.03.06.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 06:11:55 -0700 (PDT)
Date: Wed, 3 Jul 2024 09:11:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, parav@nvidia.com,
	feliu@nvidia.com, hengqi@linux.alibaba.com
Subject: Re: [PATCH virtio 17/19] virtio: convert the rest virtio_find_vqs()
 users to virtio_find_vqs_info()
Message-ID: <20240703090519-mutt-send-email-mst@kernel.org>
References: <20240703123913.969202-1-jiri@resnulli.us>
 <20240703123913.969202-18-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240703123913.969202-18-jiri@resnulli.us>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 03, 2024 at 02:39:11PM +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Instead of passing separate names and callbacks arrays
> to virtio_find_vqs(), have one of virtual_queue_info structs and
> pass it to virtio_find_vqs_info().
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  arch/um/drivers/virt-pci.c                    |  8 ++++---
>  drivers/bluetooth/virtio_bt.c                 | 14 ++++-------
>  drivers/firmware/arm_scmi/virtio.c            | 11 ++++-----
>  drivers/gpio/gpio-virtio.c                    | 10 ++++----
>  drivers/gpu/drm/virtio/virtgpu_kms.c          |  9 ++++----
>  drivers/iommu/virtio-iommu.c                  | 11 ++++-----
>  drivers/net/wireless/virtual/mac80211_hwsim.c | 14 ++++-------
>  drivers/rpmsg/virtio_rpmsg_bus.c              |  8 ++++---
>  drivers/virtio/virtio_input.c                 |  9 ++++----
>  net/vmw_vsock/virtio_transport.c              | 17 +++++---------
>  sound/virtio/virtio_card.c                    | 23 ++++++++-----------
>  11 files changed, 59 insertions(+), 75 deletions(-)
> 
> diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
> index 7cb503469bbd..3df2ea53471a 100644
> --- a/arch/um/drivers/virt-pci.c
> +++ b/arch/um/drivers/virt-pci.c
> @@ -567,12 +567,14 @@ struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus)
>  
>  static int um_pci_init_vqs(struct um_pci_device *dev)
>  {
> +	struct virtio_queue_info vqs_info[] = {
> +		{ "cmd", um_pci_cmd_vq_cb },
> +		{ "irq", um_pci_irq_vq_cb },
> +	};
>  	struct virtqueue *vqs[2];
> -	static const char *const names[2] = { "cmd", "irq" };
> -	vq_callback_t *cbs[2] = { um_pci_cmd_vq_cb, um_pci_irq_vq_cb };
>  	int err, i;
>  
> -	err = virtio_find_vqs(dev->vdev, 2, vqs, cbs, names, NULL);
> +	err = virtio_find_vqs_info(dev->vdev, 2, vqs, vqs_info, NULL);
>  	if (err)
>  		return err;
>  
> diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
> index 463b49ca2492..6481f9fe24c4 100644
> --- a/drivers/bluetooth/virtio_bt.c
> +++ b/drivers/bluetooth/virtio_bt.c
> @@ -254,13 +254,9 @@ static void virtbt_rx_done(struct virtqueue *vq)
>  
>  static int virtbt_probe(struct virtio_device *vdev)
>  {
> -	vq_callback_t *callbacks[VIRTBT_NUM_VQS] = {
> -		[VIRTBT_VQ_TX] = virtbt_tx_done,
> -		[VIRTBT_VQ_RX] = virtbt_rx_done,
> -	};
> -	const char *names[VIRTBT_NUM_VQS] = {
> -		[VIRTBT_VQ_TX] = "tx",
> -		[VIRTBT_VQ_RX] = "rx",
> +	struct virtio_queue_info vqs_info[VIRTBT_NUM_VQS] = {
> +		[VIRTBT_VQ_TX] = { "tx", virtbt_tx_done },
> +		[VIRTBT_VQ_RX] = { "rx", virtbt_rx_done },
>  	};
>  	struct virtio_bluetooth *vbt;
>  	struct hci_dev *hdev;
> @@ -289,8 +285,8 @@ static int virtbt_probe(struct virtio_device *vdev)
>  
>  	INIT_WORK(&vbt->rx, virtbt_rx_work);
>  
> -	err = virtio_find_vqs(vdev, VIRTBT_NUM_VQS, vbt->vqs, callbacks,
> -			      names, NULL);
> +	err = virtio_find_vqs_info(vdev, VIRTBT_NUM_VQS, vbt->vqs,
> +				   vqs_info, NULL);
>  	if (err)
>  		return err;
>  
> diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
> index 4892058445ce..a6ae59c03308 100644
> --- a/drivers/firmware/arm_scmi/virtio.c
> +++ b/drivers/firmware/arm_scmi/virtio.c
> @@ -354,11 +354,9 @@ static void scmi_vio_deferred_tx_worker(struct work_struct *work)
>  	scmi_vio_channel_release(vioch);
>  }
>  
> -static const char *const scmi_vio_vqueue_names[] = { "tx", "rx" };
> -
> -static vq_callback_t *scmi_vio_complete_callbacks[] = {
> -	scmi_vio_complete_cb,
> -	scmi_vio_complete_cb
> +static struct virtio_queue_info scmi_vio_vqs_info[] = {
> +	{ "tx", scmi_vio_complete_cb },
> +	{ "rx", scmi_vio_complete_cb },
>  };
>  
>  static unsigned int virtio_get_max_msg(struct scmi_chan_info *base_cinfo)
> @@ -831,8 +829,7 @@ static int scmi_vio_probe(struct virtio_device *vdev)
>  	if (have_vq_rx)
>  		channels[VIRTIO_SCMI_VQ_RX].is_rx = true;
>  
> -	ret = virtio_find_vqs(vdev, vq_cnt, vqs, scmi_vio_complete_callbacks,
> -			      scmi_vio_vqueue_names, NULL);
> +	ret = virtio_find_vqs_info(vdev, vq_cnt, vqs, scmi_vio_vqs_info, NULL);
>  	if (ret) {
>  		dev_err(dev, "Failed to get %d virtqueue(s)\n", vq_cnt);
>  		return ret;
> diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
> index 9fae8e396c58..a45b392358c4 100644
> --- a/drivers/gpio/gpio-virtio.c
> +++ b/drivers/gpio/gpio-virtio.c
> @@ -457,15 +457,15 @@ static void virtio_gpio_free_vqs(struct virtio_device *vdev)
>  static int virtio_gpio_alloc_vqs(struct virtio_gpio *vgpio,
>  				 struct virtio_device *vdev)
>  {
> -	const char * const names[] = { "requestq", "eventq" };
> -	vq_callback_t *cbs[] = {
> -		virtio_gpio_request_vq,
> -		virtio_gpio_event_vq,
> +	struct virtio_queue_info vqs_info[] = {
> +		{ "requestq", virtio_gpio_request_vq },
> +		{ "eventq", virtio_gpio_event_vq },
>  	};

I'd maybe do struct virtio_queue_info vqs_info[2]
so it's clear array is the right size. 
Not a new issue so can be a separate cleanup.

>  	struct virtqueue *vqs[2] = { NULL, NULL };
>  	int ret;
>  
> -	ret = virtio_find_vqs(vdev, vgpio->irq_lines ? 2 : 1, vqs, cbs, names, NULL);
> +	ret = virtio_find_vqs_info(vdev, vgpio->irq_lines ? 2 : 1, vqs,
> +				   vqs_info, NULL);
>  	if (ret) {
>  		dev_err(&vdev->dev, "failed to find vqs: %d\n", ret);
>  		return ret;
> diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
> index 5a3b5aaed1f3..938c08a707eb 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
> @@ -116,11 +116,10 @@ static void virtio_gpu_get_capsets(struct virtio_gpu_device *vgdev,
>  
>  int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
>  {
> -	static vq_callback_t *callbacks[] = {
> -		virtio_gpu_ctrl_ack, virtio_gpu_cursor_ack
> +	struct virtio_queue_info vqs_info[] = {
> +		{ "control", virtio_gpu_ctrl_ack },
> +		{ "cursor", virtio_gpu_cursor_ack },
>  	};

I'd maybe do struct virtio_queue_info vqs_info[2]
so it's clear array is the right size. 
Not a new issue so can be a separate cleanup.

> -	static const char * const names[] = { "control", "cursor" };
> -
>  	struct virtio_gpu_device *vgdev;
>  	/* this will expand later */
>  	struct virtqueue *vqs[2];
> @@ -207,7 +206,7 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
>  	DRM_INFO("features: %ccontext_init\n",
>  		 vgdev->has_context_init ? '+' : '-');
>  
> -	ret = virtio_find_vqs(vgdev->vdev, 2, vqs, callbacks, names, NULL);
> +	ret = virtio_find_vqs_info(vgdev->vdev, 2, vqs, vqs_info, NULL);
>  	if (ret) {
>  		DRM_ERROR("failed to find virt queues\n");
>  		goto err_vqs;
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 9ed8958a42bf..ef77c1efc767 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -1094,14 +1094,13 @@ static struct iommu_ops viommu_ops = {
>  static int viommu_init_vqs(struct viommu_dev *viommu)
>  {
>  	struct virtio_device *vdev = dev_to_virtio(viommu->dev);
> -	const char *names[] = { "request", "event" };
> -	vq_callback_t *callbacks[] = {
> -		NULL, /* No async requests */
> -		viommu_event_handler,
> +	struct virtio_queue_info vqs_info[] = {

I'd maybe do struct virtio_queue_info vqs_info[VIOMMU_NR_VQS]
so it's clear array is the right size. 
Not a new issue so can be a separate cleanup.

> +		{ "request" },

Let's keep the comment here:
		{ "request", NULL /* No async requests */ },


> +		{ "event", viommu_event_handler },
>  	};
>  
> -	return virtio_find_vqs(vdev, VIOMMU_NR_VQS, viommu->vqs, callbacks,
> -			       names, NULL);
> +	return virtio_find_vqs_info(vdev, VIOMMU_NR_VQS, viommu->vqs,
> +				    vqs_info, NULL);
>  }
>  
>  static int viommu_fill_evtq(struct viommu_dev *viommu)
> diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
> index 20fa21bb4d1c..565c091f1ba5 100644
> --- a/drivers/net/wireless/virtual/mac80211_hwsim.c
> +++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
> @@ -6558,17 +6558,13 @@ static void hwsim_virtio_rx_done(struct virtqueue *vq)
>  
>  static int init_vqs(struct virtio_device *vdev)
>  {
> -	vq_callback_t *callbacks[HWSIM_NUM_VQS] = {
> -		[HWSIM_VQ_TX] = hwsim_virtio_tx_done,
> -		[HWSIM_VQ_RX] = hwsim_virtio_rx_done,
> -	};
> -	const char *names[HWSIM_NUM_VQS] = {
> -		[HWSIM_VQ_TX] = "tx",
> -		[HWSIM_VQ_RX] = "rx",
> +	struct virtio_queue_info vqs_info[HWSIM_NUM_VQS] = {
> +		[HWSIM_VQ_TX] = { "tx", hwsim_virtio_tx_done },
> +		[HWSIM_VQ_RX] = { "rx", hwsim_virtio_rx_done },
>  	};
>  
> -	return virtio_find_vqs(vdev, HWSIM_NUM_VQS,
> -			       hwsim_vqs, callbacks, names, NULL);
> +	return virtio_find_vqs_info(vdev, HWSIM_NUM_VQS,
> +				    hwsim_vqs, vqs_info, NULL);
>  }
>  
>  static int fill_vq(struct virtqueue *vq)
> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> index e9e8c1f7829f..440f1cc9157d 100644
> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> @@ -868,8 +868,10 @@ static void rpmsg_virtio_del_ctrl_dev(struct rpmsg_device *rpdev_ctrl)
>  
>  static int rpmsg_probe(struct virtio_device *vdev)
>  {
> -	vq_callback_t *vq_cbs[] = { rpmsg_recv_done, rpmsg_xmit_done };
> -	static const char * const names[] = { "input", "output" };
> +	struct virtio_queue_info vqs_info[] = {

I'd maybe do struct virtio_queue_info vqs_info[2]
so it's clear array is the right size. 
Not a new issue so can be a separate cleanup.

> +		{ "input", rpmsg_recv_done },
> +		{ "output", rpmsg_xmit_done },
> +	};
>  	struct virtqueue *vqs[2];
>  	struct virtproc_info *vrp;
>  	struct virtio_rpmsg_channel *vch = NULL;
> @@ -891,7 +893,7 @@ static int rpmsg_probe(struct virtio_device *vdev)
>  	init_waitqueue_head(&vrp->sendq);
>  
>  	/* We expect two virtqueues, rx and tx (and in this order) */
> -	err = virtio_find_vqs(vdev, 2, vqs, vq_cbs, names, NULL);
> +	err = virtio_find_vqs_info(vdev, 2, vqs, vqs_info, NULL);
>  	if (err)
>  		goto free_vrp;



>  
> diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
> index 1a730d6c0b55..e1491ad9eced 100644
> --- a/drivers/virtio/virtio_input.c
> +++ b/drivers/virtio/virtio_input.c
> @@ -185,13 +185,14 @@ static void virtinput_cfg_abs(struct virtio_input *vi, int abs)
>  
>  static int virtinput_init_vqs(struct virtio_input *vi)
>  {
> +	struct virtio_queue_info vqs_info[] = {
> +		{ "events", virtinput_recv_events },
> +		{ "status", virtinput_recv_status },
> +	};
>  	struct virtqueue *vqs[2];
> -	vq_callback_t *cbs[] = { virtinput_recv_events,
> -				 virtinput_recv_status };
> -	static const char * const names[] = { "events", "status" };
>  	int err;
>  
> -	err = virtio_find_vqs(vi->vdev, 2, vqs, cbs, names, NULL);
> +	err = virtio_find_vqs_info(vi->vdev, 2, vqs, vqs_info, NULL);

ARRAY_SIZE(vqs_info) is now possible instead of 2.
Can be a separate cleanup, though.


>  	if (err)
>  		return err;
>  	vi->evt = vqs[0];
> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index 43d405298857..d303ef4d9898 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -617,20 +617,15 @@ static void virtio_transport_rx_work(struct work_struct *work)
>  static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
>  {
>  	struct virtio_device *vdev = vsock->vdev;
> -	static const char * const names[] = {
> -		"rx",
> -		"tx",
> -		"event",
> -	};
> -	vq_callback_t *callbacks[] = {
> -		virtio_vsock_rx_done,
> -		virtio_vsock_tx_done,
> -		virtio_vsock_event_done,
> +	struct virtio_queue_info vqs_info[] = {
> +		{ "rx", virtio_vsock_rx_done },
> +		{ "tx", virtio_vsock_tx_done },
> +		{ "event", virtio_vsock_event_done },
>  	};
>  	int ret;
>  
> -	ret = virtio_find_vqs(vdev, VSOCK_VQ_MAX, vsock->vqs, callbacks, names,
> -			      NULL);
> +	ret = virtio_find_vqs_info(vdev, VSOCK_VQ_MAX, vsock->vqs, vqs_info,
> +				   NULL);
>  	if (ret < 0)
>  		return ret;
>  
> diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
> index 7805daea0102..a6b0da6790dc 100644
> --- a/sound/virtio/virtio_card.c
> +++ b/sound/virtio/virtio_card.c
> @@ -110,25 +110,22 @@ static void virtsnd_event_notify_cb(struct virtqueue *vqueue)
>  static int virtsnd_find_vqs(struct virtio_snd *snd)
>  {
>  	struct virtio_device *vdev = snd->vdev;
> -	static vq_callback_t *callbacks[VIRTIO_SND_VQ_MAX] = {
> -		[VIRTIO_SND_VQ_CONTROL] = virtsnd_ctl_notify_cb,
> -		[VIRTIO_SND_VQ_EVENT] = virtsnd_event_notify_cb,
> -		[VIRTIO_SND_VQ_TX] = virtsnd_pcm_tx_notify_cb,
> -		[VIRTIO_SND_VQ_RX] = virtsnd_pcm_rx_notify_cb
> -	};
> -	static const char *names[VIRTIO_SND_VQ_MAX] = {
> -		[VIRTIO_SND_VQ_CONTROL] = "virtsnd-ctl",
> -		[VIRTIO_SND_VQ_EVENT] = "virtsnd-event",
> -		[VIRTIO_SND_VQ_TX] = "virtsnd-tx",
> -		[VIRTIO_SND_VQ_RX] = "virtsnd-rx"
> +	struct virtio_queue_info vqs_info[] = {

Why not
	struct virtio_queue_info vqs_info[VIRTIO_SND_VQ_MAX] ?

otherwise it's not clear all arrays are same size.


> +		[VIRTIO_SND_VQ_CONTROL] = { "virtsnd-ctl",
> +					    virtsnd_ctl_notify_cb },
> +		[VIRTIO_SND_VQ_EVENT] = { "virtsnd-event",
> +					  virtsnd_event_notify_cb },
> +		[VIRTIO_SND_VQ_TX] = { "virtsnd-tx",
> +				       virtsnd_pcm_tx_notify_cb },
> +		[VIRTIO_SND_VQ_RX] = { "virtsnd-rx",
> +				       virtsnd_pcm_rx_notify_cb },
>  	};
>  	struct virtqueue *vqs[VIRTIO_SND_VQ_MAX] = { 0 };
>  	unsigned int i;
>  	unsigned int n;
>  	int rc;
>  
> -	rc = virtio_find_vqs(vdev, VIRTIO_SND_VQ_MAX, vqs, callbacks, names,
> -			     NULL);
> +	rc = virtio_find_vqs_info(vdev, VIRTIO_SND_VQ_MAX, vqs, vqs_info, NULL);
>  	if (rc) {
>  		dev_err(&vdev->dev, "failed to initialize virtqueues\n");
>  		return rc;
> -- 
> 2.45.2

