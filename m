Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161571F3FEE
	for <virtualization@lists.linux.dev>; Tue, 22 Apr 2025 06:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745302900; cv=none; b=FHGTW1jz5FBvZHKbb7ACatpnCERJ2KBnpiCUFf1ScQfKXDhsyC9Z+vpnyXQVW/bq1LNOeCcDAUt4lGvuB7NirVuLOyDpAE+PINF03EYGdPnxBMtUW8nRfY1vYTIMEKHBlXxthBxex+0TVSMd1AVIh2i4Yi0F7qTZdeYmXJ+FUgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745302900; c=relaxed/simple;
	bh=cAw1KiHXJS8Y5Pay+EoJvDyaaQNF23TRcKQ2PCc7VbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZutri/h1kNUrH4tTF8MvUviDTnDGraNZRzxU+pz1EirpopXlwEgNRC0lcxB1hpmo5RY1WyOmUjZwTxKYBC80lL+On2C7Iy3TGmTjRqqHqjwVy3M/YAqli12u0vHL7Z8a5I0Bd/hQznA+yNOjvSjgNGzwmeJUWTDX+n8EhoaUK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J1cmNaA2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J1cmNaA2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745302897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XlhC5ER/uZjdQRn1SDme5yjK3b4NzyHUHmBD4jzLIJs=;
	b=J1cmNaA2VwLOtn2Pza29VQd5JTdcGP8JoPSj16msX5638MdFA9wcjYvOcWtNrhiSrSjKMw
	TXEjAo83dhF6TT4+qE/diowQqycF45hh7GuEmj9GgQ/qUPLdqb95X0G6893SWdkNBc1pcE
	pRjN/ikm1YzQ9Sx0LCPuq43rBwfrf+k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-18-9d5JeT7aNzK4_RGk2FtZHg-1; Tue,
 22 Apr 2025 02:21:33 -0400
X-MC-Unique: 9d5JeT7aNzK4_RGk2FtZHg-1
X-Mimecast-MFC-AGG-ID: 9d5JeT7aNzK4_RGk2FtZHg_1745302891
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0AC2A180048E;
	Tue, 22 Apr 2025 06:21:31 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.45])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 600E71800367;
	Tue, 22 Apr 2025 06:21:29 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 2100B18003A9; Tue, 22 Apr 2025 08:21:27 +0200 (CEST)
Date: Tue, 22 Apr 2025 08:21:27 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, 
	Eric Auger <eric.auger@redhat.com>, Eric Auger <eauger@redhat.com>, 
	Jocelyn Falempe <jfalempe@redhat.com>, David Airlie <airlied@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Simona Vetter <simona@ffwll.ch>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v2] virtgpu: don't reset on shutdown
Message-ID: <f7yzgdhzc4w7j5zt74muisvh3efpvlag7es23c6nvsg25q5puu@o37kylmbkfad>
References: <8490dbeb6f79ed039e6c11d121002618972538a3.1744293540.git.mst@redhat.com>
 <ge6675q3ahypfncrwbiodtcjnoftuza6ele5fhre3jmdeifsez@yy53fbwoulgo>
 <20250415095922-mutt-send-email-mst@kernel.org>
 <lgizdflxcku5ew2en55ux3r72u37d6aycuoosn5i5a5wagz6sc@d2kha7ycmmpy>
 <d6315206-6ef5-4c44-8450-85aac01946c9@suse.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6315206-6ef5-4c44-8450-85aac01946c9@suse.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

> > diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
> > index e32e680c7197..71c6ccad4b99 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
> > @@ -130,10 +130,10 @@ static void virtio_gpu_remove(struct virtio_device *vdev)
> >   static void virtio_gpu_shutdown(struct virtio_device *vdev)
> >   {
> > -	/*
> > -	 * drm does its own synchronization on shutdown.
> > -	 * Do nothing here, opt out of device reset.
> > -	 */
> > +	struct drm_device *dev = vdev->priv;
> > +
> > +	/* stop talking to the device */
> > +	drm_dev_unplug(dev);
> >   }
> 
> It's the correct approach but also requires drm_dev_enter() and
> drm_dev_exit() around all of the driver's hardware access.

The functions adding requests to the virtio rings use
drm_dev_enter+drm_dev_exit already.

take care,
  Gerd

