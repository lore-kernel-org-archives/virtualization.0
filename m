Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB1620C47E
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Nov 2024 21:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730928831; cv=none; b=tnaxs4zAL4XOL41ypzkxotzh9lY6H/8k6q4UI3yhaNzlc4MJjUsHd32CNcfIsum4xgNhPPEyhFHQbzyr9is8VV1wh6i+vfv1Og1/iRvBznzmhpJCfUNVI1pOVR4NkhguIlKLKeMA9Wgt8gF4ufRbn0/2wM8JQsJgOkI+D62bBj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730928831; c=relaxed/simple;
	bh=fdOaNFvjHNhZvAo41H3nYbZtuHMgOflDpg4KuZc1jzg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d8jTT0VPbZ6APOi2H2u9hKdsJxGmDZsHpd2fWeL+oPtMFEheZhTP2Z3pcYV0H1T0igJVbdutwd23Gj6s3O4paadEjsSx4DpWgGe9CK7l4ePousdVY2EsPTzhCwsaD8cDU59vrnBA/+dl1f3X0WWx5RQRn1I2ubTY9iOW/SbCOes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gbsrLLgE; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gbsrLLgE"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 380104027F
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Nov 2024 21:33:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GazJwpNWnzSS for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Nov 2024 21:33:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=alex.williamson@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org EB28140281
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EB28140281
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gbsrLLgE
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EB28140281
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Nov 2024 21:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730928826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3rFuWga3DWj70TxE9k7zWnQDJYpC4sUfbe1+XXpU5Mo=;
	b=gbsrLLgEiq9C4sfWMft62N4ol2aDPFrdx8zFwWvClEhLLXqyDQ4RN3PIScT4hmFRr0/K4h
	iZdBV5htF9eY468u5SyGpypH2SRMocBodBLe7A4jctFRf7nylors7u56w5nnKxHckUmzpO
	InazuABpxRaNn7fRItZjgZzjuqrOn6o=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-40rP0HPuNdq1NyzBSB3qSg-1; Wed, 06 Nov 2024 16:33:45 -0500
X-MC-Unique: 40rP0HPuNdq1NyzBSB3qSg-1
X-Mimecast-MFC-AGG-ID: 40rP0HPuNdq1NyzBSB3qSg
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-83ab67710b5so5901239f.3
        for <virtualization@lists.linux-foundation.org>; Wed, 06 Nov 2024 13:33:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730928824; x=1731533624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rFuWga3DWj70TxE9k7zWnQDJYpC4sUfbe1+XXpU5Mo=;
        b=YZFo6scilEMPxqCGBXb51hAEQ/ym9r2Pm0VDWUxEYd9RtMyjmEfT2pi3aI2k3X3hVh
         NeOTTUkXXDB4NCs28rO5S9HfFhVpVwG12L/LywxUHoentpdghtG6wOU6U8kHFUhNix/k
         wAo0b0Cz6DERKkS+130hSIQZwdjpbsSwUzAssBsEQfynLDo0XBipzJg264LTaeSquzs2
         nQ4P14vH+bU4QKYrmsNBJeSM75yc+XnBZwjKkDhRbZsaiZMCwzkPF1JQsRMbrZ1DOLHk
         4ZzP9mkPYfFBXJ8zIlhQCNMU6H2UAV85vCuFxrm4w/6dIsPsnDFxw4H0/lh2tgTHRWYZ
         ANhA==
X-Forwarded-Encrypted: i=1; AJvYcCU03V+KCKQCeqVC6b2LY0I5mrgrJVDht/FRDhqSSrvrry2ss6M4FIOj+dRAUZ+fEL8WnmaSQlSvSMTiuiyUfw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwrBr5EeyUpB8PJgkPsBAJaVrJX3hijdsuale22Pntkv/+2nxtT
	9bjnRQo7O3Kpt8QKZ2Lv6JwnyeCR1eJdzY0vIxAMAsXbW8Rt00miYCTmx5JZ7tEyCkBuQa6QTT4
	tvdkiZJVffGRvoeGfwgUCbwqslljB1vi5Co62s1b22jNgK0eKsrVlMziZCjqyoShR4vlI7vho1/
	RNiC4=
