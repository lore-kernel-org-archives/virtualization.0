Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF81320E
	for <virtualization@lists.linux.dev>; Tue, 23 Apr 2024 08:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713861329; cv=none; b=fgSw5k1CcL68iAs0cH/jl8gYc8HEF/5+xnSPv7xVqG7mzc4zhFHdxtwpskP0XzN30PmH4Yw39DPITIrrdRiVZqf6a3R2PY6j9txeYvUiyrcmx+9cwoZlHh2Fjy7pjDiP3aRlsjw38NH4STl09QTSD6KUfgf6XMXOkEtVh7dVxik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713861329; c=relaxed/simple;
	bh=QhvqyhIsTHNTsZQVv5LUhXm64Ffg94gJwiDYosBvGdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Xk7AdJgBkCHIk+OmulYNkLeQora7CaX3iy1tlnjVJEehjfySwz86w7U3Vwd6L5y3fx7fhqf/xoXJ/2xr8UXe696jF5yWMqwQfhqbuzA+BPTmwKChqk69dAerQNhcMmNmEBdy3GguEDg3jSxQEdSbCnQxw4GPVz2A8I4jbyobuEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a27nDfNC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a27nDfNC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713861327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+vJaKEAfDiE8wRROjPB/46PERXPjfD/eS5OLTnH5/nA=;
	b=a27nDfNCvFStSwmOUAjh8w9rmR4kme2eIa1hq8QoABbZO5KKfVVaAtgnbrj3VsNA8FrOna
	xqtES0yN8JOgm1DA7soc70n4YYPaAGtsq743vaM3br27y8jXoSeGc9XlUV8Dll2b1VrtmZ
	j1tcSHnYQfyFEDkBbVQFQSSftEfCKg4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-_EBDMIXyM8udvKtX5B9TXw-1; Tue, 23 Apr 2024 04:35:23 -0400
X-MC-Unique: _EBDMIXyM8udvKtX5B9TXw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-343d02b62ddso3818849f8f.1
        for <virtualization@lists.linux.dev>; Tue, 23 Apr 2024 01:35:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713861322; x=1714466122;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+vJaKEAfDiE8wRROjPB/46PERXPjfD/eS5OLTnH5/nA=;
        b=LKJWdcvJx7y2qg4oq3wtJxtNFBx5BIHURzdmEvYh+pmwYo1B4nMhy8rXeRnGF/ou/C
         JMs84PYfFLP2YEfn3EDYq6mFF7HEfRkL8UlVdmrBwqtqgEJNI2ZjFK2JgAReKRAMIb32
         EScnBSeGFyDlFkHHTvBvVz7ObcNiK41ErAveevEWI/GcHogixiy4ncPhT65PL5n1ylhf
         mwt1dXee2k2snEYB2OR1NzUZh3HhvmSYP7wJcnhIzNAJBeqRUdU1lznmIs0+QnXGPxNU
         0w/mT/HRYN7QFxC8TJXoLkvgv6qCCqhnWyBlAQB0LovDyGR8aoroyVecxpOOW0b5aTVD
         bsZA==
X-Forwarded-Encrypted: i=1; AJvYcCXW+Ub0+NIngrisGtVtH7gqx5Oy8P/RR7EPW3eloB2oXS89gTgsvGBtQMB4pSK58D2tFg+36i534lly5GXt+9qmvooGnzz16T5lvnlpS6M=
X-Gm-Message-State: AOJu0YwRlJFldosAR6u4cIK2hRCHxRqhS3guoLLHRyuxTgc8KqvV+eNk
	3G9VAbGklclclQIIGNfXDWHO9zFnzGDwwJoRpPosNVfa2jaPbFJeV/51dFk8dDsb8QfFU5Me+Hq
	MSrO9aY/rdJwfUi4ps9iWWavnvllzKTd+xjxo4HMZPevzq76/qNwa8AeT5qH/q4yX
X-Received: by 2002:a05:6000:dc3:b0:34b:3660:e2a9 with SMTP id dw3-20020a0560000dc300b0034b3660e2a9mr2764019wrb.11.1713861322121;
        Tue, 23 Apr 2024 01:35:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEX4SaLtyioB9h3624ku7UiJ/Wtf/loc9Olj195YLr4+j8FwgrH++GD+muge83O5ZK3GOZNOw==
X-Received: by 2002:a05:6000:dc3:b0:34b:3660:e2a9 with SMTP id dw3-20020a0560000dc300b0034b3660e2a9mr2763997wrb.11.1713861321532;
        Tue, 23 Apr 2024 01:35:21 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7429:3c00:dc4a:cd5:7b1c:f7c2])
        by smtp.gmail.com with ESMTPSA id f18-20020adff592000000b00343a0e2375esm13854101wro.27.2024.04.23.01.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 01:35:20 -0700 (PDT)
