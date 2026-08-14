Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B351189F43
	for <virtualization@lists.linux.dev>; Fri, 14 Aug 2026 04:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786681871; cv=none; b=oUTWhkHQcPobbNWbW/MkfWThAzn+hjfFIYDg+oSlCeLd5VoYgw1iYS71u0agp6zFuvon4w5mHuEJe7dzd8xPIaS/q577BM5GQgsk8adCj3dg90LEOuOpnnBuVYpYRKnZBwSiUNUaD56H/dA3tOOy86IMoIOzJGoW5kISPHqdMjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786681871; c=relaxed/simple;
	bh=mHRHVvf60GH9AoSxXUVzVeU7W3fjsuyIMYHqU/lZpyM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RhfGJtPYzERyBhfZhTlgWkDxb12pyTkfhApOVZLGS52zpi5DyPT6TO29iipIAJHT4cOVOlSh5vC7UsfbDj63/gQJSGTEFxogehNIGOODTkpqnDFTzUzQMd5oB7vlB4IW+fxC4tpSbx1KZtsJW1Ejww3GZgM6UyMbPYcUTgMNeC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rcihHWry; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rcihHWry"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cb5b8572b70so676997a12.2
        for <virtualization@lists.linux.dev>; Thu, 13 Aug 2026 21:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786681869; x=1787286669; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZFnJtKJCWIEEeDVMRtp70GTjEuRFU7I+mzBwGLiw1QY=;
        b=rcihHWry6AUIuYES3eeZXGS/XMT5h9JNfjzI0oD0X28l1hhFwUhsSkkgLh+Msf1kfT
         cxlpBzsh0IlxUNdbxptSScCP44fzxmugFHR/7OQFK51szvHsSBFMvue+O2YPZWUbvF6w
         TpBK+gBKCK0S5w7T02VJOgr/mlv9RXgALqtKjmh/Mz0svtrfjok90p1DUhUMc7Hjc19Q
         0TpqLn81J+9pGq9PhyaNVHTw1wmZBwtTnrOG3dlGj/jnbcdlVgOSAVfRVXDt/2U7qVgX
         HF0nG83KeLs8Hc0+Q8Gf4ulHIW9XUu0+HI05vrlLvsyKBevtNgcNZEEbjCMnX7uoLj5C
         RTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786681869; x=1787286669;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZFnJtKJCWIEEeDVMRtp70GTjEuRFU7I+mzBwGLiw1QY=;
        b=N2WDrfb+nxlKwMGRvJf7VQtTZLPLZG2/uD4wQzTuy5HrLnfXkYF7ZB0u17HgOqTqBf
         msxPzKTglyg+s1m9jo7R00A7kX/G4LFiho9yfjkcNSZtJ7CHrTIbsbevX4i8X2naz9AK
         2cLjBQ2jnYNzYCMuIP5vwm2/hmk0ZCRXpfNgaMi9tO9SGLyB1zwhPfUfEUSUjTy2vDX9
         V3n7SrQ1l2Z+punYJJEX7ktBBn9a1pwrtdIFpGk4vVn1RvSzvyv1ZuNAhSTDNeqCl1wQ
         /0RM3abb8C6OxddBkK+XjNJX6OCA9vNsja8POQA8NopIiIPBIYHyYYmB+xtZe9X0XDgi
         pCyg==
X-Forwarded-Encrypted: i=1; AHgh+RoBsiQZjOBj178p+3QN2V8SFymSiSaureW4ui/Afwr/gpkTJJFeK7DLqynSb6fQOsh5iCZuqo1EPbZvp8UAdA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwOZI9CHC8GGZt1e6zXM6nYI54Ipkss05Th3CjEXa1nIoB9DqYq
	kQ+hAejp6yaR+oW8UVLlBOyFVJwhbsVP1WEbch7BdIyUsoGHa9Yc9S4P
X-Gm-Gg: AR+sD12DN4FBrVkC/N7ij77QmWDO+U8Vi5fn0+VfqRQFmA9V+yvrcrUwAiYmCatCD6/
	L1VGGELEs0WlHLIuP4pF4wDnFta7bgxxpgLNHEOfkryA4J+S5tH9oDHRRd3jnWOcJwIEgQNDeFD
	KoffMhjlo3OzM2EXVAdsXWznjrPJb7Df1Ag05dqcUzh3JdDA8q5egvPRhFtUMjyMiafeTUFoEfQ
	AorVqEnk0XXa0MJuQ1qX7cmAJg/VgxIgDZpKLnzCTXZkXkuHY8G7RQ4q3a17BlRs0+zoJNersdE
	9pT1ahc/HJranrtKEHfSiuEUnUgsptzley41fhl3QAk21CH+1cEgPrKzg2vF1wYl6yUY07mWVtc
	Fh8sZykfYJIZR/1IQRN0rKdG8DTLKa8QBkEW+aPeRQenKUxZH7FAW5KAmlHfcsAZNnggqZDB9Dq
	P2UkVo1diYmGPtf7fWsul7PXF58wfo0djnUB0SsMoENlpkBmF3LNOEhD/1lGyBv4A=
