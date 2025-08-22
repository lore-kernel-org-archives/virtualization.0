Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115562D7DCB
	for <virtualization@lists.linux.dev>; Fri, 22 Aug 2025 10:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755858123; cv=none; b=fQnHBt/08b4ffpFC63gPuvqYQjCOEds/gpw4gPI7N0+3cMWaE1XQjifTW6kvsL/qVNgljVElNPPA5PDGICWrwUjY+wt8nGyR9ls4jW15vqq9gznKYydjdQ4gA8vvcDQYj1DXWyUlXkGVtfww1WPIBVVLYTZcdba2XwIm5OL1AQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755858123; c=relaxed/simple;
	bh=QDSdtnZUnX3xJMyqT3lvdDtJgiNwcC+bStOaJK2QDQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jc8F8lgtlI6rnz22sgBmkNX+a4iaUhbQMkd2aDN1NijIYc7eEs3NMC8RaXZjkGtSQCnHjs4RpzNAwqv2LfYqglPk1jy4FZsEwIvW8M3hjPvesbQlC/AMtBNOPws/WGsNjJ7jdWpKoxsQJxAAQl9IuXmxlTSytWHaJkSOa2HrtG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O67l0Qtn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O67l0Qtn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755858120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BsR7WvFetJQPDV9UadbGaGgLU3t3WtTZVmLYnKWZWUw=;
	b=O67l0QtnhIV7PqECQwMO3zfrD+mudj2IqSIOcvjmLbq1SPsMrmFKrSaMR3IUy76ZkFQNjc
	cwMMd2eTW+mM3tNgB1F/RDPEy92UcBSM9UTCWHotGoceniWj5HvsV0o2iFhIgCypUwob6x
	k7VgjUcheeleO33Arr3FKykrw+iRwiY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-MsSfZ_NxPdu0yh-4-2otaw-1; Fri, 22 Aug 2025 06:21:57 -0400
X-MC-Unique: MsSfZ_NxPdu0yh-4-2otaw-1
X-Mimecast-MFC-AGG-ID: MsSfZ_NxPdu0yh-4-2otaw_1755858116
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3c6abcfd1c0so47817f8f.1
        for <virtualization@lists.linux.dev>; Fri, 22 Aug 2025 03:21:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755858116; x=1756462916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BsR7WvFetJQPDV9UadbGaGgLU3t3WtTZVmLYnKWZWUw=;
        b=j9fIA0tnsuuGRtFZ7YKjDTA+ERPrzwUwiI1xo+Dv/RvGHlgfd+o2M0oUs/7SANZqZO
         J4pNervqGpxkubnFxubbUt8wZDFmWY9L0EbKDlMCQYT4CVBfrYQlMvZ+bNjZTQ8eGxo1
         aUqCSgHEWNXVvTs97VUlPnU6s+R7DHv/kj586xFdC2mYWwAVChMY2Ai2CvQENLBVpcbt
         BQFZWJq6Xlpl5RRPZWuHkjCSNYgdWZ1B7AkqAs8i8rij34hGTkpOvN65HRzN5lZGfk7M
         v9xZjVaS0O2wPKkMhmTK3FFK5plq4oX28spbfI4DKzePmVOQbD6falP1Itt3xOfIjgck
         iW3A==
X-Gm-Message-State: AOJu0YyEi224kopM8pv9BEANTz7DQ8cfSWERi0GgvjOyBKjckRGjTWni
	mBXS/Ho28Cj0Y94eWCGfjjZKZ8tv2vtZ6VBdsKVTgSVk6WdhPZzcCY6ojLVA47ahB8/OFsQTpUl
	qjCRfxdD+Xa23QULFVsWzqlezp8mIVMKTbZ1+bK7ifbui+QSc96WI6A6bGPVsZx1VIq3C
X-Gm-Gg: ASbGnct4S3tv0dm3hZyORpvZEOxyXqArCFYXTEjbM7SkCc9TYtWDCz0zgGdYEBse62v
	/ichfGyfmS2e6MEcdBX2OW2Co2YDJNu61GzswKduJsbIteBF4ZenEdUk7Uk4ke1/+Zy0sx9g/qu
	wbTaSnloFQV7O2oG8/LBRYYtkmPeDpiIirFyD61RmuHWtT+82creOT43Eekw/Yb1HiEm2i/mc/u
	vrIZevwXPiir8V/nhjk6WdFAXXuylMMk4qFE9oGNRcCFNFmFhbA5ryoeNhi2IFlyy4xBElKC5jP
	ZBT84IDknkj2m54ljAZyBT8QxTXeasPW
