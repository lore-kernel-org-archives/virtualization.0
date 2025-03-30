Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE1DAD2F
	for <virtualization@lists.linux.dev>; Sun, 30 Mar 2025 21:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743371335; cv=none; b=iuEp6Fz73MLVBFJrqNl0YarllCY9Bz5viZpcQt4CFQt6hzHmZYWR+ijSe2tEhQOpm47NOB012HNkbtcXMFg4SR3djmFev8co8lOlvRCNdxwVg6QVRJJYSy3/3l4gA5Sb9b/e2+8qhEqF/Kev0VRDvAZI8QqMcGPi+kbYDswEAO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743371335; c=relaxed/simple;
	bh=KZH/gVFLFKR8E7Hs8KBGnWzJSYu4wOpcLXfxzdOJuWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=b3xsUbhnbY76mc6Vo1VDIX0CQsyDHsQ2wCCKdgFJbv20E4l10F9rNyWAWwjfrmtJbagtJg3eyuUbRHF2dDbuqm0o9rz9SMbLRliGrbdxmGfJtpwWluHZE6Qb3c9rxZmZn6NoXx6U9iSy9iE5dChr0W0Xl3kNKvSp0AVjsI7u0yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hNpU6pON; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hNpU6pON"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743371332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MRkqFL3NXkPCwg+oa2kxw02pthB6mXCTdemECWhwX84=;
	b=hNpU6pONKodQd8M3EaFiv2hkW8z9T57xb8mKe/6fwQP4r2uOXMyqo/dfIt+nlnwHmtXVbq
	wQ1vehs87NGYy8Q7MT4LQCIlSRbjYF5CCA/r/K1EJJlhdTm8m3Hk+CthvJvXu8MncyODep
	UN7+vTARjHsksykNsg+mytaw1YWHr/o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-Gya-k0gDNq6m3GaPhwKPuQ-1; Sun, 30 Mar 2025 17:48:51 -0400
X-MC-Unique: Gya-k0gDNq6m3GaPhwKPuQ-1
X-Mimecast-MFC-AGG-ID: Gya-k0gDNq6m3GaPhwKPuQ_1743371330
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cf3168b87so19826155e9.2
        for <virtualization@lists.linux.dev>; Sun, 30 Mar 2025 14:48:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743371330; x=1743976130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRkqFL3NXkPCwg+oa2kxw02pthB6mXCTdemECWhwX84=;
        b=giGjcSyTgt3xXyxrrO03GZ6bnv6vduU88TFtPTIcYlWi6poZYSV0gmILNucnZ7JWyt
         FQIL5GMXDzFI1xI0y9WONt7Sgo1N0eDIEyySlfFXrqbtVkYeaeefsIIYLBeo3uJPRxCq
         4fYAKquh+A/hO/t/puJmKvL0YPFlzZlFIP8s6Zy3LeZjKcVSplovrA39GntjCfVOwg9L
         SRcQAjaJd9C3/zWIZhfcgw+Z24XROby+L7wehiaGcMHGdRRhJj93Gz/saK7V/c1/9Yw/
         5r46t52MhFn+eBQ7ll5klRlbJGD8qZlayacH5Kb89xSz8V7upSSHYApd+5l6DbM9pxBs
         PVPw==
X-Forwarded-Encrypted: i=1; AJvYcCXrPIwJnAIT26cDvL9efN76IcnouYfHapAaQpabYDn2XQp4qFfIye7TicOigNIguRIzUKKjYDGjeV3c5Pq1Pw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwNswOhpfImvKF9tRppmokBHsHIWMsUnxnuYTtt9WHdPGY2oPu5
	r2CYgtpUg4UODYWLLdbcsXKH3FzP2PbUsMXdeJfBKCAuU+mWsFOCOXfmF3izd59mCTLQlRWMpKi
	twkHE8M+TiUsQKpCKywH3qbFK+xzM5hBIN8BhDvg6o24Cnk4eWDnSdKz8eMjN8aT6
