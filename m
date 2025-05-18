Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E00F1F463E
	for <virtualization@lists.linux.dev>; Sun, 18 May 2025 20:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747599057; cv=none; b=N8fclAm6pUrshH/OL+p7NroFkGG3it8Oj+I2yyPgoKzqXDGBJWTqpo8u4mmwRcT3Gds9sxZyjhXh8ZADJTANVnRxnYsY+Ib7RVlr/MIVj3RsyoKMK2X3jpcrVGyCAkUBKzwMbPRuHoZTuUP9mZRMEedWrnh4l5JUvn82mM2GJY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747599057; c=relaxed/simple;
	bh=BZghFxnzXNSsmGXc+tWUOfKJ3tXV3mjjGNZeuOUUjHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YPcprEjshQwlPZOTjrxMcpBKWzFL8HBTl2P7ThEl6Q5BiyGZb73jR2MeXHosKdPR64d/4HVs5zi8+j/wxBIu3iACwRyzQidqnGeDkPQI9UR1HmQjnFDtTg1AGZXy/uOoG8KWjIWP3X3mz5aXYCaxQJTxrOGzMBKR5JOOFbtLOlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=REKGX5/s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="REKGX5/s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747599054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o3OJIBHhQbvH4C7u2Xf44+7JcPKOKfrafXSUikraTic=;
	b=REKGX5/sc71qKZVk40lGUjt5gZy1PdfI3yDmbqsRLNRKDBf7qnoQRpVxQmqqlINjuM06mz
	7rg5SFn5hiq/co9Kl1hKvfPd/jcD1RnV08DePzgPO1W/cgXs85M5KfmMQMg/HilTuk1w8G
	jexQgMS2JXavog0UeIAR4qedaDtPMGU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-mJbsEWJ7NkydafXjW_QiMw-1; Sun, 18 May 2025 16:10:52 -0400
X-MC-Unique: mJbsEWJ7NkydafXjW_QiMw-1
X-Mimecast-MFC-AGG-ID: mJbsEWJ7NkydafXjW_QiMw_1747599051
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-442fda1cba7so10312675e9.1
        for <virtualization@lists.linux.dev>; Sun, 18 May 2025 13:10:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747599051; x=1748203851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3OJIBHhQbvH4C7u2Xf44+7JcPKOKfrafXSUikraTic=;
        b=UTK1JtAyIVbKFZNt4a11yQ9NUIWsy7wiDDZBT56Qvg9EZh5pZ9BJrIicUpigW3J0v8
         Uhqamz0GW5w/PRmLYK8V+V0meJMBsZpWl5fAT1/OY2iyMAy8MiVWyrmASj6uFGgms57/
         iR5xCi8+Z4cxkZfw79QtJkClRwPz7wgkkJX4yGWY0hM/MoBTnk0/zPy76g1ubQJAWzI6
         nIEXILbdAk0rFKHYCGb2JeEje7U3h59Tl6nuw/WrdVmiLk/efGqoCCKyQ8G62xGasTnh
         GsGi5TUoiHgoAcVUAXwp0tCkoOibfbqlJrr70QhuKRFgKgNjMRFFLrBGn+Xozqky7h/l
         oVHg==
X-Forwarded-Encrypted: i=1; AJvYcCVRGFhUClWeQZkS8m4kbJrJegkGnGTWY4A8W8zuCljh7KFLLmF9JGjEqZmrxqmVc2nwug6RBAAQSW0vu+Yskg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzMXQVuMJ3tXJ83ZBWCl6XvhwuH6wcCZKfwZ2U/EsCup/VOPs2h
	58zpt6vFhAwZhEAMGrHN+d2VrEDU5TFSZbEoIYh3SdhUCDuf+cvBb/7UcdgoTSFqyWwvs6pdNil
	CBiFgTPSRrE0uQxvSJk/T//cHqjFzfjnVvLyW+uKcC3qM+VM20cVbFwTxbwBEyJ3Jy0cf
X-Gm-Gg: ASbGncvH6weRKMFEF593J4Ge30fWx1P7ZC9YLb/IdbjKg/MzWGh0Xm5K1zTxTi+TyAK
	d9Hjf0+DbWaoNtKjWP4/yDYsaE0mbH/W8S4IO8C1OGlpBgYrNKAm40WBf1E2/KcCjwcjRz7YZKQ
	qHUAyyZYruttgfRdgOBByZZIS1hAXOO6Xz/eK7ahBLNb1zqTbxL0uQwhriTty5O55lp8zAAgLMH
	EYYBlJmS+yiAMO56OFsf1fAQn/NlVmHNe5j1RyM8E5ziXYrXVJqnavnK3dlRzDP1EeHfUBxs6qq
	zE15kA==
