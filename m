Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5268B38A71F
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 13:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786023351; cv=none; b=iy+n9zreYQ0YciJDEfCZzihIyZvbN3v2dc0Pqv1BpD/1tTH3lS3Ri2xHxmQTMrJXNVIbzTdjToFAZC3QTOeBauSIbrWXCijO2oDpq537ud3LZRP5lMG+EhLZcBNx34hBfcoX4nZmkrrNKXGU9c3pkKhV9tSz7UxzHwfFtU8ofys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786023351; c=relaxed/simple;
	bh=ObD7bPWSxhbklQOHrMfvrjgdmbGQvAlacZ3UlKZDW7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tFv1OOMB1eWHaZV5iy7eMKApGudyxUH3JVfXupr5//brdiEznIiksuUP7xOGzK6CuEspy7gGN12sbTNSUlY15Tsf5ePN9EFhXrksxvCZX5qINIZ7FgomedQiBfQ6qtoK+kpeQQeUKhIybxUWMoZqZ8+YBFt0cIkGIE6Oz2rD198=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZDYb50vW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZDYb50vW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786023338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rILtqoeBHE7LGqRbLxT9biwUTl88ABJkJnpfbIm4pB0=;
	b=ZDYb50vWu4hGH63pBR4ioUf7l/utb1YDqsIGk6KTKvWQp75JxZwcBuzR5g1DV6xXz5vnRk
	RLitIP+2HOMjFg1M/Mtsjv4BhlkhQiJKMnKgGYt+AB2+jGkOSdnssjSy1ofOxQct5JXf0I
	xKvsHDKYZ8nuaa1sCLVb2HX6E/hm280=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-JazcctVfOL-nWg5P_qnI3Q-1; Thu, 06 Aug 2026 09:35:37 -0400
X-MC-Unique: JazcctVfOL-nWg5P_qnI3Q-1
X-Mimecast-MFC-AGG-ID: JazcctVfOL-nWg5P_qnI3Q_1786023336
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-495529a93f9so20430865e9.3
        for <virtualization@lists.linux.dev>; Thu, 06 Aug 2026 06:35:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786023336; x=1786628136;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rILtqoeBHE7LGqRbLxT9biwUTl88ABJkJnpfbIm4pB0=;
        b=huhkV184K8iqvFljXHJnwNovpx8zilD6EICcmmQvKltY+mmgNfQx0BNpL7nNlWjCaw
         VAtEn3mnCJLp2nvT/fNA/1GhVlUmRwQfMQFrxGQU5eYGuMSM5XHinWDcKBAKd4UVmyJd
         eFzQjgeRzn8sRPrVEC+Lx/DvtpCNNoqRp+1Ygn1CUgxgKGpn9TgbMBgOUxbT+Uxfo562
         zrscVdZIsjfXKrHr58PRcyd9e5TE9I5OL+TWOjuJbBHYswwf+/wOnRejfyoBuWA+N4Cl
         1TeaZRHlSid+ezGjtvEQd5NFf/H2d/GaT8iKch2fKvMUkkXAzqzg+CsW5q4H6RnqNfF/
         fVGg==
X-Forwarded-Encrypted: i=1; AHgh+RrGlw1E2MMVDmiPT7l811UTxt/D7pwBJEiXerc3GspMfPZpOzNIOIBMVCWmjA1lVGjjdml//E5YPzUiTBiIfw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yya7CsdI7OiOOq3gjcIN0c3IG6Xq22Z11ssZPB4fCbOrJT+iWIk
	JQ8lmgFIedWfWvgLE609dIdRywkKZ8UrVIjwv6ZtM3LZllIUde2IxTZyopCaQzzuGM55u6vJ66r
	a4Ni0JFXe3i0l21Wi+1nb8cR54dOfsWCI3Qkz468KStxzJ9yzHKUsnRUquYRdoYF3wiP7
