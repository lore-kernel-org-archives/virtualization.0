Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BB6407597
	for <virtualization@lists.linux.dev>; Thu, 30 Jul 2026 14:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785422942; cv=none; b=sQ7U5chlHfJHyCmA2Yqv/xGgmjsroo59CaV61fom5nTs6xxAX+95nQFSjAxLcE8j0rxrV7FpHxgF9eBKNPX6im9B0W4fZAxjIo1KIHqIBFojVfJ/hbdUjQEsVIUSgiXdPHbU8ivf7WVYJwJRT7GOja5vorWAhzU8bUppLveZIxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785422942; c=relaxed/simple;
	bh=xT+59zrSNXgZSX292AF0H2w7CA1Unv3yXaYCM8QYlXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=KHezyjQUOLwAeT5oepVHnRKDsWOucrAvaSEU/s7JJh1fyg4V6pCnQjyTyfPPooJGWdSZa+f3hCqIABwD13fLIpvkRO4pZSIAaQtd431JNzqUnebG7hcf9zRB15xIW90uyA0hBRvCYmGNHa76bXmj6U0lkuDvMiMTQKqwy35ZwoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WDPQsKK2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WDPQsKK2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785422938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=icEaXTibKrUroRnU8otVcNfABM2uS6NaLhn91NMFBqw=;
	b=WDPQsKK2LeKdPU2iKUJDXXb0BSQaoFX2hRc/DnX4+cN6+LeZ+c6gePg7tGGQJdDqa0+5s4
	9CsAbCGOEwpNj+D6ClHvngkbLRIlj3ZlEpXm5hPWWfcsumX71sr8BXxbixMTC+gyG4dFUZ
	SDYdrcbY05ZWPfU64XTf/GsfKLGZXPk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-hAPYrRGCPduB9yGD5ahTOg-1; Thu, 30 Jul 2026 10:48:57 -0400
X-MC-Unique: hAPYrRGCPduB9yGD5ahTOg-1
X-Mimecast-MFC-AGG-ID: hAPYrRGCPduB9yGD5ahTOg_1785422936
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49554715277so21712615e9.1
        for <virtualization@lists.linux.dev>; Thu, 30 Jul 2026 07:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785422936; x=1786027736;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=icEaXTibKrUroRnU8otVcNfABM2uS6NaLhn91NMFBqw=;
        b=Q0FeQ3DyDVeF6Odk909XCXZmAEV9sHb3EuOF+sHm5qJ+UGDi5XReGB3G5HbCowlPte
         EWmWZvUicn/VNvq6JNEzS3v9Qqf+oNPshQ8mTJSB+4WsaEV5qeysYtUKGIdSvGE1omwW
         fF0MLeTTBEH/c5dg9yag7DU/waBbLhWloy285ZZsMzIerF68fPgrpv617IIkt32euTwt
         2GmiXHZ/Ew16u2u+9Bvb0Ws9975VOGLCqpebJELdMNGgLun0aq/mnHysv2uI+sCkycH3
         BoaZsLxdKrThKrPIju8C9Gip6dC1RYrrJgsfHuEw64lGKnblFyWm1q5r7nTcnjkdwy7p
         SMXQ==
X-Forwarded-Encrypted: i=1; AHgh+RqPbfiFGRId5If6BcVrpuhIA8wwJyUpCq2gIwJ1iG6Tv4KDuGAnLFq8VoZxJRT4RupfbUvQvE8MNqpL6fSlKQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyWJeaUM/4E9HMg+KRslRNYO+Wo6jIYW2y/FvEYpsrfWX4VtnGB
	+qxCG5EPvOoLoN9yRAOHqsGc6/fxVa28Y5+tqOKGpeBOC1k7VpSLEiFrveHtWcL7y6XWk3+8BJG
	5qEESoIaPj6CImhvcLBglBhqA+UXw8iYFr73qgBDgtO3tgvxT+FYtEogZmC0pcBlXTbuN
X-Gm-Gg: AR+sD11Qbdi4sMiyAj3BHa9jnAWCejKGStuCpK3CN6AtPYF0yxznnpunMOZOsIbsxqa
	5WRi48xRP853lSJXAiEboN4GbtnFyciH71RZe2dGil87lJAtExQX2tnPTOcGfUaf+LJ8sz78w6h
	tRSfXyh15LVrQR1Pzwv43VVz708EKLwmKHKw7/ZZFARtYe1n3QF/Bz5vAzhPuqX/1H94fnQN4Qs
	i3blryRtLDbcCo9NSploCYDa/btLdgnthUKnjNlY6/TIVJZEeWKy+0nR2j3an65uq4ehgJYR7SO
	Hiy79WewEqXad3V7VrIYw4gnytDX/1DC67+bsVnVDVTxokXhg1sNH/MQhXlxOH/iCWa+rZA8Dgu
	/j6o3VQ6oPR+YBp36FZAQEro=
