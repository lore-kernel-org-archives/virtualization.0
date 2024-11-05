Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C251D27BF
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Nov 2024 23:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730848736; cv=none; b=N2Ya578HR7nWidk5EcewXDnJ7zItKnlbbtsTa0sLKTKStiEZ6j1J2HNML3KnGYb5eDLt9mZ7GrudUR5NBHNaXSL4BB1vOkwpENqautVTAkBjJUP21GBC5jpKDrx5MrDHVyxjkHUzxQcl0Y+cqQXzCgfcjINXr0t5kYCQ342XdrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730848736; c=relaxed/simple;
	bh=LwBakWoo04OagPpyp0RAonw0RHNrAFVcq29SGjGwL7E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t6Y/dIn+DSRVmTQl6qhx2ZXFuQqPp78UxKUw6BgPkU6UAg41pLLLNLSYfDkBsEkejy4ge6ypcN319KHz3+ddWIRaaQpSdO2XcUFnNRtvoq4dcAIkNA1bOROw41yUTEtvx3SRT4v6gE8D56f0H6/MxEpuDN+UIEMJD3PSYFq2tw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kyz4ZGHs; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kyz4ZGHs"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C958A401A2
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Nov 2024 23:18:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bTEi1kjE2c4Q for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Nov 2024 23:18:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=alex.williamson@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5747D40197
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5747D40197
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Kyz4ZGHs
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5747D40197
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Nov 2024 23:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730848730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=29OVp9dBUQ2V20hBqFAQ4FqvV7sf8LfdstOD5BPqG/s=;
	b=Kyz4ZGHsdfwz1GgxKCwuB9gMLU/qrz6fxfsHNpJy3YRpEFg46KF5cPoGicuWmJPEGnosGz
	D2sIv5KFHlCbltljy4aZYBViCKt2dpbTLS+CBD4T1PHmGvJg94iqiyB4MgUlrNXtXXtEWH
	ogt2B8Z3Hw+oVYONg2SJl3kL+r7eNCg=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-RuDTWbc9M2qmGNPtMbtOrA-1; Tue, 05 Nov 2024 18:18:48 -0500
X-MC-Unique: RuDTWbc9M2qmGNPtMbtOrA-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a6c4c46af8so5074865ab.3
        for <virtualization@lists.linux-foundation.org>; Tue, 05 Nov 2024 15:18:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730848727; x=1731453527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=29OVp9dBUQ2V20hBqFAQ4FqvV7sf8LfdstOD5BPqG/s=;
        b=EBUCgRHaimp5eCu/rj/A8f2t8m4gvBpAMoLNUsz4R4sMYRHS/YjyzS3meCrcI6tqmZ
         CO4XyHfEXfDNbMXafiEQXJspYrC9ofPvuNShj+TydT9qL4Mpvx/bSKtq+iJMmDf8tNiN
         kLdQtBTa1X3LHKyyn93o23lO4KaVxl/DQTE1PS9B15rWmJAZdJ21nVIGYyq7XDE3iO2I
         YMdbOmvWhDM5Xna/6gbTvHEWw4phNhum74jGt7Yhpw8djECSiGqgbnHJCMdU7xc1l/Wj
         ZbhWK/NdnVo+LYjhNtCpdz/de544GAtZdrABtDWwDtCwkHVmB15xpWucL2R2RI738xkC
         zeRA==
X-Forwarded-Encrypted: i=1; AJvYcCXg2UgJ+DgD6IgEoUHqGugGb7TTqOnFtJtkKl1Yhl45TFm0g73DqnZIFLJ4s+hhkGHiw3oSdSUVfoXosyM/9w==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Ywp6x9mh1ick7vby1ACZm7Sfdm1rIMuty43rv1a/BV6WyLVJTlc
	GgAhxsDWjXLWrErKowQZ1wIT/u5OxQTR3Bd2pwqcnPodsb3mYX18bYP/WdaRT3wFZ5BlttPNFSD
	5GMOdtiKFiFHhakdes7Gy0NnPVkHl58baxSNOPrNEdU9rDX5dD8bMk8tbVz55n78KhQClvRDLYD
	zNMLE=
X-Received: by 2002:a05:6e02:b2d:b0:3a6:ac17:13e3 with SMTP id e9e14a558f8ab-3a6ac1717famr60577645ab.7.1730848727264;
        Tue, 05 Nov 2024 15:18:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/B5xVC97K5koz5637iGId4N+tsYxZgKGmtzW8MaaSyK3qhMVypcGHpBarTT6cMX6q2Jtw5g==
