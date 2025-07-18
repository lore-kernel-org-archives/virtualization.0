Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFDC1FECB0
	for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 08:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752828562; cv=none; b=b8+FATZ3Jw9UmDC1MxmyeHecbqRCIS/spU9ezSipx9P52hDnxEObtaUXYe8Bkat44T4N/eQUxoEKH8NljjW1qxxp1r3hfNRJzfQwEGJe6GXJ3SvXwKAV/Ni8TaXO/C6jFWkOLbSEvyksWwE8RggJLXsdknpVMqE8N6IbJ5YZBng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752828562; c=relaxed/simple;
	bh=wCPPRc0VzsC5IdtUOf1G0kU8JrdHOJ7JP7ZKRTRoUPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=oitVyDo5RHNTQN1ojgg8XZ7s0eMPqJhAAQWlZqZQGRPa6t7M/tmw9OBHKj0j8bYc7thz3kAPMizfW8FuS4XHRIdaj/llRMmctRyruJKzIGWWu62n2fO/rjgcDf6iAXVAQ+25AoJk76+aZakK+XVmS1Invy+YwATaER2OLuzUIdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hKBu6Qqo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hKBu6Qqo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752828559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8KsQs3P4rKkKS2aJiPc/yrGDUFzJ+y012/Kj1o/hA4s=;
	b=hKBu6QqowpnXYvCCrn5MwUpgL66Yza8TeYDperwtcZI8y4jsn2lm1Tb1SYTw2x57UKmb3Z
	6TipAX09W/jsICDmKgszEBqXbJHk0oGCg1ugU38dq22LpQp1ypp3M4NTkTsgB6AHTEp30D
	Ex7W1GtjTQIFHzDGPXE6NaTyJm9741g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-JDFHezakPpSwINKL55wRRQ-1; Fri, 18 Jul 2025 04:49:18 -0400
X-MC-Unique: JDFHezakPpSwINKL55wRRQ-1
X-Mimecast-MFC-AGG-ID: JDFHezakPpSwINKL55wRRQ_1752828557
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a52bfda108so935117f8f.3
        for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 01:49:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752828557; x=1753433357;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8KsQs3P4rKkKS2aJiPc/yrGDUFzJ+y012/Kj1o/hA4s=;
        b=bW5ivOsyLmyZREsV75BmbTk6dy/j6/MkxXgj8I4QMg1bamm7tIrkpwIxGWxcmmy3I8
         xD3OT0XPNhecR8Cm0PJg8g5eIAimmGiDb41A8Gvluo5912uzfldkR+BiCvifDp37cdR4
         3mWI4y/NnSfC4S3nbR15vcaFYffafH1HDL0R8dSpjbcWERar/xvUZyETwcxYGw2ZHouP
         uJbYz5qT57UL00CVKjK3f84yD9dQoL/Ns5I5RdDjS+AHeLQVIdDwtj8F7cXb6lL3jWAF
         6pl7nAktFcjXGamM3MyXLjeeLY5CBNHxdEsDsKk3lSgKa/eu3qnx6w8HzCLGK5Ej5gAl
         JsHw==
X-Forwarded-Encrypted: i=1; AJvYcCUo/Y8tdPR0qAioxkkJ8G4mty0unUP4eaBLDXNZD0+zfPmrlOsHWJF6yPf7tgcTg5bNLcyfWhRfgU7CqSEe3g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzFPTL/+9POmwDKf+1/eYMeLVgLYUWVvsPIyycTXF00QYK1O4EV
	XwOQXof1xVgQ+j8F4tGWISCUP1aNIaxdQviGU+9CpRDl7qc2Qpr94HWg9cuzoVAIPlpIx1Nd/AU
	r61utm+ebBQ5XKSyggVILeP/7YXnvvNwoePDLdj1FHQcf+nB+emvTI4EDeG1kMM4AseWH
X-Gm-Gg: ASbGncvDL7YfIfm4OWn6sVTeNOknAm2HP9Kd6mQmYZHDX8apxdDRn599BzSg24z03x1
	WvCWU4VBhtapuhxze20zmUV2+th/ygENS0R3qmkpFd7WEBIX6lUg9B6LRN9GvWvjNyQyAWTKVkb
	pQ3YOEvAGy1/hyMnBFgMmwE14SdwK3yAFI61DyC0pG1sQSpix8dL+mwOKAnENchrprPXh5/StwK
	Z7GIE/FUdlke7ABU2LO2GD3MAKEVBfZn1wdIyqPwXBM5YnwIFly8Zuf0yLKdYKPz/jTf98xzMoE
	xMxl4MXuMbAoPEQRp1cOKoTesBqtAppI
X-Received: by 2002:a05:6000:2002:b0:3a4:e393:11e2 with SMTP id ffacd0b85a97d-3b60dd95be4mr7453262f8f.34.1752828556934;
        Fri, 18 Jul 2025 01:49:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAv8Yr0vEh3V/VgAEmk4FFsZAxJoPXqTMHA+hUNzzvYdhccFiA4RkN5P9nCDOFFaR6qJ/8Cg==
X-Received: by 2002:a05:6000:2002:b0:3a4:e393:11e2 with SMTP id ffacd0b85a97d-3b60dd95be4mr7453236f8f.34.1752828556483;
        Fri, 18 Jul 2025 01:49:16 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca48823sm1211352f8f.43.2025.07.18.01.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 01:49:16 -0700 (PDT)
Date: Fri, 18 Jul 2025 04:49:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, hch@infradead.org
Subject: Re: [PATCH V3 0/9] Refine virtio mapping API
Message-ID: <20250718044839-mutt-send-email-mst@kernel.org>
References: <20250718023758.36866-1-jasowang@redhat.com>
 <CACGkMEsPPxVB5mgcT4=6xL5trBHn33_P1pqxgti-4FSqdYZ5vQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsPPxVB5mgcT4=6xL5trBHn33_P1pqxgti-4FSqdYZ5vQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LMk0cBOdoK1haXeIaBX2OlWH-Ouz7h2S-ICTekM3bHA_1752828557
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Jul 18, 2025 at 12:23:49PM +0800, Jason Wang wrote:
> On Fri, Jul 18, 2025 at 10:38 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> > Hi all:
> >
> > Virtio used to be coupled with DMA API. This works fine for the device
> > that do real DMA but not the others. For example, VDUSE nees to craft
> > with DMA API in order to let the virtio-vdpa driver to work.
> >
> > This series tries to solve this issue by introducing the mapping API
> > in the virtio core. So transport like vDPA can implement their own
> > mapping logic without the need to hack with DMA API. The mapping API
> > are abstracted with a new map operations in order to be re-used by
> > transprot or device. So device like VDUSE can implement its own
> > mapping loigc.
> >
> > For device that uses DMA (for example PCI device), the virtio core
> > will still call DMA API directly without the need of implementing map
> > ops per device/transport.
> >
> > Please review.
> >
> > Changes since V2:
> >
> > - Drop VDUSE dependenct for HAS_DMA and ARCH_HAS_DMA_OPS
> 
> I just realized V2 has been merged. So I will post an independent
> patch to do this on top.
> 
> Thanks

Dropped for now. Posted a comment though. does v3 fix the build failure
in linux-next?

