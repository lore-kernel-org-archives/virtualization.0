Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8021C1FC7E6
	for <virtualization@lists.linux.dev>; Thu, 19 Dec 2024 08:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734597081; cv=none; b=cbL0LcN/GSWjKm5w225hWo7zu+3lyP6z1X+wug/scCxLoq6Gdufaoy0ArOhujZuuViLEkqlYxLdVw2e6Wr0fg59euoD4GcJk9egL6F2Yn5T8XTjBSYR37KzlQ+spROaKk9qvxU8Bfm4L5fHiCQH9Q/bZWVgoiLYoNxax9nbIQaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734597081; c=relaxed/simple;
	bh=2IM8Isl/HvcjVPdOdCc+YEyWJcS5dGDRruGLb2kRjFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Ic7/EZOyDsfTgF3mzWRoNyc5my3EiqS+g5BCCZA1FrpPk7E+dKZ+Rs9zSu8CgAwmmFLW0P3Qd1G/TpAfQQhnUYQBOXVH0JmYpS9jtI3lun+YbyFMC4higWEpeH0dd56Ky9s1//odMABdEaWFYFFR0z4iQs0shMsYDNfqq3lOoHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zx4accGI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zx4accGI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734597078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HKgfqq1V/q2Bw/na+eWOMQ9Qre2mVUN/gi9oaR1AL+A=;
	b=Zx4accGIe07HfV0SCAeZZWSgNa9Rjz/OqD2X8vdwSQ0QveNV2l5WGHIzHklgOR/sjwPHp1
	EwFAZJWmiL1E1D2NtCxMQrjmeawEFqlKICDGcVSVsbE9aWORqcj3xP7tx2fIZ+Ix3A2Ydn
	BradhHY7lm/WxFoNdWNya8tnAz+dO7Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-hkSr2U1bMHupW0LdTji4YA-1; Thu, 19 Dec 2024 03:31:17 -0500
X-MC-Unique: hkSr2U1bMHupW0LdTji4YA-1
X-Mimecast-MFC-AGG-ID: hkSr2U1bMHupW0LdTji4YA
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4361f371908so4263935e9.0
        for <virtualization@lists.linux.dev>; Thu, 19 Dec 2024 00:31:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734597075; x=1735201875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKgfqq1V/q2Bw/na+eWOMQ9Qre2mVUN/gi9oaR1AL+A=;
        b=uhYyfTDCJFOXrw/fTDyBCbMWuyKJ2HzAFQnWk2s0YysX1xOt1I8j576vmMxdfTaron
         ojTQ9uqcSh34lt3MtAaAOD5pbi26pbvYfWfgs5SOtsE9eGdJaPfGHAkW3qdSkKAWC7qr
         l4Vi4VfDx9KAkDGgsMdND5GzCRjdrqaBf0yavlVmw8bB+566n9YyRkj6kn3mApYZyC0H
         YIaC//DVho/XcAJwzyavAwo7wM4Sh3Om4hWJc2qhvqX0QQYJtqFmSVfxkhoevJqH8vI3
         lylQb7HpojXxTV3LXdCvOR1IA9CYHNNyz1KuzZO64Q5vEF5dvNgwD7QoKoS2sBEMxLMx
         0YUA==
X-Forwarded-Encrypted: i=1; AJvYcCW3V0uiNh7z0iacTEJqkyLwxJA35sEafP1MkMpDVsy6z+SY1ArjBWEfuCPLw360rn5YCrpGtYBWd1jlBES3LQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQKnLcQ9MvsBy11WnsnX1XhL8n4N9LjGxKF+uDsd+O5DtgVzT/
	SqpWYnywG+RHQuDa4wlM6LjRyDusg4lPDLHU1gNN3QCrm0a7GWSdcgfvCTLrPyW6+M7KaFvjyPA
	hNGnEesgW2nT9ej6/w1uTfg9tQND2uGbmCRiDYXtSdimIo0OwlieLKFepqg3udqyw
X-Gm-Gg: ASbGnct0XCTh5NXA4YVV0OWNtZw8Kd0Ml0Fk3vU1L6yTxsRUqx5UsWvLGdSCeGOB51V
	U7r3GmfNABvI/JxhyWSmhtdrFhSnZT7HdbwNjCQpfN6Zlb8l98cHVtrv6huVz8cDmnzwfWvqW+G
	3z/wzr0YRBwWPc3CZ56iBJ/YjtG0+zyP3pDbbDHq1ms+Bc7BsCcp9IiEQhUzg2I83JHM5K5f5X2
	hUtwUDnNw28s6jUeoN0Hyw7AMxixn/UOJwTkSKhLGnnCroE+w==
