Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504572E54AA
	for <virtualization@lists.linux.dev>; Mon, 22 Jun 2026 14:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782140324; cv=none; b=boRBjK4o1h6iyz92Bdr3X80fQU/2e86zw2rtW3YxmAYP1dIaLsGid+YrIfy6yCEAGCvr9HuIaxO9D5l0et7GOjE3dfaBJ8LxcB71alMDhQ/j99/qwi5/RPUfLVfSlbOJaiNTkLia1ESntQIHwE+mTzFhNnTSBRfdSzqCx4onM5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782140324; c=relaxed/simple;
	bh=aSGgG9KnpqfwEvch2LMjPA4okhZC7xQVuMZup5njJsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=WG9zXlCQs4tJA4ltu2pbJO3ss+oP+V7rwSeLg3q4bPeVpul57HNaLPxwnHhHA0CE7DG9vX3jzcnGR8Pr6NikkD0IzEn49Z78Zff/IpXfj2PU+p49YgIG/eND6GIUaGrOFI6hEu0DjgX5HCtd6vPL+agXgkR3T7GdRIKb9AgmCas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iEi9aJ3r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iEi9aJ3r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782140321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hGbjuSGTfMEtkMyDobc9j0xZ/49pPMvHeh7tIkGswH4=;
	b=iEi9aJ3rVzp4c0PtRuM3sMbiVmoEpEMWkgXJexE+IZSHj+MjPDR1yyEjJ8tMS5FoDzBoEa
	wi+AinWfwd6dgh0mjH3cGIzu7m9LSzemGYuCxKF5y4gxLmCtkghSshBSQRUInckNM95N5G
	bVP7h+9hiF8BAIA8SUsMsKakFaU4Eq0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-sWYCO5ubM5mqn_UpR5yJnw-1; Mon, 22 Jun 2026 10:58:40 -0400
X-MC-Unique: sWYCO5ubM5mqn_UpR5yJnw-1
X-Mimecast-MFC-AGG-ID: sWYCO5ubM5mqn_UpR5yJnw_1782140319
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4923411f041so36286985e9.2
        for <virtualization@lists.linux.dev>; Mon, 22 Jun 2026 07:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782140319; x=1782745119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hGbjuSGTfMEtkMyDobc9j0xZ/49pPMvHeh7tIkGswH4=;
        b=Osj5p4HPvxPNb4d1YVEEW9zN8FTqOqz+EXN8rIVtytOXADI+iTgi6/QekYEdVy714P
         ASnGoweyddO/5SgfAeG3bQNQ21aZXTJaVjHwoumCt6DEVDWPdJvCvrcnRozKjyHSzVf2
         urCuNI5VX4K6c8TQQ7OFVukLwB2gmFhE+akvokuyJPfvxuWHchRwGBVQUm18QocCexQw
         12qRPRwOGX+gF+e1Hk8IzXGrxoJtyiR1ib+LEQDCf4M/z6Y9IUaxAt9giB86Rpof5b2A
         n91rdlAzgbRxXMddeQtMfqpCuxTn3ERESWNm5Hq9J5nstWaKiyhTZrDq7TG2AYp8jgxq
         e3tw==
X-Forwarded-Encrypted: i=1; AFNElJ9+B2fS/6zHGJrXMW16/LKdEaImxA3fafyuHtxDjK4fz8MxSE/e1vn25Y/5l3RZf/0NLAWQWQb2tFPmfz3o7w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwHIQMBFXAUPgzWEu6g6UsUHEP8TZge3epxi8PxNpsuUs60Mpee
	kXe2p1YENyYRGA0Ud1WJOhngr3ziquvFg1An5yUeRIQUfQzr+rGpjSttxeDmQvAbjDx0PDJeYBG
	CDv1D9gdvxAJyu0mJ0LBx49KD9EJaiD0Z6rW6xXkpcegTv9tPsJ7QG/E0qWWpnwYp4e81
X-Gm-Gg: AfdE7cmAo9Ym1w2/Ot8DluD5vnGJyNtqr6rufhwofAx9Ji3sxXvJL5L0OYBfwW/qgT4
	fbVj78EB3c5ORsA14BJ7IDhGsJ9YqQRGGm6Oa+CPXyyDHK2FcyqYcPRjazUA8XGN0t76qoXYuEB
	j7vcfBeoby5jyFfWJ8c/Lowm2T/H1hQ/jvfl3ziDYh0zgHtLVyo5Kq/HcwoQXpD5GhllRB+eZCA
	HIA79ZYIjhTZLVey19EajfdeFHkn0HRbjPQJZnB1jL/NqiCuIpU4vsaGuXZEBNSsOfzFXydgQ7N
	K7yGah5Xh/NoudR9rLlfBxZzmYKVO6Amp3OlrRKcXqTGb4ColgqONoSYjFkyKljZutcgYb8XmhT
	MADQ67YO+/AbpunMIUGVLy2Dvx8zQnA+r
