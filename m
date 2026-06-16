Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B00D30148C
	for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 13:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781617360; cv=none; b=bgFJ3nmVQybKSMOS8YS/vyBsnW/y01EbfYJBmBz91iMv2Ko9Oh0B5KH+2tynn9JyqMegs5hyaW/LVjAd3YncIAE3FjVtZKB93a4aMxbjHnr4Hfy+o70/22tbSm8b45L7auyqSKm1gsr3ia+l+Gqy63j0H5HD7ijX5iI9G8VeQ1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781617360; c=relaxed/simple;
	bh=tc2x14jzytwc/9908NmOW1OURlK/VDWDQ8I16o2NBns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=R5Oy1qOTxZdgfn00LSeIDG6VjeGH5i5Q1g6jNW9NwgbjvxB9RNk70TmgjXVpuFY/A6v/EQahUIO1D1oOnlxWlN1IMAwZw1W3YIVD1KPumIgjObHOWr20D1khvIrZs6u05KtLTyYxDZIt8kfInTVUDQS7dkr5mR3zzItdvsd+q+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FBG/QONm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FBG/QONm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781617358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TMMzkYgDyxgPnpqnDrhKhTR3oBCFllCmFxdRzsYDtQk=;
	b=FBG/QONmIBdC+NcdzoRv4c4YmpzTfrJVtJJDaG16yJNMUZasEXGzDG0BUL39/Kfg7BHfZ1
	PC6xyN0dGXtLeseJL28Tts9FTRT+NexBprppHJLNVM3LGYhs+PCLLR85bXFyOeoO7uarcK
	nytYXV10ms7NfCu/n+k2i4wD056a13A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-11Z7vaaZMFKNwWfMVo1EuQ-1; Tue, 16 Jun 2026 09:42:36 -0400
X-MC-Unique: 11Z7vaaZMFKNwWfMVo1EuQ-1
X-Mimecast-MFC-AGG-ID: 11Z7vaaZMFKNwWfMVo1EuQ_1781617355
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-461a5d47a8bso262261f8f.1
        for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 06:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781617355; x=1782222155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TMMzkYgDyxgPnpqnDrhKhTR3oBCFllCmFxdRzsYDtQk=;
        b=h99CbSvrgFic8BIHXOc5SYieEw1QVQad61aQoNTJgoNJcl4cKWT1VC9kUBxCgIbcXT
         RfbSZovxVzHRt0OUVLnTJvKcumiLqhrSBR2EXGF17Npm4xNn8nytDYtzz6uXyD/EQCFn
         O4Doe8sKMGCn/Fz6rcRNSAprcCHehGsSEbYQexUiu3np1COosIKLnLMDramGPQhD3tw4
         eRJOooyxTCuq3V6qbRimM8v74WYlSYW2W7YMbgDrOQcp1roJieiDIxkK21K/Lf16JSsU
         nqoB8XbIca9Ok18Vhl1dkZQ8040tJSdqPvieFQ6NE7mm0Dhs/Cg/4N1sM0ugTmr3NWI4
         cqIg==
X-Forwarded-Encrypted: i=1; AFNElJ8HNmK/QnUXnm2FuFWUjDDuGa+bwfG4iUImpfF7V4QE3kSQe59r+1Txoyin5G66fRF/luh31QZhf4y0RpfV3g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyGfiHAU27kouH4oO111oI1toGTNsmq7nXJSn7OT72i0Q18SUcz
	Do6Nsqn+BocgUcUwn0cvdEGI1c6fQmRThfciPTc4sUdWZenq3pj87w+fzX3s0XRaqVLC2N2cIbU
	0e1zNALYWcvN+EniBYZ5SvFKv3Ry0PTzv4vGrIwSTv0Pz5AywNzNUWeglob6V19uG1RO/