X-Received: by 2002:a05:600c:4ed2:b0:434:f7ea:fb44 with SMTP id 5b1f17b1804b1-4365535c6a3mr57458805e9.14.1734597075416;
        Thu, 19 Dec 2024 00:31:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmEAGsD3J5lAW4FA+s63y3sWjvKNvfQZ3gFL7w0rvckTj28XiNMSxT5zIucbWC042DWgnKHg==
X-Received: by 2002:a05:600c:4ed2:b0:434:f7ea:fb44 with SMTP id 5b1f17b1804b1-4365535c6a3mr57458095e9.14.1734597074934;
        Thu, 19 Dec 2024 00:31:14 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f6:4834:3deb:8c9:181b:4574])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b4432dsm44515275e9.41.2024.12.19.00.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 00:31:14 -0800 (PST)
Date: Thu, 19 Dec 2024 03:31:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Wagner <wagi@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
	Chandrakanth patil <chandrakanth.patil@broadcom.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Nilesh Javali <njavali@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	Don Brace <don.brace@microchip.com>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <llong@redhat.com>, Ming Lei <ming.lei@redhat.com>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>,
	Sridhar Balaraman <sbalaraman@parallelwireless.com>,
	"brookxu.cn" <brookxu.cn@gmail.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
	storagedev@microchip.com, virtualization@lists.linux.dev
Subject: Re: [PATCH v4 6/9] virtio: blk/scsi: use block layer helpers to
 calculate num of queues
Message-ID: <20241219032956-mutt-send-email-mst@kernel.org>
References: <20241217-isolcpus-io-queues-v4-0-5d355fbb1e14@kernel.org>
 <20241217-isolcpus-io-queues-v4-6-5d355fbb1e14@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241217-isolcpus-io-queues-v4-6-5d355fbb1e14@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kb8YWaLxT6O2Mg2WI25vDd0bBk_uD1CvX3fr1tnISN4_1734597075
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 17, 2024 at 07:29:40PM +0100, Daniel Wagner wrote:
> Multiqueue devices should only allocate queues for the housekeeping CPUs
> when isolcpus=managed_irq is set. This avoids that the isolated CPUs get
> disturbed with OS workload.
> 
> Use helpers which calculates the correct number of queues which should
> be used when isolcpus is used.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>

The subject is misleading, one thinks it is onlu virtio blk.
It's best to just split each driver in a patch by its own.
for the changes in virtio:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/block/virtio_blk.c                | 5 ++---
>  drivers/scsi/megaraid/megaraid_sas_base.c | 3 ++-
>  drivers/scsi/virtio_scsi.c                | 1 +
>  3 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index ed514ff46dc82acd629ae594cb0fa097bd301a9b..0287ceaaf19972f3a18e81cd2e3252e4d539ba93 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -976,9 +976,8 @@ static int init_vq(struct virtio_blk *vblk)
>  		return -EINVAL;
>  	}
>  
> -	num_vqs = min_t(unsigned int,
> -			min_not_zero(num_request_queues, nr_cpu_ids),
> -			num_vqs);
> +	num_vqs = blk_mq_num_possible_queues(
> +			min_not_zero(num_request_queues, num_vqs));
>  
>  	num_poll_vqs = min_t(unsigned int, poll_queues, num_vqs - 1);
>  
> diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
> index 59d385e5a917979ae2f61f5db2c3355b9cab7e08..3ff0978b3acb5baf757fee25d9fccf4971976272 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_base.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_base.c
> @@ -6236,7 +6236,8 @@ static int megasas_init_fw(struct megasas_instance *instance)
>  		intr_coalescing = (scratch_pad_1 & MR_INTR_COALESCING_SUPPORT_OFFSET) ?
>  								true : false;
>  		if (intr_coalescing &&
> -			(blk_mq_num_online_queues(0) >= MR_HIGH_IOPS_QUEUE_COUNT) &&
> +			(blk_mq_num_online_queues(0) >=
> +			 MR_HIGH_IOPS_QUEUE_COUNT) &&
>  			(instance->msix_vectors == MEGASAS_MAX_MSIX_QUEUES))
>  			instance->perf_mode = MR_BALANCED_PERF_MODE;
>  		else
> diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
> index 60be1a0c61836ba643adcf9ad8d5b68563a86cb1..46ca0b82f57ce2211c7e2817dd40ee34e65bcbf9 100644
> --- a/drivers/scsi/virtio_scsi.c
> +++ b/drivers/scsi/virtio_scsi.c
> @@ -919,6 +919,7 @@ static int virtscsi_probe(struct virtio_device *vdev)
>  	/* We need to know how many queues before we allocate. */
>  	num_queues = virtscsi_config_get(vdev, num_queues) ? : 1;
>  	num_queues = min_t(unsigned int, nr_cpu_ids, num_queues);
> +	num_queues = blk_mq_num_possible_queues(num_queues);
>  
>  	num_targets = virtscsi_config_get(vdev, max_target) + 1;
>  
> 
> -- 
> 2.47.1

