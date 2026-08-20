Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ED9443A9C
	for <virtualization@lists.linux.dev>; Thu, 20 Aug 2026 12:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787229574; cv=pass; b=A21/VNaB7MbmtTOMJ3C6+VyTSF8NmbiNkoWUqJ+71l0Yw9ysxRD7XpZRLr8Pa+80yGSHtjnwnkwd8SMY95JieupRoXqIS8Fy9nCcB80jQVzzlAbu+skHBDNFNFZBvSbIryUYkeS1p+RYePlRV/8mg04IEt1KkU4um9tDSTDj1sQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787229574; c=relaxed/simple;
	bh=aL5TuuMwAaQVwOyXsLkpLSm0ZpL31g9SvuoVklTboFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qAmUIzOqpwGNh3Cgt3gHEto65ae++wd0b8d3RLMckEw2hM9NI2RpoxYo3QQG9SyVR6TQ3gqpLxj8Y3+BuVdM/I5dTUyA4hfNyehP6VYawmok6cqVc6nLCBr8av/bCDZwpaQ5iPYXoe5SO5veKWs3hq2hEqNlFgtIzMVQg+PIXQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNVIBIOd; arc=pass smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNVIBIOd"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-936c02e58dfso151248585a.3
        for <virtualization@lists.linux.dev>; Thu, 20 Aug 2026 05:39:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787229572; cv=none;
        d=google.com; s=arc-20260327;
        b=Bo7efTIld9ioEZE55IklErwDO9w8nFfUguBgjeuZpJwzO3VfR2X+/pSE5jWJ7EzSMF
         g+rwCwTgWd+le5Jq8RzFLx7IFdmPaD40yaNqPtyX+4bye1rMeNOcgLqu3HDXohmrEQHn
         5X2tZQIDvt/nGv3xm/TR2NR5CYaHZ7jA9m2uVZeKXI1ihvrDe3DekcCIJREVuey+FQ+y
         jDBzn/V38O4EDtltNK0JX4nMs0swY822T9w+JQVSbvN3yPDy7XYIbTJgzLi+IcrXjk9A
         QRNAvehadbz/IKL88XM4fKvLLyHRIsnJOQ0aGV+dnFoxVQLqfAtsDKvWAFu+7oIV2ROD
         YZBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uohgdUdRgrY842N3nbUM8yhr+cf5Gqn3ftN8ZqqRYvM=;
        fh=hbR6WPStDGGCsM6ZUuuVh26Ki+sbDsrHnbdl4bS9RHc=;
        b=gu80TgxOwi8cVucKzUYFzaQb2109Q/ydEM5nTd7UO3xQf1PxJLGjZbKuwjtrgMwAGX
         TfPlFv+nol4vTdXvkAnjIbzV6QjuBBlYcvs9zlvFuC7wlWTVd+iMsIv/lb3nugJOkDjS
         oXDGRm3QZwekfu/zNNLRDBhcTeW6v+j49/7MLECdNXd4ajLXHQ2F7qey/heYyVwogKDy
         nYiT8rhlSBwQ4dOBTdQ0syD7qHOmWE0kBrhZzT3vm45YqG5tHWwFV5WG03UWbIM5zErM
         Yfc9a29Uo+1wnVMS9Mk+AiciV75to0+IhMMTJnHgFnVnZ2bIPkaRBj7gXqYrNFAfwWdv
         DESA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787229572; x=1787834372; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uohgdUdRgrY842N3nbUM8yhr+cf5Gqn3ftN8ZqqRYvM=;
        b=PNVIBIOdcRO8SoDdOvFCv6R/hed9+O0+Ut/uDg2zUAyZQnLharCKDHUbAoVDIA1szB
         gRra3tUxGzHMZy6Fv997QAfUz8tmuHPffPNHoqfRLcI+2fWlPGU1sdPKq0AEHhya7BsO
         Rhf6e04+8+h8MtwXcVULwImaH45py128Y8nSNJp5KapAXzv+BawXOHJLg81PSbwehh0Y
         gLeRgQhGpa+kf6y52G9ajAGqLRDm16MdJWcEGpYN6WljIft/3tGy0VlEd9f2y5XcsjyF
         T+t08YWIfyC7Px2B8ZXakOMZaLUU2v0H10dcePlcHCYcsE41UMvzmCHVqmtkOS+/ZM70
         w75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787229572; x=1787834372;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uohgdUdRgrY842N3nbUM8yhr+cf5Gqn3ftN8ZqqRYvM=;
        b=kTW4gr6WNbGl5zTSt8isHxZ5CaaDKkxANKx8QnEDUhZf1jQnRRElgEGXnR3pn/SrUX
         n0OkYxRgd9ve9sPkrhcZZgXy/OQBB9/sZK96LLCclEyV2XdQMWyoCNDOnFws9iHyVK2D
         pw7f5/8b0K5jKouUKHaV6G5IMQeD/3oiuOthnCeFW/x3Mzg+Zygl8UrSKlUV1pqiZPtV
         T+s9iaBmOG8Oq9/Oy0OtotYDaYdd1Mvc8DnCYIdpi2t0wP3VrWguBQ0Cr4xVszulAe/N
         n5FKcIlu3evwNhaxZl9N2wedgjL3S1AEoRlgK212FNTYt04RkSvL2rJGhQqUFwnrU2jj
         8Hew==
