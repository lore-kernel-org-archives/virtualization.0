Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47CE3BCD2E
	for <virtualization@lists.linux.dev>; Mon, 17 Aug 2026 08:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786954122; cv=pass; b=AlHogIiBNjAZi6jMuOUKw2hR6wkNP7FP48T7z5UgZA/hQjDPFMukK7n8pDcgKgqU8R1br4MDBhHgT7WYONICRwD+zcEMHN+BUTq8Jf1690pdlQMxUXjOkBj9g1Taexkf1s6UziQXbGJgC4NU2wmnU3c4n+VM4EXALtubS11Ki70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786954122; c=relaxed/simple;
	bh=jlHk602IzD49KATS7pfkgJoqej7MicT5d5fLp7NdNRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h/8u3yjnzy3EcRKWZE8oQZT1qlE4dWjoxvVLdoLvgCUy5rL6DKKUW3zwUeO9yNRTEnw07hrPEHNrb887wWoDUa+lT6j6VWNkheIxACq7Y0V/HsJJY9RKc111+nRFI2qByUrDhgY3nbTRSMJoiyZk/YSFSvp+Iy5VLGG+WS0MDkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lDJ8z3Mp; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lDJ8z3Mp"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b3119957f0so2783788e87.1
        for <virtualization@lists.linux.dev>; Mon, 17 Aug 2026 01:08:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786954119; cv=none;
        d=google.com; s=arc-20260327;
        b=aCbGmBiX5sZ2gLqkQwbCNxDCYVLRENvyDXVAOYH8N53v5lSbMofRvg4uOyyJRdjfbZ
         oSLs0B9oJmCIjf/VdPm0LLNROgeMcajTAgpw4lDEr7Ne9wPzZ0uj4AH/nexC6twZH0+V
         D6/CR0DcrsL5s+j0TaigLHDRjUML9mzSXEw8lLxYe4Kze2QCHcwPQHTDqVKptxDym0I+
         vWT/YrTClqyC2ZQxXNkFFYqazrCdd4OHVCjzY8CqOG4/KpdOkHX1nMv84voMY+FcFidg
         WWsP26MaHAHrOmghEcCK9JzhPqv+p6lXkMGb/WlzgSTnyKIm8A7j1Fed1TaXb6b1Ivzn
         5MWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Zq5NcBW4r+uAp2cc7Gehb73xyshGtyDG5pRXGUBZHc4=;
        fh=4F54DKZTFfhIkYpnsmmOzPHY0KdINAUPoKRjFVnznCA=;
        b=ST3Wd4dAlxDqKC0Czo+fMdoSozWLJBlKqb1ZdYH25/y3HMTM6C2SRDuSNjr7dUl2UO
         VNjDPQfRsf5Won5VR/Ztw+EUobUiWckE/Msv9hxIZlohjgV5kRajkLqGS9LZx/JX0U2B
         Hs2hXbYAo6nIPL3ErvhIpt60DIp8LTyjHB5fyNp0nvT67YhCOxySYk71YWhXocGOPSOl
         CbYVIMwPqQ+g0TT6rYnH35xr2sd7W3Eaiu/Qd2btGd7QRIz70GyAAqnB457LIndJfShP
         BWJ8w/01Tv1d4CS01ToLcbjwNbJncJr5ixL4oVAFdAdFbCg2bQ4Kgp3NaNLfB+brkgSD
         VvUg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786954119; x=1787558919; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zq5NcBW4r+uAp2cc7Gehb73xyshGtyDG5pRXGUBZHc4=;
        b=lDJ8z3Mpegujclp1f0Or6YVpbzRYWxIZtre8sQv8xIsfQAQWuKigBse+SZJWrjCAf/
         SYfu6IGt31KPkLkLVt/n/Whewkhz9A+iEVCajkrw5VvovT3p27WRfledSr5ZE1nWOwLB
         f2jsxFBxXiBfaHjo4tkb4VmquRvHWHQUKX6aMfQ7QXgSG6dqa+sacR3gcPQ5wAmg9OGR
         aRGuNLj0epx7Q3SQL1XJf9dqXVSNqHn1xdZERWujuV0mCnufC9Md6RBHC51CKSMoHOij
         qx7aIBi2Qxeymdvv0C5hW0K0KftjUdfWRMsRKaS5rbWpdgsdsbXOntct1BiKIrQBk5Z8
         k5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786954119; x=1787558919;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Zq5NcBW4r+uAp2cc7Gehb73xyshGtyDG5pRXGUBZHc4=;
        b=je7OP6LgdZ+txqV3g5a8oRou7o3sns5dvmrAnIOkhP9G35yDFK+J89MN7LIHPrLrFm
         /1FWS4VjWTLM3XeU2qeyKN+hTHNAyr9jVEJNtPBmq8KBLzHO76PS4vCVqlUQPwUeWSDu
         zom7jYXFMH5igS3RkXdDQklaQGLdE6JCykKUDKVL8NFZLNucZiccXuOFRhfrZ8A/AmwU
         AnE6B9Ul7X3V1auMir5jxPNhHfLtdVbsfrwdWIF5rf+3toaDgRDazpk/owWDfXoV9iY7
         GyE4pUJff93VOLqHZCd24FHBSPepmDr940nfQGxMuic4V3gU72NtqWasLoUGH3rMVh/W
         2V9A==