X-Gm-Gg: Acq92OFOdfyxPYlgM0+PLMYE5rL9LQaTqY4nDhi52tTWC1Bv5YwKKCm88XxyUwxbuAb
	jmYYlgPxhUFgSM8aIWuFi1hN0fXE0iM+0W6HyTi+pQQQqRD+Iht10ESyr/Tf3fLgg0qRQEw34xd
	Wxw7D9A8HkVqsegfIkZ7moo+94iDzhWz+fGFzm7rEzocOkLfclPy3b4MyrYYgg6F+JqRzAv6UgB
	HiOZr44nsnsJHah5liE9v71+7fem2HH9gigDwiTfjEmcgf7LvlIkeHJW3Fmh9KVzPODp/TmDR6F
	MqZYr6FVafAdvHX/j+MJhHbnhaqVrklf56Fe7oePtKiL/zz+wlMqTVibe8W8ge/GoYrDn/L8Zxv
	ocba6KRdi7vMnDpz7kQF96LhAbPVoHAbYiWDbjZpzhvTvxANTVO3xbmSIogtoF8w5uR80jjg=
X-Received: by 2002:a05:6000:40e1:b0:461:fc84:dbee with SMTP id ffacd0b85a97d-461fc84dc91mr1007010f8f.16.1781617355126;
        Tue, 16 Jun 2026 06:42:35 -0700 (PDT)
X-Received: by 2002:a05:6000:40e1:b0:461:fc84:dbee with SMTP id ffacd0b85a97d-461fc84dc91mr1006943f8f.16.1781617354664;
        Tue, 16 Jun 2026 06:42:34 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2c5266sm51242208f8f.29.2026.06.16.06.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 06:42:34 -0700 (PDT)
Date: Tue, 16 Jun 2026 15:42:31 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com, 
	ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH 1/4] vhost/vsock: split out vhost_vsock_drop_backends
 helper
Message-ID: <ajFSurS_piyfFvjM@sgarzare-redhat>
References: <20260612165718.433546-1-andrey.drobyshev@virtuozzo.com>
 <20260612165718.433546-2-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260612165718.433546-2-andrey.drobyshev@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: S4Kb9gzX7sCM0DqkVZ226a1cRc9JDb5V3pgpX4Pitwo_1781617355
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Jun 12, 2026 at 07:57:15PM +0300, Andrey Drobyshev wrote:
>From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>
>Split the actual backend dropping part from vhost_vsock_stop.  We're
>going to need it for the VHOST_RESET_OWNER implementation in the
>following patch, when vsock->dev.mutex is already taken and owner is
>checked.
>
>Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>---
> drivers/vhost/vsock.c | 26 +++++++++++++++++---------
> 1 file changed, 17 insertions(+), 9 deletions(-)

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 9aaab6bb8061..b12221ce6faf 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -664,9 +664,24 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
> 	return ret;
> }
>
>-static int vhost_vsock_stop(struct vhost_vsock *vsock, bool check_owner)
>+static void vhost_vsock_drop_backends(struct vhost_vsock *vsock)
> {
>+	struct vhost_virtqueue *vq;
> 	size_t i;
>+
>+	lockdep_assert_held(&vsock->dev.mutex);
>+
>+	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
>+		vq = &vsock->vqs[i];
>+
>+		mutex_lock(&vq->mutex);
>+		vhost_vq_set_backend(vq, NULL);
>+		mutex_unlock(&vq->mutex);
>+	}
>+}
>+
>+static int vhost_vsock_stop(struct vhost_vsock *vsock, bool check_owner)
>+{
> 	int ret = 0;
>
> 	mutex_lock(&vsock->dev.mutex);
>@@ -677,14 +692,7 @@ static int vhost_vsock_stop(struct vhost_vsock *vsock, bool check_owner)
> 			goto err;
> 	}
>
>-	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
>-		struct vhost_virtqueue *vq = &vsock->vqs[i];
>-
>-		mutex_lock(&vq->mutex);
>-		vhost_vq_set_backend(vq, NULL);
>-		mutex_unlock(&vq->mutex);
>-	}
>-
>+	vhost_vsock_drop_backends(vsock);
> err:
> 	mutex_unlock(&vsock->dev.mutex);
> 	return ret;
>-- 
>2.47.1
>

