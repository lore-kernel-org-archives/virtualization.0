Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FC2216A0D
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Nov 2024 22:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730846876; cv=none; b=B1qnKXHIgXIrbvYIcREQLsi1rP4iBn+TNQ5ytuoW1euOg5UC3qwMnCeT4cT/1uk1M0jUWLBD+Ho/+OXpqqcK8EsxViJxw8cfHERI5RS68N7HX66+ir/Sd5sRZk8sgzj3o0M2EQjtSteAb31w/by0w2UgmeCHqQo3TRVUesECIWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730846876; c=relaxed/simple;
	bh=UVJwF2eaf7xMsubg3R8aYALiI2rmW6URHri5jD8fqG0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vGT/XtCee1IVijepuHgG55pBB242HbkFhOsIQ78qBp+tIMVzMA6gSJ9PQo/MY75xjdzV+54Yhs8ruFZBiPzyZLYL8LJbNb7EV9EuUA8o0+F2ll3YHEFOzFQBz/QPgEPFHzK5/mtXyuLmWNaR5Xkz2Kh2RjRskAGVcm2yfZbAqL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d3iAGG4T; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d3iAGG4T"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 28B6480F82
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Nov 2024 22:47:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 090WDX7g6DuF for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Nov 2024 22:47:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=alex.williamson@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 4690980F68
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4690980F68
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d3iAGG4T
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4690980F68
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Nov 2024 22:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730846871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hy6vVSgqfhi2pXpOuKAON40ShXvmgHmJPNdAjxfFg6o=;
	b=d3iAGG4TH8pBRrS9nGEdtm1KAC7Ey6LqxKstyZ7KVDyQ5wgEPgnjiRkzWq/jkHTUZh9UqI
	Ki6IAryzsr/gghp3wKJDqefc0jGRBzwX+qCgqcvLHZG/Q0YWAZWpcD1Z3kL9oq4O1cJFbC
	XCpSujul/ts0eSBOifJ+9B5pVDbXkQQ=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-0E670bcyNvCm4ZNVBPr8kA-1; Tue, 05 Nov 2024 17:47:50 -0500
X-MC-Unique: 0E670bcyNvCm4ZNVBPr8kA-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83ac0a1c419so31841239f.2
        for <virtualization@lists.linux-foundation.org>; Tue, 05 Nov 2024 14:47:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730846869; x=1731451669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hy6vVSgqfhi2pXpOuKAON40ShXvmgHmJPNdAjxfFg6o=;
        b=e7E1vFCgdZsuDOgOtPfJxBSkmIagjFbJ5qHxGBz5NPrQIOMiY9FuPeuBZZGrZ/DzeH
         j6Sf6zA99yF+seYdyYloM6Up7FdUJec3lVnLxo/3V2adeBUdbK97/ivbV5g5e0ywSa+F
         cRJ9NtCoZtgDR0sgTq07rYOs/Z3hBGuQkKSDbjZrP3nlRrWPKI1jh5Sh7L5plQHWd65F
         XJ51EPyUhZkKBxwFVp6Y7wUg5Vu7nxrjr3cLElYN4mbskQajLTVarZf4WOIa1jSNzz3M
         OsfYd752WNKNclZbjRRimSECqN2xdiS5+gCg5RLL5pifI6DYxbWIzP6vTpOjbVWK+ThB
         BKkA==
X-Forwarded-Encrypted: i=1; AJvYcCVs/6w1nT5lyCmRnIslJvsjR1WTUCNG0aJev7wjfC2IlRTbNedAjm7XdNNOirMJDOzs6vpkR1svdR8v6prc5w==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxibEbZvet167SlVkP1bpHhIf6VvJFcVN35SnrAsyBnWnmPsbAV
	ZH71ooe1WGCTrzbS4KYvECW/CghbZwC/EqpUW1Sm5XdVRIiLvL7h/jSwh30KnFPqEjCJHwn5dhq
	eFIzk3rU6l1KL+IcCy4pWjh9402DYT6w3Fixl4SDY/gOosRt+zFjj4ryuTCIC5jIO1ZXj9x4yZ/
	31L9E=