X-Received: by 2002:a05:600c:3c82:b0:43d:7588:667b with SMTP id 5b1f17b1804b1-445229b42b7mr37633405e9.10.1747599050877;
        Sun, 18 May 2025 13:10:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9jnPJWyH4uHKeXx423hSexRvEamch9ljSyzfnly8GcWhHz5Jv8eYgLruUdeBR+mLa1dJkMw==
X-Received: by 2002:a05:600c:3c82:b0:43d:7588:667b with SMTP id 5b1f17b1804b1-445229b42b7mr37633235e9.10.1747599050463;
        Sun, 18 May 2025 13:10:50 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f3951854sm183062725e9.24.2025.05.18.13.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 13:10:49 -0700 (PDT)
Date: Sun, 18 May 2025 16:10:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	David Matlack <dmatlack@google.com>,
	Like Xu <like.xu.linux@gmail.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Yong He <alexyonghe@tencent.com>
Subject: Re: [PATCH v2 0/8] irqbypass: Cleanups and a perf improvement
Message-ID: <20250518161024-mutt-send-email-mst@kernel.org>
References: <20250516230734.2564775-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250516230734.2564775-1-seanjc@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UWwiaH60I2R7q2qS0zv6t4yatoy1SvDWGa-LwnHovPw_1747599051
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 16, 2025 at 04:07:26PM -0700, Sean Christopherson wrote:
> The two primary goals of this series are to make the irqbypass concept
> easier to understand, and to address the terrible performance that can
> result from using a list to track connections.
> 
> For the first goal, track the producer/consumer "tokens" as eventfd context
> pointers instead of opaque "void *".  Supporting arbitrary token types was
> dead infrastructure when it was added 10 years ago, and nothing has changed
> since.  Taking an opaque token makes a very simple concept (device signals
> eventfd; KVM listens to eventfd) unnecessarily difficult to understand.
> 
> Burying that simple behind a layer of obfuscation also makes the overall
> code more brittle, as callers can pass in literally anything. I.e. passing
> in a token that will never be paired would go unnoticed.
> 
> For the performance issue, use an xarray.  I'm definitely not wedded to an
> xarray, but IMO it doesn't add meaningful complexity (even requires less
> code), and pretty much Just Works.  Like tried this a while back[1], but
> the implementation had undesirable behavior changes and stalled out.
> 
> Note, I want to do more aggressive cleanups of irqbypass at some point,
> e.g. not reporting an error to userspace if connect() fails is awful
> behavior for environments that want/need irqbypass to always work.  And
> KVM shold probably have a KVM_IRQFD_FLAG_NO_IRQBYPASS if a VM is never going
> to use device posted interrupts.  But those are future problems.
> 
> v2:
>  - Collect reviews. [Kevin, Michael]
>  - Track the pointer as "struct eventfd_ctx *eventfd" instead of "void *token".
>    [Alex]
>  - Fix typos and stale comments. [Kevin, Binbin]
>  - Use "trigger" instead of the null token/eventfd pointer on failure in
>    vfio_msi_set_vector_signal(). [Kevin]
>  - Drop a redundant "tmp == consumer" check from patch 3. [Kevin]
>  - Require producers to pass in the line IRQ number.


VDPA bits:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> v1: https://lore.kernel.org/all/20250404211449.1443336-1-seanjc@google.com
> 
> [1] https://lore.kernel.org/all/20230801115646.33990-1-likexu@tencent.com
> [2] https://lore.kernel.org/all/20250401161804.842968-1-seanjc@google.com
> 
> Sean Christopherson (8):
>   irqbypass: Drop pointless and misleading THIS_MODULE get/put
>   irqbypass: Drop superfluous might_sleep() annotations
>   irqbypass: Take ownership of producer/consumer token tracking
>   irqbypass: Explicitly track producer and consumer bindings
>   irqbypass: Use paired consumer/producer to disconnect during
>     unregister
>   irqbypass: Use guard(mutex) in lieu of manual lock+unlock
>   irqbypass: Use xarray to track producers and consumers
>   irqbypass: Require producers to pass in Linux IRQ number during
>     registration
> 
>  arch/x86/kvm/x86.c                |   4 +-
>  drivers/vfio/pci/vfio_pci_intrs.c |  10 +-
>  drivers/vhost/vdpa.c              |  10 +-
>  include/linux/irqbypass.h         |  46 ++++----
>  virt/kvm/eventfd.c                |   7 +-
>  virt/lib/irqbypass.c              | 190 +++++++++++-------------------
>  6 files changed, 107 insertions(+), 160 deletions(-)
> 
> 
> base-commit: 7ef51a41466bc846ad794d505e2e34ff97157f7f
> -- 
> 2.49.0.1112.g889b7c5bd8-goog

