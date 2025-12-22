Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C36D344039
	for <virtualization@lists.linux.dev>; Mon, 22 Dec 2025 10:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766399318; cv=none; b=tbAvcxj7ZSj037YNFTFYj/+RDE8zyc+/3En7B24aEf5J5536mt280G3DBTe+ffp6izrBGxdo05uwF4DeZCA7sN6GXhSr4m2RHupYnRHJXL2Y8c+S+PPW+dzN+ps/JMbfZsifmktZOsfXK5G5xFk7T+2g8BiiHsPPX/MXNhwJU1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766399318; c=relaxed/simple;
	bh=RYOEo0QqalYM5sZEidpnueLx5OzS3SsLz0gk5/eXQzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ChgsBl7CSHRBMJZLzMU2hXQ2amRV9/dCpR8Bi/El4/ToDxXmvX1s6bnYc0FchscMKiJVHK/yZxms/dWiN+DGhTz5efC+8Awqb3a2DMH1gUVIUd4acNECBfMmQ/rRcGtPTqon8EnT/rwvyD1tpj9Nzg+uRFHimxKtciz3uIR4pNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z603nUPo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z603nUPo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766399316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Lzh3ktOcpcWXyP4/rbK2pYjL3xRmfQliLNZbOIIRak=;
	b=Z603nUPophRt4t5F8ozOQcgE09EdTCcGyqPzzSGZzyPzQS7NXeM7WzcOP3dhY3hZstuksB
	ffOV7Ov26vcovg9R4Wvb/aql4dSc1su1rCIC0rJZhFf8UlG93fNYDPWVyLlduZJRuNrQtD
	Avob7yBri4NnWFmPBSPntbh+XZw+iiQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-kgLd1m93PZ2WlkiMmJqnyA-1; Mon, 22 Dec 2025 05:28:35 -0500
X-MC-Unique: kgLd1m93PZ2WlkiMmJqnyA-1
X-Mimecast-MFC-AGG-ID: kgLd1m93PZ2WlkiMmJqnyA_1766399314
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-430f5dcd4d3so2067489f8f.1
        for <virtualization@lists.linux.dev>; Mon, 22 Dec 2025 02:28:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766399314; x=1767004114;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Lzh3ktOcpcWXyP4/rbK2pYjL3xRmfQliLNZbOIIRak=;
        b=uzUP4umXq/42nINjh9iyVOdE8i6U/WIDk3zyumBYRKcjNQFdsEZQfbDGtkgkmhX51+
         SBcZ8VOQV0GnJ/CDvDX7Ifa5XjFst/dN/DcbGmR+EJkzBnHT2VsL7OLMbIG9hqNpXXgo
         fxLak6O+VeMDVh0aO+FlK+tSmiDmePUOwqQ92dlyZF5gF3VTXNZloL/J70GUxN257mBV
         NuhFQhJnRfs7d1fREQWToTrCxYA1ObZaScnSuIwxsEXlbuxxWIQo1IQv+R/yTDRegc9L
         N50z5yOAKe6JmQ/sk57Bp/VDv/EzeVnGGcfSD8/xrFLI1G0TTfLRk3KF1OogjnFd5u4W
         oE3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXzC+Z4RQh2crqK40THBaS06wOONwSb8QUz3jPd0Vu+aL84HBbXL56s72UPTb0M2Sb7gMp0bvTsc03LdOmVvg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzgz+aWnS5+UfMURe1YZ5JFQB5ZHYRj879kpFlxXBRTA0yD8FPX
	Sgph13b6SA2vOAqnpAfXb0n7w1F24isLXF1tgtUTrH7DGPpLXx1JMdDIlSNs9lcDSCdCIYJEOu2
	4+A9qfDjOCcL1TacbkSl5o2IBPMJ9rTGCf+8dnSeohvkK2M0VkhQ255yclkZRKmBtnjDk
X-Gm-Gg: AY/fxX6KOJP6u5nB6/pIEflQA+MbAqt06UDufyuWkCQCKPInYWVXfgs0740lpoq5m+U
	rBV52/OjB7/GuILIKbeNfaTHHc0LyuJCQmaRXzKD9NJvyzFtDG9UrZqoQ85fYHDICszqhK4IW0j
	LPLJzbH6REcgBwh1ku/GV150jvWuZtsCvGncJ0bvyZGfFpv8Kp58nspYZMT0JsD3FbhR3PdZb9E
	3qYp5XxkVEoMYkiNgGdWesXtuFc0RupoHbzFPufWxgOIm6VjtKg4z4EeC6dLG2X6CJGb6KYjiOV
	cTV36dxSYbt2NVXeLee/f7bt3JFP0vPSP8qePhZG5pWp2jgVnjWRZAmvbU4eDy0MsrTw2v+5bjE
	/oyBbUIpGJrbF+LJCT8PgmbjDs9+4zV4p6g==
X-Received: by 2002:a05:6000:3113:b0:430:fbce:458a with SMTP id ffacd0b85a97d-432448b7f11mr15254367f8f.18.1766399313796;
        Mon, 22 Dec 2025 02:28:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/V6eOZjMGJS25s11w/k2yUY/3pVUksIOZTn40lX4MWRDR19KCI5R6E8otHzEhlJPmyE+p3g==
X-Received: by 2002:a05:6000:3113:b0:430:fbce:458a with SMTP id ffacd0b85a97d-432448b7f11mr15254345f8f.18.1766399313333;
        Mon, 22 Dec 2025 02:28:33 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa2bdfsm21572830f8f.32.2025.12.22.02.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 02:28:32 -0800 (PST)
Date: Mon, 22 Dec 2025 05:28:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] virtio: uapi: avoid usage of libc types
Message-ID: <20251222052818-mutt-send-email-mst@kernel.org>
References: <20251222-uapi-virtio-v1-1-29390f87bcad@linutronix.de>
 <20251222033807-mutt-send-email-mst@kernel.org>
 <20251222111044-611cdccb-327c-4ed8-a75b-1a65aa353802@linutronix.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251222111044-611cdccb-327c-4ed8-a75b-1a65aa353802@linutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: B9HIVv232Qun5bYhOiGH_QBXozgOzL3ZbtoV3Wj6U78_1766399314
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Dec 22, 2025 at 11:22:16AM +0100, Thomas Weiﬂschuh wrote:
> On Mon, Dec 22, 2025 at 03:39:12AM -0500, Michael S. Tsirkin wrote:
> > On Mon, Dec 22, 2025 at 09:00:33AM +0100, Thomas Weiﬂschuh wrote:
> > > Using libc types and headers from the UAPI headers is problematic as it
> > > introduces a dependency on a full C toolchain.
> > > 
> > > On Linux 'unsigned long' works as a replacement for 'uintptr_t' and does
> > > not depend on libc.
> > > 
> > > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > 
> > 
> > are you fixing other uses of uintptr_t ?
> 
> I am focussing on UAPI headers which include libc headers.
> virtio_ring.h seems to be the only such header which uses uintptr_t.
> There are a few other UAPI headers which reference uintptr_t, but only
> in comments or macros.
> 
> uintptr_t in regular kernel code is out of scope for me.
> While it is iffy, it doesn't actually hurt.
> 
> 
> Thomas

And other uses of stdint.h?

