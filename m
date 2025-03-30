Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3486A1C3F34
	for <virtualization@lists.linux.dev>; Sun, 30 Mar 2025 13:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743342140; cv=none; b=IbSKJ3nVqNXB9mxk3YK+5NRMcAUhVKw8NW55ItA5QFJSGGR/cHtaJ8+PAVQ3t6vqUBNsYbjb1G00IKKHKuiyUMK1zpeqPh2AYif34EL0yBgApzREI5sJuRg4WJ/p0zFVQ2CsbqAqcFqDnfMD/om0lZe6u12ysRoNLuVQoI8DOXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743342140; c=relaxed/simple;
	bh=2cv65ANmvXQxsrzcnNi+iyx/EAJeHzczP4T4gq8dZCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=c5EJjyD/eWqq8bteRck2UHy/u1HhNd2emGltBb3AIMZlJO6TOskyzRi9YJSUltm7X+PO0wnb/nVvWJ2WAWhqz0lAje4F0hauaeXVLqYWrMYSyJ9Ldzck56v+VmVgXmx6yPHnQ76XZfP6aRZMYIgA5z0mK/LHi4eM08ZgufKwcOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=apTelp9U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="apTelp9U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743342138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EVKwqJPfr4QPaIDNGk2hvYA8CboNSIQugm7IZY2L/BA=;
	b=apTelp9U7lLc3kM4d7/EK6a2qjTv8pzhiTdtP/SPQaDpYBAjOWQzlAb6sGtVgM+kwW69hg
	FbI+dX/DzdFbX3ou4TqDDPt1biTQwxM33geZHlNCaqIThhUXMuVoFsygEHOGNQ4f5cZ0+Q
	WLlG2Z8zF/Nb4ZcTc2P+kSSXAH8oWtc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-0pZ6GReBPP-R0dvrj4q1BQ-1; Sun, 30 Mar 2025 09:42:16 -0400
X-MC-Unique: 0pZ6GReBPP-R0dvrj4q1BQ-1
X-Mimecast-MFC-AGG-ID: 0pZ6GReBPP-R0dvrj4q1BQ_1743342135
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43bc97e6360so19937255e9.3
        for <virtualization@lists.linux.dev>; Sun, 30 Mar 2025 06:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743342135; x=1743946935;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EVKwqJPfr4QPaIDNGk2hvYA8CboNSIQugm7IZY2L/BA=;
        b=e7lRifw6upbI2eI3JDsnwhk2HQO1CJZXcwAfV3wygtHzTEejveRirZDqlfRr2RCbZn
         CXWd6hmFEHdrIWEkNjlZ4c7A0FWy3xKr6YqO/NtdC1zTspMIkrgyD8GLRhVosa/wtGfl
         muGLsKVCGv8XiL5IUsCiyE3qpO+jM9fEPOG60U+67Wns1EYinfZnqrJWv+3pLv8FOZfm
         S48ZTOaiP/y2qew29tFFvU/0jfysI29nHkoSQ1tbxqsS6rZV/8nTszI8T1STcAiaW5mb
         z1vuZP/dpdAiTT35GUB9bpLbiAe2ikqk+Z0ucy1UPJLgdF+7tveDIJEtJM9PGhRjMh86
         2eLg==
X-Forwarded-Encrypted: i=1; AJvYcCWJOektPXIz3JhUfG5l91n4hugfnIfnwmrDT611/OtSVPM5sb8VUYFYhcfmITPuQ6ZqzLht/1xyO/yvxL0quA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxCCFwMvNkDzHzEQaQzG3cjjRUSfZ2Cu5JZV9BoAwkwX9vygZ8o
	NupaXT7/pTt5CCVOwD71sx8eYdbM2sn350GFTWfQDKd7ieh7wqO+5ec2aa/bec2DBo1MZkYx4l/
	CZzTF9MkEWnfqwWBx601l4rHRWPjoqtDgALTibzdo+Brf2K2ZG4gkEv4LvVyPmY7Y
X-Gm-Gg: ASbGncs7Xo/+mkwFQvIVnkS9S6sJxDUP0NJ81Efyv4TGgObiPRWLWIUj60qkmmkXx1Y
	BSA8C9bL+h2A6Va4r+kess6WTeADgWIIqmaLkKUlm8ZZiKlp+KVfkIR2K58EaSh7Ma4S6eUzS22
	OBUE5DoDyZ00++LbuF3psKxUZasj6n1KcM0QBxdf68+xvpBGjU7xgZVI8hMZ0VTJfPcyk+mJlvg
	e57VZn2VyPqoSnyXEhrxJbwFFNjRmqgJUqazLUKufOekXOnUqoKn/2N8bgLMAA1XyvZmaPC8Y4p
	Ix2aVXO/qg==
X-Received: by 2002:a05:600c:384d:b0:43c:fded:9654 with SMTP id 5b1f17b1804b1-43db62bd0a5mr44135445e9.19.1743342134759;
        Sun, 30 Mar 2025 06:42:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFceVYy8P/4rdEylphWngsUQJtsROJ+u5xjCs5nBFb/+Q+tLCz4LEP8IBXSQxv5v24A9e0nCQ==
X-Received: by 2002:a05:600c:384d:b0:43c:fded:9654 with SMTP id 5b1f17b1804b1-43db62bd0a5mr44134915e9.19.1743342134286;
        Sun, 30 Mar 2025 06:42:14 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d90000f48sm91443025e9.37.2025.03.30.06.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 06:42:12 -0700 (PDT)
Date: Sun, 30 Mar 2025 09:42:07 -0400
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
Message-ID: <20250330093532-mutt-send-email-mst@kernel.org>
References: <20210209062131.2300005-1-tientzu@chromium.org>
 <979b6a34ca5724ced1d4871b58bf227065d7da57.camel@infradead.org>
 <20250321142947-mutt-send-email-mst@kernel.org>
 <d1382a6ee959f22dc5f6628d8648af77f4702418.camel@infradead.org>
 <8e7084b04e5c0456c0ff32ea131a199c6af763cd.camel@infradead.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <8e7084b04e5c0456c0ff32ea131a199c6af763cd.camel@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ggy1B4WoZvm8gbDWGaGb8BDQa7FQOw5KcsiKh0rzGrI_1743342135
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Mar 28, 2025 at 05:40:41PM +0000, David Woodhouse wrote:
> On Fri, 2025-03-21 at 18:42 +0000, David Woodhouse wrote:
> > On Fri, 2025-03-21 at 14:32 -0400, Michael S. Tsirkin wrote:
> > > On Fri, Mar 21, 2025 at 03:38:10PM +0000, David Woodhouse wrote:
> > > > On Tue, 2021-02-09 at 14:21 +0800, Claire Chang wrote:
> > > > > This series implements mitigations for lack of DMA access control on
> > > > > systems without an IOMMU, which could result in the DMA accessing the
> > > > > system memory at unexpected times and/or unexpected addresses, possibly
> > > > > leading to data leakage or corruption.
> > > > 
> > > > Replying to an ancient (2021) thread which has already been merged...
> > > > 
> > > > I'd like to be able to use this facility for virtio devices.
> > > > 
> > > > Virtio already has a complicated relationship with the DMA API, because
> > > > there were a bunch of early VMM bugs where the virtio devices where
> > > > magically exempted from IOMMU protection, but the VMM lied to the guest
> > > > and claimed they weren't.
> > > > 
> > > > With the advent of confidential computing, and the VMM (or whatever's
> > > > emulating the virtio device) not being *allowed* to arbitrarily access
> > > > all of the guest's memory, the DMA API becomes necessary again.
> > > > 
> > > > Either a virtual IOMMU needs to determine which guest memory the VMM
> > > > may access, or the DMA API is wrappers around operations which
> > > > share/unshare (or unencrypt/encrypt) the memory in question.
> > > > 
> > > > All of which is complicated and slow, if we're looking at a minimal
> > > > privileged hypervisor stub like pKVM which enforces the lack of guest
> > > > memory access from VMM.
> > > > 
> > > > I'm thinking of defining a new type of virtio-pci device which cannot
> > > > do DMA to arbitrary system memory. Instead it has an additional memory
> > > > BAR which is used as a SWIOTLB for bounce buffering.
> > > > 
> > > > The driver for it would look much like the existing virtio-pci device
> > > > except that it would register the restricted-dma region first (and thus
> > > > the swiotlb dma_ops), and then just go through the rest of the setup
> > > > like any other virtio device.
> > > > 
> > > > That seems like it ought to be fairly simple, and seems like a
> > > > reasonable way to allow an untrusted VMM to provide virtio devices with
> > > > restricted DMA access.
> > > > 
> > > > While I start actually doing the typing... does anyone want to start
> > > > yelling at me now? Christoph? mst? :)
> > > 
> > > 
> > > I don't mind as such (though I don't understand completely), but since
> > > this is changing the device anyway, I am a bit confused why you can't
> > > just set the VIRTIO_F_ACCESS_PLATFORM feature bit?  This forces DMA API
> > > which will DTRT for you, will it not?
> > 
> > That would be necessary but not sufficient. ...

could you explain pls?

> My first cut at a proposed spec change looks something like this. I'll
> post it to the virtio-comment list once I've done some corporate
> bureaucracy and when the list stops sending me python tracebacks in
> response to my subscribe request.

the linux foundation one does this? maybe poke at the admins.

> In the meantime I'll hack up some QEMU and guest Linux driver support
> to match.
> 
> diff --git a/content.tex b/content.tex
> index c17ffa6..1e6e1d6 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -773,6 +773,9 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>  Currently these device-independent feature bits are defined:
>  
>  \begin{description}
> +  \item[VIRTIO_F_SWIOTLB (27)] This feature indicates that the device
> +  provides a memory region which is to be used for bounce buffering,
> +  rather than permitting direct memory access to system memory.
>    \item[VIRTIO_F_INDIRECT_DESC (28)] Negotiating this feature indicates
>    that the driver can use descriptors with the VIRTQ_DESC_F_INDIRECT
>    flag set, as described in \ref{sec:Basic Facilities of a Virtio
> @@ -885,6 +888,10 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>  VIRTIO_F_ACCESS_PLATFORM is not offered, then a driver MUST pass only physical
>  addresses to the device.
>  
> +A driver SHOULD accept VIRTIO_F_SWIOTLB if it is offered, and it MUST
> +then pass only addresses within the Software IOTLB bounce buffer to the
> +device.
> +
>  A driver SHOULD accept VIRTIO_F_RING_PACKED if it is offered.
>  
>  A driver SHOULD accept VIRTIO_F_ORDER_PLATFORM if it is offered.
> @@ -921,6 +928,10 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>  A device MAY fail to operate further if VIRTIO_F_ACCESS_PLATFORM is not
>  accepted.
>  
> +A device MUST NOT offer VIRTIO_F_SWIOTLB if its transport does not
> +provide a Software IOTLB bounce buffer.
> +A device MAY fail to operate further if VIRTIO_F_SWIOTLB is not accepted.
> +
>  If VIRTIO_F_IN_ORDER has been negotiated, a device MUST use
>  buffers in the same order in which they have been available.
>  
> diff --git a/transport-pci.tex b/transport-pci.tex
> index a5c6719..23e0d57 100644
> --- a/transport-pci.tex
> +++ b/transport-pci.tex
> @@ -129,6 +129,7 @@ \subsection{Virtio Structure PCI Capabilities}\label{sec:Virtio Transport Option
>  \item ISR Status
>  \item Device-specific configuration (optional)
>  \item PCI configuration access
> +\item SWIOTLB bounce buffer
>  \end{itemize}
>  
>  Each structure can be mapped by a Base Address register (BAR) belonging to
> @@ -188,6 +189,8 @@ \subsection{Virtio Structure PCI Capabilities}\label{sec:Virtio Transport Option
>  #define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
>  /* Vendor-specific data */
>  #define VIRTIO_PCI_CAP_VENDOR_CFG        9
> +/* Software IOTLB bounce buffer */
> +#define VIRTIO_PCI_CAP_SWIOTLB           10
>  \end{lstlisting}
>  
>          Any other value is reserved for future use.
> @@ -744,6 +747,36 @@ \subsubsection{Vendor data capability}\label{sec:Virtio
>  The driver MUST qualify the \field{vendor_id} before
>  interpreting or writing into the Vendor data capability.
>  
> +\subsubsection{Software IOTLB bounce buffer capability}\label{sec:Virtio
> +Transport Options / Virtio Over PCI Bus / PCI Device Layout /
> +Software IOTLB bounce buffer capability}
> +
> +The optional Software IOTLB bounce buffer capability allows the
> +device to provide a memory region which can be used by the driver
> +driver for bounce buffering. This allows a device on the PCI
> +transport to operate without DMA access to system memory addresses.
> +
> +The Software IOTLB region is referenced by the
> +VIRTIO_PCI_CAP_SWIOTLB capability. Bus addresses within the referenced
> +range are not subject to the requirements of the VIRTIO_F_ORDER_PLATFORM
> +capability, if negotiated.


why not? an optimization?
A mix of swiotlb and system memory might be very challenging from POV
of ordering.


> +
> +\devicenormative{\paragraph}{Software IOTLB bounce buffer capability}{Virtio
> +Transport Options / Virtio Over PCI Bus / PCI Device Layout /
> +Software IOTLB bounce buffer capability}
> +
> +Devices which present the Software IOTLB bounce buffer capability
> +SHOULD also offer the VIRTIO_F_SWIOTLB feature.
> +
> +\drivernormative{\paragraph}{Software IOTLB bounce buffer capability}{Virtio
> +Transport Options / Virtio Over PCI Bus / PCI Device Layout /
> +Software IOTLB bounce buffer capability}
> +
> +The driver SHOULD use the offered buffer in preference to passing system
> +memory addresses to the device.

Even if not using VIRTIO_F_SWIOTLB? Is that really necessary?

> If the driver accepts the VIRTIO_F_SWIOTLB
> +feature, then the driver MUST use the offered buffer and never pass system
> +memory addresses to the device.
> +
>  \subsubsection{PCI configuration access capability}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / PCI configuration access capability}
>  
>  The VIRTIO_PCI_CAP_PCI_CFG capability
> 


