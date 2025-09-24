Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80F027FB26
	for <virtualization@lists.linux.dev>; Wed, 24 Sep 2025 07:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758699731; cv=none; b=RZnkOcwIKrHFHuqgJANgshIe2SNrf8IQtmtLc0w06084pPIKcN0HD97Ocd0HTWY8GoJ6tioRurP62NpN1gOw6KvkdRVuQiRgAFYjKIweoeHcv2Iqpfts0KfBANb3GiHMCyrWSc+/pm9eDJNks9rgzhWlz7WWuRkDmqMtzJThwq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758699731; c=relaxed/simple;
	bh=s22C2XkvtqXbgWCggQzklD/42otLP53lpOCy5Alg7+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=PZBWJPjIan3/85AeUFFtqxDyY3AQyYem5ZRbzSmqOYpI8BP4zMNPy2HxH7wun1gsAX6RDKGHgjTqYelAJqWqgV41Nwop5ERspX+UjEOP4KYBSdTnsQ3k8rfgIHI711qDx+zXz1VQmw1WbOzUF9ofBImyU+FzAUH7nwFDgFa5B0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eodvDCe3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eodvDCe3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758699728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8iP4CgsS/C0dxL3gWclMrWG9rP/QiQu1MTT4mBV3Urc=;
	b=eodvDCe3wQLHNVbgp2a0Qm8VGCvVUSto7LSBq3jhrNf5MgvyLnWwAYyNDOdK7SDqRJDqu2
	l1Mku4Jw/L3PMiLqV8xV3etxd5Oti80X1UfIhdQIFLIFBOjUIZ37ePPqGTRn86FnsV83ql
	bKE/+23tAopzBg0RmUVTDjZcq+6ywEY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-_GiXzHrON6iDqRWojlY4hg-1; Wed, 24 Sep 2025 03:42:01 -0400
X-MC-Unique: _GiXzHrON6iDqRWojlY4hg-1
X-Mimecast-MFC-AGG-ID: _GiXzHrON6iDqRWojlY4hg_1758699720
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45de07b831dso45741875e9.1
        for <virtualization@lists.linux.dev>; Wed, 24 Sep 2025 00:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758699720; x=1759304520;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8iP4CgsS/C0dxL3gWclMrWG9rP/QiQu1MTT4mBV3Urc=;
        b=Pj9pbOb5Ck5viarFjww5bT2NqbjhFCg59ipFoy82Qkm8iQUQo1Kizc06TaP7tsY31K
         5G2CziJ2KcMeaTgOBWiJoZHPB5WuzS4VQXz1KWMjug5/JtJDj10BDnq6bfY6gGx2jE3o
         W44MoLBE+hjRt4FFeosmszTf7JUpLTliJWFiWZAtWnUVIZU3hki5cY4fN/1q8hdsLjDU
         +5mcoHdRkzA4LiGLucKgaoqByNA58balYnUZqPWM0kcm1jv4r9QLjonjMPaCvEgHTrre
         n+dEk8J18oW0pmi+CX5Mzro1OLo7kuySk40tN1+e0g+Js4uV25fJFyVkIba3cmohcWgE
         PZsg==
X-Forwarded-Encrypted: i=1; AJvYcCWTONsKpp5mOxUPJz2B8w+gZ65O6Qjf00QJtlhffkfMcwimTfDwTdCfc26K7tA0UaOclP5CTFhJJBqE9mkYmg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz7Pn+ku4s+tq2VEfdhoeOCj5yDU1jEhrEG/YXMRfOKNYPkeezW
	TGDFU1q6ceFMFE+w0p4YrPyDTCidrATy2a1Y5NMkAnoXemwPEYsQOvaKkprp5jGAYke7/S7UGr0
	RN2xkOjcuUKcSbmPoVigmxeSaFfFYDNdAWJBFO1c8Vyon+U90KuatGjLnUuWCDGmYjiPX
X-Gm-Gg: ASbGncsS15RImOmcYgxiLhQuy2M1PFuds/HMy6p1oN7vsF/58B9XjdGtDAtrPOP5+/b
	j9PQlk2vIqUFKDp/dVKW5/D2g9AfXPlAOJCwB2GIj9a23GaYH6b/XKOHudUtd/ndQwR+8DWoUSM
	p8Lk6ZY2GR8VE4pm3/MezF3/q2lfw8d5/tvXKlTGlnHru38lYUG5gmJ5Dswk2jDZOVkDYrQvYpb
	1hb1j/hU8KzK+ekDUK3ycNH6fR39Rh+Wt9oqJqqSVEv31ENklBgBSEMSPoWPWlrJiqwHi1YRjUJ
	yvgwP3GNL14+oGmQrbCPD68kpD1yOJjLtHU=
X-Received: by 2002:a05:600c:3547:b0:46e:1d8d:cfa2 with SMTP id 5b1f17b1804b1-46e1dacf6edmr50676315e9.20.1758699720375;
        Wed, 24 Sep 2025 00:42:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBaH8Qcz+geVHLVmG1y55L66i7iUAa9TF2rE/T5FQj6JWkFbMfTzOEnJtYBSrJWjTl6QSAhw==
X-Received: by 2002:a05:600c:3547:b0:46e:1d8d:cfa2 with SMTP id 5b1f17b1804b1-46e1dacf6edmr50676015e9.20.1758699719977;
        Wed, 24 Sep 2025 00:41:59 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40bd194c0bdsm1287994f8f.61.2025.09.24.00.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 00:41:59 -0700 (PDT)
Date: Wed, 24 Sep 2025 03:41:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>,
	willemdebruijn.kernel@gmail.com, eperezma@redhat.com,
	stephen@networkplumber.org, leiyang@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH net-next v5 0/8] TUN/TAP & vhost_net: netdev queue flow
 control to avoid ptr_ring tail drop
Message-ID: <20250924034112-mutt-send-email-mst@kernel.org>
References: <20250922221553.47802-1-simon.schippers@tu-dortmund.de>
 <20250924031105-mutt-send-email-mst@kernel.org>
 <CACGkMEuriTgw4+bFPiPU-1ptipt-WKvHdavM53ANwkr=iSvYYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuriTgw4+bFPiPU-1ptipt-WKvHdavM53ANwkr=iSvYYg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hG1CQ8oFKzako-oEV1RpHPGDTtW_hfSjCzIt5xiogYY_1758699720
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Sep 24, 2025 at 03:33:08PM +0800, Jason Wang wrote:
> On Wed, Sep 24, 2025 at 3:18 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Sep 23, 2025 at 12:15:45AM +0200, Simon Schippers wrote:
> > > This patch series deals with TUN, TAP and vhost_net which drop incoming
> > > SKBs whenever their internal ptr_ring buffer is full. Instead, with this
> > > patch series, the associated netdev queue is stopped before this happens.
> > > This allows the connected qdisc to function correctly as reported by [1]
> > > and improves application-layer performance, see our paper [2]. Meanwhile
> > > the theoretical performance differs only slightly:
> >
> >
> > About this whole approach.
> > What if userspace is not consuming packets?
> > Won't the watchdog warnings appear?
> > Is it safe to allow userspace to block a tx queue
> > indefinitely?
> 
> I think it's safe as it's a userspace device, there's no way to
> guarantee the userspace can process the packet in time (so no watchdog
> for TUN).
> 
> Thanks

Hmm. Anyway, I guess if we ever want to enable timeout for tun,
we can worry about it then. Does not need to block this patchset.

> >
> > --
> > MST
> >

