Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0430A524A0
	for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 12:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713787724; cv=none; b=qrw/6J4jVE5zOxULw/CUbJ0MEKqvCj2BbuogIZXMEEBp0bNjBYSjX0YoBarZCAEdU5UDiZxYaG6qY8lXFGkKDaDydniiMdmhpiT81uSguhtPWDaJVasVlaOV5tg5CihZLPpiaKCBmuxjm4O6YAfo892jEeTfqGXr8e/E9XEe3vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713787724; c=relaxed/simple;
	bh=my+P67LFzQSKQvstytruFE1AYZFQMHNKysY/jRMRvdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=FQYDz5JU7lwY73AjofT3hSUWxjgZSZ1m0K2aZuMUWcdmOXfTEKS03uXlBQ5y8nyLhX+h+KNBzWK8xy35vPvY5OCdpOK5PDnq5c2sze58KSju29ZHKo0mUrUYacu7hwcKBjJMfz2ApciDbNrvlqrQXFJpORqx0B6Jfb7AUoRzjPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fh8ke4+6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fh8ke4+6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713787721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8kOf0Ccw9EW1YPuXrZV1wz4F+Kl3dauR1DbyA65i60M=;
	b=Fh8ke4+6Hn2bpuYoZBRsCPJfer1cm3ABWQgITi+ve7W75kxBjCR3attnNc7y7TFjvsEFa/
	b2+AV78MFUk7JMg2ude+1FVrytZuOlSe/hpT89/VNvcm7Mg56SxDJRlpnQGZV81d/Ixyhu
	PkycVYMqRIpU245MomP6VwvGYYrnT+k=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-5MKd5J_SNfaywkk2-kYA7w-1; Mon, 22 Apr 2024 08:08:39 -0400
X-MC-Unique: 5MKd5J_SNfaywkk2-kYA7w-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3c6f2d993ceso4919604b6e.2
        for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 05:08:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713787719; x=1714392519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kOf0Ccw9EW1YPuXrZV1wz4F+Kl3dauR1DbyA65i60M=;
        b=bS0okhrrNjc5tgTVKu9jxNKx1nCXZ9HpnM/mPKvXn7i8BGbovl0gHHgLRz2eRWAL4s
         8BzvcQDVNg8/qY1PqKzUHBb2tV48XQTQUZ3y7DhU+BtdMI+AB+NF5xgxFqBCVVIDQotD
         k94hCu9flqAsPDJQZ6nsnOPJJdNYxxj+30eu8ddr7tSSyFczW2Pi/BQN7mTLD4I0Awr0
         DA5CzUVWspTR/bKHvqqTcjhaxZYW/vc8lEVS2ZpB/N+qi4TVlvecjqH1JLylNbTsdZp0
         TB4F0rgqNPavc7Y8OZOQVqf7orRmWsE6TTbCwOha6pYWpnRTuF/7S55/Z8XhtQaw+QmW
         Oawg==
X-Forwarded-Encrypted: i=1; AJvYcCVn3j0pZ1zZTyZo/ipdFEMqYCzRp1oAPtciSTDLCjJTUsH6rzQlRLFV5mAhqFzEFVRCs94v/s0xLhXrE/Bsve+zBtS/ORp3a+qmxhqooE4=
X-Gm-Message-State: AOJu0YxkxfWt9BN/5WS6pPbJl6VL9T8/ntyzt4Vo53uLT48zKst5lEtv
	Lv+ASXCfV5C8a6cTpP8skrVMUAkCwxDVm4T+MBO7qilV4jAVk+Rp15yJM4WPc022leqbytRDetP
	E2hVxZo/DqY1qspzRnN0eEMqx8nsm3MVt3UnN252/YR/gqHcJ15Qd5P+jD4tc9MNo
X-Received: by 2002:aca:2210:0:b0:3c7:443f:1ae7 with SMTP id b16-20020aca2210000000b003c7443f1ae7mr9597658oic.58.1713787718658;
        Mon, 22 Apr 2024 05:08:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2gCDRlrbhQbqvB0C+CF6O/3Btd8kPG9ni9Vxg0Rzo5XITY6GWOxgO3ytISR3UPYyrxLEhkg==
X-Received: by 2002:aca:2210:0:b0:3c7:443f:1ae7 with SMTP id b16-20020aca2210000000b003c7443f1ae7mr9597629oic.58.1713787718051;
        Mon, 22 Apr 2024 05:08:38 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7429:3c00:dc4a:cd5:7b1c:f7c2])
        by smtp.gmail.com with ESMTPSA id kg25-20020a05622a761900b00436eacea78fsm4182387qtb.65.2024.04.22.05.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 05:08:37 -0700 (PDT)
Date: Mon, 22 Apr 2024 08:08:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: lyx634449800 <yuxue.liu@jaguarmicro.com>
Cc: jasowang@redhat.com, angus.chen@jaguarmicro.com,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com,
	linux-kernel@vger.kernel.org, Heng Qi <hengqi@linux.alibaba.com>
Subject: Re: [PATCH v5] vp_vdpa: don't allocate unused msix vectors
Message-ID: <20240422080729-mutt-send-email-mst@kernel.org>
References: <ffab38f0-2ec6-4ed2-b0f8-398f2829b71d@linux.alibaba.com>
 <20240410033020.1310-1-yuxue.liu@jaguarmicro.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240410033020.1310-1-yuxue.liu@jaguarmicro.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 10, 2024 at 11:30:20AM +0800, lyx634449800 wrote:
> From: Yuxue Liu <yuxue.liu@jaguarmicro.com>
> 
> When there is a ctlq and it doesn't require interrupt
> callbacks,the original method of calculating vectors
> wastes hardware msi or msix resources as well as system
> IRQ resources.
> 
> When conducting performance testing using testpmd in the
> guest os, it was found that the performance was lower compared
> to directly using vfio-pci to passthrough the device
> 
> In scenarios where the virtio device in the guest os does
> not utilize interrupts, the vdpa driver still configures
> the hardware's msix vector. Therefore, the hardware still
> sends interrupts to the host os.

I just have a question on this part. How come hardware
sends interrupts does not guest driver disable them?

> Because of this unnecessary
> action by the hardware, hardware performance decreases, and
> it also affects the performance of the host os.
> 
> Before modification:(interrupt mode)
>  32:  0   0  0  0 PCI-MSI 32768-edge    vp-vdpa[0000:00:02.0]-0
>  33:  0   0  0  0 PCI-MSI 32769-edge    vp-vdpa[0000:00:02.0]-1
>  34:  0   0  0  0 PCI-MSI 32770-edge    vp-vdpa[0000:00:02.0]-2
>  35:  0   0  0  0 PCI-MSI 32771-edge    vp-vdpa[0000:00:02.0]-config
> 
> After modification:(interrupt mode)
>  32:  0  0  1  7   PCI-MSI 32768-edge  vp-vdpa[0000:00:02.0]-0
>  33: 36  0  3  0   PCI-MSI 32769-edge  vp-vdpa[0000:00:02.0]-1
>  34:  0  0  0  0   PCI-MSI 32770-edge  vp-vdpa[0000:00:02.0]-config
> 
> Before modification:(virtio pmd mode for guest os)
>  32:  0   0  0  0 PCI-MSI 32768-edge    vp-vdpa[0000:00:02.0]-0
>  33:  0   0  0  0 PCI-MSI 32769-edge    vp-vdpa[0000:00:02.0]-1
>  34:  0   0  0  0 PCI-MSI 32770-edge    vp-vdpa[0000:00:02.0]-2
>  35:  0   0  0  0 PCI-MSI 32771-edge    vp-vdpa[0000:00:02.0]-config
> 
> After modification:(virtio pmd mode for guest os)
>  32: 0  0  0   0   PCI-MSI 32768-edge   vp-vdpa[0000:00:02.0]-config
> 
> To verify the use of the virtio PMD mode in the guest operating
> system, the following patch needs to be applied to QEMU:
> https://lore.kernel.org/all/20240408073311.2049-1-yuxue.liu@jaguarmicro.com
> 
> Signed-off-by: Yuxue Liu <yuxue.liu@jaguarmicro.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>
> ---
> V5: modify the description of the printout when an exception occurs
> V4: update the title and assign values to uninitialized variables
> V3: delete unused variables and add validation records
> V2: fix when allocating IRQs, scan all queues
> 
>  drivers/vdpa/virtio_pci/vp_vdpa.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> index df5f4a3bccb5..8de0224e9ec2 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -160,7 +160,13 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
>  	struct pci_dev *pdev = mdev->pci_dev;
>  	int i, ret, irq;
>  	int queues = vp_vdpa->queues;
> -	int vectors = queues + 1;
> +	int vectors = 1;
> +	int msix_vec = 0;
> +
> +	for (i = 0; i < queues; i++) {
> +		if (vp_vdpa->vring[i].cb.callback)
> +			vectors++;
> +	}
>  
>  	ret = pci_alloc_irq_vectors(pdev, vectors, vectors, PCI_IRQ_MSIX);
>  	if (ret != vectors) {
> @@ -173,9 +179,12 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
>  	vp_vdpa->vectors = vectors;
>  
>  	for (i = 0; i < queues; i++) {
> +		if (!vp_vdpa->vring[i].cb.callback)
> +			continue;
> +
>  		snprintf(vp_vdpa->vring[i].msix_name, VP_VDPA_NAME_SIZE,
>  			"vp-vdpa[%s]-%d\n", pci_name(pdev), i);
> -		irq = pci_irq_vector(pdev, i);
> +		irq = pci_irq_vector(pdev, msix_vec);
>  		ret = devm_request_irq(&pdev->dev, irq,
>  				       vp_vdpa_vq_handler,
>  				       0, vp_vdpa->vring[i].msix_name,
> @@ -185,21 +194,22 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
>  				"vp_vdpa: fail to request irq for vq %d\n", i);
>  			goto err;
>  		}
> -		vp_modern_queue_vector(mdev, i, i);
> +		vp_modern_queue_vector(mdev, i, msix_vec);
>  		vp_vdpa->vring[i].irq = irq;
> +		msix_vec++;
>  	}
>  
>  	snprintf(vp_vdpa->msix_name, VP_VDPA_NAME_SIZE, "vp-vdpa[%s]-config\n",
>  		 pci_name(pdev));
> -	irq = pci_irq_vector(pdev, queues);
> +	irq = pci_irq_vector(pdev, msix_vec);
>  	ret = devm_request_irq(&pdev->dev, irq,	vp_vdpa_config_handler, 0,
>  			       vp_vdpa->msix_name, vp_vdpa);
>  	if (ret) {
>  		dev_err(&pdev->dev,
> -			"vp_vdpa: fail to request irq for vq %d\n", i);
> +			"vp_vdpa: fail to request irq for config: %d\n", ret);
>  			goto err;
>  	}
> -	vp_modern_config_vector(mdev, queues);
> +	vp_modern_config_vector(mdev, msix_vec);
>  	vp_vdpa->config_irq = irq;
>  
>  	return 0;
> -- 
> 2.43.0