X-Received: by 2002:a05:600c:8b2b:b0:492:4a56:690b with SMTP id 5b1f17b1804b1-4924a5669d3mr168320595e9.35.1782140318507;
        Mon, 22 Jun 2026 07:58:38 -0700 (PDT)
X-Received: by 2002:a05:600c:8b2b:b0:492:4a56:690b with SMTP id 5b1f17b1804b1-4924a5669d3mr168320045e9.35.1782140317925;
        Mon, 22 Jun 2026 07:58:37 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fe7ba08sm301101105e9.11.2026.06.22.07.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 07:58:37 -0700 (PDT)
Date: Mon, 22 Jun 2026 10:58:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Denis V. Lunev" <den@openvz.org>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] virtio_balloon: quiesce balloon work before device
 shutdown
Message-ID: <20260622105806-mutt-send-email-mst@kernel.org>
References: <20260622133715.3707707-1-den@openvz.org>
 <20260622133715.3707707-3-den@openvz.org>
 <8b83f251-3a3e-4fc9-8ea9-8d101fb92919@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <8b83f251-3a3e-4fc9-8ea9-8d101fb92919@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GTxUHhWwAtTy6iEDf-IdK2pIehJD1YQV6zm_YGO1uEw_1782140319
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 22, 2026 at 04:38:54PM +0200, David Hildenbrand (Arm) wrote:
> On 6/22/26 15:37, Denis V. Lunev wrote:
> > Commit 8bd2fa086a04 ("virtio: break and reset virtio devices on
> > device_shutdown()") added a generic virtio bus .shutdown handler that
> > breaks and resets every virtio device during device_shutdown(), i.e. on
> > reboot and kexec.
> > 
> > virtio_balloon provides no .shutdown of its own, so that generic path
> > runs while the balloon's asynchronous work is still armed. Once the
> > device has been broken, virtqueue_add_inbuf() in
> > virtballoon_free_page_report() returns -EIO and trips its
> > WARN_ON_ONCE(). On a kernel booted with panic_on_warn that turns an
> > ordinary reboot, for example a kexec based upgrade, into a fatal panic
> > in the middle of device_shutdown(), so the machine never reaches the
> > new kernel.
> > 
> > Relaxing that single WARN_ON_ONCE() would only hide the symptom: the
> > inflate/deflate and OOM paths do not warn, they call
> > wait_event(vb->acked, ...) and would instead block forever on a broken
> > queue that can no longer complete. The device has to be quiesced, not
> > just kept quiet.
> 
> Ah, so
> 
> 	/* We should always be able to add one buffer to an empty queue. */
> 	virtqueue_add_outbuf(vq, &sg, 1, vb, GFP_KERNEL);
> 
> is not actually correct.

Yes - we can't if the device is completely gone)

> Yeah, quiescing sounds cleaner, although I am thinking whether we should also
> warn if virtqueue_add_outbuf() fails, similar to what we do in
> virtballoon_free_page_report().
> 
> > 
> > Add a .shutdown handler that quiesces the balloon via the shared
> > virtballoon_quiesce() helper while the device is still alive, and only
> > then breaks and resets it. The break and reset are repeated here rather
> > than reused from virtio_dev_shutdown(): drv->shutdown replaces the
> > generic handler rather than augmenting it, so that drivers such as
> > virtio-gpu can opt out of the reset. Unlike virtballoon_remove() the
> > balloon workqueue is not destroyed, as shutdown does not free the
> > device and cancel_work_sync() together with stop_update already prevent
> > any further work from being queued.
> > 
> > Fixes: 8bd2fa086a04 ("virtio: break and reset virtio devices on device_shutdown()")
> > Signed-off-by: Denis V. Lunev <den@openvz.org>
> > ---
> >  drivers/virtio/virtio_balloon.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> > index 5b02d9191ac6..e35ada767b4b 100644
> > --- a/drivers/virtio/virtio_balloon.c
> > +++ b/drivers/virtio/virtio_balloon.c
> > @@ -1137,6 +1137,15 @@ static void virtballoon_remove(struct virtio_device *vdev)
> >  	kfree(vb);
> >  }
> >  
> > +static void virtballoon_shutdown(struct virtio_device *vdev)
> > +{
> > +	virtballoon_quiesce(vdev->priv);
> > +
> > +	virtio_break_device(vdev);
> > +	virtio_synchronize_cbs(vdev);
> > +	vdev->config->reset(vdev);
> 
> I guess it would be good if we wouldn't have to copy what the default handler
> does, but could instead just have it in a reusable core function?
> 
> > +}
> > +
> 
> -- 
> Cheers,
> 
> David