X-Received: by 2002:a5e:c919:0:b0:82a:a4f0:5084 with SMTP id ca18e2360f4ac-83b1c5f47acmr919530939f.4.1730846869598;
        Tue, 05 Nov 2024 14:47:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNvw0E95RflmRxC50MhBSYG+4byrWMcigcl8Qhn3x9uyhAjLjXSK8M8BAbkHM6fU8/t+sFHw==
X-Received: by 2002:a5e:c919:0:b0:82a:a4f0:5084 with SMTP id ca18e2360f4ac-83b1c5f47acmr919529239f.4.1730846869151;
        Tue, 05 Nov 2024 14:47:49 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de048bfc01sm2619901173.58.2024.11.05.14.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 14:47:48 -0800 (PST)
Date: Tue, 5 Nov 2024 15:47:46 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Cc: <mst@redhat.com>, <jasowang@redhat.com>, <jgg@nvidia.com>,
 <kvm@vger.kernel.org>, <virtualization@lists.linux-foundation.org>,
 <parav@nvidia.com>, <feliu@nvidia.com>, <kevin.tian@intel.com>,
 <joao.m.martins@oracle.com>, <leonro@nvidia.com>, <maorg@nvidia.com>
Subject: Re: [PATCH V1 vfio 5/7] vfio/virtio: Add support for the basic live
 migration functionality
Message-ID: <20241105154746.60e06e75.alex.williamson@redhat.com>
In-Reply-To: <20241104102131.184193-6-yishaih@nvidia.com>
References: <20241104102131.184193-1-yishaih@nvidia.com>
	<20241104102131.184193-6-yishaih@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Nov 2024 12:21:29 +0200
