Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F3C1EFF9A
	for <virtualization@lists.linux.dev>; Tue, 13 May 2025 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747131536; cv=none; b=PSfM5GLDwD7sfSBj/n83cUaNpbV3IuG0jkCl/vKxKYPD4MOQmdqwFf/7iJ8MzQgeuFwtbG/2cGpMSwowWH7DImm5Gf+/8gp8XOzLyzRFlAuo+rktyxtX/cfOX4vIXKx+S4hKJmpRnmnE9Ks5c0WNboBTd2yrDQrqMyhI9NRgP6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747131536; c=relaxed/simple;
	bh=jRuzo4/3OQzqG2dIac5MD2AcA91NQR6fPMzmFIs9ZcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RP2in1m9EjJpSu/csUopkfnKQr/j2VwQRImkP7UAAqU+5glZ2jDZWbFZM6wrOzhDIJdT0ACkWgF//BUpx3HV2Ql0YXbG+VQNI+bqVFo6/kPQGGYFk31ZNtSAdyR2YyzaGdNxO88VgMlXPiQ7d2fV6tdSGrjTDEmCfpVUXxhv3XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WiDon6kq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WiDon6kq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747131532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MmHwRr/FwfMiAzxrBeHegbZ0WVrEAMDlFqzhA6NIUDs=;
	b=WiDon6kqCdyrG5m36iOVWKJt07ER+nm1PeB96WBgysWru193w495Yp0weHrqgwzxLPcMtw
	l5aV5ZQIMgCEpfWoFXXnyx8S1QmPjJK24kV1G0syB9Ye6VaSEsHnhw/l8Bvj6fwJH881cT
	4pNmFSiu9CQKyScq+UenCc9Ou1RgsJ0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-WPmxU_g-OtWEwNRhKiprWQ-1; Tue,
 13 May 2025 06:18:49 -0400
X-MC-Unique: WPmxU_g-OtWEwNRhKiprWQ-1
X-Mimecast-MFC-AGG-ID: WPmxU_g-OtWEwNRhKiprWQ_1747131528
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D29DD1955D45;
	Tue, 13 May 2025 10:18:47 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.155])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1381919560BC;
	Tue, 13 May 2025 10:18:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 88180180060D; Tue, 13 May 2025 12:18:44 +0200 (CEST)
Date: Tue, 13 May 2025 12:18:44 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Eric Auger <eric.auger@redhat.com>, David Airlie <airlied@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Simona Vetter <simona@ffwll.ch>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux.dev>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/virtio: implement virtio_gpu_shutdown
Message-ID: <iptz2uxajkl3l62piqu6tq5pembbmqho667otbaj7nneh5vk3r@sxdvm7e57nae>
References: <20250507082821.2710706-1-kraxel@redhat.com>
 <urpxto3fgvwoe4hob2aukggeop4bcsyb7m5wflgru4c3otd6rq@aktopqufgxom>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <urpxto3fgvwoe4hob2aukggeop4bcsyb7m5wflgru4c3otd6rq@aktopqufgxom>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

> > diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
> > index e32e680c7197..71c6ccad4b99 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
> > @@ -130,10 +130,10 @@ static void virtio_gpu_remove(struct virtio_device *vdev)
> >  
> >  static void virtio_gpu_shutdown(struct virtio_device *vdev)
> >  {
> > -	/*
> > -	 * drm does its own synchronization on shutdown.
> > -	 * Do nothing here, opt out of device reset.
> > -	 */
> > +	struct drm_device *dev = vdev->priv;
> > +
> > +	/* stop talking to the device */
> > +	drm_dev_unplug(dev);
> 
> I'm not necessarily opposed to using drm_dev_unplug() here, but it's
> still pretty surprising to me. It's typically used in remove, not
> shutdown. The typical helper to use at shutdown is
> drm_atomic_helper_shutdown.
> 
> So if the latter isn't enough or wrong, we should at least document why.

The intention of this is to make sure the driver stops talking to the
device (as the comment already says).

There are checks in place in the virt queue functions which will make
sure the driver will not try place new requests in the queues after
drm_dev_unplug() has been called.  Which why I decided to implement it
that way.

drm_atomic_helper_shutdown() tears down all outputs according to the
documentation.  Which is something different.  I don't think calling
drm_atomic_helper_shutdown() will do what I need here.  Calling it in
addition to drm_dev_unplug() might make sense, not sure.

Suggestions are welcome.

take care,
  Gerd