X-Gm-Gg: ASbGncubpw+ZcGgYXaBhqRHcmGJrIFns73uxqfs3kp8Z4xAd3YMEDF2/it27TADlAgP
	biHShBT9PJhJsAL8A+uoSmb+IdY92S9JOYvfwIVR/InP0q7Vu3Q2QJJH5IJ4vx1CnUOLTrlt+oc
	Gh51twXvlhJxGrnDRszsBt/8fDyRRlTt13shPFH/oUA5Tq72mhvKk4c0f7AnDhu1bHnawc7ouCX
	e9mdm0FTKXo6vqehsNw8QIozTHTgA26gjqpFstYnSXjRzF0M7zu/wvPAsDQE9iqyUZOl760biIq
	7ENqJ6QEGg==
X-Received: by 2002:a05:600c:1d8c:b0:43c:f050:fee8 with SMTP id 5b1f17b1804b1-43db628992cmr52509515e9.20.1743371329781;
        Sun, 30 Mar 2025 14:48:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1kdHHR/M4aOUOFDnZpG/iLLAoqQlqVBS2836/4CKe19RX2SyJrF+xilFjC/1QxsrymXzr6Q==
X-Received: by 2002:a05:600c:1d8c:b0:43c:f050:fee8 with SMTP id 5b1f17b1804b1-43db628992cmr52509055e9.20.1743371329422;
        Sun, 30 Mar 2025 14:48:49 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82e83477sm147882045e9.16.2025.03.30.14.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 14:48:48 -0700 (PDT)
Date: Sun, 30 Mar 2025 17:48:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org, Claire Chang <tientzu@chromium.org>,
	Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
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
Message-ID: <20250330173951-mutt-send-email-mst@kernel.org>
References: <20210209062131.2300005-1-tientzu@chromium.org>
 <979b6a34ca5724ced1d4871b58bf227065d7da57.camel@infradead.org>
 <20250321142947-mutt-send-email-mst@kernel.org>
 <d1382a6ee959f22dc5f6628d8648af77f4702418.camel@infradead.org>
 <20250330125929-mutt-send-email-mst@kernel.org>
 <E3EE485D-AD74-457C-BDEC-F8C62DFE4909@infradead.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <E3EE485D-AD74-457C-BDEC-F8C62DFE4909@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dZ6PtBKo3Na4CncZrrH7vT6YlOYSJ7cDjBVVUZosKIQ_1743371330
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 30, 2025 at 10:27:58PM +0100, David Woodhouse wrote:
> On 30 March 2025 18:06:47 BST, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> It's basically just allowing us to expose through PCI, what I believe
> >> we can already do for virtio in DT.
> >
> >I am not saying I am against this extension.
> >The idea to restrict DMA has a lot of merit outside pkvm.
> >For example, with a physical devices, limiting its DMA
> >to a fixed range can be good for security at a cost of
> >an extra data copy.
> >
> >So I am not saying we have to block this specific hack.
> >
> >what worries me fundamentally is I am not sure it works well
> >e.g. for physical virtio cards.
> 
> Not sure why it doesn't work for physical cards. They don't need to be bus-mastering; they just take data from a buffer in their own RAM.

I mean, it kind of does, it is just that CPU pulling data over the PCI bus
stalls it so is very expensive. It is not by chance people switched to
DMA almost exclusively.


> >Attempts to pass data between devices will now also require
> >extra data copies.
> 
> Yes. I think that's acceptable, but if we really cared we could perhaps extend the capability to refer to a range inside a given BAR on a specific *device*? Or maybe just *function*, and allow sharing of SWIOTLB buffer within a multi-function device?

Fundamentally, this is what dmabuf does.

> I think it's overkill though.
> 
> >Did you think about adding an swiotlb mode to virtio-iommu at all?
> >Much easier than parsing page tables.
> 
> Often the guests which need this will have a real IOMMU for the true
> pass-through devices.

Not sure I understand. You mean with things like stage 2 passthrough?

> Adding a virtio-iommu into the mix (or any other
> system-wide way of doing something different for certain devices) is
> problematic.

OK... but the issue isn't specific to no DMA devices, is it?


> The on-device buffer keeps it nice and simple,

I am not saying it is not.
It's just a little boutique.

> and even allows us to
> do device support for operating systems like Windows where it's a lot
> harder to do anything generic in the core OS.

Well we do need virtio iommu windows support sooner or later, anyway.

-- 
MST

