Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BFA189F3B
	for <virtualization@lists.linux.dev>; Sun, 20 Apr 2025 11:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745148815; cv=none; b=mV1M/8dBV+jtVBvDb7MJkIjG0uCsHfV7jKy6NShPg0u4n5yR9yoLO0jpb88P+UIkkTmqKvz6oxvgnl4JQwLK+FqS52H1lZTaWjlMhDEQtOwNYAAv4Qvy+nbQL/uSqyzjjLdV6ZhzyYIJDBeGIuKKxrIEzafntxif4BjAwOtz1rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745148815; c=relaxed/simple;
	bh=RA8CUgRMD4B2ll2rzijMUl69p1yhcnUbgXiJzMcElRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZHdBfziSHHsRXbITBq9vyPw4elo6wt8kM3UQixAts/UHfHVPI2zjA3ZsdtzQ+fdoIOrFE3jj+3wuBlDIN6Hg7XKWkjYXV5Sw+XyZNaXoe2KveadBE+kU6f7xQauYV1paunbQHPzH5GKU0n/SpK64hI5L5OfeU3fJuQnlPcH6+4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JKT0qy8u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JKT0qy8u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745148810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nvZP845QWj3rd1Mf+quAtSxZA7EGMkvoF+QsUfRhxPs=;
	b=JKT0qy8uUCe7SkBT2wxRy9gaPY2kOPBWK6yYBKxcSe+2Rh5BAOSqpLSmk5FyN+pcL3DohG
	fmqM9FPbawqpNGbzU+A1YbTIoEk03LcgNLUCy41nLExQArKndWGtdjuL12iBJprFtIKm6L
	nnTH5v/58vRf0KTcLXIqy1Q/5O57YBY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-krlNYauTPc-nbMM35bxLjQ-1; Sun, 20 Apr 2025 07:33:26 -0400
X-MC-Unique: krlNYauTPc-nbMM35bxLjQ-1
X-Mimecast-MFC-AGG-ID: krlNYauTPc-nbMM35bxLjQ_1745148805
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-391315098b2so836334f8f.2
        for <virtualization@lists.linux.dev>; Sun, 20 Apr 2025 04:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745148805; x=1745753605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvZP845QWj3rd1Mf+quAtSxZA7EGMkvoF+QsUfRhxPs=;
        b=r5Shde2tQgpbiFt7rSsEO3cFZG25HSQHqAXOYga81ejdiHy21h9TZQ8mwzizm+MF+Y
         8VhAth8wCXMigN+Tg+8p5jcaoo5ro/2wVXpLFC90p7wmAuBCMXTvA/uVYWQ+wm2s+9iG
         FrqVmLeUBSPtGtMe+Q+zIvRYFyIn6P2F5aAFc/67K205XNVZjFx8taTShw5hZpCl1YdY
         n2isDyhiiTf7hHHZAqGDnc/hMQIwip6B6Sdx3PCF2/PI57hHLPQuVOAtd4cf/8OBC/Jj
         XFKg/dw2KTTPP7sCfL7lw4AM2AxKjNQCYgo0TLq5sVNCqne+kCluyBTgUMn/NDXq0KBO
         NFqw==
X-Gm-Message-State: AOJu0YyknCcAISKs386CVpC+OpnRgV9tQVQxx/QLlb9rmJ5YyE3VYUX5
	7DqWqBdbeBmpePatHkB787h7pYqmOKZC8wLWMPIJa4YB03pWMWcH+GF+ARRND05Q8dE9Nfqmf/i
	AIXRcNvNQ6kbK2ivwaUhBnUQ4Ipr92yKR8CfLZ8NNQGs08INlpbv1RA/kUDq3wWyt