X-Received: by 2002:a05:6000:4383:b0:3c5:9e0f:7607 with SMTP id ffacd0b85a97d-3c5dc734286mr1744622f8f.33.1755858116060;
        Fri, 22 Aug 2025 03:21:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUO6AnrO7QzlxlMIJWKsxbYeqV/MnPslbbUlNJDbzbnkOgi3Hgch3hfndltvEmRoBM6OkOwA==
X-Received: by 2002:a05:6000:4383:b0:3c5:9e0f:7607 with SMTP id ffacd0b85a97d-3c5dc734286mr1744598f8f.33.1755858115600;
        Fri, 22 Aug 2025 03:21:55 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c66f532bbbsm1005865f8f.44.2025.08.22.03.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 03:21:55 -0700 (PDT)
Date: Fri, 22 Aug 2025 06:21:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	stefanha@redhat.com, pbonzini@redhat.com,
	xuanzhuo@linux.alibaba.com, stable@vger.kernel.org,
	mgurtovoy@nvidia.com, lirongqing@baidu.com
Subject: Re: [PATCH] Revert "virtio_pci: Support surprise removal of virtio
 pci device"
Message-ID: <20250822060839-mutt-send-email-mst@kernel.org>
References: <20250822091706.21170-1-parav@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250822091706.21170-1-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Y2eiYy84xHdwowpEdCDfxcjwl17_C42lY0yEuweQ7Bs_1755858116
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 22, 2025 at 12:17:06PM +0300, Parav Pandit wrote:
> This reverts commit 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio pci device").
> 
> Virtio drivers and PCI devices have never fully supported true
> surprise (aka hot unplug) removal. Drivers historically continued
> processing and waiting for pending I/O and even continued synchronous
> device reset during surprise removal. Devices have also continued
> completing I/Os, doing DMA and allowing device reset after surprise
> removal to support such drivers.
> 
> Supporting it correctly would require a new device capability

If a device is removed, it is removed. Windows drivers supported
this since forever and it's just a Linux bug that it does not
handle all the cases. This is not something you can handle
with a capability.





> and
> driver negotiation in the virtio specification to safely stop
> I/O and free queue memory. Failure to do so either breaks all the
> existing drivers with call trace listed in the commit or crashes the
> host on continuing the DMA.

If the device is gone, then DMA does not continue.

IIUC what is going on for you, is that you have developed a surprise
removal emulation that pretends to remove the device but
actually the device is doing DMA. So of course things break then.

> Hence, until such specification and devices
> are invented, restore the previous behavior of treating surprise
> removal as graceful removal to avoid regressions and maintain system
> stability same as before the
> commit 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio pci device").
> 
> As explained above, previous analysis of solving this only in driver
> was incomplete and non-reliable at [1] and at [2]; Hence reverting commit
> 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio pci device")
> is still the best stand to restore failures of virtio net and
> block devices.
> 
> [1] https://lore.kernel.org/virtualization/CY8PR12MB719506CC5613EB100BC6C638DCBD2@CY8PR12MB7195.namprd12.prod.outlook.com/#t


I can only repeat what I said then, this is not how we do kernel
development.

> [2] https://lore.kernel.org/virtualization/20250602024358.57114-1-parav@nvidia.com/

What was missing here, is handling corner cases. So let us please 
try to handle them.

Here is how I would try to do it:

- add a new driver callback
- start a periodic timer task in virtio core on remove
- in the timer, probe that the device is still present.
  if not, invoke a driver callback
- cancel the task on device reset

If you do not have the time, let me know and I will try to look into it.

> Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio pci device")
> Cc: stable@vger.kernel.org
> Reported-by: lirongqing@baidu.com
> Closes: https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9b4741@baidu.com/
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
>  drivers/virtio/virtio_pci_common.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index d6d79af44569..dba5eb2eaff9 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -747,13 +747,6 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
>  	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
>  	struct device *dev = get_device(&vp_dev->vdev.dev);
>  
> -	/*
> -	 * Device is marked broken on surprise removal so that virtio upper
> -	 * layers can abort any ongoing operation.
> -	 */
> -	if (!pci_device_is_present(pci_dev))
> -		virtio_break_device(&vp_dev->vdev);
> -
>  	pci_disable_sriov(pci_dev);
>  
>  	unregister_virtio_device(&vp_dev->vdev);
> -- 
> 2.26.2

