Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67AD37C927
	for <virtualization@lists.linux.dev>; Wed, 19 Aug 2026 14:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787148594; cv=pass; b=hSUVE3RTtyZzslvU+Tft3yzVAWj5whdA0212KRVkrOsoFsz09K0MnqUNY9Xe+jRzNhRvL/9SwotOPWOOw/uUvHS1YZ4I+oHn0c0ezsNw674CCguKMnB5E6QfhupPYR6jaqKUK0hqhF7sWYATkTaxuyH08tDveNyCRDhuWxrLV84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787148594; c=relaxed/simple;
	bh=mQJhKOEjw9O3sNOjoGU+M3F8LtVcSFzmDVvu0spcCd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hR4yCuSeQv+u53no6+Z60jCPcwrhRe3xy1vEq4YPGd3/2mSo4O3J3oug2IKh17+wSnkMsOq9QK+W4ybuB96oHVWLKw7SMczGFdMK4Xdnh3NFu4AK5iWyF/+PJL2qsaULNgdUVXCSEE5laR/e9oEzAyoCY3AaavMQSVfqYTJV7SE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSlRU/rn; arc=pass smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSlRU/rn"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-934944f2d22so75081485a.0
        for <virtualization@lists.linux.dev>; Wed, 19 Aug 2026 07:09:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787148592; cv=none;
        d=google.com; s=arc-20260327;
        b=Mfb1mbeoX5zwKay9j+BZ6dRyt5rEaK0Mkl8KG0H7ETnz+/RBfR/NhcFNoLTE3p+/GX
         arJpfsGQ25GppttIm2KEepWcn7lerjuxeAxWLh4pEyiEExTZU0+0IeGcnJnJjkb+TVLG
         slAxkCevmh3AYLhGFcF/35d6PZ904xTvJQpXTQHcpGGjeM85T15Hbtx0sy9YE9Ixu7cM
         i7kE+j09FKJSOYTivgnGbdr+Gppzzz0SxGMqjdWQQWwOZGWbCTbiI/h4lmpFmPkMKTwS
         7IxqgeGkEQfL/v95x3K5//VeuYk++H1SedoJswuoUA882WW1Ox+k3PJT/8CH6T37/Vw6
         fI+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3K0kn1fHbJEcdZDTCVctcTgJzJz/9hoM0nwTQCh+f8E=;
        fh=JT6KGmlpdDiOdPc2wO3mxjM5XSOUXiPNpccl8xXN5+8=;
        b=qxSKXcPY3tBqBu4dxIJJiLuwx51FryOCzN47tHqmJeob7ap4RxbecnDBrtL9XZ1dCM
         a9ZGwjScVzACHi56pgSVo+XJljHAJVGmX3dl3fIxjTXraeWPlnOLHH63GxkaK6V5+0uW
         EeqnRpavFVdOVi3Q+jhzKJAWbu0QLkvhGY/WlGughu0Cm9XGglxrVb7WCt+dQJb2gyvw
         mW9aNISrkD96SrUqwtItD7Nx4u/JrMq8Q91L+QtihrqcTs1QhDHVislXn7VlHJEj1C6+
         NMPveQP7m1UiDUNoSEuZuHkBh66lTh6yop1ARmx4tNvFgoeZSVKFgufKN32gF2keQbic
         YKaw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787148592; x=1787753392; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3K0kn1fHbJEcdZDTCVctcTgJzJz/9hoM0nwTQCh+f8E=;
        b=KSlRU/rnPzX5DfvQSN/HROfljjl1s+7JHEhZ32LhOq67C9i0Vi1udKCURtdesh/vkH
         FjE8Gzv93K7X19p7DXVnH5VzcF+CW/FHMMOJahoZNwaM5VzE6IB0/gbZtrYD8fv5q/xk
         oN5gQkefL/9u5CNkdCda/N7q7HUCMz/wxdaJLSHrvN6rX4iX6G7ptJwKRoHxTrLoHyrf
         /anLed5aT5IIA6JHseLuEyY4lEgCuZ94a1I7vlyrKHGVzIqKHXATgnHz+boLIbkZ389y
         zLlli4UsvSVqvKo+R6K1YF7cyOQoiGunOya/HHMaORWz7kSpkjhOiFuOmiM/bA4kvFH/
         EPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787148592; x=1787753392;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3K0kn1fHbJEcdZDTCVctcTgJzJz/9hoM0nwTQCh+f8E=;
        b=gHRsUV5zjCi0BX0+9mN/JjynPmdMHzEUvoQ6/o6etlC62HpdBREUnTiW12EZDrKGfT
         PuS3te/64KRVOMR6LK7dd4k//8qWX/K6O03ndNXnABnKDIYRKN5S0k/P20ljKMJRTNYG
         5/T9JJHk4m8wEn9c+O1hPpWf3mL/YRmdIIJMPyBJvEnW/zw/Tj8lx5SBP+g4RicyJpum
         SZwrm4J/vWHmKjbhAOK2pEJWZwh0T+nPE0zfuj2CxZGRrELBata8WRQdmV99zrwKK+wQ
         rv1WEPKIGa9a3pspI7TVQmQRWd63Xk2BgdkVUu+z3URRC0IGXzjao8PYjmOes9F0IULB
         6HUw==
