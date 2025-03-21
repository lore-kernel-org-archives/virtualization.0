Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B29B1E9B36
	for <virtualization@lists.linux.dev>; Fri, 21 Mar 2025 18:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742581963; cv=none; b=Lybz+AiKQmLIwtzbMnjGN0sss/r8r+cEpcJhBFB9tLccJx0zTjy3b9i2NtH+yLIsuhbDv7hNfq29td6emtBP3ToW+8aI9hyVaEVYxJ3KEBxg5MWStLKK3u9+fcqlbIvXImCrv2viuMiRb7bzzFqVwjblCPV4zXnPMzkngarZ38k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742581963; c=relaxed/simple;
	bh=OGIF01jTzLLwnp3yRBbvZluiVgmfjC+jL66qfu3gwks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=QNnGqKS1P/swgnc38TEW++wtXIOfYy0fiOv99PO/8JpEhPDsB0Z09fwhDAQORGrmxRn1DtwjwpC+kMt5SVlgpGiriGYpNNnCNpVh1mS+AzRckVOu/23Ynr7ho31kmSFfIZ4pONsXhY4bKyWu9X8SgPU/rFNqs6lW0lMxtRATVfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gjiCZJR/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gjiCZJR/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742581960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x6Pr4yNEy0Ee63hyTGb7eb9xdvxKn8eEKjzFLCkdY+o=;
	b=gjiCZJR/w6OyouwB1eYm+pfhTMryG+34TEiMtudulzNowUkFNrCtKAh8w3ezVhLs5/9YJ3
	NZ6RJfuVF39zokC+yeBDVfFibTf2ZuVLMHxgAHoYyqjrUu4fvBq7JqqCHd43DBuHR/mVyt
	GLM/R07wK9wTpuz36emgUC/81UCjBtY=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-XzRgAuPuOL6Voxd2vX-vTA-1; Fri, 21 Mar 2025 14:32:35 -0400
X-MC-Unique: XzRgAuPuOL6Voxd2vX-vTA-1
X-Mimecast-MFC-AGG-ID: XzRgAuPuOL6Voxd2vX-vTA_1742581955
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-22410053005so57680515ad.1
        for <virtualization@lists.linux.dev>; Fri, 21 Mar 2025 11:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742581955; x=1743186755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6Pr4yNEy0Ee63hyTGb7eb9xdvxKn8eEKjzFLCkdY+o=;
        b=afkHG0mL9gyJdsjuCH+rm0ahjOARtwvyBuOcgfNrKH3tOWur2IyXoX/VZoDQwmhGf9
         2l7fggLhppeiHKISCIX9OBVFezF45GEpzTf3/rYjuiSqVi/hefXrZaYJVtSw5Z3l2I6g
         K0CIwdwBpur6BgYRQ0Mcjz+cAE3xxkhdfopHTDwAtRUQNFTyKH+a8SDxib6rcOGk5Qea
         /jMe2cWI16k3KEJPrxAKZZ8Po8LhmBlRxHYf4Mm77bnotKTtFtvF3Ordt2sWl1jTS4l2
         DOmzGOCKX/t6U0W+2sy+aSn8WClXkGwhSQfvioFj7DpIH5c524DJKJ8iXpDF+ZEJyuDa
         vJag==
X-Forwarded-Encrypted: i=1; AJvYcCXsPZQ/HePLvnvX58BJuX87jAGvmbDsUaGmewPTDv20y9mgj7RVPBZxOmHpRvJA8syMWzpph5ZVML7bdPFKjQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwGVl1kQjepfQHsocmFertBeeKQqDi8jTPdedHnScfgGRUXkQMA
	Lzr0Y+wOarh/M9DXGh0noY0e64SjSq+FhGBzNYckfpr6M55r7PPsnskDqK8aOmeyLY/0ppgRdiG
	dc6iAT443HBbPYiocpk+bw/9VVgE49ddvXnLs80v9Ngh9NFmWLG5jmlyWmvVwxxWD
X-Gm-Gg: ASbGncs9q7q8uE//ePD/Igh05QWSgg1TAheerM61AOAD7To+/t4P9tPgRKAVVPxbOzM
	mKglXMssZeGg1JejZmyTCmaP/xZz8RWsFh9QhP8VFZbvhP1I+EVCCiB2uWBinyKHz4Yvz2GXx+x
	tcDWHLzst62IzZb+o8/tYfgCjncO2tGYJapfNaXWb81AWuqfAvaggh/YFlBEIbYmohZplL1KsqO
	uoKLY/AltqkT6vBLC3EX8hoMeCWPk6qV6RcJbRwFb9M/9KzRPiFNhmFJB25+MMQtubytSAM0aK8
	UpTZnkDw
X-Received: by 2002:a05:6a00:3d49:b0:736:592e:795f with SMTP id d2e1a72fcca58-7390598e637mr6094590b3a.9.1742581954607;
        Fri, 21 Mar 2025 11:32:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgvI4Fq7PhyVG2/6UfPhY7tEePZCtkHS/CCaoQm+lEN40XhsJxvkXhRtIdT7ONaz8I8Nvvbw==
X-Received: by 2002:a05:6a00:3d49:b0:736:592e:795f with SMTP id d2e1a72fcca58-7390598e637mr6094532b3a.9.1742581953971;
        Fri, 21 Mar 2025 11:32:33 -0700 (PDT)
Received: from redhat.com ([195.133.138.172])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390618e08esm2305706b3a.169.2025.03.21.11.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 11:32:33 -0700 (PDT)
Date: Fri, 21 Mar 2025 14:32:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Claire Chang <tientzu@chromium.org>, Rob Herring <robh+dt@kernel.org>,
	mpe@ellerman.id.au, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	boris.ostrovsky@oracle.com, jgross@suse.com,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	heikki.krogerus@linux.intel.com, peterz@infradead.org,
	benh@kernel.crashing.org, grant.likely@arm.com, paulus@samba.org,
	mingo@kernel.org, sstabellini@kernel.org,
	Saravana Kannan <saravanak@google.com>, xypron.glpk@gmx.de,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Bartosz Golaszewski <bgolaszewski@baylibre.com>,
	xen-devel@lists.xenproject.org, Thierry Reding <treding@nvidia.com>,
	linux-devicetree <devicetree@vger.kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	Nicolas Boichat <drinkcat@chromium.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	lkml <linux-kernel@vger.kernel.org>,
	"list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
	Jim Quinlan <james.quinlan@broadcom.com>,
	Robin Murphy <robin.murphy@arm.com>, hch@infradead.org,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, graf@amazon.de
Subject: Re: Using Restricted DMA for virtio-pci
Message-ID: <20250321142947-mutt-send-email-mst@kernel.org>
References: <20210209062131.2300005-1-tientzu@chromium.org>
 <979b6a34ca5724ced1d4871b58bf227065d7da57.camel@infradead.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <979b6a34ca5724ced1d4871b58bf227065d7da57.camel@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LqEEoqXDwLrS36WbRN2I1vv7uOjwUZOu1wkUb6kqC9s_1742581955
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 21, 2025 at 03:38:10PM +0000, David Woodhouse wrote:
> On Tue, 2021-02-09 at 14:21 +0800, Claire Chang wrote:
> > This series implements mitigations for lack of DMA access control on
> > systems without an IOMMU, which could result in the DMA accessing the
> > system memory at unexpected times and/or unexpected addresses, possibly
> > leading to data leakage or corruption.
> 
> Replying to an ancient (2021) thread which has already been merged...
> 
> I'd like to be able to use this facility for virtio devices.
> 
> Virtio already has a complicated relationship with the DMA API, because
> there were a bunch of early VMM bugs where the virtio devices where
> magically exempted from IOMMU protection, but the VMM lied to the guest
> and claimed they weren't.
> 
> With the advent of confidential computing, and the VMM (or whatever's
> emulating the virtio device) not being *allowed* to arbitrarily access
> all of the guest's memory, the DMA API becomes necessary again.
> 
> Either a virtual IOMMU needs to determine which guest memory the VMM
> may access, or the DMA API is wrappers around operations which
> share/unshare (or unencrypt/encrypt) the memory in question.
> 
> All of which is complicated and slow, if we're looking at a minimal
> privileged hypervisor stub like pKVM which enforces the lack of guest
> memory access from VMM.
> 
> I'm thinking of defining a new type of virtio-pci device which cannot
> do DMA to arbitrary system memory. Instead it has an additional memory
> BAR which is used as a SWIOTLB for bounce buffering.
> 
> The driver for it would look much like the existing virtio-pci device
> except that it would register the restricted-dma region first (and thus
> the swiotlb dma_ops), and then just go through the rest of the setup
> like any other virtio device.
> 
> That seems like it ought to be fairly simple, and seems like a
> reasonable way to allow an untrusted VMM to provide virtio devices with
> restricted DMA access.
> 
> While I start actually doing the typing... does anyone want to start
> yelling at me now? Christoph? mst? :)


I don't mind as such (though I don't understand completely), but since
this is changing the device anyway, I am a bit confused why you can't
just set the VIRTIO_F_ACCESS_PLATFORM feature bit?  This forces DMA API
which will DTRT for you, will it not?

-- 
MST

