Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D06222063
	for <virtualization@lists.linux-foundation.org>; Thu, 30 Nov 2023 19:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BmUxWtMK"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8CB8F6F563
	for <virtualization@lists.linux-foundation.org>; Thu, 30 Nov 2023 19:20:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8CB8F6F563
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BmUxWtMK
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.599
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AZsdaGlYOXzY
	for <virtualization@lists.linux-foundation.org>;
	Thu, 30 Nov 2023 19:20:20 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CF54A60B29
	for <virtualization@lists.linux-foundation.org>; Thu, 30 Nov 2023 19:20:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CF54A60B29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701372018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gI+NHy4QsgVzIpGUJkuvfP+tzzElBrBrYlrvCXuyd6c=;
	b=BmUxWtMKUcErcnayyXU1z26Cqj5USXiecxIEldZyeFRRXNPbTrtLv4kvH3yD9sPL3e3CRD
	WmO9QbQQ2ZkKDW/Cy8BMCmqWPKxkKSHTnvA7fm9mNBSQIUTTf8lSuAsRrM6Zf0Bclf3WTH
	eCc6LnipA2bq9yAsLfWUsfkWSv7OS5c=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-98sW-ZWvMc2Qv5IGcJPeug-1; Thu, 30 Nov 2023 14:20:13 -0500
X-MC-Unique: 98sW-ZWvMc2Qv5IGcJPeug-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7b3f80e659aso118655139f.2
        for <virtualization@lists.linux-foundation.org>; Thu, 30 Nov 2023 11:20:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701372013; x=1701976813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gI+NHy4QsgVzIpGUJkuvfP+tzzElBrBrYlrvCXuyd6c=;
        b=glAKQG1PBJ/N+LUwHI2XB78kEeOZxmjGQ5z1IAeqfhkWsm1PRIEFrHCA5BMJjgMkLW
         nxe+5aUYmWMhnHb0FzFzUiCPQwFBsm1CubbWcVrE7iSDnlfmoHJQ2u/jTCCi8hHOH40Q
         A1U++gSh3M1tJK8OeqC16u0C620RqK4OgMkoGZf5Epz2bqVdbpQD1ZeDNo0BLqbZTkBU
         dZRv4YMW5byeF0xvEW+lrYTK6q/thT/traFOxRnB7/f0FPXOLNsD7LHfH0qTf0FApiEg
         6Soe7V6MDfeR0O2Ka+2xmzz6yxxJYbvEcVlMfJImBdLG2KriPQGRg38z3ERqQlvo2e1Y
         iyNA==
X-Gm-Message-State: AOJu0YyIHD6eelPhmfm0Za61zisvPlUqmIZMNTACxhxR74uKPPlUlhfE
	p7v++TwJByltkB2HJxZSeNwS4tJKY1YEetX8MIftAnXMxoFQjh2QLxh2fqTLjV//R5y9r1tCiW3
	166mEdkqhR+/RqZvT+rNA29XGMXEx2SuFAHFl9dmJ5Q==
X-Received: by 2002:a5e:8613:0:b0:791:16ba:d764 with SMTP id z19-20020a5e8613000000b0079116bad764mr25053634ioj.16.1701372013014;
        Thu, 30 Nov 2023 11:20:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWZAGlxOOtEZV4cyIfR8XEUIGJn/VBf5TbyQKFfZMrEfeBiouv9jSp1k1yGD0s6K3Fb1D2/A==
X-Received: by 2002:a5e:8613:0:b0:791:16ba:d764 with SMTP id z19-20020a5e8613000000b0079116bad764mr25053595ioj.16.1701372012621;
        Thu, 30 Nov 2023 11:20:12 -0800 (PST)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id cc14-20020a056602424e00b007b35739a580sm509939iob.27.2023.11.30.11.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 11:20:12 -0800 (PST)
Date: Thu, 30 Nov 2023 12:20:10 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Cc: <mst@redhat.com>, <jasowang@redhat.com>, <jgg@nvidia.com>,
 <kvm@vger.kernel.org>, <virtualization@lists.linux-foundation.org>,
 <parav@nvidia.com>, <feliu@nvidia.com>, <jiri@nvidia.com>,
 <kevin.tian@intel.com>, <joao.m.martins@oracle.com>,
 <si-wei.liu@oracle.com>, <leonro@nvidia.com>, <maorg@nvidia.com>