X-Gm-Gg: ASbGncvai+AWDcUcnV/WZpqDgqH0dz6fk7KjmQ/ceHABOEb37ROVapXT9VhswsRomtb
	X+xT2XERMkxiuJaTEFfTCyDtVWZOC/RRvNHvWY0dGbgQq8DGJb3rNzAN9LnTXXmuVFqR9P3rM+H
	/9eC6etiUESDCCiwszJnSbzUygaMeP46jm0eW1aw8PHr3uxpW4bhKMk2aI9eqhd61Jx0l4FfrDF
	DGja6kUfXi1t888TGFEZxYj7W0z6yw50NR+29rrarJTV45GZtFU842/zgTNV3IYh4wGMhISgwAa
	U1A8dw==
X-Received: by 2002:a05:6000:228a:b0:390:eacd:7009 with SMTP id ffacd0b85a97d-39efbad5316mr6405062f8f.42.1745148805386;
        Sun, 20 Apr 2025 04:33:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQCKS72GTmxFnFHR90LXI0GJ9R5/W1FyF+kTOSDx5Zy/LJZOfwe3w3Jt8j7Jl4TGUElujTzg==
X-Received: by 2002:a05:6000:228a:b0:390:eacd:7009 with SMTP id ffacd0b85a97d-39efbad5316mr6405048f8f.42.1745148804987;
        Sun, 20 Apr 2025 04:33:24 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa493377sm8776962f8f.62.2025.04.20.04.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 04:33:24 -0700 (PDT)
Date: Sun, 20 Apr 2025 07:33:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Israel Rukshin <israelr@nvidia.com>
Cc: virtualization@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Nitzan Carmi <nitzanc@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH 2/2] virtio-pci: Add admin command length check for
 device writable portions
Message-ID: <20250420073230-mutt-send-email-mst@kernel.org>
References: <1745147945-194225-1-git-send-email-israelr@nvidia.com>
 <1745147945-194225-3-git-send-email-israelr@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1745147945-194225-3-git-send-email-israelr@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CshgG_4tDITkMJUQCsxU1MVWQz3T6EzAkp22lpt1yyc_1745148805
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 20, 2025 at 02:19:05PM +0300, Israel Rukshin wrote:
> Add a safety check to ensure that the length of data written by the
> device is at least as large as the status length. If this condition is
> not met, it indicates a potential error in the device's response.
> 
> This change aligns with the virtio specification, which states:
> "The driver MUST NOT make assumptions about data in device-writable
> buffers beyond the first len bytes, and SHOULD ignore this data."
> 
> By failing the admin command when len is insufficient, we ensure
> that the driver does not process potentially invalid or incomplete
> status from the device.
> 
> Signed-off-by: Israel Rukshin <israelr@nvidia.com>
> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>  drivers/virtio/virtio_pci_modern.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 7209390a5cbf..0374e86aece3 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -48,6 +48,7 @@ void vp_modern_avq_done(struct virtqueue *vq)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
>  	struct virtio_pci_admin_vq *admin_vq = &vp_dev->admin_vq;
> +	unsigned int status_size = sizeof(struct virtio_admin_cmd_status);
>  	struct virtio_admin_cmd *cmd;
>  	unsigned long flags;
>  	unsigned int len;
> @@ -56,8 +57,10 @@ void vp_modern_avq_done(struct virtqueue *vq)
>  	do {
>  		virtqueue_disable_cb(vq);
>  		while ((cmd = virtqueue_get_buf(vq, &len))) {
> -			cmd->result_sg_size =
> -				len - sizeof(struct virtio_admin_cmd_status);
> +			if (len < status_size)
> +				cmd->ret = -EIO;
> +			else
> +				cmd->result_sg_size = len - status_size;
>  			complete(&cmd->completion);
>  		}



No this is out of spec:
	Similarly, the driver compares the used buffer length
	of the buffer to what it expects and then silently
	truncates the structure to the used buffer length.
	The driver silently ignores any data falling outside
	the used buffer length reported by the device.  Any missing
	fields are interpreted as set to zero.

so if status is 0, device can just write a shorter buffer and
driver must assume 0, which is success, not failure.




>  	} while (!virtqueue_enable_cb(vq));
> -- 
> 2.34.1

