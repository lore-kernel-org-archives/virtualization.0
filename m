Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9E71CD20D
	for <virtualization@lists.linux.dev>; Sun, 30 Mar 2025 16:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743353967; cv=none; b=nbIrVLY0EOAzo0CSyPRp7mtpqaW2XZWINDdyEwXwOjBlr3daCqnLhacgNfJGcIfjdfrcRFZzmTcOWJo9d7K5D6Y9rd/Ly8BTGgeGjUS9W68pvjYWnRiqIS3sO3PnSYO+s5MpoNWM3tU2hq/j8zFYltHwlaL7cr8LEiVi1i7nXwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743353967; c=relaxed/simple;
	bh=L+Ch126l1E8VN++Dx7jTJTrhsULldQUHnKQy3Ih2m08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=VRbJBlv2vJlNLJxBtkBaW3lU+xELkW0iZ+QaNbS2I5yU5FpaJLGLRh6L6PHzc5U0va1IwCDZGGF7dJj+29zKwUaGu/Q53s1VEdLey/Ehyic08akhREuYKrJHbpjEaQwYFHhhwRNQ9XJibClSbeQWI1WetUnVsgdhnSkFeUuHsxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iYWBVoXU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iYWBVoXU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743353963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o3t3cKdFvQ9kSTO6AkCwvmYi+EYplfurO1UOS5Rdldo=;
	b=iYWBVoXU6nG0tTObS6zuLPdGl8lDH8o2PCx/xJ+3MC/KE/7hQH6uFH4tFPgobPZhyQe1xb
	boG3tH5lMAt9VbyuMykqNtsjTqdWA5XOfiRZyN6zQFtJpnj6XT4EWzfLfjUNxrjVFpXllV
	QzgM6Q0ZKcmeUML/xujsuGw7foKnYko=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-bJDZCfbxO4uhjB9YyrHmLw-1; Sun, 30 Mar 2025 12:59:22 -0400
X-MC-Unique: bJDZCfbxO4uhjB9YyrHmLw-1
X-Mimecast-MFC-AGG-ID: bJDZCfbxO4uhjB9YyrHmLw_1743353961
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43941ad86d4so18579115e9.2
        for <virtualization@lists.linux.dev>; Sun, 30 Mar 2025 09:59:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743353961; x=1743958761;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o3t3cKdFvQ9kSTO6AkCwvmYi+EYplfurO1UOS5Rdldo=;
        b=wgSZGbf5cJbU70UrdGOF54E53mAwy8lt0wdDGNVZHJPaJNH1yP9cFB0UAmTgxu9rZf
         s3gs5ajnD1oJxPwzlEUDwvu55sjYYlfPOLMwma0l5TKZSkcjvIPcEjHDe8NWwGSiSgG/
         CwmFrHyaoMyoAfvcWf/Xki4CMO0wpdsCTkwFbnx7q4HCowkHIKg9AxUYlA4sn1KUwQX+
         0MgUeJseLaevtl5rDp6ABjQo5Y12d0UTRCcVu8KYxkNgT0CCDxicZCzFbcc1Fcpgn7OW
         k1EmMyZehLyK0IM5JnOH2sZpcTabn4FvCpF4lujxmRfOWH0QADuJx65uRRabScOQmRDC
         w+zQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJhgDyvAR4bW63k1fpesED19Ah490WKSChtoU816nOJqVhx3LrLjPW5IP04xLKvkgGDcP7XJZD5RIb3GQ/Lw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyUnboDGJ0GByx1KU5YoRoHyW5LJx1zTFTc2Ee0f27zuV1qhick
	Sd4XNxDOxjqmejhQf0SB80toLUkbYm8v9TBmz3UerWkLS/gXFSnlJ2q+XIqlWcLjz3wl40dgS6J
	sOkOGUPmZcNQbsiRyMYMQvZJfBtJE1ZjdHh1AomdkQZ3mXZ4JdBGb2uddySW9jeaV
X-Gm-Gg: ASbGncsAmjJoKYhB4E5VNMAlMOxmfUx70IJ90Z+avUePgDfOIkGTtk0BP8YzFzLNbTS
	7qehB4BQoMxZNCz/Ukfv0aDAPPyI3ydLPZHtKi9VXSg20qjsHxmEyeXKmMDkEAzu1mrwkB0FjBm
	8pHtwrPNJGfWaJhTvrsng5pQKltemZXyTVxC46+0iSxC74XWLjK0gGltZBuie9AxD1kSABQFDQF
	dm/ClOfLDnv/Cjmatl99+HupBJ0EJcL9RRHQFCUSnybBvyMWOyCXrrbscjvcAUU0UrE5voiXBry
	wOV4dqQewA==
X-Received: by 2002:a05:600c:3b1a:b0:43c:f16a:641e with SMTP id 5b1f17b1804b1-43db61d774emr47821965e9.6.1743353960954;
        Sun, 30 Mar 2025 09:59:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+p9VLRRjFT3w4qBD/7B0LlHwO9LmFFwBhLcfryqChirTqXeZbU3Dh3SrxX6aYrpGFJgo00w==
X-Received: by 2002:a05:600c:3b1a:b0:43c:f16a:641e with SMTP id 5b1f17b1804b1-43db61d774emr47821495e9.6.1743353960480;
        Sun, 30 Mar 2025 09:59:20 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d8ff02f9csm97569695e9.26.2025.03.30.09.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 09:59:18 -0700 (PDT)
Date: Sun, 30 Mar 2025 12:59:13 -0400
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
Message-ID: <20250330125637-mutt-send-email-mst@kernel.org>
References: <20210209062131.2300005-1-tientzu@chromium.org>
 <979b6a34ca5724ced1d4871b58bf227065d7da57.camel@infradead.org>
 <20250321142947-mutt-send-email-mst@kernel.org>
 <d1382a6ee959f22dc5f6628d8648af77f4702418.camel@infradead.org>
 <8e7084b04e5c0456c0ff32ea131a199c6af763cd.camel@infradead.org>
 <20250330093532-mutt-send-email-mst@kernel.org>
 <09fc164ebcfd893ffd67d1b224d6e1c5e5772ee0.camel@infradead.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <09fc164ebcfd893ffd67d1b224d6e1c5e5772ee0.camel@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wKwtAxZwD9mziDl-k87sMOimJkGKf8aev_9HE4WErkA_1743353961
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Sun, Mar 30, 2025 at 04:07:56PM +0100, David Woodhouse wrote:
> On Sun, 2025-03-30 at 09:42 -0400, Michael S. Tsirkin wrote:
> > On Fri, Mar 28, 2025 at 05:40:41PM +0000, David Woodhouse wrote:
> > > On Fri, 2025-03-21 at 18:42 +0000, David Woodhouse wrote:
> > > > > 
> > > > > I don't mind as such (though I don't understand completely), but since
> > > > > this is changing the device anyway, I am a bit confused why you can't
> > > > > just set the VIRTIO_F_ACCESS_PLATFORM feature bit?  This forces DMA API
> > > > > which will DTRT for you, will it not?
> > > > 
> > > > That would be necessary but not sufficient. ...
> > 
> > could you explain pls?
> 
> There was more to that in the previous email which I elided for this
> followup.
> 
> https://lore.kernel.org/all/d1382a6ee959f22dc5f6628d8648af77f4702418.camel@infradead.org/
> 
> > > My first cut at a proposed spec change looks something like this. I'll
> > > post it to the virtio-comment list once I've done some corporate
> > > bureaucracy and when the list stops sending me python tracebacks in
> > > response to my subscribe request.
> > 
> > the linux foundation one does this? maybe poke at the admins.
> > 
> > > In the meantime I'll hack up some QEMU and guest Linux driver support
> > > to match.
> > > 
> > > diff --git a/content.tex b/content.tex
> > > index c17ffa6..1e6e1d6 100644
> > > --- a/content.tex
> > > +++ b/content.tex
> > > @@ -773,6 +773,9 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
> > >  Currently these device-independent feature bits are defined:
> > >  
> > >  \begin{description}
> > > +  \item[VIRTIO_F_SWIOTLB (27)] This feature indicates that the device
> > > +  provides a memory region which is to be used for bounce buffering,
> > > +  rather than permitting direct memory access to system memory.
> > >    \item[VIRTIO_F_INDIRECT_DESC (28)] Negotiating this feature indicates
> > >    that the driver can use descriptors with the VIRTQ_DESC_F_INDIRECT
> > >    flag set, as described in \ref{sec:Basic Facilities of a Virtio
> > > @@ -885,6 +888,10 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
> > >  VIRTIO_F_ACCESS_PLATFORM is not offered, then a driver MUST pass only physical
> > >  addresses to the device.
> > >  
> > > +A driver SHOULD accept VIRTIO_F_SWIOTLB if it is offered, and it MUST
> > > +then pass only addresses within the Software IOTLB bounce buffer to the
> > > +device.
> > > +
> > >  A driver SHOULD accept VIRTIO_F_RING_PACKED if it is offered.
> > >  
> > >  A driver SHOULD accept VIRTIO_F_ORDER_PLATFORM if it is offered.
> > > @@ -921,6 +928,10 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
> > >  A device MAY fail to operate further if VIRTIO_F_ACCESS_PLATFORM is not
> > >  accepted.
> > >  
> > > +A device MUST NOT offer VIRTIO_F_SWIOTLB if its transport does not
> > > +provide a Software IOTLB bounce buffer.
> > > +A device MAY fail to operate further if VIRTIO_F_SWIOTLB is not accepted.
> > > +
> > >  If VIRTIO_F_IN_ORDER has been negotiated, a device MUST use
> > >  buffers in the same order in which they have been available.
> > >  
> > > diff --git a/transport-pci.tex b/transport-pci.tex
> > > index a5c6719..23e0d57 100644
> > > --- a/transport-pci.tex
> > > +++ b/transport-pci.tex
> > > @@ -129,6 +129,7 @@ \subsection{Virtio Structure PCI Capabilities}\label{sec:Virtio Transport Option
> > >  \item ISR Status
> > >  \item Device-specific configuration (optional)
> > >  \item PCI configuration access
> > > +\item SWIOTLB bounce buffer
> > >  \end{itemize}
> > >  
> > >  Each structure can be mapped by a Base Address register (BAR) belonging to
> > > @@ -188,6 +189,8 @@ \subsection{Virtio Structure PCI Capabilities}\label{sec:Virtio Transport Option
> > >  #define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
> > >  /* Vendor-specific data */
> > >  #define VIRTIO_PCI_CAP_VENDOR_CFG        9
> > > +/* Software IOTLB bounce buffer */
> > > +#define VIRTIO_PCI_CAP_SWIOTLB           10
> > >  \end{lstlisting}
> > >  
> > >          Any other value is reserved for future use.
> > > @@ -744,6 +747,36 @@ \subsubsection{Vendor data capability}\label{sec:Virtio
> > >  The driver MUST qualify the \field{vendor_id} before
> > >  interpreting or writing into the Vendor data capability.
> > >  
> > > +\subsubsection{Software IOTLB bounce buffer capability}\label{sec:Virtio
> > > +Transport Options / Virtio Over PCI Bus / PCI Device Layout /
> > > +Software IOTLB bounce buffer capability}
> > > +
> > > +The optional Software IOTLB bounce buffer capability allows the
> > > +device to provide a memory region which can be used by the driver
> > > +driver for bounce buffering. This allows a device on the PCI
> > > +transport to operate without DMA access to system memory addresses.
> > > +
> > > +The Software IOTLB region is referenced by the
> > > +VIRTIO_PCI_CAP_SWIOTLB capability. Bus addresses within the referenced
> > > +range are not subject to the requirements of the VIRTIO_F_ORDER_PLATFORM
> > > +capability, if negotiated.
> > 
> > 
> > why not? an optimization?
> > A mix of swiotlb and system memory might be very challenging from POV
> > of ordering.
> 
> Conceptually, these addresses are *on* the PCI device. If the device is
> accessing addresses which are local to it, they aren't subject to IOMMU
> translation/filtering because they never even make it to the PCI bus as
> memory transactions.
> 
> > 
> > > +
> > > +\devicenormative{\paragraph}{Software IOTLB bounce buffer capability}{Virtio
> > > +Transport Options / Virtio Over PCI Bus / PCI Device Layout /
> > > +Software IOTLB bounce buffer capability}
> > > +
> > > +Devices which present the Software IOTLB bounce buffer capability
> > > +SHOULD also offer the VIRTIO_F_SWIOTLB feature.
> > > +
> > > +\drivernormative{\paragraph}{Software IOTLB bounce buffer capability}{Virtio
> > > +Transport Options / Virtio Over PCI Bus / PCI Device Layout /
> > > +Software IOTLB bounce buffer capability}
> > > +
> > > +The driver SHOULD use the offered buffer in preference to passing system
> > > +memory addresses to the device.
> > 
> > Even if not using VIRTIO_F_SWIOTLB? Is that really necessary?
> 
> That part isn't strictly necessary, but I think it makes sense, for
> cases where the SWIOTLB support is an *optimisation* even if it isn't
> strictly necessary.
> 
> Why might it be an "optimisation"? Well... if we're thinking of a model
> like pKVM where the VMM can't just arbitrarily access guest memory,
> using the SWIOTLB is a simple way to avoid that (by using the on-board
> memory instead, which *can* be shared with the VMM).
> 
> But if we want to go to extra lengths to support unenlightened guests,
> an implementation might choose to just *disable* the memory protection
> if the guest doesn't negotiate VIRTIO_F_SWIOTLB, instead of breaking
> that guest.
> 
> Or it might have a complicated emulation/snooping of virtqueues in the
> trusted part of the hypervisor so that it knows which addresses the
> guest has truly *asked* the VMM to access. (And yes, of course that's
> what an IOMMU is for, but when have you seen hardware companies design
> a two-stage IOMMU which supports actual PCI passthrough *and* get it
> right for the hypervisor to 'snoop' on the stage1 page tables to
> support emulated devices too....)
> 
> Ultimately I think it was natural to advertise the location of the
> buffer with the VIRTIO_PCI_CAP_SWIOTLB capability and then to have the
> separate VIRTIO_F_SWIOTLB for negotiation... leaving the obvious
> question of what a device should do if it sees one but *not* the other.
> 
> Obviously you can't have VIRTIO_F_SWIOTLB *without* there actually
> being a buffer advertised with VIRTIO_PCI_CAP_SWIOTLB (or its
> equivalent for other transports). But the converse seemed reasonable as
> a *hint* even if the use of the SWIOTLB isn't mandatory.

OK but I feel it's more work than you think, so we really need
a better reason than just "why not".

For example, it's not at all clear to me how the ordering is
going to work if buffers are in memory but the ring is swiotlb
or the reverse. Ordering will all be messed up.

-- 
MST

