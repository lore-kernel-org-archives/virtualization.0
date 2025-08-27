Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8382F275B08
	for <virtualization@lists.linux.dev>; Wed, 27 Aug 2025 13:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756301619; cv=none; b=BU2ezr//oafSZTRxJ58UY7nOlr19q7GzvEbCtAdQ9JvYbBLpuUUh/Uiz2UpYPkzOufgsQ92g9eirlWtXQ0kwik4GctahY8z2YIJtC9HfZvOmEJHchNBjoy3nl7j6zKZR2lYv2+8AlCNkRoh47bC3aOiPGpWBA/I08ThUPF8A24Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756301619; c=relaxed/simple;
	bh=chTWJ/zEI6rTbv+YqS2P0SrjG/e7+RT/8QbiIzXP3ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=QeCIkLQbajn6UTFs0DA0OXeCnqdSz/EE9VCruh5/K1xocHPZMk4j9hKhUdSIMPBP76r6UjH+GHdT4sGrFF8CoTXlwpzBFIo5Co95/6RZQHZTMPtFp106L9KfJI7UYZiSTN9rOj65/fuT/gZpTJtCp2M5HnIwc44mfp7onAwXj8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XAdQFc/+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XAdQFc/+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756301616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K8z/3KgzEoz0nXpB3RNGuEeKXFHUG30ORWT5Yv+ILFU=;
	b=XAdQFc/+APj2Ni6OA8YpWcFuFZtMD5MnA7H1+sOHppuLvZK9r5LDJw2GcvaFg2GD59HuIW
	66ASidHiH96Qv0LROw6oZOu+cUraRJWjTifKl0zT8xWL5NliT/NbkFTM099buDRZKRZ5JJ
	zC2DKUHZi1NEPS1zSOKLH8HlcLtleX8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-XAH7dpHGPl2R9WYPvHcPVg-1; Wed, 27 Aug 2025 09:33:34 -0400
X-MC-Unique: XAH7dpHGPl2R9WYPvHcPVg-1
X-Mimecast-MFC-AGG-ID: XAH7dpHGPl2R9WYPvHcPVg_1756301613
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3c897f28ab0so2481160f8f.2
        for <virtualization@lists.linux.dev>; Wed, 27 Aug 2025 06:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756301612; x=1756906412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8z/3KgzEoz0nXpB3RNGuEeKXFHUG30ORWT5Yv+ILFU=;
        b=AW6hbj7coLDM9bepj2Rxfo2Ib+VDR7Yldb9QA3zsuNcvOy96hcT2HWKBEnfkWG1kLo
         UqmPpR499nhZ3Ht2oIy86vnrIpNkhud5VoGLzgip5YjXWWZB4FPsySHxKIQXvB2YYxeQ
         2BLAZt31itALilQ4HSbRNlRgS5IYJuVsufQWWLhPXYhJW9vQ3aMGGTto2P3fsJG4R5Ss
         gh+s+T4zhnrqnUGp9AGidEJX4bWrJI0UrbRvbKizby6iEwmb8yDgcSylruCJMvdn7x2R
         P0NN/o3MzRsvjGOeGRiai7ZhSjRth1trj2j9EfVj8VMvOzzL9OU5/68oQEeknQ1D08CC
         wdmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ6Lf59Lvnfa8FDaPfbeVqsAYqbwwmY6apyTZXahtznOi6lnJmbPiYkIlf/XovVK/Cwhiw/Bqr3wPYkC6caw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxliMWVVMJxMVcq0Tsx2PC3xMQS35yOp9JPJwy8luEeGBsa1nny
	xKhbAn1xY5RyqxFx4ISLspKTn2QdcO1H22EEPHQnOKQFcnqv0CXX3li9uO+dLO9YwwWgyllDBW+
	oU6A5wePHFHUwWGyb8IqIF9S8hH2JRcUaRhtRoQSGKf0fJAVpYCXr3SwOB4oP6icJgIAe
X-Gm-Gg: ASbGncuw9Uni5L5i5XnPeoXB2nkloZ2WtYwugfmOUOI2Yv7mc4fZ5Soiw8s6EHR2x5k
	72Q90ZwlayrY/BnsTJ7TjYqKqX61MI/iQLblCZRVS70deIrcOWGUPeSWfC2DuUSJh22BCs8OUCE
	dpKX2kVIUvXWIfw77aB20snLH3AvxXU6OmwrAVxh+BDiG96RZhn6wBD1WhMU6CJa/9PGefvRZm3
	ZH9vImQ1gTxer5DzZkWqzHIeVvAQ1PAG91nsgJgXZbqNV66xytIFn2kaG0H/JtKy2Dlqw3TZYqy
	jtx/wmNBgNkLZoenEsO1PJdMu5JGoPQ=
