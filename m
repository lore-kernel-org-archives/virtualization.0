Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892883F86F0
	for <virtualization@lists.linux.dev>; Wed, 19 Aug 2026 08:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787126957; cv=none; b=PvQjBBmTE31JxCf1ZpM1ixBlkipaLFjkllqEYPjQbzKLJAIRN5CYaNWhww6yxDcaXmHvDwfSPNPUOgQDjJJbE96EQ01rE9hrU+mI24iWVh9SAp1vq4rqMO3RN7u15tC1GxrGc3cVgisWtnojcE390lu/jlLMBc7fvSi/+MrJ520=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787126957; c=relaxed/simple;
	bh=j+gVWaBheHtgcMbGe74/jYIUWmpVeo4REI3joDdZInY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=CFGEksv0P8UbuLw6DaLm/q60y1AaGkm4khb/3LXL1mtg9ZmijWuI4AIqR/JiuIz3M/xR8KKFAQbz2QbTs2Mq23rju1iZ3ZfwSzFG2soByBBo8inBl5gB5wiaeRVr8A9tO86DBupEPRaxrB6QxqmH2/0KlWR9oTkM4xx7ZjIoOSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FVBJTL3c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FVBJTL3c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787126954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nxIGNpX1bEb8ZoU7IALqEmofFiDxquDbYKReTWVCnAw=;
	b=FVBJTL3csZWvfO7fUFs3z0+Co2ydTF7OBCJZ0ocEZLtZ0bfFpOHRU7vqW2XcMQCSM+WK5n
	B/x4bdtsrhDQVjvTJyEH4ZElLXykdY/euG4vGsl/GqBZTLYtZ1D78bSmHPyf3xfeWfEBKm
	Zu0T6wfVJY4P/pIZVm8+mZwvXVJOwwM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-1eQ4ryF1PTybWorDlV-MYg-1; Wed, 19 Aug 2026 04:09:07 -0400
X-MC-Unique: 1eQ4ryF1PTybWorDlV-MYg-1
X-Mimecast-MFC-AGG-ID: 1eQ4ryF1PTybWorDlV-MYg_1787126946
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4954c2d4081so6451665e9.2
        for <virtualization@lists.linux.dev>; Wed, 19 Aug 2026 01:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787126946; x=1787731746;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nxIGNpX1bEb8ZoU7IALqEmofFiDxquDbYKReTWVCnAw=;
        b=CIfjaAAmkwoHket/IahvDV6NM3sv5qbM/ltaYgCVz6I5V1RX2niAUCGXLFSPnogMyY
         wbnnAa7Q1xCDOmWWdLvBp8+zZ0MzTp6fhfwg1hbjjMBDLkj79DnidqMrtnLiZcDMKQMp
         l1RQw3Bv3BqYjbZlLlZXyvp4hgJr1c4Z/xgwEGeTN9/Zu/G89lCm0yKJtAC0Vg/h8j/A
         j1PHACzfjYsJ5y+5UwwaKSZs8l1IIPa6J3od7yMthdN5ycFLSWjvHVeTHKZhPmtMN8cc
         KE+sfsmqycT++76NdWN4T0yIh/uek7Ozsm9BLAa9nWQGvkKjeKTcU7ONqg3Hz5OBAF47
         +O5w==
X-Forwarded-Encrypted: i=1; AHgh+RqMCPzG9avuqqQ457uX/kkRFi3adrRGe+SSA4mwMLHIh9uFZZNOeOPsbKiC5OqFRClEvKru/dUr8VdtFlpGCw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyRatXJXAAU8ipWyjAcEVbY0JXkk6Clm3rl1/j4Exq5ieGz7wbI
	8/aw55iHSVjVt6R2EhgYY3VuwBA6mBbiiFZIlxoBAVwalM3wNi8buZhz2qiMhwFWiA0KOkgRroG
	XVrNjjR5eI7/f3y3gQX1Y7z1FChRi8fDWExYDLzp4qEwZ7fE9xaLtS61VwzgbHfAydjDN
X-Gm-Gg: AR+sD12hB5ObIptFX1WmWhBuaGsYHBMHux3a8GpBbNUpKqXlrIrBk1GcFtsDz31woYS
	gDz50XXlkZQoJs4h2kZmm6C2QWNxJ7D+b20q5eN6AvtnjJ7U0EwUwLMsFbLouBdIzozFYRCyoAO
	fXaBOAVz/y1853Z0IIjwVzzSIVmMIIPspywen6XxXGsltROGBQwP0FbtJMMda0TDc+DIQbhfPyB
	1lGnFnZ0QGzf5Z5zJlC/y3TetMlty2A3KuKYIKRKsWrR+Ebur3ojf3cxUAtbusgQgGNSOOP5ZKc
	rJfe+MOlc/9UE//yOaq5jy2LHbHZGEKHDgLiCZgnmdFyo9Qdao1u91pexGkQSxLibUZ8/R+HqCI
	XEWdD1ljxtKldGoA1D1W6lB67e0NtfQ0Fk3clqXnwctgb2I7J2kgZ
X-Received: by 2002:a05:600c:a42:b0:499:484a:98e7 with SMTP id 5b1f17b1804b1-499aa1ef085mr46678825e9.14.1787126946065;
        Wed, 19 Aug 2026 01:09:06 -0700 (PDT)
X-Received: by 2002:a05:600c:a42:b0:499:484a:98e7 with SMTP id 5b1f17b1804b1-499aa1ef085mr46677575e9.14.1787126945570;
        Wed, 19 Aug 2026 01:09:05 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it. [82.53.135.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499a9e00bddsm36778675e9.3.2026.08.19.01.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 01:09:05 -0700 (PDT)
Date: Wed, 19 Aug 2026 10:08:59 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com, 
	stefanha@redhat.com, weiyj.lk@gmail.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/3] vhost: invalidate vring access on IOTLB
 transitions
