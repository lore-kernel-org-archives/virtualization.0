Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E391F9F73
	for <virtualization@lists.linux.dev>; Wed, 16 Apr 2025 13:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744811847; cv=none; b=r5Zlw+q80ZSm6T9qfqDRLTF5N9WPl+3ruIk8H8TOkEqLBvz9cOVz096oHfuWMfccmxhxHFzo8aFV+fxU9oYarc5kKKGyl2ZbPRaZOyRh7dBcvHTuXmTPxi6BMAVRFve3rsHFaGmHKBjQHIvVjKN6am4EMuST6dQRq+TtBlgQjYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744811847; c=relaxed/simple;
	bh=MNXVDNVfw5Twupf4cZaVoIvlSy9LnqYAExkWnEXMwE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=caUfZR5JV01jN9BCZqF7HtsU/TK7JaPsXwbdHYOuqRYDPJ8IRml5uLm+awNxRiUtX3Leu07BQG+ufMe4CD7whZTSMUqHizfCjyAHaSiFfmUYHfE2TILhrsqScIE7XpObpeZyPtYW+tSGu/ozeyi3dyTlRLQclqDMVvx95/bUFWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fEiTNpQy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fEiTNpQy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744811844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8FZv3owO9XjrPT1Qe2b2EgoIB5J4qrwytxe3pIKY7Sg=;
	b=fEiTNpQyXz0mWGw16jXCQRFPnzbULE2qPnFM27JzVj+PWtufFaLkaSekaWXOs5FKGiFjuo
	THBY/HWsO4/ddVwOJQRZrdsnyfL3qN81LdJ2t01vdFyue6SLD8Zm4namquXTKTGhEarjOj
	XBfgfVWH/8KYvdhGAL+uQY2U2igsuBo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-417-z8sKgJnPN2aC5T__Amqn7w-1; Wed,
 16 Apr 2025 09:57:17 -0400
X-MC-Unique: z8sKgJnPN2aC5T__Amqn7w-1
X-Mimecast-MFC-AGG-ID: z8sKgJnPN2aC5T__Amqn7w_1744811836
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B600E180098A;
	Wed, 16 Apr 2025 13:57:15 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.216])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C14F180045C;
	Wed, 16 Apr 2025 13:57:14 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id ED6CB1800387; Wed, 16 Apr 2025 15:57:11 +0200 (CEST)
Date: Wed, 16 Apr 2025 15:57:11 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Eric Auger <eric.auger@redhat.com>, 
	Eric Auger <eauger@redhat.com>, Jocelyn Falempe <jfalempe@redhat.com>, 
	David Airlie <airlied@redhat.com>, Gurchetan Singh <gurchetansingh@chromium.org>, 
	Chia-I Wu <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Simona Vetter <simona@ffwll.ch>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v2] virtgpu: don't reset on shutdown
Message-ID: <lgizdflxcku5ew2en55ux3r72u37d6aycuoosn5i5a5wagz6sc@d2kha7ycmmpy>
References: <8490dbeb6f79ed039e6c11d121002618972538a3.1744293540.git.mst@redhat.com>
 <ge6675q3ahypfncrwbiodtcjnoftuza6ele5fhre3jmdeifsez@yy53fbwoulgo>
 <20250415095922-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415095922-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Tue, Apr 15, 2025 at 10:00:48AM -0400, Michael S. Tsirkin wrote:
> On Tue, Apr 15, 2025 at 01:16:32PM +0200, Gerd Hoffmann wrote:
> >   Hi,
> > 
> > > +static void virtio_gpu_shutdown(struct virtio_device *vdev)
> > > +{
> > > +	/*
> > > +	 * drm does its own synchronization on shutdown.
> > > +	 * Do nothing here, opt out of device reset.
> > > +	 */
> > 
> > I think a call to 'drm_dev_unplug()' is what you need here.
> > 
> > take care,
> >   Gerd
> 
> My patch reverts the behaviour back to what it was, so pls go
> ahead and send a patch on top? I won't be able to explain
> what it does and why it's needed.

See below.  Untested.

Eric, can you give this a spin?

thanks,
  Gerd

----------------------- cut here -------------------------------
From f3051dd52cb2004232941e6d2cbc0c694e290534 Mon Sep 17 00:00:00 2001
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 16 Apr 2025 15:53:04 +0200
Subject: [PATCH] drm/virtio: implement virtio_gpu_shutdown

Calling drm_dev_unplug() is the drm way to say the device
is gone and can not be accessed any more.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index e32e680c7197..71c6ccad4b99 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -130,10 +130,10 @@ static void virtio_gpu_remove(struct virtio_device *vdev)
 
 static void virtio_gpu_shutdown(struct virtio_device *vdev)
 {
-	/*
-	 * drm does its own synchronization on shutdown.
-	 * Do nothing here, opt out of device reset.
-	 */
+	struct drm_device *dev = vdev->priv;
+
+	/* stop talking to the device */
+	drm_dev_unplug(dev);
 }
 
 static void virtio_gpu_config_changed(struct virtio_device *vdev)
-- 
2.49.0

