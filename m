Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F783405C2
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 22:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZG6ABtKt"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7572361412
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 22:52:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7572361412
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZG6ABtKt
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HuA08ndiJvNK
	for <virtualization@lists.linux-foundation.org>;
	Tue,  5 Dec 2023 22:52:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7CD0661411
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 22:52:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7CD0661411
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701816719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bp190EtfGjWCeA3brdN4OZ/TodkB+7ZXGXpd4KD/R9A=;
	b=ZG6ABtKt8QNMdGVEjTic6laOVcdJgqGXkVmh0OQuagKlWciq46EWrX3uyWd/QIUU6Mw9Sf
	7CRPuquB8kE19yYVAF4+jlHXW2ZaFvat9HDlhZjWUmepJHh8yBbHQM7p+72eeXODBKoUDA
	nawi886hAra/6NPlYrsZ7P372akNGFw=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-g640zjSuPq62mh14-HpdAw-1; Tue, 05 Dec 2023 17:51:57 -0500
X-MC-Unique: g640zjSuPq62mh14-HpdAw-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-58d5657b6bbso334125eaf.1
        for <virtualization@lists.linux-foundation.org>; Tue, 05 Dec 2023 14:51:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701816716; x=1702421516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bp190EtfGjWCeA3brdN4OZ/TodkB+7ZXGXpd4KD/R9A=;
        b=oeKV/IsNnzv9+Xukr11Br2Eu3EO0qX0absPNTfuxZjwW8mJgMxGv35x9D/RjMksjz3
         +9Hqn4c8LLOXzImrP47YS1c3FwtZpHrMy9LvDEjkrlL1K76quvDw2YeqXteQZYRzx6pm
         hiqgGhEFOUucuslIrzv51X0ROezlUoQRo7UrGl9BW98LnoYUlbuczl6WTrGS7qU0kluY
         RO8pBQFqVZtFFjyCMbGBf3cCJDdlRZkdqHR5eLW6TK4mG00f+Halffbeyxxt1+DY62WX
         GhGANM4nEyiRyi8pM2pn6ukKsGl3AKaus1+xaigitbAeysOegG+2YK2ODFIqU6X6PJ0D
         5Ucg==
X-Gm-Message-State: AOJu0YyMpG//M13HPEcTkix2SVRNYjcNWrgA0DFEbsS3dyK83VJY2dPZ
	RGrY6P0X1aGptTGubeYSDHMCmQPTUIqrpM2ertiW2Ul/ox+x4VJnaN8NG+QZ9J3A0gX5M/AR3oH
	2pbq0mIMOoCa3kVZBX9Tid8vErzWMnPQjBjO8Tu5kZQ==
X-Received: by 2002:a05:6870:b14d:b0:1fb:788:e8a3 with SMTP id a13-20020a056870b14d00b001fb0788e8a3mr1044681oal.30.1701816716690;
        Tue, 05 Dec 2023 14:51:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHX+wy1tCPko5PNZEieZRXLMkP4wf5109/rs8kmfxtsW8LCRjq2ZZRbnCa0Y7fVkzda+iRfsA==
X-Received: by 2002:a05:6870:b14d:b0:1fb:788:e8a3 with SMTP id a13-20020a056870b14d00b001fb0788e8a3mr1044670oal.30.1701816716352;
        Tue, 05 Dec 2023 14:51:56 -0800 (PST)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id pb15-20020a0568701e8f00b001fb17559927sm2426720oab.48.2023.12.05.14.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 14:51:55 -0800 (PST)
Date: Tue, 5 Dec 2023 15:51:53 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Cc: <mst@redhat.com>, <jasowang@redhat.com>, <jgg@nvidia.com>,
 <kvm@vger.kernel.org>, <virtualization@lists.linux-foundation.org>,
 <parav@nvidia.com>, <feliu@nvidia.com>, <jiri@nvidia.com>,
 <kevin.tian@intel.com>, <joao.m.martins@oracle.com>,
 <si-wei.liu@oracle.com>, <leonro@nvidia.com>, <maorg@nvidia.com>
