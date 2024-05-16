Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4EB146A72
	for <virtualization@lists.linux.dev>; Thu, 16 May 2024 13:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715865207; cv=none; b=HawyKMrn0w2jN0ok6WHTpOQsAsPjHGHHCMh4QrOaSi52J1AU4GGLMxVjGLsvZbf05pFF6X6p0CH0oGk3NzB7EBDzgJKKOI+tRxkDDpjar+ru1acrhQttSKPZcBpI1aD3btam01N901xi0dABBijZK19GvSqXlqDXIR4A2kxwDn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715865207; c=relaxed/simple;
	bh=dtd4iyliPDvaVoHet9Iu/w99q8VWU7+7Di+EZZbiPyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DdkZQOvl7gT6AoudkngY3hyNkU1PjCN0laXBkvHi99JLn1yQ29nqUKmzo5TlR5EZJKh3Zdco312bBxZbfDyZ8u1v1o59crzft/4HPx6WGvILQR5NAJN9iT6p+ZI2Ryd2la5x1RcIBRaExgFz9uSAhxr0uk8+4xo/gs24kqCwub8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TtHbuqgp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TtHbuqgp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715865204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OSy7yg6jMdWHxfxX09d5z7SmLjQyRKKO4cx1YTEDaNs=;
	b=TtHbuqgpAXJSB/ACWVQYNbvENOmjAsTrMF+YCgdsjLpQ69vGUM1nxSK9FEZpZX4Cx2C475
	DMUG/UPvPOT7ai5UGAbs6sPpQWnPCxO0GWwZdgRdVP9cyHo8xgLZGf+OLHi4RVT7W9UtAN
	so9eR4begDDcMtGr9HAy80HKbYRvBvU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-ju5jhofzOsqUUdPl9KoSbg-1; Thu, 16 May 2024 09:13:23 -0400
X-MC-Unique: ju5jhofzOsqUUdPl9KoSbg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-34dce5456c3so5764233f8f.0
        for <virtualization@lists.linux.dev>; Thu, 16 May 2024 06:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715865202; x=1716470002;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OSy7yg6jMdWHxfxX09d5z7SmLjQyRKKO4cx1YTEDaNs=;
        b=OQlRUIekBriDY1/wd2qe8RkKfM4DdBvqienDjZ026uzYjHuA6PQVK74Ey4QNKwMVrz
         V+16bQ5AcHhI0Oy4UrSdK7h+PuePw7ow5k+JH/kjaVTk+TxKDm0Dm80CT+0kYlJhjS6R
         /PhjK0aCvwibB8D3neO8eq3MAY5UtGXnyaLUV7d3ap9Fg4RgRiThYaEcF9SK9wU2A9jD
         WD2F8zFnCReDMLU31q7C79Ask0glo3WNHjMKI0krLQ5qQ/Gx/6mY28Bw3dZCA1d/t3wy
         LpCuhLvb8UpFQ2vs6P09VBnlNr88u8Hxetza6upe5rugFppMRSFyt0JjhDV/q4CJAA3O
         Fc3A==
X-Forwarded-Encrypted: i=1; AJvYcCXSH0ZBir8JNRYJMy7wRT8aipIx5OgR9JWlBK+HDiqs1qLj1VkiErrBW7nz8rah3/jJcQqj4SMeVzsmUh4wnFGu1nGzcUwJ6n488/Q3vu8=
X-Gm-Message-State: AOJu0YyGuJY08mb5POsc5ixuXgoDAk4Y6bq+uay1QjvfTGhpRAcgXcT6
	4lGFLxNQYfHIBKJrAjn1DI3iMXx3BydnvKRvgHKsYg7pFx+CBYC5QMh0Vx/AsjOn2FcRRUEirnV
	qA0kRuASqRlq2UkPd2c5Ub9Vif16Prz4FjE/nMeorGDf5rnHumJRVHGE05KW4r+QD
X-Received: by 2002:adf:b1de:0:b0:351:b2ff:63a8 with SMTP id ffacd0b85a97d-351b2ff64bfmr13163039f8f.16.1715865201873;
        Thu, 16 May 2024 06:13:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFA5A0Z4lKyhtRXL+abQQ48JwBKJ6OTwX20epAfBjFZPy6ZIE08R+/aOGNiGghuAu5Wsstb3g==
X-Received: by 2002:adf:b1de:0:b0:351:b2ff:63a8 with SMTP id ffacd0b85a97d-351b2ff64bfmr13163013f8f.16.1715865201301;
        Thu, 16 May 2024 06:13:21 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:8a3f:2db6:ab3d:a443:822c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8a789asm18993930f8f.51.2024.05.16.06.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 06:13:20 -0700 (PDT)
Date: Thu, 16 May 2024 09:13:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Shunsuke Mie <mie@igel.co.jp>, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com
Subject: Re: [RFC] Legacy Virtio Driver with Device Has Limited Memory Access
Message-ID: <20240516091053-mutt-send-email-mst@kernel.org>
References: <CANXvt5r00Y5VGKSFXFnwbvGF+fhh2uNvU5VBGwECA9yabK4=Uw@mail.gmail.com>
 <20240516125913.GC11261@thinkpad>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240516125913.GC11261@thinkpad>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, May 16, 2024 at 02:59:13PM +0200, Manivannan Sadhasivam wrote:
> On Thu, May 16, 2024 at 01:38:40PM +0900, Shunsuke Mie wrote:
> > Hi virtio folks,
> > 
> 
> You forgot to CC the actual Virtio folks. I've CCed them now.
> 
> > I'm writing to discuss finding a workaround with Virtio drivers and legacy
> > devices with limited memory access.
> > 
> > # Background
> > The Virtio specification defines a feature (VIRTIO_F_ACCESS_PLATFORM) to
> > indicate devices requiring restricted memory access or IOMMU translation. This
> > feature bit resides at position 33 in the 64-bit Features register on modern
> > interfaces. When the linux virtio driver finds the flag, the driver uses DMA
> > API that handles to use of appropriate memory.
> > 
> > # Problem
> > However, legacy devices only have a 32-bit register for the features bits.
> > Consequently, these devices cannot represent the ACCESS_PLATFORM bit. As a
> > result, legacy devices with restricted memory access cannot function
> > properly[1]. This is a legacy spec issue, but I'd like to find a workaround.
> > # Proposed Solutions
> > I know these are not ideal, but I propose the following solution.
> > Driver-side:
> >     - Implement special handling similar to xen_domain.
> > In xen_domain, linux virtio driver enables to use the DMA API.
> >     - Introduce a CONFIG option to adjust the DMA API behavior.
> > Device-side:
> > Due to indistinguishability from the guest's perspective, a device-side
> > solution might be difficult.
> > 
> > I'm open to any comments or suggestions you may have on this issue or
> > alternative approaches.
> > 
> > [1] virtio-net PCI endpoint function using PCIe Endpoint Framework,
> > https://lore.kernel.org/lkml/54ee46c3-c845-3df3-8ba0-0ee79a2acab1@igel.co.jp/t/
> > The Linux PCIe endpoint framework is used to implement the virtio-net device on
> > a legacy interface. This is necessary because of the framework and hardware
> > limitation.
> > 
> 
> We can fix the endpoint framework limitation, but the problem lies with some
> platforms where we cannot write to vendor capability registers and still have
> IOMMU.
> 
> - Mani
> 

virtio 1.0 was released 10 years ago.  Just implement the modern spec.
Or if there's something wrong with the modern spec, tell us and we will
try to fix it.

> -- 
> மணிவண்ணன் சதாசிவம்

