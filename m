Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747393E120E
	for <virtualization@lists.linux.dev>; Thu, 20 Aug 2026 08:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787216365; cv=none; b=HWovTlCuNxnDEC1TuaouMmYt/ynTQJogQ+PFSaDSraj1gLjhuPUBKSH4dZw2nhwI5moSgSBak83QOz+M1un3ANU2wkomcn0K1u42nJq+iZbiDUzSMVeNeEViyTzfTsFc9GDbjUnpvaPoZjDicSNHYCDKwvSHB4e15WgMKsiEwtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787216365; c=relaxed/simple;
	bh=A+zUCLXifVgTuHB4fPwTYTmQVtckKJL/x1J77vP12OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jzMU1eGGqBc6yqrXmhx6RGblyui0kf5U6F3Mr6fX3BgWt4OJFrPshFId7C0aq51nTo1dbbVDDK6lscGiFCQJMUgkBuBlOkctCouarOIYkbur/sT01dcRivMo1OUimdpgfBZTd4+V6WxyZ0tgz3TfTefC421lI7q5Vx0ncwIWw/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DnvSgCcU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DnvSgCcU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787216362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DTl22GoWoyN6aViItfu2yJEcGK2iytdtHBsWnD7u58U=;
	b=DnvSgCcU3U6O6jWd6inFHOzD2W+28rTrSbAFdLqeUYDcKt4ACYMeO6IA1Xqibzd4wHQ6x/
	ZqizsO7qPCvKflRwWoQlcVwyH1na4vvaa0GqPelg3whVAbMfl2uuiQI7qX247DaB6JFuI6
	Cdf0SCsC5aw37f6MYBNzU2ylljtEeK8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-M2bhN5pCNiWATJZvRlE95g-1; Thu, 20 Aug 2026 04:59:20 -0400
X-MC-Unique: M2bhN5pCNiWATJZvRlE95g-1
X-Mimecast-MFC-AGG-ID: M2bhN5pCNiWATJZvRlE95g_1787216360
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4957287363bso13388755e9.0
        for <virtualization@lists.linux.dev>; Thu, 20 Aug 2026 01:59:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787216360; x=1787821160;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DTl22GoWoyN6aViItfu2yJEcGK2iytdtHBsWnD7u58U=;
        b=qqwAKV1hYPc8lEKOu7i1pAFg8h1vM2cC58Y2PqPnbTQk226Ff5zTtXhaAXBF4f8hNP
         aqeESs/BtdI3c3TSDvqtG/aEQVUCRArGVCrcrjs1n6NiXHUXcAGJbtjLIefJatSrrYpl
         Tupb+BuWr294dH6kkHH+1qXOKCSjSGtICblSXwJ4h7SnbIVk0aN0oAKIY07SkxFrJ496
         cXE250wxrYJDhK2jscc0gOpASs/NWeqwNLt8EI2r7V/XNdQlMJEK1XonCX3JMk+9bAUq
         H/1CVgoTtat+z29D4s9k57ycOy6pP22PalJsOkJtkfokKZ0yjz561DS6B3oI5zZokvfV
         zhAQ==
X-Forwarded-Encrypted: i=1; AHgh+RqqZlG7vwU2ovRQipoffqNipfi/I31J3Yt5t0uh6eMQFC/XlArcErwpp/o0WoUCA0g3qztpXujcrhPTGpcntw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3rkte27GUcEMQT/pwp4D/jVlAOnGb3n5M9ZBinRwzeuVUuDZ/
	6K3Fssb4yjcqFKnIBa/W/W4bPabrEY3RwbzBdiFbcPJHVzVraBS7fbmkOqtN1BvG+Age5vpCExm
	pxW+OrDeH4ZJa3zyps4TgnUYkHDW8dgtUlZqO/oIvjBU+4fOpNBEwRjHg4Zb5FDf3jBWI
X-Gm-Gg: AR+sD13CJFTTMcWP414Oy304xw7mrF0qNpIiuwYKA5O+2/5fpFDt0ty4wgsy1UmEIcE
	e0APj1dIssEX8qIJloGikqYV6ixmLOhEeqsSVwnU0T+PPrFsgySLrNMGUl/hxaWCzjFtoB2FvCr
	J/mVZXnpzjjcBu/bNJe0WkKOgwcH7EtipHAOgdwsVZ6c9xJjIoQLkCh9wS622aezhPh87I+EhO+
	0uNJMRYAHdZXsPo+myGoWQiIxJOfNbpTcgL2K4/rjUndgW0x/wihI/I1HlSP/dO4OXSaBc3G3bh
	XY+F5CIhMe03AspJQnEjRn6/TAHAvvmoFDX0kQxGlt5as7zXqLxTUY9scS5DqP+jBbsini+eLTl
	me1N2tWwVwODP8WZnY33Nks0IoYMDaW4EQommoA5DNM5XbidBKSdx
