Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECB43CF678
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 14:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027221; cv=none; b=LkKgh4ZKTfQvb1K9xjTTNlHVSZoayiJeRFqUqzkmZRJoM+YoC60HDRb41KzG83B+Z7bvrPSlaq5mVVIH4XlSCSNeGJBKmfCAaUtYE0evvlQz4dOyiINU0mwmSSKUBhUEcfD/vw/FdDjAblgmCFDZlmz5mj82CIqIdOe4BGWfZdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027221; c=relaxed/simple;
	bh=gcjKawjwo26uLkajY4IH3jQHyOn7PT0OmTOcUrswS9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eS41lzjBggtZCRoH00jQ+tdBbF6NKzbU2S1fmqXS0D5CXkuFxrC6r8eV8V61J8NG0t9dAGyNiyzIWuSS20DWqgotBUZA/pnJbtVtlEjm8X4WDKyxHiQkC8FAH6HnysdmSABsDXyzvNi3CBZhSafK+C+HKaX2En08fmoKmWtGJAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=alCl8suo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="alCl8suo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786027219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/p4TBvMBVw0EXOJptfY8mrIcbCKeY/alz7cq+D1eCSU=;
	b=alCl8suoolMoyncx/Loac02th4Vh6cPgJRiDXZ+59kHgehbEBYWy/l0WH54BTV8IXug4Wt
	ezeMhbArXe/yVJXtPBWjiQtRDIOtEJcKL2TMd8v7h/uOeXBP/71vYyDtNhFA10jT2yoIFv
	FjwVXDEDFhjZYov8E8umNjr9jSabdP0=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-U-CHIkhdOKmEi4gCIlq-lg-1; Thu, 06 Aug 2026 10:40:18 -0400
X-MC-Unique: U-CHIkhdOKmEi4gCIlq-lg-1
X-Mimecast-MFC-AGG-ID: U-CHIkhdOKmEi4gCIlq-lg_1786027217
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cc86a9ef97so38732755ad.3
        for <virtualization@lists.linux.dev>; Thu, 06 Aug 2026 07:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786027217; x=1786632017;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/p4TBvMBVw0EXOJptfY8mrIcbCKeY/alz7cq+D1eCSU=;
        b=qEcKDG9qFTvUUdJ/Bh/pOCXOpVS4F0yCH7Z9OqzHbAckHnY1RIjyfMLAmHjq+0kmrA
         em/9kg3mU43R2xfQsRFuXGcblGAegm3PKK8vNU/MDLLcA1XU4dSxfdOuUUYg9BXWFdWO
         vqiKdWLdiHWrF7jcJzdiJGiZidY2e5rETaTlab2q+aOHEu2gzhafVdMzhOETp1bgw+QU
         c+2CnU7i30vBpUFMdI7+Ck+6tDxMYPYNxLlttP5TReMf1jhnByumHTS2f5RIb0wc0lgt
         hi+Zfhf6eteuLB/sXIZN4IuHOyOxOp838b5Oi3YIg2djUDUYfUBo9YXI1eVX+QY3rwg0
         IJ1w==
X-Forwarded-Encrypted: i=1; AHgh+RpN+a972xfjafGLcyFr0jXBRYSP+ZFaVGYKfnCEEqlgGyJKJbw6v1PRteYbYCnCKlhvUsKF4wkDFedz4d251Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwXAQQg7Q85EEcNcYHN2Uoe7mqs67ptjaHtAg/+oiDbFJI0wuTp
	a5bix8C2Nuj4WSv9Lk8kUsf/Fw7jrxN8536jfFBXDxPTh6mRJYTynzC3idSzS8DyYj3LF8Ru9i+
	zHk5UsMPH0XobDY9PPXq0FtydbK2lFxKlgRiXb4lcwMxU1e5TW9dAnhMBBdRxYlPFvlTaNn4v8W
	UtXS8TWngwpEyZTc3EndX2QieA33fTDI/ylNCNvMqwVpo=
X-Gm-Gg: AR+sD116AHpBo9F2l7Z6K2DK8/lhX8gDEiQ8bfe+u8diCNRT92jVLY198KkQCWPa+5q
	o12y7/QB6WeIrtbxMrnfJvYafyg8ryVE9qKqy5zcEkLmbq9PtdIXzNXgXxAF2P2vJ8cCZuhTRPW
	Df0vQF8NzlFEP5oUTM/jRDrH+M0/Qo9rhVuaN7TlL8rWIY9B9Iyhz4r1c=