Date: Tue, 23 Apr 2024 04:35:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Liu <gavin.liu@jaguarmicro.com>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>,
	Angus Chen <angus.chen@jaguarmicro.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Heng Qi <hengqi@linux.alibaba.com>
Subject: Re: =?utf-8?B?5Zue5aSN?= =?utf-8?Q?=3A?= [PATCH v5] vp_vdpa: don't
 allocate unused msix vectors
Message-ID: <20240423043424-mutt-send-email-mst@kernel.org>
References: <ffab38f0-2ec6-4ed2-b0f8-398f2829b71d@linux.alibaba.com>
 <20240410033020.1310-1-yuxue.liu@jaguarmicro.com>
 <20240422080729-mutt-send-email-mst@kernel.org>
 <SEYPR06MB6756E87AE40D93704A0614A9EC112@SEYPR06MB6756.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <SEYPR06MB6756E87AE40D93704A0614A9EC112@SEYPR06MB6756.apcprd06.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Apr 23, 2024 at 01:39:17AM +0000, Gavin Liu wrote:
> On Wed, Apr 10, 2024 at 11:30:20AM +0800, lyx634449800 wrote:
> > From: Yuxue Liu <yuxue.liu@jaguarmicro.com>
> >
> > When there is a ctlq and it doesn't require interrupt callbacks,the 
> > original method of calculating vectors wastes hardware msi or msix 
> > resources as well as system IRQ resources.
> >
> > When conducting performance testing using testpmd in the guest os, it 
> > was found that the performance was lower compared to directly using 
> > vfio-pci to passthrough the device
> >
> > In scenarios where the virtio device in the guest os does not utilize 
> > interrupts, the vdpa driver still configures the hardware's msix 
> > vector. Therefore, the hardware still sends interrupts to the host os.
> 
> >I just have a question on this part. How come hardware sends interrupts does not guest driver disable them?
>                
>    1：Assuming the guest OS's Virtio device is using PMD mode, QEMU sets the call fd to -1
>    2：On the host side, the vhost_vdpa program will set vp_vdpa->vring[i].cb.callback to invalid
>    3：Before the modification, the vp_vdpa_request_irq function does not check whether 
>       vp_vdpa->vring[i].cb.callback is valid. Instead, it enables the hardware's MSIX
> 	  interrupts based on the number of queues of the device
> 

So MSIX is enabled but why would it trigger? virtio PMD in poll mode
presumably suppresses interrupts after all.