X-Gm-Gg: AR+sD10NxU/Gmsn5k9NoxvNiNng/Saq9ckcec9b88LYkyVY9Anj9HHld517DoHd2NP9
	jEighkUIhTOzXnx7h1dlf0q5gumTXhr7FG0s3+xGgghUp/UzjY0mYFtZZFjPSNc7vMS7x6mHIRv
	3y/DK3sLwBQ3rA4QhEsVaAuN8PnaJtCWmoPMOAfl4RhhvGjHP/2MoibZoeFwK+7h/Hu5L/oOv/o
	u5KMWMvTJeZaJTznsfRJTJPeKvEBfiJvThmbXbd5YIOMPNJxb93fR4k/tuSUWRAVraA7EF+IWo6
	6C2GW7EXvdKx4jAwCvpWTjlNcMCb9NysnQBpX2stzzrpQ4plBlYoprz/nGzrXPGXiJ8GE8CUNwW
	nbXw=
X-Received: by 2002:a05:600c:8485:b0:493:e974:41ac with SMTP id 5b1f17b1804b1-4994e7d646cmr224933995e9.16.1786023335696;
        Thu, 06 Aug 2026 06:35:35 -0700 (PDT)
X-Received: by 2002:a05:600c:8485:b0:493:e974:41ac with SMTP id 5b1f17b1804b1-4994e7d646cmr224932915e9.16.1786023335225;
        Thu, 06 Aug 2026 06:35:35 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.117.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49954228a47sm95181535e9.12.2026.08.06.06.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 06:35:34 -0700 (PDT)
Date: Thu, 6 Aug 2026 15:35:27 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	jasowangio@gmail.com, eperezma@redhat.com
Subject: Re: [PATCH] vhost: clear vq->worker under vq->mutex when freeing
 workers
Message-ID: <anSMBpQJ8x-vXYy2@sgarzare-redhat>
References: <20260723153310.745855-1-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260723153310.745855-1-andrey.drobyshev@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4DmN0It7tupaH4M2lteZRZxmUdaOuAd2qwd2zVEq4zc_1786023336
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Jul 23, 2026 at 06:33:10PM +0300, Andrey Drobyshev wrote:
>Every other update of vq->worker is done under vq->mutex - the worker
>attach/swap ioctls and vhost_worker_killed().  vhost_workers_free() is
>the sole exception: it clears vq->worker without holding the lock.

mmm, vhost_dev_cleanup() updates vq->worker without the mutex too IIUC.

>
>The effect is harmless in practice, as this only happens while the
>owning process (and thus the whole device) is dying, but the lockless
>write is inconsistent with the rest of the code.  Clear vq->worker under
>vq->mutex, like everyone else, so that all writers of vq->worker follow
>the same locking rule.
>
>This issue was found by Sashiko AI review.

Can you share a link to the review?

I don't know if it's common or not, but having the link in the commit or 
after --- will help the reviewers.

>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
> drivers/vhost/vhost.c | 10 ++++++++--
> 1 file changed, 8 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 4c525b3e16ea..dbb6cb5eccea 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -722,13 +722,19 @@ static void vhost_worker_destroy(struct vhost_dev *dev,
> static void vhost_workers_free(struct vhost_dev *dev)
> {
> 	struct vhost_worker *worker;
>+	struct vhost_virtqueue *vq;
> 	unsigned long i;
>
> 	if (!dev->use_worker)
> 		return;
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

Pre-existing, but IIUC vhost_workers_free() is called only by 
vhost_dev_cleanup() at the bottom, after a loop calls vhost_vq_reset() 
on each virtqueue (without the mutex) where we already set `vq->worker` 
to NULL, so IMO at this point it's already NULL, no?

Thanks,
Stefano

> 	/*
> 	 * Free the default worker we created and cleanup workers userspace
> 	 * created but couldn't clean up (it forgot or crashed).
>-- 
>2.47.1
>