Subject: Re: [PATCH V5 vfio 8/9] vfio/pci: Expose
 vfio_pci_core_iowrite/read##size()
Message-ID: <20231205155153.2d5aceab.alex.williamson@redhat.com>
In-Reply-To: <20231205170623.197877-9-yishaih@nvidia.com>
References: <20231205170623.197877-1-yishaih@nvidia.com>
	<20231205170623.197877-9-yishaih@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
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

On Tue, 5 Dec 2023 19:06:22 +0200
Yishai Hadas <yishaih@nvidia.com> wrote:

> Expose vfio_pci_core_iowrite/read##size() to let it be used by drivers.
> 
> This functionality is needed to enable direct access to some physical
> BAR of the device with the proper locks/checks in place.
> 
> The next patches from this series will use this functionality on a data
> path flow when a direct access to the BAR is needed.
> 
> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> ---
>  drivers/vfio/pci/vfio_pci_rdwr.c | 46 +++++++++++++++++---------------
>  include/linux/vfio_pci_core.h    | 19 +++++++++++++
>  2 files changed, 43 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
> index a9887fd6de46..448ee90a3bb1 100644
> --- a/drivers/vfio/pci/vfio_pci_rdwr.c
> +++ b/drivers/vfio/pci/vfio_pci_rdwr.c
> @@ -38,7 +38,7 @@
>  #define vfio_iowrite8	iowrite8
>  
>  #define VFIO_IOWRITE(size) \
> -static int vfio_pci_iowrite##size(struct vfio_pci_core_device *vdev,		\
> +int vfio_pci_core_iowrite##size(struct vfio_pci_core_device *vdev,	\
>  			bool test_mem, u##size val, void __iomem *io)	\
>  {									\
>  	if (test_mem) {							\
> @@ -55,7 +55,8 @@ static int vfio_pci_iowrite##size(struct vfio_pci_core_device *vdev,		\
>  		up_read(&vdev->memory_lock);				\
>  									\
>  	return 0;							\
> -}
> +}									\
> +EXPORT_SYMBOL_GPL(vfio_pci_core_iowrite##size);
>  
>  VFIO_IOWRITE(8)
>  VFIO_IOWRITE(16)
> @@ -65,7 +66,7 @@ VFIO_IOWRITE(64)
>  #endif
>  
>  #define VFIO_IOREAD(size) \
> -static int vfio_pci_ioread##size(struct vfio_pci_core_device *vdev,		\
> +int vfio_pci_core_ioread##size(struct vfio_pci_core_device *vdev,	\
>  			bool test_mem, u##size *val, void __iomem *io)	\
>  {									\
>  	if (test_mem) {							\
> @@ -82,7 +83,8 @@ static int vfio_pci_ioread##size(struct vfio_pci_core_device *vdev,		\
>  		up_read(&vdev->memory_lock);				\
>  									\
>  	return 0;							\
> -}
> +}									\
> +EXPORT_SYMBOL_GPL(vfio_pci_core_ioread##size);
>  
>  VFIO_IOREAD(8)
>  VFIO_IOREAD(16)
> @@ -119,13 +121,13 @@ static ssize_t do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
>  				if (copy_from_user(&val, buf, 4))
>  					return -EFAULT;
>  
> -				ret = vfio_pci_iowrite32(vdev, test_mem,
> -							 val, io + off);
> +				ret = vfio_pci_core_iowrite32(vdev, test_mem,
> +							      val, io + off);
>  				if (ret)
>  					return ret;
>  			} else {
> -				ret = vfio_pci_ioread32(vdev, test_mem,
> -							&val, io + off);
> +				ret = vfio_pci_core_ioread32(vdev, test_mem,
> +							     &val, io + off);
>  				if (ret)
>  					return ret;
>  
> @@ -141,13 +143,13 @@ static ssize_t do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
>  				if (copy_from_user(&val, buf, 2))
>  					return -EFAULT;
>  
> -				ret = vfio_pci_iowrite16(vdev, test_mem,
> -							 val, io + off);
> +				ret = vfio_pci_core_iowrite16(vdev, test_mem,
> +							      val, io + off);
>  				if (ret)
>  					return ret;
>  			} else {
> -				ret = vfio_pci_ioread16(vdev, test_mem,
> -							&val, io + off);
> +				ret = vfio_pci_core_ioread16(vdev, test_mem,
> +							     &val, io + off);
>  				if (ret)
>  					return ret;
>  
> @@ -163,13 +165,13 @@ static ssize_t do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
>  				if (copy_from_user(&val, buf, 1))
>  					return -EFAULT;
>  
> -				ret = vfio_pci_iowrite8(vdev, test_mem,
> -							val, io + off);
> +				ret = vfio_pci_core_iowrite8(vdev, test_mem,
> +							     val, io + off);
>  				if (ret)
>  					return ret;
>  			} else {
> -				ret = vfio_pci_ioread8(vdev, test_mem,
> -						       &val, io + off);
> +				ret = vfio_pci_core_ioread8(vdev, test_mem,
> +							    &val, io + off);
>  				if (ret)
>  					return ret;
>  
> @@ -364,16 +366,16 @@ static void vfio_pci_ioeventfd_do_write(struct vfio_pci_ioeventfd *ioeventfd,
>  {
>  	switch (ioeventfd->count) {
>  	case 1:
> -		vfio_pci_iowrite8(ioeventfd->vdev, test_mem,
> -				  ioeventfd->data, ioeventfd->addr);
> +		vfio_pci_core_iowrite8(ioeventfd->vdev, test_mem,
> +				       ioeventfd->data, ioeventfd->addr);
>  		break;
>  	case 2:
> -		vfio_pci_iowrite16(ioeventfd->vdev, test_mem,
> -				   ioeventfd->data, ioeventfd->addr);
> +		vfio_pci_core_iowrite16(ioeventfd->vdev, test_mem,
> +					ioeventfd->data, ioeventfd->addr);
>  		break;
>  	case 4:
> -		vfio_pci_iowrite32(ioeventfd->vdev, test_mem,
> -				   ioeventfd->data, ioeventfd->addr);
> +		vfio_pci_core_iowrite32(ioeventfd->vdev, test_mem,
> +					ioeventfd->data, ioeventfd->addr);
>  		break;
>  #ifdef iowrite64
>  	case 8:

There's a vfio_pci_iowrite64() call just below here that was missed.
Otherwise the vfio parts of the series looks ok to me.  We still need
to recruit another reviewer though.

My preferred merge approach would be that virtio maintainers take
patches 1-6 and provide a branch or tag I can merge to bring 7-9 in
through the vfio tree.  Thanks,

Alex

> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index 67ac58e20e1d..85e84b92751b 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -131,4 +131,23 @@ int vfio_pci_core_setup_barmap(struct vfio_pci_core_device *vdev, int bar);
>  pci_ers_result_t vfio_pci_core_aer_err_detected(struct pci_dev *pdev,
>  						pci_channel_state_t state);
>  
> +#define VFIO_IOWRITE_DECLATION(size) \
> +int vfio_pci_core_iowrite##size(struct vfio_pci_core_device *vdev,	\
> +			bool test_mem, u##size val, void __iomem *io);
> +
> +VFIO_IOWRITE_DECLATION(8)
> +VFIO_IOWRITE_DECLATION(16)
> +VFIO_IOWRITE_DECLATION(32)
> +#ifdef iowrite64
> +VFIO_IOWRITE_DECLATION(64)
> +#endif
> +
> +#define VFIO_IOREAD_DECLATION(size) \
> +int vfio_pci_core_ioread##size(struct vfio_pci_core_device *vdev,	\
> +			bool test_mem, u##size *val, void __iomem *io);
> +
> +VFIO_IOREAD_DECLATION(8)
> +VFIO_IOREAD_DECLATION(16)
> +VFIO_IOREAD_DECLATION(32)
> +
>  #endif /* VFIO_PCI_CORE_H */

