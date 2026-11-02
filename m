Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793578971;
	b=QvSFdY+kkxXDJld3W0OQdbS/1y1WjK3Y8dm6puxsys6b4AfTdKaAJXaKlzkDOuUuXS73
	 +mNRIg9kXAPoMrWRRC+Z+GWCGFQp7UlWht3W4ISzpuLCcAQ8G6XZlVRZ1BpMvEmYNCAks
	 xtBRnB0mTOZxuhar0bpZhqIb1L1kvwYGrFsufeLjiOS9NNwMSeRV8HO1zh2bMqQPElW6C
	 LFnYD7cng3Y8Kdru+ob//sJupH8pmqQ6c3cz1DAp4et0G4g4R49wKntXRD/YpNo12bwCl
	 R7VJ+q5lw9g40PfqMOfDGUOlsutJ+3PULbqkEHnu6OVk2Cf7MUMmMxu0lxDuJREjNKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793578971;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding;
	bh=JOVQ4ASZFEh46dK4HlVqM/YOvdjeg+7exp1HRpI2jDQ=;
	b=BmCHrVKRffzFx8i+CHu+siHRsif9EalOPkOVxvHFSgK+XjvlHVjOzlyWC+U9s0uCdSFE
	 vNfJ/PcvnBz1ipM1TztNTxY+sY4cEcEeiZMRAw0aoFxSiEc9OPYjv4zH6toRUZP8D0cyZ
	 h02URkiJ/ktnSPRfQZX+AxR9JyhrNOFSff3IsW6wK3tXEZNs/MjD4gwX7P9otC4VUcRKZ
	 ezKBRa0sC1PJc1p2/1+JvxJUMn9SUHGG3zXt+CuT1pb98H1wbSKjiBKt6NSrBRSMrQZOF
	 AkUCCKKa+F1GcMbA0vPCYautFj5LS1vTf9eEohWtqiUjbd34r4E+QEVP9seTvW3Nhgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TF6OsejY;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70380606A329
	for <virtualization@lists.linux.dev>; Mon,  2 Nov 2026 00:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70380606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TF6OsejY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793578969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JOVQ4ASZFEh46dK4HlVqM/YOvdjeg+7exp1HRpI2jDQ=;
	b=TF6OsejYeFVgzLBaLUt93670nHNJLhL95l9hPYV9w28Zono1qh3YZeEKsejG8cQWK87dx9
	qyUp825C7EhkSUs9nViZilz8+giPDId4msi8vpciDkFJi07jAaKFJ7l1lHRiJjWmxzTCIb
	gLd67naZ3T2XJvQCRfrocqXY/i/u2Qs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-SIk0PCKBPCuguW_Tt0y8gw-1; Sun, 01 Nov 2026 19:22:46 -0500
X-MC-Unique: SIk0PCKBPCuguW_Tt0y8gw-1
X-Mimecast-MFC-AGG-ID: SIk0PCKBPCuguW_Tt0y8gw_1793578965
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a2063be13dso22012365e9.3
        for <virtualization@lists.linux.dev>; Sun, 01 Nov 2026 16:22:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793578965; x=1794183765;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JOVQ4ASZFEh46dK4HlVqM/YOvdjeg+7exp1HRpI2jDQ=;
        b=oK+5NskTOfSOoIq88HJB4pN7snYFnNjYj/60soUwk43qEbWkUQftVS/b+J4I9ycZ2F
         LmgaRaj+PCNIEo+mHkdR/VSVPp9t2jilpfaMJEMQl8o5uzZ+3k//waVKp0nf8WF02avF
         +3z+LOzPMiBqj0dUKPe9bzwdtCV+tBU2OlgPtTao2sk6SMJTecy4rEHjm+y+GzfX+ZYB
         AFgfk6vg6HuzzGwBlhUDxpbe5wv0aZXeye8naI0CpeGS84boFPXqAsaKPxqAsAW48HgM
         HOVh9ckPH1VWQXZmqnYuO8G77cGhZ7ULwKUnwT+A4cQkvi5Kf9eblNdpuvHlBAjUmq/c
         7pFw==
X-Forwarded-Encrypted: i=1; AKwUvBzx0PqtKjQ54+WSh4XvdE/5Bm3igU6Tr9BlcRbKuJxoZuv0wQ/Gf7oZsF3EQLhk8aH3PurVSKCwNOHbIsiB3g==@lists.linux.dev
X-Gm-Message-State: AFq9FYJs4qn5zqgrIulN6+LDTgFIwGTMkqSL72lKUNT5/VnQ0fa+zlO4
	rh9IlMApzqruCg62DBrO7wSznen3VWvhE2/RgxCkohus2meFlSnpmHFGUrj3/u9Jig23JD0b8yB
	nfLjducANDFq0ZatmQ0XUeIcNtGZVvknK6nUZhNDz1IBjPgHwImfHbi69QP4Z7zjA2e09