X-Forwarded-Encrypted: i=1; AHgh+RrysW/A/91weu41mCKfQI8yANUUwzdHCXbzzTtuV+bOED6SENCmcOXF4pjJdkRnnOsbghGW9bf69WUxCGowVg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw7JVma3EW65R0520ZTAjf7rGPluqFN9b6pCP8YaBn5RALczVsu
	XE7EtQvMdjGiw/s0CZv3osP+d/tKGjPNRkUyFvoi+elo8VvG5lhQTZdkfIgVQnAS/dbKrnz16i+
	e6fMMcnk0aNjqJwUmCpWmWsTQa37l25U=
X-Gm-Gg: AR+sD10htmOB8MdLgApeVi93VvQCrM6jcwDxYzqu4juDY6O8+181cp8Vr4BNlvOFZJU
	v1eHhOxVd8n8vtQcV3EpBpcRzLDkoUfXrMDeRVvAJdpzpTa4O2QGx762yCRlSCCqqKSiui/0BeU
	9FHB+qTyh+EK/nILgqZAlGTEJk6A9W3GJFl/G71eZ6Bpo8Lj30ZQ3k2pKibd43eR7pWINF7gwwj
	k+O2j9xRg06fmE2BYSKVv8gKMQ3+bodUofi6mhdPWzBuRozRcYcpf0MS4hp/2nj2MqPMLzg4suM
	QGm/odLzChUAtofRlSm+GKSmWLF+Eobeddq143JpNnQMMZa4CB7gkKY=
X-Received: by 2002:a05:620a:404a:b0:92f:199:b035 with SMTP id
 af79cd13be357-9371e252a0fmr1102568885a.3.1787229571662; Thu, 20 Aug 2026
 05:39:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260820080332.313933-1-physicalmtea@gmail.com>
 <20260820080332.313933-2-physicalmtea@gmail.com> <aobCds-JDgs3BiSp@sgarzare-redhat>