Subject: Re: [PATCH V4 vfio 8/9] vfio/pci: Expose
 vfio_pci_iowrite/read##size()
Message-ID: <20231130122010.3563bdee.alex.williamson@redhat.com>
In-Reply-To: <20231129143746.6153-9-yishaih@nvidia.com>
References: <20231129143746.6153-1-yishaih@nvidia.com>
	<20231129143746.6153-9-yishaih@nvidia.com>
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

On Wed, 29 Nov 2023 16:37:45 +0200
Yishai Hadas <yishaih@nvidia.com> wrote:

> Expose vfio_pci_iowrite/read##size() to let it be used by drivers.
> 
> This functionality is needed to enable direct access to some physical
> BAR of the device with the proper locks/checks in place.
> 
> The next patches from this series will use this functionality on a data
> path flow when a direct access to the BAR is needed.
> 
> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> ---
>  drivers/vfio/pci/vfio_pci_rdwr.c | 10 ++++++----
>  include/linux/vfio_pci_core.h    | 19 +++++++++++++++++++
>  2 files changed, 25 insertions(+), 4 deletions(-)

I don't follow the inconsistency between this and the previous patch.
Why did we move and rename the code to setup the barmap but we export
the ioread/write functions in place?  Thanks,

Alex


> diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
> index 6f08b3ecbb89..817ec9a89123 100644
> --- a/drivers/vfio/pci/vfio_pci_rdwr.c
> +++ b/drivers/vfio/pci/vfio_pci_rdwr.c
> @@ -38,7 +38,7 @@
>  #define vfio_iowrite8	iowrite8
>  
>  #define VFIO_IOWRITE(size) \
> -static int vfio_pci_iowrite##size(struct vfio_pci_core_device *vdev,		\
> +int vfio_pci_iowrite##size(struct vfio_pci_core_device *vdev,		\
>  			bool test_mem, u##size val, void __iomem *io)	\
>  {									\
>  	if (test_mem) {							\
> @@ -55,7 +55,8 @@ static int vfio_pci_iowrite##size(struct vfio_pci_core_device *vdev,		\
>  		up_read(&vdev->memory_lock);				\
>  									\
>  	return 0;							\
> -}
> +}									\
> +EXPORT_SYMBOL_GPL(vfio_pci_iowrite##size);
>  
>  VFIO_IOWRITE(8)
>  VFIO_IOWRITE(16)
> @@ -65,7 +66,7 @@ VFIO_IOWRITE(64)
>  #endif
>  
>  #define VFIO_IOREAD(size) \
> -static int vfio_pci_ioread##size(struct vfio_pci_core_device *vdev,		\
> +int vfio_pci_ioread##size(struct vfio_pci_core_device *vdev,		\
>  			bool test_mem, u##size *val, void __iomem *io)	\
>  {									\
>  	if (test_mem) {							\
> @@ -82,7 +83,8 @@ static int vfio_pci_ioread##size(struct vfio_pci_core_device *vdev,		\
>  		up_read(&vdev->memory_lock);				\
>  									\
>  	return 0;							\
> -}
> +}									\
> +EXPORT_SYMBOL_GPL(vfio_pci_ioread##size);
>  
>  VFIO_IOREAD(8)
>  VFIO_IOREAD(16)
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index 67ac58e20e1d..22c915317788 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -131,4 +131,23 @@ int vfio_pci_core_setup_barmap(struct vfio_pci_core_device *vdev, int bar);
>  pci_ers_result_t vfio_pci_core_aer_err_detected(struct pci_dev *pdev,
>  						pci_channel_state_t state);
>  
> +#define VFIO_IOWRITE_DECLATION(size) \
> +int vfio_pci_iowrite##size(struct vfio_pci_core_device *vdev,		\
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
> +int vfio_pci_ioread##size(struct vfio_pci_core_device *vdev,		\
> +			bool test_mem, u##size *val, void __iomem *io);
> +
> +VFIO_IOREAD_DECLATION(8)
> +VFIO_IOREAD_DECLATION(16)
> +VFIO_IOREAD_DECLATION(32)
> +
>  #endif /* VFIO_PCI_CORE_H */