X-Gm-Message-State: AOJu0YwW327oCb4fEkbzbVqnnhmo3Q6nE4h/wh9nrBw/8hNb9oQG3EqB
	lG5q4GUXOQ10Oz3GjbWsHAILUYHwBx7JjKobxny7M4PyVTaBIxBPSZRSqoR9ezNsrWwgfIRpXe1
	50D38wsSRmTq9iqm75IHCCUfbSjgoyzU8JNgASyqS
X-Gm-Gg: AR+sD11t38jCJ9dX1nB84qM25G7CHt+VooyJsNCmFWTyP1lPhjQpIzILJj2e4ddwffw
	vhL6FgDgoNmmFSP6G2iiW4td1bEgBtxsxhaghXFkxT3zZMOSq8PTFxHip8Ps/E8gqGo7jAATF2p
	BBmXCfb577WvGzAkaZ8gMiX+BiG+Ofrgl0/wJtC2MQTVoEw5gSEvvVoQSaIYTkgXtRmg9pQopOW
	vFLW0+44p+Li6cUlQlbVKdKlHX5d6nW2J9uCSyT75OGJHlxqOZfASxNUWOecLOuOlZurPW6DWq7
	1Cru5A25i00xGJ5+y+B4pOu0Jg7yTlQxtF/clUH3wG+87S+q/PTREk6zAUjf9/3jbgmeVrLMgrY
	=
X-Received: by 2002:ac2:4f12:0:b0:5b2:f211:130e with SMTP id
 2adb3069b0e04-5b45916acaamr2877358e87.37.1786954118585; Mon, 17 Aug 2026
 01:08:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260814105954.4060627-1-sergiiushakov@google.com> <aoK8fF27_nu1ux9s@infradead.org>
In-Reply-To: <aoK8fF27_nu1ux9s@infradead.org>
From: Sergii Ushakov <sergiiushakov@google.com>
Date: Mon, 17 Aug 2026 10:08:21 +0200
X-Gm-Features: AcwNN1XAoP3oHuAeEAegVjZNw955sF8O13C8o6CZZQS_gl28GbEoZXh-QgGOtlA
Message-ID: <CADhvd_MfDwX=Ebwt3XQJrzYkvACGCdAq1VYT585Bv2v37Zu2rg@mail.gmail.com>
Subject: Re: [PATCH] virtio-blk: clamp max_segments when indirect descriptors
 are disabled
To: Christoph Hellwig <hch@infradead.org>
Cc: virtualization@lists.linux.dev, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Aug 2026 at 09:47, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Aug 14, 2026 at 12:59:54PM +0200, Sergii Ushakov wrote:
> > When VIRTIO_RING_F_INDIRECT_DESC is not negotiated by the host, every
> > scatter-gather segment in a request must consume a physical slot in
> > the virtqueue ring.
> >
> > If the host does not advertise VIRTIO_BLK_F_SEG_MAX and provides a small
> > virtqueue (e.g. 128 descriptors on QNX Hypervisor), the block layer
> > defaults max_segments to BLK_MAX_SEGMENTS (1024). When a multi-page
> > compound bio arrives from the page cache, virtqueue_add_split() rejects
> > the request with -ENOSPC and triggers:
> >
> >   WARNING: at drivers/virtio/virtio_ring.c:1493 virtqueue_add+...
> >   WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->indirect);
> >
> > This permanently wedges the blk-mq queue and blocks all subsequent disk
> > I/O in uninterruptible sleep (D state).
> >
> > Add a virtio_blk.max_segments module parameter to allow runtime cmdline
> > overrides, and automatically clamp sg_elems to
> > (virtqueue_get_vring_size - 2) when indirect descriptors are disabled.
>
> What is the reason for the override?

The module parameter was intended for two main reasons:
1. A safety fallback for non-compliant/buggy hypervisors that may have
   internal segment limits lower than the advertised ring size without
   advertising VIRTIO_BLK_F_SEG_MAX.
2. Debugging and performance benchmarking of smaller scatter-gather lists
   without needing kernel rebuilds.
That said, the automatic clamping to (vring_size - 2) resolves the
hang and panic out-of-the-box. If the preference is to avoid adding a new
module parameter, we may drop it and keep only the automatic
clamping.