X-Forwarded-Encrypted: i=1; AHgh+Rr2AE7ItMVEcAikZpe625ewUybdFm7tKABnfKOQeesbRlS88xZYgvi6AyK9PeBbNr8ZVWiiWl22TpUw93Ydpw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxcIC1q/pAEp6dIDocD4XajDZCtCBlmEQ2Bh8yUzwI9pW9/gz3p
	yiVEFvPNOH87ViNJO4NucsYgvrWG51g67VRWMsj0lEeZ6Bb7e0bOcCq2mhkvb56aErqxbqJcGuS
	JWuwTvByYHidSr2ixzKj8XQcfIRJCs48=
X-Gm-Gg: AR+sD11X4clQAlfxCcKl7CBemfBIr8q4NJ0I5VNcuoBgi6dcBqgqvFPZOxtRMqrUSyy
	Av43xj0/OUQPVNSQgNRhvHgMwdF6JGWAJvkN5W4mwbsZ2DacFEPEfdsXZOoomZjuz9gGSmJfyVt
	G3BHeKp6ukM3+earg5r5bDTZdWDJ+nwPMSas8887LxlfLcAFPjfX1oJ+s/L+V90h0rVboogGCTt
	BG5uyHOvZXS3iBg8370afGMhHgEWKoGEL+fGAw6cqr1BijNwD2VOqLpq8Ju21DDcYvnv2wjNqQe
	gbgwpHofK/AJ7KvziZosr0d2QMBNz19WKYkwoa0Abs2I2g==
X-Received: by 2002:a05:620a:6989:b0:915:6a2b:6265 with SMTP id
 af79cd13be357-9371e67768fmr433513185a.44.1787148590518; Wed, 19 Aug 2026
 07:09:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260818042613.281125-1-physicalmtea@gmail.com>
 <20260818042613.281125-2-physicalmtea@gmail.com> <aoVkRe_BN6L_5XZn@sgarzare-redhat>
In-Reply-To: <aoVkRe_BN6L_5XZn@sgarzare-redhat>
From: Jia Jia <physicalmtea@gmail.com>
Date: Wed, 19 Aug 2026 22:09:13 +0800
X-Gm-Features: AcwNN1Wyv_sTsBQBf0-FqnHUDP5OfgUj3xn0SY-WfGW-HK_cGsBtdxAB-mDAfmg
Message-ID: <CAJwVaML_qrz3hu-7ZyFDEz2M3vAsGPnmNua35dAgn52E+jOxUw@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] vhost: invalidate vring access on IOTLB transitions
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com, 
	stefanha@redhat.com, weiyj.lk@gmail.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Tue, Aug 18, 2026 at 12:26:11PM +0800, Jia Jia wrote:
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
> >
>
> Please don't leave spaces here!
>
> >Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> >---
> > drivers/vhost/vhost.c | 53 ++++++++++++++++++++++++++++++++++++++++++-
> > drivers/vhost/vhost.h |  1 +
> > 2 files changed, 53 insertions(+), 1 deletion(-)
>
>
> This patch doesn't apply, I tried vhost tree, net tree, and master.
> On which tree is this based?
>
> Stefano
>

Thanks for checking. I confirmed that v6 was generated from an older
local linux-next snapshot with local changes on top,
so it does not apply cleanly to the current tree. Sorry for taking up
your time. I will fix this first. Thanks again.


> >
> >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >index 4c525b3e16ea..9f74537b1c1c 100644
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
> >@@ -1911,6 +1922,9 @@ int vq_meta_prefetch(struct vhost_virtqueue *vq)
> > {
> >       unsigned int num = vq->num;
> >
> >+      if (!vq->desc || !vq->avail || !vq->used)
> >+              return 0;
> >+
> >       if (!vq->iotlb)
> >               return 1;
> >
> >@@ -2270,11 +2284,48 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
> > }
> > EXPORT_SYMBOL_GPL(vhost_vring_ioctl);
> >
> >+/* Caller must hold the device mutex. */
> >+void vhost_clear_device_iotlb(struct vhost_dev *d)
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
> >       niotlb = iotlb_alloc();
> >       if (!niotlb)
> >               return -ENOMEM;
> >@@ -2287,7 +2338,7 @@ int vhost_init_device_iotlb(struct vhost_dev *d)
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
> >
>