Yishai Hadas <yishaih@nvidia.com> wrote:
> diff --git a/drivers/vfio/pci/virtio/main.c b/drivers/vfio/pci/virtio/main.c
> index b5d3a8c5bbc9..e2cdf2d48200 100644
> --- a/drivers/vfio/pci/virtio/main.c
> +++ b/drivers/vfio/pci/virtio/main.c
...
> @@ -485,16 +478,66 @@ static bool virtiovf_bar0_exists(struct pci_dev *pdev)
>  	return res->flags;
>  }
>  
> +static int virtiovf_pci_init_device(struct vfio_device *core_vdev)
> +{
> +	struct virtiovf_pci_core_device *virtvdev = container_of(core_vdev,
> +			struct virtiovf_pci_core_device, core_device.vdev);
> +	struct pci_dev *pdev;
> +	bool sup_legacy_io;
> +	bool sup_lm;
> +	int ret;
> +
> +	ret = vfio_pci_core_init_dev(core_vdev);
> +	if (ret)
> +		return ret;
> +
> +	pdev = virtvdev->core_device.pdev;
> +	sup_legacy_io = virtio_pci_admin_has_legacy_io(pdev) &&
> +				!virtiovf_bar0_exists(pdev);
> +	sup_lm = virtio_pci_admin_has_dev_parts(pdev);
> +
> +	/*
> +	 * If the device is not capable to this driver functionality, fallback
> +	 * to the default vfio-pci ops
> +	 */
> +	if (!sup_legacy_io && !sup_lm) {
> +		core_vdev->ops = &virtiovf_vfio_pci_ops;
> +		return 0;
> +	}
> +
> +	if (sup_legacy_io) {
> +		ret = virtiovf_read_notify_info(virtvdev);
> +		if (ret)
> +			return ret;
> +
> +		virtvdev->bar0_virtual_buf_size = VIRTIO_PCI_CONFIG_OFF(true) +
> +					virtiovf_get_device_config_size(pdev->device);
> +		BUILD_BUG_ON(!is_power_of_2(virtvdev->bar0_virtual_buf_size));
> +		virtvdev->bar0_virtual_buf = kzalloc(virtvdev->bar0_virtual_buf_size,
> +						     GFP_KERNEL);
> +		if (!virtvdev->bar0_virtual_buf)
> +			return -ENOMEM;
> +		mutex_init(&virtvdev->bar_mutex);
> +	}
> +
> +	if (sup_lm)
> +		virtiovf_set_migratable(virtvdev);
> +
> +	if (sup_lm && !sup_legacy_io)
> +		core_vdev->ops = &virtiovf_vfio_pci_lm_ops;
> +
> +	return 0;
> +}
> +
>  static int virtiovf_pci_probe(struct pci_dev *pdev,
>  			      const struct pci_device_id *id)
>  {
> -	const struct vfio_device_ops *ops = &virtiovf_vfio_pci_ops;
>  	struct virtiovf_pci_core_device *virtvdev;
> +	const struct vfio_device_ops *ops;
>  	int ret;
>  
> -	if (pdev->is_virtfn && virtio_pci_admin_has_legacy_io(pdev) &&
> -	    !virtiovf_bar0_exists(pdev))
> -		ops = &virtiovf_vfio_pci_tran_ops;
> +	ops = (pdev->is_virtfn) ? &virtiovf_vfio_pci_tran_lm_ops :
> +				  &virtiovf_vfio_pci_ops;

I can't figure out why we moved the more thorough ops setup to the
.init() callback of the ops themselves.  Clearly we can do the legacy
IO and BAR0 test here and the dev parts test uses the same mechanisms
as the legacy IO test, so it seems we could know sup_legacy_io and
sup_lm here.  I think we can even do virtiovf_set_migratable() here
after virtvdev is allocated below.

I think the API to vfio core also suggests we shouldn't be modifying the
ops pointer after the core device is allocated.

>  
>  	virtvdev = vfio_alloc_device(virtiovf_pci_core_device, core_device.vdev,
>  				     &pdev->dev, ops);
> @@ -532,6 +575,7 @@ static void virtiovf_pci_aer_reset_done(struct pci_dev *pdev)
>  	struct virtiovf_pci_core_device *virtvdev = dev_get_drvdata(&pdev->dev);
>  
>  	virtvdev->pci_cmd = 0;
> +	virtiovf_migration_reset_done(pdev);
>  }
>  
>  static const struct pci_error_handlers virtiovf_err_handlers = {
> diff --git a/drivers/vfio/pci/virtio/migrate.c b/drivers/vfio/pci/virtio/migrate.c
> new file mode 100644
> index 000000000000..2a9614c2ef07
> --- /dev/null
> +++ b/drivers/vfio/pci/virtio/migrate.c
...
> +static int virtiovf_pci_get_data_size(struct vfio_device *vdev,
> +				      unsigned long *stop_copy_length)
> +{
> +	struct virtiovf_pci_core_device *virtvdev = container_of(
> +		vdev, struct virtiovf_pci_core_device, core_device.vdev);
> +	bool obj_id_exists;
> +	u32 res_size;
> +	u32 obj_id;
> +	int ret;
> +
> +	mutex_lock(&virtvdev->state_mutex);
> +	obj_id_exists = virtvdev->saving_migf && virtvdev->saving_migf->has_obj_id;
> +	if (!obj_id_exists) {
> +		ret = virtiovf_pci_alloc_obj_id(virtvdev,
> +						VIRTIO_RESOURCE_OBJ_DEV_PARTS_TYPE_GET,
> +						&obj_id);
> +		if (ret)
> +			goto end;
> +	} else {
> +		obj_id = virtvdev->saving_migf->obj_id;
> +	}
> +
> +	ret = virtio_pci_admin_dev_parts_metadata_get(virtvdev->core_device.pdev,
> +				VIRTIO_RESOURCE_OBJ_DEV_PARTS, obj_id,
> +				VIRTIO_ADMIN_CMD_DEV_PARTS_METADATA_TYPE_SIZE,
> +				&res_size);
> +	if (!ret)
> +		*stop_copy_length = res_size;
> +
> +	/* We can't leave this obj_id alive if didn't exist before, otherwise, it might
> +	 * stay alive, even without an active migration flow (e.g. migration was cancelled)
> +	 */

Nit, multi-line comment style.

Thanks,
Alex

