Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F1D2EE96F
	for <virtualization@lists.linux.dev>; Tue, 17 Jun 2025 19:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750189593; cv=none; b=fpQeueP7FVvxHh/um3+gpnZbWSr/CJBHfb8H6XRj0tQzQ0VBr4oUbxz8wvsSosalBlS7l6ihFb8ZYwCh5fMtSRRGZCoPPw+MXEwJX8Tvar+LswpU7nua4TR14w5pUe4rvujsgqx7K83bLQVKs62SVtgfDMneuPIfV2u+8ZimKVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750189593; c=relaxed/simple;
	bh=6SdbPPe9pmSE8+0ZJM1umJlBQZ1wA58S28tOdEyrjyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=twnMXotQdFR3KbFSsIXJTw/3qBIK8WvaVJtZdyorRRrpeF/oaJYS4vq8Lb1YGxx10BhgHpHxLMA2eRDUZvItcCHPKo/KCPQLcVu31P+74kh0DQTU2sGBAeWsz5LMBnbMeTXVYn1HTu5UAtJQFVWTCKy3kgiktsuCVYSlDjLOF6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ge9TFfAx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ge9TFfAx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750189586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=icFJhskVkKQqZu2iPajxPrgD6zNA+fOLsrBnVy7h8EQ=;
	b=Ge9TFfAxUkdAQOkD+NY36Je4bbGXW0QDykg2HVY9YIV87CshgAKptVNl1neNO612KTURvv
	nxCIfVWRIJWwhx0Uvm/vzZ2frCCXjdX9b/4CwdawcbElT37rvx3bTJwGAQDsT+URbTNYAl
	qAITwCPEzHIfU8oPG+3pjeX5UvGfMD8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-5ea9cX5tPPqzr4NFfg48KA-1; Tue, 17 Jun 2025 15:46:25 -0400
X-MC-Unique: 5ea9cX5tPPqzr4NFfg48KA-1
X-Mimecast-MFC-AGG-ID: 5ea9cX5tPPqzr4NFfg48KA_1750189576
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a50816cc58so2068967f8f.3
        for <virtualization@lists.linux.dev>; Tue, 17 Jun 2025 12:46:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750189576; x=1750794376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icFJhskVkKQqZu2iPajxPrgD6zNA+fOLsrBnVy7h8EQ=;
        b=A6d8uqS9Vzg+qy+fNum5vlBqT/ngo9FSsp0U9kRz90odIOM5/J5diqOT0/y76jywJy
         C5tAmxeb6Xp7Q3HXa+n459kXjVT3ZjJih5XGeoLB1LSBvkaL0nGSiHcMGKWlIIGnJWOa
         3edraUvb0XgY8iSVV9PLHZKCfrd7WRTgZHj1wE7fUZ8YgqlNb5DGfBzwXqNSm+ZbtOEH
         cKYpCn9e+k0rF7iue/p8TeL/eSSn9c46/5yWuZGacA0jS34cv3yCEJA9ssJp633gDweP
         nppsha+xQMIqSxjOZbdKwvKvOKSN6K3Ac6NZRtno+uS3w2eSrEkeTe++iMGMZO8NpClC
         d+2g==
X-Forwarded-Encrypted: i=1; AJvYcCUchVUiAOGfyKwMwlKfGpAHqFUheGHhqVrdM+hXdJcnx2SZxxeH36Unj8JQchTrJgWGnfA54F3cf5Sbm0DY/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzlWoNkeu2DWISDpffwG4c6DL+ln0mAkCx1Ze9JgG8U3RXMYZA1
	V24ufdQa1LczAUqrSLaRpA0CLy8ksUQLIKUYbCHh0U2zoaCVOsfGWxJEUHm0917ihYho0UJi/6J
	aNguhVwMDsVXQapqo/DhLFEzD6rGPh6aisp3KKxGWZ4wPzWpk5Y47AWsDu5UYgnlz3cHN