X-Received: by 2002:a05:6000:2281:b0:3cd:4ff9:c487 with SMTP id ffacd0b85a97d-3cd4ff9c926mr847047f8f.45.1756301612449;
        Wed, 27 Aug 2025 06:33:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpXWIRKQBLCST7L7FbqSdMsqrTEd8mC9YrfacqJgmW7hhmhY+MtE22/oJUnVDrsWnKorEEVQ==
X-Received: by 2002:a05:6000:2281:b0:3cd:4ff9:c487 with SMTP id ffacd0b85a97d-3cd4ff9c926mr847017f8f.45.1756301611871;
        Wed, 27 Aug 2025 06:33:31 -0700 (PDT)
Received: from redhat.com ([185.137.39.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ccac1b892bsm2973545f8f.67.2025.08.27.06.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 06:33:31 -0700 (PDT)
Date: Wed, 27 Aug 2025 09:33:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Honglei Huang <honglei1.huang@amd.com>,
	David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>, dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/virtio: fix host visible memory detection in
 virtio-gpu
Message-ID: <20250827093320-mutt-send-email-mst@kernel.org>
References: <20250827081231.1878248-1-honglei1.huang@amd.com>
 <9ecf015d-d96a-40ac-a7fb-50e46c4f6e00@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <9ecf015d-d96a-40ac-a7fb-50e46c4f6e00@collabora.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ENmWk0YyHWQUTtAowWuWkIdHyIL5AHTT4P5VcwPaiIU_1756301613
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 27, 2025 at 03:52:05PM +0300, Dmitry Osipenko wrote:
> On 8/27/25 11:12, Honglei Huang wrote:
> > From: Honglei Huang <Honglei1.Huang@amd.com>
> > 
> > Commit 206cc44588f7 ("virtio: reject shm region if length is zero")
> > enhanced the validation in virtio_get_shm_region() by adding a check
> > for a zero-length shared memory region.
> > 
> > It is performed before the underlying transport's .get_shm_region()
> > implementation is called. This creates an issue in the virtio-gpu
> > driver, where the `region` struct is part of a larger structure
> > that is zero-initialized by drmm_kzalloc().
> > 
> > Consequently, the `len` field is 0 at the time of the check, causing
> > virtio_get_shm_region() to return false prematurely. This prevents the
> > host visible memory feature from being enabled, even when the device
> > supports it.
> > 
> > To resolve this, this patch bypasses the inline helper and calls the
> > underlying vdev->config->get_shm_region() function pointer directly.
> > This ensures that the region's parameters are checked only after they
> > have been populated by the transport, aligning with the intended logic.
> > 
> > Signed-off-by: Honglei Huang <Honglei1.Huang@amd.com>
> > ---
> >  drivers/gpu/drm/virtio/virtgpu_kms.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
> > index 7dfb2006c561..ed5981248302 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
> > @@ -174,8 +174,10 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
> >  	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_RESOURCE_BLOB)) {
> >  		vgdev->has_resource_blob = true;
> >  	}
> > -	if (virtio_get_shm_region(vgdev->vdev, &vgdev->host_visible_region,
> > -				  VIRTIO_GPU_SHM_ID_HOST_VISIBLE)) {
> > +	if (vgdev->vdev->config->get_shm_region &&
> > +	    vgdev->vdev->config->get_shm_region(
> > +		    vgdev->vdev, &vgdev->host_visible_region,
> > +		    VIRTIO_GPU_SHM_ID_HOST_VISIBLE)) {
> >  		if (!devm_request_mem_region(&vgdev->vdev->dev,
> >  					     vgdev->host_visible_region.addr,
> >  					     vgdev->host_visible_region.len,
> 
> Hi, virtio_get_shm_region() change has been reverted by [1]. Don't think
> anything else needs to be done.
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20250827&id=ced17ee32a9988b8a260628e7c31a100d7dc082e
> 
> +cc Michael Tsirkin
> 
> Might be only good to send a stable kernel PR with that revert. I see
> patch available only in linux-next, while stable kernels need to be
> fixed sooner.

sooner than what?

