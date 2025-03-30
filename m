Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854471DB551
	for <virtualization@lists.linux.dev>; Sun, 30 Mar 2025 17:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743354419; cv=none; b=L4QslGH9OQv4mwffi0p+afQei4ZC2CrBXbaQviqT/MtRrk0i1AUiHptJdg+eqawNWXwhr+OZM+XTrp76FaGsb0eng0iwKDX+q3ec6bGZcqFw/G/09KmIpxkecrB9gRd5KikKKjFY9RZGX9DxPzbypsLr3MjymawxWAscf1XqPhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743354419; c=relaxed/simple;
	bh=5UmCN6T9Cr1gCtDDz08QVciKcS4TNX6bP4xhWdD/03c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=g7N6nKr0CHWhFs6iC9pNzbEGkVlfJT7mZFyKxlA4esOO3qPM6MuXq5VQY5rzg1iCHXW3syx1/9Ltq4ZCpMQHmjXGHlHLAXhbIdBzouSguqlXSbyUOloWukmk7uhMIu/vfteHbi+2rX6PqknQYi5G2zWA/sCMi6r2pOZEUOsmUtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gnsH83w+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gnsH83w+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743354416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q3mk6TbPcxIg/goVXurjT8cjd9wFt7uMusUUceOMSw4=;
	b=gnsH83w+LEvnz/9UzYJxOSwl0DD3U4YQF62i+QZPC3hocp/LTC5bu5oMMAiWKKf3auiR5M
	SOybO3X3P5MLBzWwLubmq/5bZB5tTHSEGiMj2hsfC2fXyPQbZuAtjqeu1U6nzZdq7CPyWA
	mmdqmcvS7lkNSuVxJ/T3JfoEEIzoeQU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-4pw-vWhhMFicsOQXmugQXw-1; Sun, 30 Mar 2025 13:06:55 -0400
X-MC-Unique: 4pw-vWhhMFicsOQXmugQXw-1
X-Mimecast-MFC-AGG-ID: 4pw-vWhhMFicsOQXmugQXw_1743354414
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-391492acb59so2402768f8f.3
        for <virtualization@lists.linux.dev>; Sun, 30 Mar 2025 10:06:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743354414; x=1743959214;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3mk6TbPcxIg/goVXurjT8cjd9wFt7uMusUUceOMSw4=;
        b=CyeuQrlsZmxesqVKf9nfFlJ9DlCe1lCFvihZRVDVaTK5grcuFN+GptKtYAFQjVVBfE
         ZiWScqqmjAFJQG60zRms1xOn2hpRXHC4ORSAT4oK7GXCdQaujBwHIHGo2v3Jf26DsQyX
         lGUgyGnck9quNd+svb6DaBXWO1tSs0//DqGiwd9hSSvs0TCayJgAi/rB6DSfkqF51R/y
         70p43zKLgeCcROloAApEo57dP0Rlyw/ZfjEZKAhH0vAZaNL3C4QKL5TPPLL24XR0e2Nk
         YXgG8SGnBszDEmI3lfw1x+s60KkAATacVVfhxNd8TCluMd48mAej4ibOBP2xY+WR6QIi
         slZw==
X-Forwarded-Encrypted: i=1; AJvYcCXGA1ovj1Ft1NvP30EYypmPDo87ZiKRPFKA2wfn6KL389M57gfer786z8B5587MxPqunrtH9hruXgr10E+k9Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4YaixAQoLoc6og86jQ2+HIsC4qdVcI1i20LKsIyp/4HmzBkIO
	dZi2rYhEKyaU94g25gSqVxvyIyltFGwvyMsG88aJnQ76VdDWv9YKR/rwinM6VfWNhVpGK99M27+
	YBLI7bd0IE3Dd48tJgrnXvm/2mymKqfxn7O+76k+mA3BV/mbvuiLT1mqMTtOxfJ03
X-Gm-Gg: ASbGncseHLsz+mEaQmN7gF+pRAa6Vx3d2/NG/VBXKW/sW3iR/UexKq5lnTqCyE5g/od
	nyHb4U9D/iBZA6OcAeofRaGzdiudEaxS8uRSVc9e176hFMGKXcLgoZ1Y0+zkLvzFGEM5c/9d70E
	gnvqO7PVZUUBNLXcbX7jyXTYGv7twH5GPZSRQjgDAUQDqlnl1sFpTv7Y9s2UDX0YMrt648YdWoM
	0YMnqb/oT7bxlGkP6OYCu09anjgcsbMoEXIrd9qaWSGxjqGXa5IhPBC2X5twXxX/1f2RO44b4yd
	JYOk8x2vyQ==
X-Received: by 2002:a05:6000:290f:b0:390:f552:d291 with SMTP id ffacd0b85a97d-39c120dc53emr6045336f8f.22.1743354413851;
        Sun, 30 Mar 2025 10:06:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHnojfMbGERAUL3k9pGdjXNeKSJM3z6oVNts7beynMJRyZ4qGr50Up8p35T+/D9THLJjAJmw==
X-Received: by 2002:a05:6000:290f:b0:390:f552:d291 with SMTP id ffacd0b85a97d-39c120dc53emr6045310f8f.22.1743354413473;
        Sun, 30 Mar 2025 10:06:53 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d8ff02e75sm96683605e9.30.2025.03.30.10.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 10:06:52 -0700 (PDT)
Date: Sun, 30 Mar 2025 13:06:47 -0400
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
Message-ID: <20250330125929-mutt-send-email-mst@kernel.org>
References: <20210209062131.2300005-1-tientzu@chromium.org>
 <979b6a34ca5724ced1d4871b58bf227065d7da57.camel@infradead.org>
 <20250321142947-mutt-send-email-mst@kernel.org>
 <d1382a6ee959f22dc5f6628d8648af77f4702418.camel@infradead.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <d1382a6ee959f22dc5f6628d8648af77f4702418.camel@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8tJwkrJ08daW4nepaTXiVyHXNyUGl8jnAKX34z2G3fo_1743354414
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Mar 21, 2025 at 06:42:20PM +0000, David Woodhouse wrote:
> On Fri, 2025-03-21 at 14:32 -0400, Michael S. Tsirkin wrote:
> > On Fri, Mar 21, 2025 at 03:38:10PM +0000, David Woodhouse wrote:
> > > On Tue, 2021-02-09 at 14:21 +0800, Claire Chang wrote:
> > > > This series implements mitigations for lack of DMA access control on
> > > > systems without an IOMMU, which could result in the DMA accessing the
> > > > system memory at unexpected times and/or unexpected addresses, possibly
> > > > leading to data leakage or corruption.
> > > 
> > > Replying to an ancient (2021) thread which has already been merged...
> > > 
> > > I'd like to be able to use this facility for virtio devices.
> > > 
> > > Virtio already has a complicated relationship with the DMA API, because
> > > there were a bunch of early VMM bugs where the virtio devices where
> > > magically exempted from IOMMU protection, but the VMM lied to the guest
> > > and claimed they weren't.
> > > 
> > > With the advent of confidential computing, and the VMM (or whatever's
> > > emulating the virtio device) not being *allowed* to arbitrarily access
> > > all of the guest's memory, the DMA API becomes necessary again.
> > > 
> > > Either a virtual IOMMU needs to determine which guest memory the VMM
> > > may access, or the DMA API is wrappers around operations which
> > > share/unshare (or unencrypt/encrypt) the memory in question.
> > > 
> > > All of which is complicated and slow, if we're looking at a minimal
> > > privileged hypervisor stub like pKVM which enforces the lack of guest
> > > memory access from VMM.
> > > 
> > > I'm thinking of defining a new type of virtio-pci device which cannot
> > > do DMA to arbitrary system memory. Instead it has an additional memory
> > > BAR which is used as a SWIOTLB for bounce buffering.
> > > 
> > > The driver for it would look much like the existing virtio-pci device
> > > except that it would register the restricted-dma region first (and thus
> > > the swiotlb dma_ops), and then just go through the rest of the setup
> > > like any other virtio device.
> > > 
> > > That seems like it ought to be fairly simple, and seems like a
> > > reasonable way to allow an untrusted VMM to provide virtio devices with
> > > restricted DMA access.
> > > 
> > > While I start actually doing the typing... does anyone want to start
> > > yelling at me now? Christoph? mst? :)
> > 
> > 
> > I don't mind as such (though I don't understand completely), but since
> > this is changing the device anyway, I am a bit confused why you can't
> > just set the VIRTIO_F_ACCESS_PLATFORM feature bit?  This forces DMA API
> > which will DTRT for you, will it not?
> 
> That would be necessary but not sufficient. The question is *what* does
> the DMA API do?
> 
> For a real passthrough PCI device, perhaps we'd have a vIOMMU exposed
> to the guest so that it can do real protection with two-stage page
> tables (IOVA→GPA under control of the guest, GPA→HPA under control of
> the hypervisor). For that to work in the pKVM model though, you'd need
> pKVM to be talking the guest's stage1 I/O page tables to see if a given
> access from the VMM ought to be permitted?
> 
> Or for confidential guests there could be DMA ops which are an
> 'enlightenment'; a hypercall into pKVM to share/unshare pages so that
> the VMM can actually access them, or SEV-SNP guests might mark pages
> unencrypted to have the same effect with hardware protection.
> 
> Doing any of those dynamically to allow the VMM to access buffers in
> arbitrary guest memory (when it wouldn't normally have access to
> arbitrary guest memory) is complex and doesn't perform very well. And
> exposes a full 4KiB page for any byte that needs to be made available.
> 
> Thus the idea of having a fixed range of memory to use for a SWIOTLB,
> which is fairly much what the restricted DMA setup is all about.
> 
> We're just proposing that we build it in to a virtio-pci device model,
> which automatically uses the extra memory BAR instead of the
> restricted-dma-pool DT node.
> 
> It's basically just allowing us to expose through PCI, what I believe
> we can already do for virtio in DT.

I am not saying I am against this extension.
The idea to restrict DMA has a lot of merit outside pkvm.
For example, with a physical devices, limiting its DMA
to a fixed range can be good for security at a cost of
an extra data copy.

So I am not saying we have to block this specific hack.

what worries me fundamentally is I am not sure it works well
e.g. for physical virtio cards.
Attempts to pass data between devices will now also require
extra data copies.


Did you think about adding an swiotlb mode to virtio-iommu at all?
Much easier than parsing page tables.



-- 
MST