X-Gm-Gg: ASbGncuyjTIki9RN6O7FBiks9woNB4c4CvR6zjofv8eAn061CJ9wxgvEJeVXrpT9ifi
	xX+cIUQi/v5hW01q1h0FV3obuMBq4GXcxNPGhnGYC0X5ugOVtLZwoqGhuRTjavGt1ZqxNXSEW0a
	CqpVqx3qPNnlmv90QT74IdrSmpCTkOSBUivehqkqWtpmLEaXGLJxJgiFNMnE4MGcHfg3KTecBK7
	DVsSK/oXP5qhhM62GoM0OTClcuZoc2cpmQCxyzgBO9Xj+TRQKQRY3K0StrQcj+kvt4R8b+Fe0rs
	GBkIO0+wPAdPTdGY
X-Received: by 2002:a05:6000:2007:b0:3a5:25e0:1851 with SMTP id ffacd0b85a97d-3a5723660b5mr12195287f8f.7.1750189576218;
        Tue, 17 Jun 2025 12:46:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFO9JZf66g6UmsF+FsTytz4QymacwGU4iFb1DNv63Dd/5GxeH4PDvqwykdFRQ9tUf5lrXqgjg==
X-Received: by 2002:a05:6000:2007:b0:3a5:25e0:1851 with SMTP id ffacd0b85a97d-3a5723660b5mr12195258f8f.7.1750189575837;
        Tue, 17 Jun 2025 12:46:15 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:4300:f7cc:3f8:48e8:2142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a543d9sm14603319f8f.5.2025.06.17.12.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 12:46:15 -0700 (PDT)
Date: Tue, 17 Jun 2025 15:46:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Alyssa Ross <hi@alyssa.is>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev, x86@kernel.org,
	Spectrum OS Development <devel@spectrum-os.org>
Subject: Re: Virtio-IOMMU interrupt remapping design
Message-ID: <20250617154524-mutt-send-email-mst@kernel.org>
References: <>
 <a65d955c-192b-4e79-ab11-8e2af78b62af@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <a65d955c-192b-4e79-ab11-8e2af78b62af@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: beEvKvNYQlef7cw52bPdCk5so21ERafmeRwK8NWgi3M_1750189576
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 15, 2025 at 02:47:15PM -0400, Demi Marie Obenour wrote:
> Virtio-IOMMU interrupt remapping turned out to be much harder than I
> realized.  The main problem is that interrupt remapping is set up
> very early in boot.  In fact, Linux calls the interrupt remapping probe
> function from the APIC initialization code: x86_64_probe_apic ->
> enable_IR_x2apic -> irq_remapping_prepare().  This is almost certainly
> much before PCI has been initialized.  Also, the order in which devices
> will be initialized is not something Linux guarantees at all, which is a
> problem because interrupt remapping must be initialized before drivers
> start setting up interrupts.  Otherwise, the interrupt remapping table
> won't include entries for already-existing interrupts, and things will
> either break badly, not get the benefit of interrupt remapping
> security-wise, or both.
> 
> The reason I expect this doesn't cause problems for address translation
> is that the IOMMU probably starts in bypass mode by default, meaning
> that all DMA is permitted.  If the IOMMU is only used by VFIO or
> IOMMUFD, it will not be needed until userspace starts up, which is after
> the IOMMU has been initialized.  This isn't ideal, though, as it means
> that kernel drivers operate without DMA protection.
> 
> Is a paravirtualized IOMMU with interrupt remapping something that makes
> sense?  Absolutely!  However, the IOMMU should be considered a platform
> device that must be initialized very early in boot.  Using virtio-IOMMU
> with MMIO transport as the interface might be a reasonable option, but
> the IOMMU needs to be enumerated via ACPI, device tree, or kernel
> command line argument.  This allows it to be brought up before anything
> capable of DMA is initialized.
> 
> Is this the right path to go down?  What do others think about this?
> -- 
> Sincerely,
> Demi Marie Obenour (she/her/hers)



The project for this discussion is also virtio-comment,
this ML is for driver work.