X-Received: by 2002:a05:6e02:218a:b0:3a2:6cd7:3255 with SMTP id e9e14a558f8ab-3a6e84df7d1mr3657045ab.6.1730928824414;
        Wed, 06 Nov 2024 13:33:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuT+VT9roBsHPUnIHBvMzoBnoPeaxTloo7Ag+mF34Wwwx3rkMzbNjX101Do2BtnATBTfkrHQ==
X-Received: by 2002:a05:6e02:218a:b0:3a2:6cd7:3255 with SMTP id e9e14a558f8ab-3a6e84df7d1mr3656805ab.6.1730928823737;
        Wed, 06 Nov 2024 13:33:43 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a6c6643853sm23973195ab.43.2024.11.06.13.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 13:33:43 -0800 (PST)
Date: Wed, 6 Nov 2024 14:33:41 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Cc: <mst@redhat.com>, <jasowang@redhat.com>, <jgg@nvidia.com>,
 <kvm@vger.kernel.org>, <virtualization@lists.linux-foundation.org>,
 <parav@nvidia.com>, <feliu@nvidia.com>, <kevin.tian@intel.com>,
 <joao.m.martins@oracle.com>, <leonro@nvidia.com>, <maorg@nvidia.com>
Subject: Re: [PATCH V1 vfio 5/7] vfio/virtio: Add support for the basic live
 migration functionality
Message-ID: <20241106143341.1b23936c.alex.williamson@redhat.com>
In-Reply-To: <eebad7d5-d7c2-4910-872c-c362c246aa78@nvidia.com>
References: <20241104102131.184193-1-yishaih@nvidia.com>
	<20241104102131.184193-6-yishaih@nvidia.com>
	<20241105154746.60e06e75.alex.williamson@redhat.com>
	<eebad7d5-d7c2-4910-872c-c362c246aa78@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WGWBZ5LvTsIecIs5zJ5VTgbAsxNqtxLGhDy6yEVjO1o_1730928824
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Nov 2024 12:21:03 +0200
Yishai Hadas <yishaih@nvidia.com> wrote:

> On 06/11/2024 0:47, Alex Williamson wrote:
> > On Mon, 4 Nov 2024 12:21:29 +0200
> > Yishai Hadas <yishaih@nvidia.com> wrote:  
> >> diff --git a/drivers/vfio/pci/virtio/main.c b/drivers/vfio/pci/virtio/main.c
> >> index b5d3a8c5bbc9..e2cdf2d48200 100644
> >> --- a/drivers/vfio/pci/virtio/main.c
> >> +++ b/drivers/vfio/pci/virtio/main.c  
> > ...  
> >> @@ -485,16 +478,66 @@ static bool virtiovf_bar0_exists(struct pci_dev *pdev)
> >>   	return res->flags;
> >>   }
> >>   
> >> +static int virtiovf_pci_init_device(struct vfio_device *core_vdev)
> >> +{
> >> +	struct virtiovf_pci_core_device *virtvdev = container_of(core_vdev,
> >> +			struct virtiovf_pci_core_device, core_device.vdev);
> >> +	struct pci_dev *pdev;
> >> +	bool sup_legacy_io;
> >> +	bool sup_lm;
> >> +	int ret;
> >> +
> >> +	ret = vfio_pci_core_init_dev(core_vdev);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	pdev = virtvdev->core_device.pdev;
> >> +	sup_legacy_io = virtio_pci_admin_has_legacy_io(pdev) &&
> >> +				!virtiovf_bar0_exists(pdev);
> >> +	sup_lm = virtio_pci_admin_has_dev_parts(pdev);
> >> +
> >> +	/*
> >> +	 * If the device is not capable to this driver functionality, fallback
> >> +	 * to the default vfio-pci ops
> >> +	 */
> >> +	if (!sup_legacy_io && !sup_lm) {
> >> +		core_vdev->ops = &virtiovf_vfio_pci_ops;
> >> +		return 0;
> >> +	}
> >> +
> >> +	if (sup_legacy_io) {
> >> +		ret = virtiovf_read_notify_info(virtvdev);
> >> +		if (ret)
> >> +			return ret;
> >> +
> >> +		virtvdev->bar0_virtual_buf_size = VIRTIO_PCI_CONFIG_OFF(true) +
> >> +					virtiovf_get_device_config_size(pdev->device);
> >> +		BUILD_BUG_ON(!is_power_of_2(virtvdev->bar0_virtual_buf_size));
> >> +		virtvdev->bar0_virtual_buf = kzalloc(virtvdev->bar0_virtual_buf_size,
> >> +						     GFP_KERNEL);
> >> +		if (!virtvdev->bar0_virtual_buf)
> >> +			return -ENOMEM;
> >> +		mutex_init(&virtvdev->bar_mutex);
> >> +	}
> >> +
> >> +	if (sup_lm)
> >> +		virtiovf_set_migratable(virtvdev);
> >> +
> >> +	if (sup_lm && !sup_legacy_io)
> >> +		core_vdev->ops = &virtiovf_vfio_pci_lm_ops;
> >> +
> >> +	return 0;
> >> +}
> >> +
> >>   static int virtiovf_pci_probe(struct pci_dev *pdev,
> >>   			      const struct pci_device_id *id)
> >>   {
> >> -	const struct vfio_device_ops *ops = &virtiovf_vfio_pci_ops;
> >>   	struct virtiovf_pci_core_device *virtvdev;
> >> +	const struct vfio_device_ops *ops;
> >>   	int ret;
> >>   
> >> -	if (pdev->is_virtfn && virtio_pci_admin_has_legacy_io(pdev) &&
> >> -	    !virtiovf_bar0_exists(pdev))
> >> -		ops = &virtiovf_vfio_pci_tran_ops;
> >> +	ops = (pdev->is_virtfn) ? &virtiovf_vfio_pci_tran_lm_ops :
> >> +				  &virtiovf_vfio_pci_ops;  
> > 
> > I can't figure out why we moved the more thorough ops setup to the
> > .init() callback of the ops themselves.  Clearly we can do the legacy
> > IO and BAR0 test here and the dev parts test uses the same mechanisms
> > as the legacy IO test, so it seems we could know sup_legacy_io and
> > sup_lm here.  I think we can even do virtiovf_set_migratable() here
> > after virtvdev is allocated below.
> >   
> 
> Setting the 'ops' as part of the probe() seems actually doable, 
> including calling virtiovf_set_migratable() following the virtiodev 
> allocation below.
> 
> The main issue with that approach will be the init part of the legacy IO 
> (i.e. virtiovf_init_legacy_io()) as part of virtiovf_pci_init_device().
> 
> Assuming that we don't want to repeat calling 
> virtiovf_support_legacy_io() as part of virtiovf_pci_init_device() to 
> know whether legacy IO is supported, we can consider calling 
> virtiovf_init_legacy_io() as part of the probe() as well, which IMO 
> doesn't look clean as it's actually seems to match the init flow.
> 
> Alternatively, we can consider checking inside 
> virtiovf_pci_init_device() whether the 'ops' actually equals the 'tran' 
> ones and then call it.
> 
> Something like the below.
> 
> static int virtiovf_pci_init_device(struct vfio_device *core_vdev)
> {
> 	...
> 
> #ifdef CONFIG_VIRTIO_PCI_ADMIN_LEGACY
> 	if (core_vdev->ops == &virtiovf_vfio_pci_tran_lm_ops)
> 		return virtiovf_init_legacy_io(virtvdev);
> #endif
> 
> 	return 0;
> }
> 
> Do you prefer the above approach rather than current V1 code which has a 
>   single check as part of virtiovf_init_legacy_io() ?

If ops is properly configured and set-migratable is done in probe,
then doesn't only the legacy ops .init callback need to init the legacy
setup?  The non-legacy, migration ops structure would just use
vfio_pci_core_init_dev.

> 
> > I think the API to vfio core also suggests we shouldn't be modifying the
> > ops pointer after the core device is allocated.  
> 
> Any pointer for that ?
> Do we actually see a problem with replacing the 'ops' as part of the 
> init flow ?

What makes it that way to me is that it's an argument to and set by the
object constructor.  The ops callbacks should be considered live once
set.  It's probably safe to do as you've done here because the
constructor calls the init callback directly, so we don't have any
races.  However as Jason agreed, it's generally a pattern to avoid and I
think we can rather easily do so here.  Thanks,

Alex