> 
> 
> ----- Original Message -----
> From: Michael S. Tsirkin mst@redhat.com
> Sent: April 22, 2024 20:09
> To: Gavin Liu gavin.liu@jaguarmicro.com
> Cc: jasowang@redhat.com; Angus Chen angus.chen@jaguarmicro.com; virtualization@lists.linux.dev; xuanzhuo@linux.alibaba.com; linux-kernel@vger.kernel.org; Heng Qi hengqi@linux.alibaba.com
> Subject: Re: [PATCH v5] vp_vdpa: don't allocate unused msix vectors
> 
> 
> 
> External Mail: This email originated from OUTSIDE of the organization!
> Do not click links, open attachments or provide ANY information unless you recognize the sender and know the content is safe.
> 
> 
> On Wed, Apr 10, 2024 at 11:30:20AM +0800, lyx634449800 wrote:
> > From: Yuxue Liu <yuxue.liu@jaguarmicro.com>
> >
> > When there is a ctlq and it doesn't require interrupt callbacks,the 
> > original method of calculating vectors wastes hardware msi or msix 
> > resources as well as system IRQ resources.
> >
> > When conducting performance testing using testpmd in the guest os, it 
> > was found that the performance was lower compared to directly using 
> > vfio-pci to passthrough the device
> >
> > In scenarios where the virtio device in the guest os does not utilize 
> > interrupts, the vdpa driver still configures the hardware's msix 
> > vector. Therefore, the hardware still sends interrupts to the host os.
> 
> I just have a question on this part. How come hardware sends interrupts does not guest driver disable them?
> 
> > Because of this unnecessary
> > action by the hardware, hardware performance decreases, and it also 
> > affects the performance of the host os.
> >
> > Before modification:(interrupt mode)
> >  32:  0   0  0  0 PCI-MSI 32768-edge    vp-vdpa[0000:00:02.0]-0
> >  33:  0   0  0  0 PCI-MSI 32769-edge    vp-vdpa[0000:00:02.0]-1
> >  34:  0   0  0  0 PCI-MSI 32770-edge    vp-vdpa[0000:00:02.0]-2
> >  35:  0   0  0  0 PCI-MSI 32771-edge    vp-vdpa[0000:00:02.0]-config
> >
> > After modification:(interrupt mode)
> >  32:  0  0  1  7   PCI-MSI 32768-edge  vp-vdpa[0000:00:02.0]-0
> >  33: 36  0  3  0   PCI-MSI 32769-edge  vp-vdpa[0000:00:02.0]-1
> >  34:  0  0  0  0   PCI-MSI 32770-edge  vp-vdpa[0000:00:02.0]-config
> >
> > Before modification:(virtio pmd mode for guest os)
> >  32:  0   0  0  0 PCI-MSI 32768-edge    vp-vdpa[0000:00:02.0]-0
> >  33:  0   0  0  0 PCI-MSI 32769-edge    vp-vdpa[0000:00:02.0]-1
> >  34:  0   0  0  0 PCI-MSI 32770-edge    vp-vdpa[0000:00:02.0]-2
> >  35:  0   0  0  0 PCI-MSI 32771-edge    vp-vdpa[0000:00:02.0]-config
> >
> > After modification:(virtio pmd mode for guest os)
> >  32: 0  0  0   0   PCI-MSI 32768-edge   vp-vdpa[0000:00:02.0]-config
> >
> > To verify the use of the virtio PMD mode in the guest operating 
> > system, the following patch needs to be applied to QEMU:
> > https://lore.kernel.org/all/20240408073311.2049-1-yuxue.liu@jaguarmicr
> > o.com
> >
> > Signed-off-by: Yuxue Liu <yuxue.liu@jaguarmicro.com>
> > Acked-by: Jason Wang <jasowang@redhat.com>
> > Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>
> > ---
> > V5: modify the description of the printout when an exception occurs
> > V4: update the title and assign values to uninitialized variables
> > V3: delete unused variables and add validation records
> > V2: fix when allocating IRQs, scan all queues
> >
> >  drivers/vdpa/virtio_pci/vp_vdpa.c | 22 ++++++++++++++++------
> >  1 file changed, 16 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c 
> > b/drivers/vdpa/virtio_pci/vp_vdpa.c
> > index df5f4a3bccb5..8de0224e9ec2 100644
> > --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> > +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> > @@ -160,7 +160,13 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
> >       struct pci_dev *pdev = mdev->pci_dev;
> >       int i, ret, irq;
> >       int queues = vp_vdpa->queues;
> > -     int vectors = queues + 1;
> > +     int vectors = 1;
> > +     int msix_vec = 0;
> > +
> > +     for (i = 0; i < queues; i++) {
> > +             if (vp_vdpa->vring[i].cb.callback)
> > +                     vectors++;
> > +     }
> >
> >       ret = pci_alloc_irq_vectors(pdev, vectors, vectors, PCI_IRQ_MSIX);
> >       if (ret != vectors) {
> > @@ -173,9 +179,12 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
> >       vp_vdpa->vectors = vectors;
> >
> >       for (i = 0; i < queues; i++) {
> > +             if (!vp_vdpa->vring[i].cb.callback)
> > +                     continue;
> > +
> >               snprintf(vp_vdpa->vring[i].msix_name, VP_VDPA_NAME_SIZE,
> >                       "vp-vdpa[%s]-%d\n", pci_name(pdev), i);
> > -             irq = pci_irq_vector(pdev, i);
> > +             irq = pci_irq_vector(pdev, msix_vec);
> >               ret = devm_request_irq(&pdev->dev, irq,
> >                                      vp_vdpa_vq_handler,
> >                                      0, vp_vdpa->vring[i].msix_name, 
> > @@ -185,21 +194,22 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
> >                               "vp_vdpa: fail to request irq for vq %d\n", i);
> >                       goto err;
> >               }
> > -             vp_modern_queue_vector(mdev, i, i);
> > +             vp_modern_queue_vector(mdev, i, msix_vec);
> >               vp_vdpa->vring[i].irq = irq;
> > +             msix_vec++;
> >       }
> >
> >       snprintf(vp_vdpa->msix_name, VP_VDPA_NAME_SIZE, "vp-vdpa[%s]-config\n",
> >                pci_name(pdev));
> > -     irq = pci_irq_vector(pdev, queues);
> > +     irq = pci_irq_vector(pdev, msix_vec);
> >       ret = devm_request_irq(&pdev->dev, irq, vp_vdpa_config_handler, 0,
> >                              vp_vdpa->msix_name, vp_vdpa);
> >       if (ret) {
> >               dev_err(&pdev->dev,
> > -                     "vp_vdpa: fail to request irq for vq %d\n", i);
> > +                     "vp_vdpa: fail to request irq for config: %d\n", 
> > + ret);
> >                       goto err;
> >       }
> > -     vp_modern_config_vector(mdev, queues);
> > +     vp_modern_config_vector(mdev, msix_vec);
> >       vp_vdpa->config_irq = irq;
> >
> >       return 0;
> > --
> > 2.43.0
> 