X-Received: by 2002:a05:600c:5253:b0:499:79b9:e226 with SMTP id 5b1f17b1804b1-499aa109edbmr172010445e9.0.1787216359756;
        Thu, 20 Aug 2026 01:59:19 -0700 (PDT)
X-Received: by 2002:a05:600c:5253:b0:499:79b9:e226 with SMTP id 5b1f17b1804b1-499aa109edbmr172009765e9.0.1787216359289;
        Thu, 20 Aug 2026 01:59:19 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it. [82.53.135.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b3c556a3sm17318315e9.3.2026.08.20.01.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 01:59:18 -0700 (PDT)
Date: Thu, 20 Aug 2026 10:59:13 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	jasowangio@gmail.com, eperezma@redhat.com
Subject: Re: [PATCH v2] vhost: clear vq->worker under vq->mutex when freeing
 workers
Message-ID: <aobAlM7l67fpDaPO@sgarzare-redhat>
References: <20260819114328.426131-1-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260819114328.426131-1-andrey.drobyshev@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kUEEhFZ0XZJ1LPk5venjX86frCzKSqPC0Yxw7Q3o3N8_1787216360
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Aug 19, 2026 at 02:43:28PM +0300, Andrey Drobyshev wrote:
>Every other update of vq->worker is done under vq->mutex - the worker
>attach/swap ioctls and vhost_worker_killed().  vhost_workers_free() is
>the sole exception: it clears vq->worker without holding the lock.
>
>The effect is harmless in practice, as this only happens while the
>owning process (and thus the whole device) is dying, but the lockless
>write is inconsistent with the rest of the code.  Clear vq->worker under
>vq->mutex, like everyone else, so that all writers of vq->worker follow
>the same locking rule.
>
>vhost_vq_reset() also used to clear vq->worker locklessly, earlier on
>the same teardown path, making the write in vhost_workers_free()
>redundant.  Drop the clear from vhost_vq_reset() and initialize the
>pointer in vhost_dev_init() instead, so that vhost_workers_free() is the
>only place clearing vq->worker on teardown.  Any work queued while
>vq->worker is still set is drained by the synchronize_rcu() +
>vhost_dev_flush() in vhost_workers_free() before the workers are freed.
>
>Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
>Closes: https://lore.kernel.org/kvm/20260721102325.1BD6C1F00A3A@smtp.kernel.org
>Link: https://lore.kernel.org/kvm/20260724153334.1BCBF1F000E9@smtp.kernel.org
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
>
>v1 -> v2:
>
>  * Drop the lockless vq->worker clear from vhost_vq_reset(), initialize
>    vq->worker in vhost_dev_init() instead;
>  * Rebase onto Michael's mst/linux-next tree (with my previously merged
>    vsock patches);
>  * Add links to Sashiko reports and adjust commit message.
>
>v1: https://lore.kernel.org/kvm/20260723153310.745855-1-andrey.drobyshev@virtuozzo.com
>
> drivers/vhost/vhost.c | 12 +++++++++---
> 1 file changed, 9 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index a0c1d54019aa..5764a54ddc92 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -392,7 +392,6 @@ static void vhost_vq_reset(struct vhost_dev *dev,
> 	vq->busyloop_timeout = 0;
> 	vq->umem = NULL;
> 	vq->iotlb = NULL;
>-	rcu_assign_pointer(vq->worker, NULL);
> 	vhost_vring_call_reset(&vq->call_ctx);
> 	__vhost_vq_meta_reset(vq);
> }
>@@ -613,6 +612,7 @@ void vhost_dev_init(struct vhost_dev *dev,
> 		vq->heads = NULL;
> 		vq->nheads = NULL;
> 		vq->dev = dev;
>+		RCU_INIT_POINTER(vq->worker, NULL);
> 		mutex_init(&vq->mutex);
> 		vhost_vq_reset(dev, vq);
> 		if (vq->handle_kick)
>@@ -722,13 +722,19 @@ static void vhost_worker_destroy(struct vhost_dev *dev,
> static void vhost_workers_free(struct vhost_dev *dev)
> {
> 	struct vhost_worker *worker;
>+	struct vhost_virtqueue *vq;

nit: `vq` is used only in the for loop, so you can move this declaration 
inside the loop. (I'm not asking to respin for just this)

> 	unsigned long i;
>
> 	if (!dev->use_worker)
> 		return;)
>
>-	for (i = 0; i < dev->nvqs; i++)
>-		rcu_assign_pointer(dev->vqs[i]->worker, NULL);
>+	for (i = 0; i < dev->nvqs; i++) {
>+		vq = dev->vqs[i];
>+
>+		mutex_lock(&vq->mutex);
>+		rcu_assign_pointer(vq->worker, NULL);
>+		mutex_unlock(&vq->mutex);
>+	}
>

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