In-Reply-To: <aobCds-JDgs3BiSp@sgarzare-redhat>
From: Jia Jia <physicalmtea@gmail.com>
Date: Thu, 20 Aug 2026 20:38:55 +0800
X-Gm-Features: AcwNN1V_ozKiep3YvThC-YsxIdIa8Rks0gJmRuoU636bafPM8R_uE-RRSwSYMDM
Message-ID: <CAJwVaM+WZhw_GCfqcEkNpe8vsTmW_OSRpiQVBXR8cpuvWiTjmg@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] vhost: invalidate vring access on IOTLB transitions
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, weiyj.lk@gmail.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Thu, Aug 20, 2026 at 04:03:30PM +0800, Jia Jia wrote:
> >When ACCESS_PLATFORM changes, the addresses cached in desc, avail, and
> >used change meaning with the address space. Clear the cached vring access
> >state when the device IOTLB is installed or removed so stale IOVAs cannot
> >be reused as direct userspace addresses.
> >
> >Keep device IOTLB initialization idempotent and apply the mode change even
> >when a virtqueue backend is attached. Drop the device-wide IOTLB first,
> >then clear each VQ state under its own mutex, and keep the old table alive
> >until every VQ has completed the handoff.
> >
> >A successful live mode change leaves the backend attached but invalidates
> >the cached vring addresses. Userspace must configure the vring addresses
> >for the new address mode before data processing can resume.
> >
> >Fixes: 6b1e6cc7855b ("vhost: new device IOTLB API")
> >Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> >---
> > drivers/vhost/vhost.c | 53 ++++++++++++++++++++++++++++++++++++++++++-
> > drivers/vhost/vhost.h |  1 +
> > 2 files changed, 53 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >index 14637cff0bd4..31fff9800045 100644
> >--- a/drivers/vhost/vhost.c
> >+++ b/drivers/vhost/vhost.c
> >@@ -344,6 +344,17 @@ static void __vhost_vq_meta_reset(struct vhost_virtqueue *vq)
> >               vq->meta_iotlb[j] = NULL;
> > }
> >
> >+/* Caller must hold the virtqueue mutex. */
> >+static void vhost_vq_invalidate_access(struct vhost_virtqueue *vq)
> >+{
> >+      vq->desc = NULL;
> >+      vq->avail = NULL;
> >+      vq->used = NULL;
> >+      vq->log_used = false;
> >+      vq->log_addr = -1ull;
> >+      __vhost_vq_meta_reset(vq);
> >+}
> >+
> > static void vhost_vq_meta_reset(struct vhost_dev *d)
> > {
> >       int i;
> >@@ -1918,6 +1929,9 @@ int vq_meta_prefetch(struct vhost_virtqueue *vq)
> > {
> >       unsigned int num = vq->num;
> >
> >+      if (!vq->desc || !vq->avail || !vq->used)
> >+              return 0;
> >+
> >       if (!vq->iotlb)
> >               return 1;
> >
> >@@ -2287,11 +2301,48 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
> > }
> > EXPORT_SYMBOL_GPL(vhost_vring_ioctl);
> >
> >+/* Caller must hold the device mutex. */
> >+void vhost_clear_device_iotlb(struct vhost_dev *d)
>
> Is this the right patch where introduce this function?
>
> IMO should be introduced when we use it.
>
> About that I'm not sure if it is better to squash the other 2 patches
> with this one, otherwise will be this bisectable?
> I mean with just this patch applied (and without the other 2) who is
> going to free the old iotlb?
>

 I'll rework the series so that the helper is introduced together with
 the vhost-net and vhost-vsock callers, most likely by squashing the three
 patches. I'm also reviewing the existing IOTLB replacement semantics
 before preparing the next revision.

> >+{
> >+      struct vhost_iotlb *iotlb;
> >+      int i;
> >+
> >+      iotlb = d->iotlb;
> >+      if (!iotlb)
> >+              return;
> >+
> >+      /*
> >+       * Drop the device-wide view first.  Each VQ then drops its
> >+       * per-VQ view and its cached ring access under its own mutex.
> >+       * Keep the old table alive until every VQ has completed this
> >+       * handoff, since a worker may still be using it while waiting
> >+       * for its VQ mutex.
> >+       */
> >+      d->iotlb = NULL;
> >+
> >+      for (i = 0; i < d->nvqs; ++i) {
> >+              struct vhost_virtqueue *vq = d->vqs[i];
> >+
> >+              mutex_lock(&vq->mutex);
> >+              vq->iotlb = NULL;
> >+              vhost_vq_invalidate_access(vq);
> >+              mutex_unlock(&vq->mutex);
> >+      }
> >+
> >+      vhost_clear_msg(d);
> >+      vhost_iotlb_free(iotlb);
> >+      wake_up_interruptible_poll(&d->wait, EPOLLIN | EPOLLRDNORM);
> >+}
> >+EXPORT_SYMBOL_GPL(vhost_clear_device_iotlb);
> >+
> > int vhost_init_device_iotlb(struct vhost_dev *d)
> > {
> >       struct vhost_iotlb *niotlb, *oiotlb;
> >       int i;
> >
> >+      if (d->iotlb)
> >+              return 0;
> >+
>
> IIUC after this patch `oiotlb` is always NULL, can we remove it?
>
> Thanks,
> Stefano

  Thanks, I took another look. I don't think we should simply remove
  oiotlb while keeping the early return, since the early return itself may
  be too broad.

  One case I need to examine more carefully is vhost stop/start. QEMU
  unregisters the IOMMU listener while vhost is stopped. If an IOVA
  mapping changes during that interval, preserving the existing kernel
  IOTLB on the next VHOST_SET_FEATURES may retain an entry pointing to the
  old HVA. A later lookup could hit that stale entry, so no IOTLB miss
  would be reported and no replacement update would be triggered through
  the miss path for that IOVA.

  The original replacement path, including oiotlb, installs a new empty
  table and safely keeps the old table alive until all VQs have switched.
  I need to review this lifecycle more carefully before deciding whether
  that replacement semantic can be removed. A logging-only feature update
  may want to preserve the IOTLB, while a restart boundary may need a new
  one, and d->iotlb != NULL alone does not distinguish those cases.

>
> >       if (max_iotlb_entries <= 0)
> >               return -EINVAL;
> >
> >@@ -2307,7 +2358,7 @@ int vhost_init_device_iotlb(struct vhost_dev *d)
> >
> >               mutex_lock(&vq->mutex);
> >               vq->iotlb = niotlb;
> >-              __vhost_vq_meta_reset(vq);
> >+              vhost_vq_invalidate_access(vq);
> >               mutex_unlock(&vq->mutex);
> >       }
> >
> >diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> >index 0192ade6e749..3c75e8089373 100644
> >--- a/drivers/vhost/vhost.h
> >+++ b/drivers/vhost/vhost.h
> >@@ -277,6 +277,7 @@ ssize_t vhost_chr_read_iter(struct vhost_dev *dev, struct iov_iter *to,
> >                           int noblock);
> > ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
> >                            struct iov_iter *from);
> >+void vhost_clear_device_iotlb(struct vhost_dev *d);
> > int vhost_init_device_iotlb(struct vhost_dev *d);
> >
> > void vhost_iotlb_map_free(struct vhost_iotlb *iotlb,
> >--
> >2.34.1
> >
>
