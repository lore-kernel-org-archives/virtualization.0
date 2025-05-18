Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3E520487E
	for <virtualization@lists.linux.dev>; Sun, 18 May 2025 21:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747605249; cv=none; b=Sdp/yU3K5OpMjRRUUsuWhpnvXAXDKwB+wCZNaSCZnHQLjJp7114pBN4KWN984DkLstFMaslUzASBwZvjGYMTQHS5HRdm5jujbwPfS0tVsSCdoofLzJBqdhpRnDRL15MRaDKOoed3ROIEF7i4KXrF5cBFdNJMpGgX/D7CoIicigs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747605249; c=relaxed/simple;
	bh=20PnTSuJpTRB3a9rlj7kzIgZoWPhz/piVscbTKW0rhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JYShX4/tG0hAgeY2I9tQn+uu+6zSiu1s4Kh1rJyx3TPIh+fNH1+FDH9JagPwsyyrmciZ3pOMMb2g95ta+lBMZkGo5Yh3v5zzcOEl+EXAHaRnme7kvZYvjtdE8Iz2uzXlWZW/ZdOFWNgGChnv0LkfIyoP6Dfl18/wYk1iv2qzMg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VTnnvjtw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VTnnvjtw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747605246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uIaIOnVIIar3oPXWrnvC7B8zNsFcZdASTSy76IqR298=;
	b=VTnnvjtwe2u2xdP0F7+DZ6n8k95lYaxxXZZLiJm2L+lpWzFGnIjRVwBUKe/HhDq0x5LWyH
	QNk3rkEvEP1GlML1MzLM/0vz2t7F2ekV0Ios06sxQkESmVw6n2lWyXo2Xphrsjaj/iplva
	3MNAWwq/3ds3SGKnlA4WMn16jOUX99U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-ImPcPh4BNsm1LbFvdUenyw-1; Sun, 18 May 2025 17:54:05 -0400
X-MC-Unique: ImPcPh4BNsm1LbFvdUenyw-1
X-Mimecast-MFC-AGG-ID: ImPcPh4BNsm1LbFvdUenyw_1747605244
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-442fda1cba7so10520445e9.1
        for <virtualization@lists.linux.dev>; Sun, 18 May 2025 14:54:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747605244; x=1748210044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uIaIOnVIIar3oPXWrnvC7B8zNsFcZdASTSy76IqR298=;
        b=GIVwu3IEZ9C87VnJ2HBwAFPx9VZRB9hg4kVMRCXHu6ASX960ujSBY9+s66rcueQGQC
         lT/pfze+6uJFwGnjCIVzUjzqN7vFbRnkYKZO055ZGv56xp/Gpii9uUYprq4NTvwsqASe
         jV4UgGRZVPqEAvPW+d5fuBzNXVhA90pFSxiFNbEXUs3tcjjutbZL9KDuc+HGvd5JADj/
         GwUeYwnTnQ015HY9y7lCcCtaOrtbO4tuFJdgnRYy/cV/iHkn69JcROBHcM0h2Uk/pHFC
         6dPBo3g161VHM4+cxLrQfUQlIdlIjJ9ahaXQnkyHibIe2GizM4VJ0/l9PDQvywPODV3a
         WdzA==
X-Forwarded-Encrypted: i=1; AJvYcCVPtAoW16lXNLQdmd8KND9KB28Ko82AfGQM8kF+2k2RQe9aVKOQN4YGouA6795Jw85/8rnTFk3l3NITJmNe9Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy33ksEiwIidTHSLrmbwkv0WF/C+tFYR2qKeokc6TucSxUTGJtc
	RQyqsAbmp+0OANzQ2nl7eI1WbQWtD9ZdK2A3xugCUApSYlEGTacw06MN21LWvqbLtmIUdsbtn4k
	V3ZtK+6YjF3M4zI6qgaj9lzHELwuFgmg8GkwrsXwxGx+y1PD61hk1fBNcAqWgesJmT7Y1