X-Gm-Gg: AYBFou1vPwNH5UVkaPnN11s09Dn34Hx9cOsCJhf4NOppRYCM/hV2MBfZ0CgM7Rhfhni
	3gKbd0rf4anNQQUvbDoHCyOkxSTQi0tOKdMI5BqOTsUGxqZX1GvNzKDQpPqCgxHnMgE2QtMyVHx
	rB7qWP86NMgvBQod3291FVah6crMFdmVXHNAr2jMBjXPZvWfPtBNZfUqr96is7wcfAHU2P1d6Kf
	fSAmhV8D/NxjkZInFjAccmnWqA6dwZo8KaZO10MQZCUVd26sVpRtjPMGputiy5UGUPPZjBgr8TI
	DkntGvo1Xphryw85EEnd+J33dsp33IuNIOtGVAUP1CorbVzM9me2XJS2jF2c3syWAIbvQ3mJYGN
	cxo0tGVFlVW+/82YPq9y894D5skyN5Y8VjZ+eVq3zMw==
X-Received: by 2002:a05:600c:1f87:b0:4a1:f68a:9736 with SMTP id 5b1f17b1804b1-4ac17b2be08mr197874395e9.26.1793578964604;
        Sun, 01 Nov 2026 16:22:44 -0800 (PST)
X-Received: by 2002:a05:600c:1f87:b0:4a1:f68a:9736 with SMTP id 5b1f17b1804b1-4ac17b2be08mr197874195e9.26.1793578964162;
        Sun, 01 Nov 2026 16:22:44 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1501:b100:9ea2:fd21:b361:8dab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf67aa704sm220328625e9.8.2026.11.01.16.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 16:22:43 -0800 (PST)
Date: Sun, 1 Nov 2026 19:22:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: sashiko-reviews@lists.linux.dev
Cc: Linfeng Sun <linfeng.sun.dev@gmail.com>,
	Eugenio Perez <eperezma@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v2] vhost-vdpa: initialize state before publishing cdev
Message-ID: <20261101192214-mutt-send-email-mst@kernel.org>
References: <20261011-fix-null-pointer-in-vhost_vdpa_release-v2-1-66ba929971ce@gmail.com>
 <sashiko-outbox-167170@kernel.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <sashiko-outbox-167170@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Gi_-lUAHijPdliQrHkaOW7YU8CObxvJwgBp6ZlygFAI_1793578965
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Sun, Oct 11, 2026 at 10:39:26AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] vhost_vdpa: spurious -EBUSY on open() due to uevent race during probe
> --


Linfeng do you want to address the bot review on list pls?

> commit cef3a58744e8aa0a22f86fbbe577797fa0a78e31
> Author: Linfeng Sun <linfeng.sun.dev@gmail.com>
> 
> vhost-vdpa: initialize state before publishing cdev
> 
> Initialize the completion and as hash buckets before cdev_device_add()
> makes the device accessible.
> 
> > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > index ff7d907191712..6cff1ed2004ee 100644
> > --- a/drivers/vhost/vdpa.c
> > +++ b/drivers/vhost/vdpa.c
> > @@ -1655,7 +1655,7 @@ static int vhost_vdpa_probe(struct vdpa_device *vdpa)
> >  		return minor;
> >  	}
> >  
> > -	atomic_set(&v->opened, 0);
> > +	atomic_set(&v->opened, 1);
> >  	spin_lock_init(&v->config_lock);
> >  	v->minor = minor;
> >  	v->vdpa = vdpa;
> > @@ -1678,16 +1678,17 @@ static int vhost_vdpa_probe(struct vdpa_device *vdpa)
> >  
> >  	cdev_init(&v->cdev, &vhost_vdpa_fops);
> >  	v->cdev.owner = THIS_MODULE;
> > +	init_completion(&v->completion);
> > +	for (i = 0; i < VHOST_VDPA_IOTLB_BUCKETS; i++)
> > +		INIT_HLIST_HEAD(&v->as[i]);
> >  
> >  	r = cdev_device_add(&v->cdev, &v->dev);
> >  	if (r)
> >  		goto err;
> >  
> > -	init_completion(&v->completion);
> >  	vdpa_set_drvdata(vdpa, v);
> >  
> > -	for (i = 0; i < VHOST_VDPA_IOTLB_BUCKETS; i++)
> > -		INIT_HLIST_HEAD(&v->as[i]);
> > +	atomic_set_release(&v->opened, 0);
> 
> [Severity: Medium]
> Will this cause a spurious -EBUSY for userspace orchestration tools like udev?
> 
> When cdev_device_add() registers the character device, it fires a KOBJ_ADD
> uevent. If userspace reacts immediately by calling open(), it will hit
> vhost_vdpa_open():
> 
> drivers/vhost/vdpa.c:vhost_vdpa_open() {
> 	...
> 	opened = atomic_cmpxchg(&v->opened, 0, 1);
> 	if (opened)
> 		return -EBUSY;
> 	...
> }
> 
> Since v->opened was artificially set to 1 earlier in probe, open() will be
> rejected with -EBUSY until atomic_set_release() clears it, which might
> break normal userspace orchestration that attempts to open the device right
> after the uevent.
> 
> >  
> >  	return 0;
> >
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261011-fix-null-pointer-in-vhost_vdpa_release-v2-1-66ba929971ce@gmail.com?part=1

