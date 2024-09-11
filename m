Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06EA14A606
	for <virtualization@lists.linux.dev>; Wed, 11 Sep 2024 09:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726048167; cv=none; b=bFVh9YwZmGEm4/K6eLIoPgvxDw0OmeoMNKcsDOjHeMsU1iM4oJx41zRvCOK4E8jCAjSl2diEVwtzh3MTiBh/MktkDimDp0XLU1yskapOJb4ylwLdmq7pYxNkA4g4aetx/EiBkYPCtV24XK0ytzCWe5tpAeZ0NE221Qnq9ArZANM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726048167; c=relaxed/simple;
	bh=Tyi+rnlYkGoSTLJ45ZdKlp8Zf8nrRBkgavIHn4MPMnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=mpaMkggj5/EBWoyK+I2bveSq24E5qB/u3/EuvMhjezUfCJA5rUw7eG7kvWwkhYTsQzQ2ihN2myBtxCisaydvRRsYJ2DNJhPqKfYluHkuAjzRmwrvWnfKmFhSeoe4lKdioHwm5jUpnmDSuLYKqoCKjAsdedbdqWL+NvMo1+aLjR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SqeSAEu1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SqeSAEu1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726048164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UjSxRH90Toq8IZeky3kH8e0MrQ28xjz36Ff7WrSkuck=;
	b=SqeSAEu1FA9b9OEYdJB0Schf4vMNPSWm6q0luUR3b1XDzqlSByPbVlQAoDqZ55A3bjKO4r
	YiNc1SapOv+5WFC+Lgy5jlOcIWGlb2mPfV+899SQblfiVIOfgPGnalqJ9JTNt/C/lwWd+v
	o4iuGFJ63wjvmNDlxNpoEdxmhrQPRK0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-140-NWXWxKjkOumZTp1_Vl9xxQ-1; Wed,
 11 Sep 2024 05:49:21 -0400
X-MC-Unique: NWXWxKjkOumZTp1_Vl9xxQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 47F5719560BD;
	Wed, 11 Sep 2024 09:49:19 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.146])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 37B3919560AD;
	Wed, 11 Sep 2024 09:49:18 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id E0C821800635; Wed, 11 Sep 2024 11:49:15 +0200 (CEST)
Date: Wed, 11 Sep 2024 11:49:15 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Jocelyn Falempe <jfalempe@redhat.com>, 
	David Airlie <airlied@redhat.com>, Gurchetan Singh <gurchetansingh@chromium.org>, 
	Chia-I Wu <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v2 1/2] drm/virtio: Defer the host dumb buffer creation
Message-ID: <firhmz5jaim2sstdv5wdxjxt4wt4bm3n4fk6bowuanlb55a3qb@fdzcsn7m4v6z>
References: <20240903075414.297622-1-jfalempe@redhat.com>
 <dc88e7b9-ff0d-4405-88d1-bd94df550ae7@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <dc88e7b9-ff0d-4405-88d1-bd94df550ae7@collabora.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hi,

> > +static int virtio_gpu_deferred_create(struct virtio_gpu_object *bo,
> > +				      struct virtio_gpu_device *vgdev,
> > +				      const struct drm_mode_fb_cmd2 *mode_cmd)
> > +{
> > +	struct virtio_gpu_object_params params = { 0 };
> > +
> > +	params.format = virtio_gpu_translate_format(mode_cmd->pixel_format);
> > +	params.dumb = true;

> > -	params.format = virtio_gpu_translate_format(DRM_FORMAT_HOST_XRGB8888);
> 
> This will break the guest blob code path in virtio_gpu_object_create(),
> AFAICT.

Good point.

> > +	} else if (params->dumb) {
> > +		/* Create the host resource in virtio_gpu_user_framebuffer_create()
> > +		 * because the pixel format is not specified yet
> > +		 */
> > +		bo->ents = ents;
> > +		bo->nents = nents;
> > +		bo->deferred = true;
> >  	}
> 
> AFAICS, the "params.dumb = true" should be set in
> virtio_gpu_mode_dumb_create() and not in virtio_gpu_deferred_create().
> Was this patch tested?

virtio_gpu_deferred_create re-creates params from scratch, so it must
set "params.dumb = true" too.  That looks fine to me.

> Overall, this deferred resource creation doesn't look robust. Could be
> better to either add SET_SCANOUT2 with the format info or add cmd that
> overrides the res fmt.

If we can solve this issue with a guest-side fix I'd very much prefer
that.  When adding device features for that the driver will have to
support both old + new devices, which I don't think will be better in
the end.

take care,
  Gerd

PS: Figured how using blob resources on s390x should work
    (tested in emulation only).
----------------------- cut here -----------------------
--- fedora-s390x-gfx.xml        2024-09-11 11:29:57.864900808 +0200
+++ fedora-s390x-gfx-blob.xml   2024-09-11 11:29:54.662935454 +0200
@@ -1,8 +1,11 @@
 <domain type='qemu'>
-  <name>fedora-s390x-gfx</name>
-  <uuid>00e1b01c-f220-4d95-9d25-cd52c4284238</uuid>
+  <name>fedora-s390x-gfx-blob</name>
+  <uuid>2dcfa930-019d-4c25-8636-65abeed741c0</uuid>
   <memory unit='KiB'>4194304</memory>
   <currentMemory unit='KiB'>4194304</currentMemory>
+  <memoryBacking>
+    <source type='memfd'/>
+  </memoryBacking>
   <vcpu placement='static'>2</vcpu>
   <os>
     <type arch='s390x' machine='s390-ccw-virtio-6.2'>hvm</type>
@@ -59,7 +62,7 @@
     </graphics>
     <audio id='1' type='none'/>
     <video>
-      <model type='virtio' heads='1' primary='yes'/>
+      <model type='virtio' heads='1' primary='yes' blob='on'/>
       <address type='pci' domain='0x0000' bus='0x00' slot='0x01' function='0x0'>
         <zpci uid='0x0001' fid='0x00000000'/>
       </address>