X-Gm-Gg: ASbGnctnUibbFnQG53JMMs49TaE0fET7fx605o6jzF63gS1Ffqa7xpDZKrIwiUMpgyw
	rQC0qLZjfmb1A8qQyJOhEI7yH1kqarK93XifCgQcDioecAO/D/Sd29vcztJWMlPq69EgTLeXbBk
	Q+V4CkRHP6RWeEy34HDPFONsZw/4LAOT+AEui7kmYka6ByGoVo3ioe/c6bC3JZnBQlUgyvXRrnJ
	s1NvF/IqjCrOpUHv38R8/80c+llL9xvddoaOEUFlpUcXaBOwaGSR/+fypVRSuCTZ2+Qr56MZqDC
	S2tQ4Q==
X-Received: by 2002:a05:600c:3ca0:b0:441:d438:4ea5 with SMTP id 5b1f17b1804b1-442ff0328b8mr73538015e9.20.1747605244355;
        Sun, 18 May 2025 14:54:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvqrHVss6NuJi0HAtzkEcNBJlsY/d82el2/IApsycphIjM1sMh75zLHZaVQnejymivmh22FQ==
X-Received: by 2002:a05:600c:3ca0:b0:441:d438:4ea5 with SMTP id 5b1f17b1804b1-442ff0328b8mr73537855e9.20.1747605244018;
        Sun, 18 May 2025 14:54:04 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35e49262fsm10020425f8f.44.2025.05.18.14.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 14:54:02 -0700 (PDT)
Date: Sun, 18 May 2025 17:53:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org,
	Eric Auger <eric.auger@redhat.com>,
	David Airlie <airlied@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>,
	"open list:VIRTIO GPU DRIVER" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/virtio: implement virtio_gpu_shutdown
Message-ID: <20250518175332-mutt-send-email-mst@kernel.org>
References: <20250507082821.2710706-1-kraxel@redhat.com>
 <urpxto3fgvwoe4hob2aukggeop4bcsyb7m5wflgru4c3otd6rq@aktopqufgxom>
 <iptz2uxajkl3l62piqu6tq5pembbmqho667otbaj7nneh5vk3r@sxdvm7e57nae>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <iptz2uxajkl3l62piqu6tq5pembbmqho667otbaj7nneh5vk3r@sxdvm7e57nae>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: s9Tv3crDokUZIFZCnHyrNYyVSlZ6cnG4sO7w4vutzhw_1747605244
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 13, 2025 at 12:18:44PM +0200, Gerd Hoffmann wrote:
> > > diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
> > > index e32e680c7197..71c6ccad4b99 100644
> > > --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
> > > +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
> > > @@ -130,10 +130,10 @@ static void virtio_gpu_remove(struct virtio_device *vdev)
> > >  
> > >  static void virtio_gpu_shutdown(struct virtio_device *vdev)
> > >  {
> > > -	/*
> > > -	 * drm does its own synchronization on shutdown.
> > > -	 * Do nothing here, opt out of device reset.
> > > -	 */
> > > +	struct drm_device *dev = vdev->priv;
> > > +
> > > +	/* stop talking to the device */
> > > +	drm_dev_unplug(dev);
> > 
> > I'm not necessarily opposed to using drm_dev_unplug() here, but it's
> > still pretty surprising to me. It's typically used in remove, not
> > shutdown. The typical helper to use at shutdown is
> > drm_atomic_helper_shutdown.
> > 
> > So if the latter isn't enough or wrong, we should at least document why.
> 
> The intention of this is to make sure the driver stops talking to the
> device (as the comment already says).
> 
> There are checks in place in the virt queue functions which will make
> sure the driver will not try place new requests in the queues after
> drm_dev_unplug() has been called.  Which why I decided to implement it
> that way.
> 
> drm_atomic_helper_shutdown() tears down all outputs according to the
> documentation.  Which is something different.  I don't think calling
> drm_atomic_helper_shutdown() will do what I need here.  Calling it in
> addition to drm_dev_unplug() might make sense, not sure.
> 
> Suggestions are welcome.
> 
> take care,
>   Gerd


I suggest adding comments in code explaining why it's approriate here.
Want to try?

-- 
MST