X-Received: by 2002:a05:600c:e557:10b0:493:f140:c3fb with SMTP id 5b1f17b1804b1-49800e898e4mr29774775e9.7.1785422935597;
        Thu, 30 Jul 2026 07:48:55 -0700 (PDT)
X-Received: by 2002:a05:600c:e557:10b0:493:f140:c3fb with SMTP id 5b1f17b1804b1-49800e898e4mr29774385e9.7.1785422935051;
        Thu, 30 Jul 2026 07:48:55 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-498011fd5fesm60785515e9.7.2026.07.30.07.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 07:48:54 -0700 (PDT)
Date: Thu, 30 Jul 2026 10:48:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Jia Jia <physicalmtea@gmail.com>, sgarzare@redhat.com,
	jasowang@gmail.com, eperezma@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost/vsock: prevent stale IOTLB after ACCESS_PLATFORM
 changes
Message-ID: <20260730104811-mutt-send-email-mst@kernel.org>
References: <20260730040938.1725757-1-physicalmtea@gmail.com>
 <20260730135508.GC1442692@fedora>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260730135508.GC1442692@fedora>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4pS6_UN_vgDcqYFdplUlwfkV-JUL2D6ZGc4v0Hn5wrk_1785422936
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 30, 2026 at 09:55:08AM -0400, Stefan Hajnoczi wrote:
> On Thu, Jul 30, 2026 at 12:09:38PM +0800, Jia Jia wrote:
> > vhost_vsock_set_features() initializes dev->iotlb when
> > VIRTIO_F_ACCESS_PLATFORM is enabled. It does not remove that IOTLB
> > when the feature is later cleared. The virtqueue still points at the
> > old IOTLB, and vhost_vsock_handle_tx_kick() passes descriptors to
> > vhost_get_vq_desc(), which translates them through that mapping.
> > 
> > A userspace backend can enable ACCESS_PLATFORM, install an IOTLB entry
> > for a payload GPA, start the device, clear ACCESS_PLATFORM, replace the
> > memory table, and reuse the old HVA before submitting the same GPA
> > again. The feature state then says direct memory access is in use
> > while the TX path still uses the old IOTLB HVA.
> > 
> > Reject clearing ACCESS_PLATFORM while the device IOTLB exists. Also
> > keep the existing IOTLB when a feature update leaves ACCESS_PLATFORM
> > enabled; VHOST_SET_FEATURES is used for runtime log updates and must
> > not discard the current translations by allocating an empty IOTLB.
> > 
> > Fixes: e13a6915a03f ("vhost/vsock: add IOTLB API support")
> > Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> > ---
> >  drivers/vhost/vsock.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> > index ae01457ea2cd..57e8fd1eb670 100644
> > --- a/drivers/vhost/vsock.c
> > +++ b/drivers/vhost/vsock.c
> > @@ -798,6 +798,7 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
> >  static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
> >  {
> >  	struct vhost_virtqueue *vq;
> > +	int ret = -EFAULT;
> >  	int i;
> >  
> >  	if (features & ~VHOST_VSOCK_FEATURES)
> > @@ -809,7 +810,14 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
> >  		goto err;
> >  	}
> >  
> > -	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
> > +	if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) &&
> > +	    vsock->dev.iotlb) {
> > +		ret = -EBUSY;
> > +		goto err;
> > +	}
> 
> This prevents one problem but there are still other issues with how
> feature bit negotiation and the IOTLB are implemented:
> 
> 1. VIRTIO_F_ACCESS_PLATFORM is defined by the VIRTIO spec and must not
>    be change after feature bit negotiation. Please reject all feature
>    bit updates except VHOST_F_LOG_ALL to comply with the VIRTIO spec and
>    eliminate potential bugs in drivers/vhost/vsock.c.

Unfortunately, vhost does not expose the feature negotiation to the
kernel.


> 2. When the device is reset, the iotlb cannot be left initialized
>    because there is no guarantee that VIRTIO_F_ACCESS_PLATFORM will be
>    negotiated again.
> 
> > +	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) &&
> > +	    !vsock->dev.iotlb) {
> >  		if (vhost_init_device_iotlb(&vsock->dev))
> >  			goto err;
> >  	}
> > @@ -827,7 +835,7 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
> >  
> >  err:
> >  	mutex_unlock(&vsock->dev.mutex);
> > -	return -EFAULT;
> > +	return ret;
> >  }
> >  
> >  static long vhost_vsock_dev_ioctl(struct file *f, unsigned int ioctl,
> > -- 
> > 2.34.1
> > 