X-Received: by 2002:a17:90b:580b:b0:38e:9e9d:9209 with SMTP id 98e67ed59e1d1-3903c5c51cdmr15623471a91.17.1786027216720;
        Thu, 06 Aug 2026 07:40:16 -0700 (PDT)
X-Received: by 2002:a17:90b:580b:b0:38e:9e9d:9209 with SMTP id
 98e67ed59e1d1-3903c5c51cdmr15623360a91.17.1786027216105; Thu, 06 Aug 2026
 07:40:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260723153310.745855-1-andrey.drobyshev@virtuozzo.com> <anSMBpQJ8x-vXYy2@sgarzare-redhat>
In-Reply-To: <anSMBpQJ8x-vXYy2@sgarzare-redhat>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 6 Aug 2026 16:40:04 +0200
X-Gm-Features: AUfX_mxXaE00zqmd2DiALac4VL3A9WWcVSqpkYeQGMWjXcfcP0SiHhV-7fpbPQU
Message-ID: <CAGxU2F4b7oy338gRSJyNko=Bnwyi+MCdzOKAtZSW2q_GJnT6=A@mail.gmail.com>
Subject: Re: [PATCH] vhost: clear vq->worker under vq->mutex when freeing workers
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, 
	stefanha@redhat.com, jasowangio@gmail.com, eperezma@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: s6iUBZPPvn4IaGvngJQokNzE15wVBr2_LwVAyVyXO10_1786027217
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Aug 2026 at 15:35, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Thu, Jul 23, 2026 at 06:33:10PM +0300, Andrey Drobyshev wrote:
> >Every other update of vq->worker is done under vq->mutex - the worker
> >attach/swap ioctls and vhost_worker_killed().  vhost_workers_free() is
> >the sole exception: it clears vq->worker without holding the lock.
>
> mmm, vhost_dev_cleanup() updates vq->worker without the mutex too IIUC.
>
> >
> >The effect is harmless in practice, as this only happens while the
> >owning process (and thus the whole device) is dying, but the lockless
> >write is inconsistent with the rest of the code.  Clear vq->worker under
> >vq->mutex, like everyone else, so that all writers of vq->worker follow
> >the same locking rule.
> >
> >This issue was found by Sashiko AI review.
>
> Can you share a link to the review?
>
> I don't know if it's common or not, but having the link in the commit or
> after --- will help the reviewers.
>
> >
> >Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> >---
> > drivers/vhost/vhost.c | 10 ++++++++--
> > 1 file changed, 8 insertions(+), 2 deletions(-)
> >
> >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >index 4c525b3e16ea..dbb6cb5eccea 100644
> >--- a/drivers/vhost/vhost.c
> >+++ b/drivers/vhost/vhost.c
> >@@ -722,13 +722,19 @@ static void vhost_worker_destroy(struct vhost_dev *dev,
> > static void vhost_workers_free(struct vhost_dev *dev)
> > {
> >       struct vhost_worker *worker;
> >+      struct vhost_virtqueue *vq;
> >       unsigned long i;
> >
> >       if (!dev->use_worker)
> >               return;
> >
> >-      for (i = 0; i < dev->nvqs; i++)
> >-              rcu_assign_pointer(dev->vqs[i]->worker, NULL);
> >+      for (i = 0; i < dev->nvqs; i++) {
> >+              vq = dev->vqs[i];
> >+
> >+              mutex_lock(&vq->mutex);
> >+              rcu_assign_pointer(vq->worker, NULL);
> >+              mutex_unlock(&vq->mutex);
> >+      }
>
> Pre-existing, but IIUC vhost_workers_free() is called only by
> vhost_dev_cleanup() at the bottom, after a loop calls vhost_vq_reset()
> on each virtqueue (without the mutex) where we already set `vq->worker`
> to NULL, so IMO at this point it's already NULL, no?

Oh, sashiko reported pretty much the same
https://sashiko.dev/#/patchset/20260723153310.745855-1-andrey.drobyshev@virtuozzo.com?part=1

So, yeah, I think it's a valid report we should fix.

Thanks,
Stefano