X-Received: by 2002:a05:6e02:b2d:b0:3a6:ac17:13e3 with SMTP id e9e14a558f8ab-3a6ac1717famr60577495ab.7.1730848726717;
        Tue, 05 Nov 2024 15:18:46 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de049a325esm2643757173.140.2024.11.05.15.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 15:18:46 -0800 (PST)
Date: Tue, 5 Nov 2024 16:18:45 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Cc: <mst@redhat.com>, <jasowang@redhat.com>, <jgg@nvidia.com>,
 <kvm@vger.kernel.org>, <virtualization@lists.linux-foundation.org>,
 <parav@nvidia.com>, <feliu@nvidia.com>, <kevin.tian@intel.com>,
 <joao.m.martins@oracle.com>, <leonro@nvidia.com>, <maorg@nvidia.com>
Subject: Re: [PATCH V1 vfio 6/7] vfio/virtio: Add PRE_COPY support for live
 migration
Message-ID: <20241105161845.734e777e.alex.williamson@redhat.com>
In-Reply-To: <20241104102131.184193-7-yishaih@nvidia.com>
References: <20241104102131.184193-1-yishaih@nvidia.com>
	<20241104102131.184193-7-yishaih@nvidia.com>
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

On Mon, 4 Nov 2024 12:21:30 +0200
Yishai Hadas <yishaih@nvidia.com> wrote:

> Add PRE_COPY support for live migration.
> 
> This functionality may reduce the downtime upon STOP_COPY as of letting
> the target machine to get some 'initial data' from the source once the
> machine is still in its RUNNING state and let it prepares itself
> pre-ahead to get the final STOP_COPY data.
> 
> As the Virtio specification does not support reading partial or
> incremental device contexts. This means that during the PRE_COPY state,
> the vfio-virtio driver reads the full device state.
> 
> As the device state can be changed and the benefit is highest when the
> pre copy data closely matches the final data we read it in a rate
> limiter mode and reporting no data available for some time interval
> after the previous call.
> 
> With PRE_COPY enabled, we observed a downtime reduction of approximately
> 70-75% in various scenarios compared to when PRE_COPY was disabled,
> while keeping the total migration time nearly the same.
> 
> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> ---
>  drivers/vfio/pci/virtio/common.h  |   4 +
>  drivers/vfio/pci/virtio/migrate.c | 233 +++++++++++++++++++++++++++++-
>  2 files changed, 229 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/vfio/pci/virtio/common.h b/drivers/vfio/pci/virtio/common.h
> index 3bdfb3ea1174..5704603f0f9d 100644
> --- a/drivers/vfio/pci/virtio/common.h
> +++ b/drivers/vfio/pci/virtio/common.h
> @@ -10,6 +10,8 @@
>  
>  enum virtiovf_migf_state {
>  	VIRTIOVF_MIGF_STATE_ERROR = 1,
> +	VIRTIOVF_MIGF_STATE_PRECOPY = 2,
> +	VIRTIOVF_MIGF_STATE_COMPLETE = 3,
>  };
>  
>  enum virtiovf_load_state {
> @@ -57,6 +59,8 @@ struct virtiovf_migration_file {
>  	/* synchronize access to the file state */
>  	struct mutex lock;
>  	loff_t max_pos;
> +	u64 pre_copy_initial_bytes;
> +	struct ratelimit_state pre_copy_rl_state;
>  	u64 record_size;
>  	u32 record_tag;
>  	u8 has_obj_id:1;
> diff --git a/drivers/vfio/pci/virtio/migrate.c b/drivers/vfio/pci/virtio/migrate.c
> index 2a9614c2ef07..cdb252f6fd80 100644
> --- a/drivers/vfio/pci/virtio/migrate.c
> +++ b/drivers/vfio/pci/virtio/migrate.c
...
> @@ -379,9 +432,104 @@ static ssize_t virtiovf_save_read(struct file *filp, char __user *buf, size_t le
>  	return done;
>  }
>  
> +static long virtiovf_precopy_ioctl(struct file *filp, unsigned int cmd,
> +				   unsigned long arg)
> +{
> +	struct virtiovf_migration_file *migf = filp->private_data;
> +	struct virtiovf_pci_core_device *virtvdev = migf->virtvdev;
> +	struct vfio_precopy_info info = {};
> +	loff_t *pos = &filp->f_pos;
> +	bool end_of_data = false;
> +	unsigned long minsz;
> +	u32 ctx_size;
> +	int ret;
> +
> +	if (cmd != VFIO_MIG_GET_PRECOPY_INFO)
> +		return -ENOTTY;
> +
> +	minsz = offsetofend(struct vfio_precopy_info, dirty_bytes);
> +	if (copy_from_user(&info, (void __user *)arg, minsz))
> +		return -EFAULT;
> +
> +	if (info.argsz < minsz)
> +		return -EINVAL;
> +
> +	mutex_lock(&virtvdev->state_mutex);
> +	if (virtvdev->mig_state != VFIO_DEVICE_STATE_PRE_COPY &&
> +	    virtvdev->mig_state != VFIO_DEVICE_STATE_PRE_COPY_P2P) {
> +		ret = -EINVAL;
> +		goto err_state_unlock;
> +	}
> +
> +	/*
> +	 * The virtio specification does not include a PRE_COPY concept.
> +	 * Since we can expect the data to remain the same for a certain period,
> +	 * we use a rate limiter mechanism before making a call to the device.
> +	 */
> +	if (!__ratelimit(&migf->pre_copy_rl_state)) {
> +		/* Reporting no data available */
> +		ret = 0;
> +		goto done;

@ret is not used by the done: goto target.  Don't we need to zero dirty
bytes, or account for initial bytes not being fully read yet?

> +	}
> +
> +	ret = virtio_pci_admin_dev_parts_metadata_get(virtvdev->core_device.pdev,
> +				VIRTIO_RESOURCE_OBJ_DEV_PARTS, migf->obj_id,
> +				VIRTIO_ADMIN_CMD_DEV_PARTS_METADATA_TYPE_SIZE,
> +				&ctx_size);
> +	if (ret)
> +		goto err_state_unlock;
> +
> +	mutex_lock(&migf->lock);
> +	if (migf->state == VIRTIOVF_MIGF_STATE_ERROR) {
> +		ret = -ENODEV;
> +		goto err_migf_unlock;
> +	}
> +
> +	if (migf->pre_copy_initial_bytes > *pos) {
> +		info.initial_bytes = migf->pre_copy_initial_bytes - *pos;
> +	} else {
> +		info.dirty_bytes = migf->max_pos - *pos;
> +		if (!info.dirty_bytes)
> +			end_of_data = true;
> +		info.dirty_bytes += ctx_size;
> +	}
> +
> +	if (!end_of_data || !ctx_size) {
> +		mutex_unlock(&migf->lock);
> +		goto done;
> +	}
> +
> +	mutex_unlock(&migf->lock);
> +	/*
> +	 * We finished transferring the current state and the device has a
> +	 * dirty state, read a new state.
> +	 */
> +	ret = virtiovf_read_device_context_chunk(migf, ctx_size);
> +	if (ret)
> +		/*
> +		 * The machine is running, and context size could be grow, so no reason to mark
> +		 * the device state as VIRTIOVF_MIGF_STATE_ERROR.
> +		 */
> +		goto err_state_unlock;
> +
> +done:
> +	virtiovf_state_mutex_unlock(virtvdev);
> +	if (copy_to_user((void __user *)arg, &info, minsz))
> +		return -EFAULT;
> +	return 0;
> +
> +err_migf_unlock:
> +	mutex_unlock(&migf->lock);
> +err_state_unlock:
> +	virtiovf_state_mutex_unlock(virtvdev);
> +	return ret;
> +}
> +
...
> @@ -536,6 +719,17 @@ virtiovf_pci_save_device_data(struct virtiovf_pci_core_device *virtvdev)
>  	if (ret)
>  		goto out_clean;
>  
> +	if (pre_copy) {
> +		migf->pre_copy_initial_bytes = migf->max_pos;
> +		ratelimit_state_init(&migf->pre_copy_rl_state, 1 * HZ, 1);

A comment describing the choice of this heuristic would be useful for
future maintenance, even if the comment is "Arbitrarily rate limit
pre-copy to 1s intervals."  Thanks,

Alex

> +		/* Prevent any rate messages upon its usage */
> +		ratelimit_set_flags(&migf->pre_copy_rl_state,
> +				    RATELIMIT_MSG_ON_RELEASE);
> +		migf->state = VIRTIOVF_MIGF_STATE_PRECOPY;
> +	} else {
> +		migf->state = VIRTIOVF_MIGF_STATE_COMPLETE;
> +	}
> +
>  	return migf;
>  
>  out_clean:

