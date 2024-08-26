Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7712D052
	for <virtualization@lists.linux.dev>; Mon, 26 Aug 2024 07:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724658450; cv=none; b=crYd8s8lB2tBezXJPZCFtt+bHUQNwwaoO3B43+GsbyeZ6END/b2EFryyNQZtQys/93P8LMNwLgzv79nDx4y3zeeTYKg8ejujAXPIRep/edN9qa+wxj5nOt7iKQqyN3hIlM6W/w7eRCQ+qezof0C2mmTuURV23G9KdCzIkdWoMU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724658450; c=relaxed/simple;
	bh=l7t6giNB41ktALa/VnPUjqWxWVHmBRDS+DZbh9TIjJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=cTHEFS1HKdqOWe69fHPIav6RJlChG/MZresxXID1t8jTX6ZcKOxSsOhoHmIQ64fZyc/QqPP4FJFnVwEx5CT7VQ2KuLEey+Q9KrVNuTfxSmDAIxKUS+rwKhWLixiioHhWAAGAKfLmefnXXQpuniX2iee74nonSj/C7k9DIakxsSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Il+vMQVf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Il+vMQVf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724658446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cW5lvmzflYFNRkWrRmvy0V+YAbvTqYSh8nq13SP1Sa0=;
	b=Il+vMQVf3WFdCyUWWUkfd3QxXtryABdEvyh2erajHIvF4UWVK8hO6xvO8iDVyoymy/gHAZ
	v8urgcT48vwFzv5dhSVYoaj1IHwIkCjDAHGOGI3PMkdyfwKug37fS/PlRkP0JWqUxQ64ls
	j9ZcWDWO4opFLGqr6id54VF5NW+pC/8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-cxejlwpKMjmu2NiKQhOrKg-1; Mon,
 26 Aug 2024 03:47:23 -0400
X-MC-Unique: cxejlwpKMjmu2NiKQhOrKg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 96C751955D4B;
	Mon, 26 Aug 2024 07:47:21 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.194.20])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9FD641955E8C;
	Mon, 26 Aug 2024 07:47:20 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 463251800631; Mon, 26 Aug 2024 09:47:18 +0200 (CEST)
Date: Mon, 26 Aug 2024 09:47:18 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: David Airlie <airlied@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Daniel Vetter <daniel@ffwll.ch>, 
	Javier Martinez Canillas <javierm@redhat.com>, dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev
Subject: Re: [PATCH 1/2] drm/virtio: Defer the host dumb buffer creation
Message-ID: <vbswvnfsjil52qnz25q4pp6qitceyuacr4lm5t6bddqgs5jzv3@i4mrwchoxvqz>
References: <20240822172338.698922-1-jfalempe@redhat.com>
 <mlqofcqa2yki43bkcl2kq6wfwchmkisnybbadd32khln5tv4ux@u4xuf6gumcqa>
 <6496591e-fa98-49ed-b85e-c76734c25568@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <6496591e-fa98-49ed-b85e-c76734c25568@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 23, 2024 at 05:35:39PM GMT, Jocelyn Falempe wrote:
> On 23/08/2024 09:04, Gerd Hoffmann wrote:
> > > +static void virtio_gpu_deferred_create(struct virtio_gpu_object *bo,
> > > +				       struct virtio_gpu_device *vgdev,
> > > +				       const struct drm_mode_fb_cmd2 *mode_cmd)
> > > +{
> > > +	struct virtio_gpu_object_params params = { 0 };
> > > +
> > > +	params.format = virtio_gpu_translate_format(mode_cmd->pixel_format);
> > > +	params.width = mode_cmd->width;
> > > +	params.height = mode_cmd->height;
> > > +	params.size = params.height * params.width * 4;
> > > +	params.size = ALIGN(params.size, PAGE_SIZE);
> > > +	params.dumb = true;
> > 
> > I'd suggest to simply store the complete virtio_gpu_object_params struct
> > in virtio_gpu_object instead of re-creating it here.
> 
> The struct params is much bigger than the struct virtio_gpu_object, so I
> though it would waste too much memory. Using a pointer would add an
> alloc/free pair, and a potential source of memleak. And as we have the
> required parameters in struct drm_mode_fb_cmd2, I found it better this way.

You have to sanity-check the size then.

take care,
  Gerd