Message-ID: <aoVkRe_BN6L_5XZn@sgarzare-redhat>
References: <20260818042613.281125-1-physicalmtea@gmail.com>
 <20260818042613.281125-2-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260818042613.281125-2-physicalmtea@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Rt8700STkabJzLWaaNUgXrgMYoFLczulLvOoe9fa_sw_1787126946
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Aug 18, 2026 at 12:26:11PM +0800, Jia Jia wrote:
>When ACCESS_PLATFORM changes, the addresses cached in desc, avail, and
>used change meaning with the address space. Clear the cached vring access
>state when the device IOTLB is installed or removed so stale IOVAs cannot
>be reused as direct userspace addresses.
>
>Keep device IOTLB initialization idempotent and apply the mode change even
>when a virtqueue backend is attached. Drop the device-wide IOTLB first,
>then clear each VQ state under its own mutex, and keep the old table alive
>until every VQ has completed the handoff.
>
>A successful live mode change leaves the backend attached but invalidates
>the cached vring addresses. Userspace must configure the vring addresses
>for the new address mode before data processing can resume.
>
>Fixes: 6b1e6cc7855b ("vhost: new device IOTLB API")
>

Please don't leave spaces here!

>Signed-off-by: Jia Jia <physicalmtea@gmail.com>
>---
> drivers/vhost/vhost.c | 53 ++++++++++++++++++++++++++++++++++++++++++-
> drivers/vhost/vhost.h |  1 +
> 2 files changed, 53 insertions(+), 1 deletion(-)


This patch doesn't apply, I tried vhost tree, net tree, and master.
On which tree is this based?

Stefano

>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 4c525b3e16ea..9f74537b1c1c 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -344,6 +344,17 @@ static void __vhost_vq_meta_reset(struct vhost_virtqueue *vq)
> 		vq->meta_iotlb[j] = NULL;
> }
>
>+/* Caller must hold the virtqueue mutex. */
>+static void vhost_vq_invalidate_access(struct vhost_virtqueue *vq)
>+{
>+	vq->desc = NULL;
>+	vq->avail = NULL;
>+	vq->used = NULL;
>+	vq->log_used = false;
>+	vq->log_addr = -1ull;
>+	__vhost_vq_meta_reset(vq);
>+}
>+
> static void vhost_vq_meta_reset(struct vhost_dev *d)
> {
> 	int i;
>@@ -1911,6 +1922,9 @@ int vq_meta_prefetch(struct vhost_virtqueue *vq)
> {
> 	unsigned int num = vq->num;
>
>+	if (!vq->desc || !vq->avail || !vq->used)
>+		return 0;
>+
> 	if (!vq->iotlb)
> 		return 1;
>
>@@ -2270,11 +2284,48 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
> }
> EXPORT_SYMBOL_GPL(vhost_vring_ioctl);
>
>+/* Caller must hold the device mutex. */
>+void vhost_clear_device_iotlb(struct vhost_dev *d)
>+{
>+	struct vhost_iotlb *iotlb;
>+	int i;
>+
>+	iotlb = d->iotlb;
>+	if (!iotlb)
>+		return;
>+
>+	/*
>+	 * Drop the device-wide view first.  Each VQ then drops its
>+	 * per-VQ view and its cached ring access under its own mutex.
>+	 * Keep the old table alive until every VQ has completed this
>+	 * handoff, since a worker may still be using it while waiting
>+	 * for its VQ mutex.
>+	 */
>+	d->iotlb = NULL;
>+
>+	for (i = 0; i < d->nvqs; ++i) {
>+		struct vhost_virtqueue *vq = d->vqs[i];
>+
>+		mutex_lock(&vq->mutex);
>+		vq->iotlb = NULL;
>+		vhost_vq_invalidate_access(vq);
>+		mutex_unlock(&vq->mutex);
>+	}
>+
>+	vhost_clear_msg(d);
>+	vhost_iotlb_free(iotlb);
>+	wake_up_interruptible_poll(&d->wait, EPOLLIN | EPOLLRDNORM);
>+}
>+EXPORT_SYMBOL_GPL(vhost_clear_device_iotlb);
>+
> int vhost_init_device_iotlb(struct vhost_dev *d)
> {
> 	struct vhost_iotlb *niotlb, *oiotlb;
> 	int i;
>
>+	if (d->iotlb)
>+		return 0;
>+
> 	niotlb = iotlb_alloc();
> 	if (!niotlb)
> 		return -ENOMEM;
>@@ -2287,7 +2338,7 @@ int vhost_init_device_iotlb(struct vhost_dev *d)
>
> 		mutex_lock(&vq->mutex);
> 		vq->iotlb = niotlb;
>-		__vhost_vq_meta_reset(vq);
>+		vhost_vq_invalidate_access(vq);
> 		mutex_unlock(&vq->mutex);
> 	}
>
>diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
>index 0192ade6e749..3c75e8089373 100644
>--- a/drivers/vhost/vhost.h
>+++ b/drivers/vhost/vhost.h
>@@ -277,6 +277,7 @@ ssize_t vhost_chr_read_iter(struct vhost_dev *dev, struct iov_iter *to,
> 			    int noblock);
> ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
> 			     struct iov_iter *from);
>+void vhost_clear_device_iotlb(struct vhost_dev *d);
> int vhost_init_device_iotlb(struct vhost_dev *d);
>
> void vhost_iotlb_map_free(struct vhost_iotlb *iotlb,
>