X-Received: by 2002:a05:6a21:e8b:b0:3cb:eb06:ce09 with SMTP id adf61e73a8af0-3cc71de3b98mr3091566637.25.1786681868451;
        Thu, 13 Aug 2026 21:31:08 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1413887e3e7sm4283985c88.9.2026.08.13.21.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 21:31:07 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: sgarzare@redhat.com
Cc: stefanha@redhat.com,
	mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v3 1/2] vhost/vsock: discard IOTLB when ACCESS_PLATFORM is cleared
Date: Fri, 14 Aug 2026 12:30:52 +0800
Message-Id: <20260814043052.59578-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <an2KTuUm-mZ0nnDQ@sgarzare-redhat>
References: <20260810134018.143973-1-physicalmtea@gmail.com>
 <20260810134018.143973-2-physicalmtea@gmail.com>
 <an2KTuUm-mZ0nnDQ@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> You can assing vq before the mutex_lock() and use it there too (and in
> mutex_unlock()), as we do in all other places in this file.

Sure, will do.

> I don't see anything vsock specific here. Would it be better to move
> this to vhost.c and reuse some of the functions we have there?
>
> I mean something like this (untested and may be incomplete):
>
> void vhost_clear_device_iotlb(struct vhost_dev *d)
> {
> 	struct vhost_iotlb *iotlb;
> 	int i;
>
> 	iotlb = d->iotlb;
> 	d->iotlb = NULL;
>
> 	for (i = 0; i < d->nvqs; ++i) {
> 		struct vhost_virtqueue *vq = d->vqs[i];
>
> 		mutex_lock(&vq->mutex);
> 		vq->iotlb = NULL;
> 		__vhost_vq_meta_reset(vq);
> 		mutex_unlock(&vq->mutex);
> 	}
>
> 	vhost_clear_msg(d);
> 	vhost_iotlb_free(iotlb);
> 	wake_up_interruptible_poll(&d->wait, EPOLLIN | EPOLLRDNORM);
> }
> EXPORT_SYMBOL_GPL(vhost_clear_device_iotlb);

Thanks for the detailed feedback. There has been some evolution behind
this patch. The work originally started from a vhost-scsi bug. After
Stefan Hajnoczi pointed out that vhost-net and vhost-vsock might have the
same underlying issue, the first version used a feature-change rejection
approach. The vhost-net patch from that stage is:

https://lore.kernel.org/all/20260726141158.1652386-1-physicalmtea@gmail.com/

Michael S. Tsirkin then suggested that simply rejecting the change was
not the best way to handle the IOTLB transition, and suggested discarding
the existing IOTLB instead. That led to the current vhost-vsock patch.

The vhost-net patch already preserves an existing IOTLB when
ACCESS_PLATFORM remains enabled, as in patch 2 here. For clearing
ACCESS_PLATFORM, the two versions currently use different policies:
vhost-net rejects the live change with -EBUSY, while this vhost-vsock
series accepts the change and tears down the old IOTLB. The vhost-net
patch also addresses a separate live IN_ORDER transition issue.

I initially kept the helper in vsock.c because I was unsure whether
changing the common vhost code was appropriate. Looking at the code,
however, the IOTLB teardown has no dependency on vsock- or net-specific
state. Unless there are other concerns, I will move the helper to
vhost.c in the next revision and apply the same IOTLB teardown handling
to vhost-net as well. I will keep the acked_features updates in each
backend's own loop, while retaining the vhost-net-specific checks for
IN_ORDER and other unsafe feature changes.

> TBH I don't like this mix.
>
> Why assigning acked_features inside vhost_vsock_clear_iotlb()?
>
> IMO it's confusing. I see that you're saving another loop around the
> VQs, but this code is not easy to understand IMO.
>
> I think we have 2 options:
> 1. leave the loop for acked_features and don't set it in
>    vhost_vsock_clear_iotlb() (less code touched by this patch).
>    This is also what to do if we move the clear_iotlb() function
>    in vhost.c.
> 2. change the code to have a single for loop with if block inside to
>    reset IOTLB stuff if needed. In this case maybe better to avoid the
>    function and move the entire code here.
>
> I prefer 1 with clear_iotlb() in vhost.c, but I'm not fully against 2.

Thanks for understanding that the original intent was to avoid an extra loop.
I agree that assigning acked_features in vhost_vsock_clear_iotlb() is confusing,
so I'll follow option 1 in the next version.

Thanks,
Jia
