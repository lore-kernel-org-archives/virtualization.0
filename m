Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14DC364029
	for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 19:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789155546; cv=none; b=Ri6F1+JmLECkVzEvk+fUn1LD03cvw4Pt3w/9nCf6zO4q9gx8Fs5ffZ4YSXP39LoDsnRDbVq0crcDiHBXqR77jXV9UTUH8BO3U1vLvGZT2ZHTekfR9mb20ydGewQYBgRoawuxxAJjyeYNCGMxH5lsERphePOROmHWeaTtA4hCPsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789155546; c=relaxed/simple;
	bh=wV1C5Bm1FWWQaO3HlT+8zYZjeIdvR2E5WEysqi+CSVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Ld/wh6dRuIQkzCQ4N2hxJIpPDTEWqpM5RZUwbg5yYgR3SZd18X2AJAvC6okvYGP41ZDp/INHdgXpdhcErK4cvMdn/Z4z8JQTT0bu0r7E329cVTCCkgJJOLQjK7+f7rAE8wVvRPQm5xbaxhCOq+XoH4hzzx/Mo8qXPnfk4yXA0ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O9KfGc/w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O9KfGc/w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789155527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bnhidkRyqiU1KNU2WPOXr40xiYcOCBtt1tPY8m9570M=;
	b=O9KfGc/wLLs8LyO+w0lTVN1mo4feU/k9R2az/Q9nXUiNyAGTEEuDD0AfcoYOeEhN0famqV
	F+ilKzaxVYPY8TltYOqRv57rq5LrLQH8yrVQr7kNvhnNL9sEKWuS6QZ+qtzQcgSQ8V8VmJ
	sD49e+8GDO6i+fyHeKSNx+GN5aRTR0c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-KMV9ji9FPOi5vl1P_EFZng-1; Fri, 11 Sep 2026 15:38:46 -0400
X-MC-Unique: KMV9ji9FPOi5vl1P_EFZng-1
X-Mimecast-MFC-AGG-ID: KMV9ji9FPOi5vl1P_EFZng_1789155525
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490a767b782so10932075e9.2
        for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 12:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789155525; x=1789760325;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bnhidkRyqiU1KNU2WPOXr40xiYcOCBtt1tPY8m9570M=;
        b=oDVIF+4mDfkm14x6y8mpNv6w32R9PsMniRJrnVImisJtmT4Ccjmo81sin4Ww77v5hC
         GURnR9oLFiSWx4bfm+oHI2XK+w7aUYJ2IqUMyp72bnnR5agssDGp7i2onlumZNDCduz4
         ng5Eb5txQKeG5iKXHEPM9pz1PFDHKL9fRJ6pMmzZNzU647SV1brYiEkNlSqhwdjprDoR
         MWjT5t0fY7hnGaa6xE49wUmjDqXfSa4J6uC1UHsn+6Fckv1M2GMlQ/f1ZIZ4LWdTCDzG
         KeL/OzvHLog/OqozdENYY4H4lvFhWtqi2+VWJ+vUZ9ZcWXoYdppylM5Ns7/RmEWTl4Me
         +0Sw==
X-Gm-Message-State: AFuF++m7ObwCKn0p1y1SBDCHhnW5cyhaXMFNRU0WDB+t28zFjtvXTbFk
	rNIXLSZvw53gCLroE26N6vxHpqgwOj3IZ8hrRgmuD5cfj7Ce74sloE/2MImXMUN1OQv14c5cCLC
	Qi+R4xkXEYj7d8Kh+pBH8SCB+KZduB4x2ysIBFjqDx+DrEfOEvldcNAyirubuZi0Z9NdX
X-Gm-Gg: AYBFou1PmV3rGHsU2UqvY4JENNRAnP0ws7gFcHYDIeRNVFIAUikZveVY5JuqGOdGv/r
	rvP3ipyi0u5sEAPinCUQXb+tVkBFo3jhUlx/R01SRadrge3xOBPvTO38yW8snot9llfUl+Fm2/D
	5R3SOO2aWVjfMnWaMmzzxU79w3eGn03dujfge4SS32yiqBquJkICunOd3o1hfUSjCRYduluIZbm
	7rcinf9Eu6/dkTwWwPeuIZ25kWhiijDXqGfieGSsdxT8gjgkVx3x3n+DHWPKtQAcTSZO0GvdCNF
	CLaZHEX0ymlV4B5X13q89678Utg21nLpkzvkzJdL79F0cGeKUrbqO3VY+QdIH8LHMHE=
X-Received: by 2002:a05:600c:3b27:b0:49c:fc6e:a3d8 with SMTP id 5b1f17b1804b1-49e619cc2aemr71854505e9.23.1789155524911;
        Fri, 11 Sep 2026 12:38:44 -0700 (PDT)
X-Received: by 2002:a05:600c:3b27:b0:49c:fc6e:a3d8 with SMTP id 5b1f17b1804b1-49e619cc2aemr71854275e9.23.1789155524389;
        Fri, 11 Sep 2026 12:38:44 -0700 (PDT)
