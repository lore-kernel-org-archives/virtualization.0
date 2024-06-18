Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1806113A268
	for <virtualization@lists.linux.dev>; Tue, 18 Jun 2024 10:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718705356; cv=none; b=WvWfPzUp9HKMK7ylmL/gclzpYvWmBHT+4NoRMMxtyd3hQB7EU1c9EgzwLhsV/nhoMztRT1uSjt3Roap8cAr7WF358gpF4EjAdxO0FHsR9XiX+g7C+gXyuyZPTtWeYePuPhO5byZ4rVCV6SVLU1+lDu7noRKmZfEL2UTbgoZl268=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718705356; c=relaxed/simple;
	bh=khuUH1bMj8Z9VH+WJa6PdJmBWinhnFOUvq23lTLU5Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=IVfnM4nVTNAEXQ43r9UegDq2KkkzcDir3XZTgvtRlgxma+fQa6F++aRYGoyV9SWAZ5HHX4Byly/iV3qwDjo8Wia34gGmWkpBiauJ2Tj6CYUqx/5wboFKQmbrAMcAD3hrM1/EQtHpJulg2Sv+Wy0qhtnL/miPXJawO0WW5g1FeRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e8/i39Bg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e8/i39Bg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718705354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rEDxZc2dLW6+Xu8qI6zPlDHwS+sRNM7U/A+bgGnLIgc=;
	b=e8/i39Bg5Jyd12IQUTGtSLABmS5nGQewwAq3lY4OHSJZnoMs2dlrNoBbgqhWx2i0ro471c
	hhaZHE3p4lnwngKawr64g4acvXiRq7VPxI6bhxUWEVhIZLsDfVBu6NMnzVTh12hqMHHwt6
	lYpT71PiIKITxTUbnqSVuvqXvTWJ8Ng=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-nyg8mEoFMISDuDsZIHDj7A-1; Tue, 18 Jun 2024 06:09:12 -0400
X-MC-Unique: nyg8mEoFMISDuDsZIHDj7A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42183fdb37cso39435495e9.3
        for <virtualization@lists.linux.dev>; Tue, 18 Jun 2024 03:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718705348; x=1719310148;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rEDxZc2dLW6+Xu8qI6zPlDHwS+sRNM7U/A+bgGnLIgc=;
        b=QKlYlzPr80zaw9I9ueCV/CALgyElqFPpdUctama3goa6axbXoQny0BDYZNBhZjoKIA
         edZdQsQvmV+KcDIS0Dy7mkOrgyv3tDgommWG+sbYHedRgnBgN2DtmhWHMDJx4FHrcSVs
         dr9IxRMyzpkdA/k31II64a3USX54JTzrt0eUX0wr8Vo6Cp1lqFh3LD20Mt8txcW7W6TQ
         Kw319wji//X1SNfi1K0wlrywR/xo5z2iqlCeC1nzfr3SHnzcg5zsm8kgQzpPknZLZBhD
         oHpZFSeAX1WkLdWrqQY43uewtXH+Ek86iTrjpR/FtLxEpfLF5NRF+nrq98kJ1LN6PiUP
         31tw==
X-Forwarded-Encrypted: i=1; AJvYcCUudf+B33EIkyFNEyMqdivUCTjXz7xgcMvIY8IzCp+cOng6grS2/MXY92r9u/wkOcYbSNQavOui7pYQIjK5vqdKygEW1W5L0sEUOMoz48I=
X-Gm-Message-State: AOJu0Yy1A5RIE8sCq7g/5/mm/H1t/IY6wxvYcTXpIXCFHqjqhK0t+ujv
	aZsqk2l4MJWh9SpOvzRabkUe4+mqBz80lV4uWF5bxCQjHUDjSCTBbl3A9Ogm5TgwLihwt/ALfzF
	abMKP+4OouXYRw6F3SNbAoJCZ3WqqOTO+KTBHJGbHrViJr1q7Bak0srtkXhCKQEed
X-Received: by 2002:a05:600c:4706:b0:422:384e:4365 with SMTP id 5b1f17b1804b1-42304821335mr99960215e9.2.1718705347903;
        Tue, 18 Jun 2024 03:09:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6lEhniOXOzh+4aLd12LE9PgD8GXi7WRdQsYXcSj/HwWxOWMkkIDigLL4/zLVBCWNFYYK/jg==
X-Received: by 2002:a05:600c:4706:b0:422:384e:4365 with SMTP id 5b1f17b1804b1-42304821335mr99959925e9.2.1718705347111;
        Tue, 18 Jun 2024 03:09:07 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:67bf:ebbb:9f62:dc29:2bdc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3609a892324sm3189067f8f.6.2024.06.18.03.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 03:09:06 -0700 (PDT)