Received: from redhat.com ([147.235.223.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26c300e2sm194467235e9.8.2026.09.11.12.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 12:38:43 -0700 (PDT)
Date: Fri, 11 Sep 2026 15:38:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: sashiko-reviews@lists.linux.dev
Cc: virtualization@lists.linux.dev, Eugenio Perez <eperezma@redhat.com>
Subject: Re: [PATCH 2/2] virtio_pci: drop extra callback sync
Message-ID: <20260911101425-mutt-send-email-mst@kernel.org>
References: <8f71425918a148dcad1be993ccabd39582d246ee.1789130213.git.mst@redhat.com>
 <082fd9b2bad1db0088caa38a8d738aa848bf36b2.1789130213.git.mst@redhat.com>
 <20260911125745.E0A2F1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260911125745.E0A2F1F00899@smtp.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: H8myLZujVrR89BJZEICrXY2c3Ww86kylMl-t9X4RY40_1789155525
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Sep 11, 2026 at 12:57:45PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] Removing `vp_synchronize_vectors()` from `vp_reset()` exposes a race condition in `virtio_device_shutdown()`, allowing in-flight configuration change interrupts to execute concurrently with or after system shutdown.
> 
> Pre-existing issues:
> - [High] Pre-existing data race in `vp_modern_avq_cleanup()` due to missing `admin_vq` lock, leading to potential virtqueue corruption.
> --
> 
> commit 0b14e711d0c9fc7c440dbf71513420ceb19b4bd3
> Author: Michael S. Tsirkin <mst@redhat.com>
> virtio_pci: drop extra callback sync
> 
> This patch drops the synchronization of callbacks on reset within virtio pci,
> relying instead on the virtio core to synchronize callbacks when needed.
> 
> > --- a/drivers/virtio/virtio_pci_legacy.c
> > +++ b/drivers/virtio/virtio_pci_legacy.c
> [ ... ]
> > @@ -98,8 +98,6 @@ static void vp_reset(struct virtio_device *vdev)
> >  	/* Flush out the status write, and flush in device writes,
> >  	 * including MSi-X interrupts, if any. */
> >  	vp_legacy_get_status(&vp_dev->ldev);
> > -	/* Flush pending VQ/configuration callbacks. */
> > -	vp_synchronize_vectors(vdev);
> 
> [Severity: High]
> Does removing this synchronization leave a race condition in the shutdown
> path?
> 
> While the core virtio_reset_device() function was updated to synchronize
> after the reset returns, virtio_device_shutdown() appears to lack this
> synchronization:
> 
> drivers/virtio/virtio.c:virtio_device_shutdown() {
>     ...
>     dev->config->reset(dev);
>     // No trailing virtio_synchronize_cbs() call
> }
> 
> Because vp_reset() writes to the status register and flushes in-flight
> interrupts, returning without synchronization means virtio_device_shutdown()
> can finish while a flushed vp_config_changed interrupt is still executing
> concurrently. 
> 
> Could this lead to unintended access to device structures or DMA memory
> during system teardown or kexec paths?

shutdown does not free memory so I do not see what is the issue
and why we need to prevent cbs from running.


> >  }
> >  
> >  static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
> > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> > --- a/drivers/virtio/virtio_pci_modern.c
> > +++ b/drivers/virtio/virtio_pci_modern.c
> [ ... ]
> > @@ -559,9 +559,6 @@ static void vp_reset(struct virtio_device *vdev)
> >  		msleep(1);
> >  
> >  	vp_modern_avq_cleanup(vdev);
> 
> [Severity: High]
> This is a pre-existing issue, but is there a potential data race here with
> concurrent interrupt handlers?
> 
> vp_modern_avq_cleanup() calls virtqueue_detach_unused_buf() without
> acquiring the admin_vq->lock. If CONFIG_VIRTIO_HARDEN_NOTIFICATION is
> disabled (leaving vq->broken as false), an in-flight admin vq interrupt
> flushed during reset might execute concurrently on another CPU:
> 
> drivers/virtio/virtio_pci_modern.c:vp_modern_avq_done() {
>     spin_lock_irqsave(&admin_vq->lock, flags);
>     do {
>         virtqueue_disable_cb(vq);
>         while ((cmd = virtqueue_get_buf(vq, &len))) {
>     ...
> }
> 
> Could concurrent modification of the virtqueue's internal vring state cause
> memory corruption or a double complete() execution if the interrupt handler
> and cleanup routine run simultaneously?


This is indeed an issue I think: an obvious fix is for now is to move a
sync before vp_modern_avq_cleanup instead of removing it. The
implication is that core irq sync is not really needed for pci, but hey,
it's inexpensive.


> > -
> > -	/* Flush pending VQ/configuration callbacks. */
> > -	vp_synchronize_vectors(vdev);
> >  }
> >  
> >  static int vp_active_vq(struct virtqueue *vq, u16 msix_vec)
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/8f71425918a148dcad1be993ccabd39582d246ee.1789130213.git.mst@redhat.com?part=2