Date: Tue, 18 Jun 2024 06:09:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Shunsuke Mie <mie@igel.co.jp>, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com
Subject: Re: [RFC] Legacy Virtio Driver with Device Has Limited Memory Access
Message-ID: <20240618060649-mutt-send-email-mst@kernel.org>
References: <CANXvt5r00Y5VGKSFXFnwbvGF+fhh2uNvU5VBGwECA9yabK4=Uw@mail.gmail.com>
 <20240516125913.GC11261@thinkpad>
 <20240520090809-mutt-send-email-mst@kernel.org>
 <20240614095033.GA59574@thinkpad>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240614095033.GA59574@thinkpad>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Jun 14, 2024 at 03:20:33PM +0530, Manivannan Sadhasivam wrote:
> On Mon, May 20, 2024 at 09:22:54AM -0400, Michael S. Tsirkin wrote:
> > On Thu, May 16, 2024 at 02:59:13PM +0200, Manivannan Sadhasivam wrote:
> > > On Thu, May 16, 2024 at 01:38:40PM +0900, Shunsuke Mie wrote:
> > > > Hi virtio folks,
> > > > 
> > > 
> > > You forgot to CC the actual Virtio folks. I've CCed them now.
> > > 
> > > > I'm writing to discuss finding a workaround with Virtio drivers and legacy
> > > > devices with limited memory access.
> > > > 
> > > > # Background
> > > > The Virtio specification defines a feature (VIRTIO_F_ACCESS_PLATFORM) to
> > > > indicate devices requiring restricted memory access or IOMMU translation. This
> > > > feature bit resides at position 33 in the 64-bit Features register on modern
> > > > interfaces. When the linux virtio driver finds the flag, the driver uses DMA
> > > > API that handles to use of appropriate memory.
> > > > 
> > > > # Problem
> > > > However, legacy devices only have a 32-bit register for the features bits.
> > > > Consequently, these devices cannot represent the ACCESS_PLATFORM bit. As a
> > > > result, legacy devices with restricted memory access cannot function
> > > > properly[1]. This is a legacy spec issue, but I'd like to find a workaround.
> > > > 
> > > > # Proposed Solutions
> > > > I know these are not ideal, but I propose the following solution.
> > > > Driver-side:
> > > >     - Implement special handling similar to xen_domain.
> > > > In xen_domain, linux virtio driver enables to use the DMA API.
> > > >     - Introduce a CONFIG option to adjust the DMA API behavior.
> > > > Device-side:
> > > > Due to indistinguishability from the guest's perspective, a device-side
> > > > solution might be difficult.
> > > > 
> > > > I'm open to any comments or suggestions you may have on this issue or
> > > > alternative approaches.
> > > > 
> > > > [1] virtio-net PCI endpoint function using PCIe Endpoint Framework,
> > > > https://lore.kernel.org/lkml/54ee46c3-c845-3df3-8ba0-0ee79a2acab1@igel.co.jp/t/
> > > > The Linux PCIe endpoint framework is used to implement the virtio-net device on
> > > > a legacy interface. This is necessary because of the framework and hardware
> > > > limitation.
> > > > 
> > > 
> > > We can fix the endpoint framework limitation, but the problem lies with some
> > > platforms where we cannot write to vendor capability registers and still have
> > > IOMMU.
> > > 
> > > - Mani
> > 
> > What are vendor capability registers and what do they have to do
> > with the IOMMU?
> > 
> 
> Virtio spec v1.2, sec 4.1.4 says,
> 
> "Each structure can be mapped by a Base Address register (BAR) belonging to the
> function, or accessed via the special VIRTIO_PCI_CAP_PCI_CFG field in the PCI
> configuration space.
> 
> The location of each structure is specified using a vendor-specific PCI
> capability located on the capability list in PCI configuration space of the
> device."
> 
> So this means the device has to expose the virtio structures through vendor
> specific capability isn't it?

The location of the structures within BAR is specified through
a vendor specific PCI capability, yes.

Why is that a problem?

People have been asking for alternative ways to do that,
so if you can point out what your issue is specifically,
it can be fixable.

> And only in that case, it can expose VIRTIO_F_ACCESS_PLATFORM bit for making
> use of IOMMU translation.
> 
> - Mani

virtio drivers won't even know where to access the features
without the capability.


> -- 
> மணிவண்ணன் சதாசிவம்

