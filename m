Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457D6267F6E
	for <virtualization@lists.linux.dev>; Tue,  8 Apr 2025 11:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744112991; cv=none; b=b+8bVx4jrbR5MWXqFcSBySEMIKxzjDHKQGGtOSglnGEElZWxBBH68ck4M8lMTA10KmhPhg3CRai0+0eEYjayDMZ+VONhuR2611e5iW4pzwtgyB3Kj2xNapP8X1GIjA87YRBhuGNRMdAUR5H/mtM0da81cT+e+d3giVb6bh0OGrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744112991; c=relaxed/simple;
	bh=juga/NFhbOp5HXMYDZ5mhk5mcegQzBe3II+n7ob2+yY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hmKvcjP5AE6JgWIAeMC5PiHbsQBd+KF4EliwhyhFGiViQduO1ptrtRcDNcNwTk7V7EPkdvSNRkXSSaeR6ISnG/ZGTngSCsbh1iVyczAU4EmEaorI4mDbqGFgAFmA2m6D7y4FsU+XLWvLLJ5NyoVCIx3cQoCG/3bU+b2xQm2xHeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GTOHKcKj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GTOHKcKj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744112988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y007czW7nolro/BBbr+wWrRJwbjuQk2oO7pcjblsRYQ=;
	b=GTOHKcKj/t99VBWj2MEP7/QU2nCRbzcz++xJtxZFOPK4pTap5DYRunj2dulfYDBFAy3rqT
	MBaP1qJkASfgeS4iWaJ3dAIG8YcyKI5FI7yWZ3oV9DFi/NjUX68qDPFAAyWCuoDPfoKt+Z
	xo1U5F28yafSdf/kas19oLHxhtBmILU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-KA-q6cGeP5ioUxXb4A1BZw-1; Tue, 08 Apr 2025 07:49:44 -0400
X-MC-Unique: KA-q6cGeP5ioUxXb4A1BZw-1
X-Mimecast-MFC-AGG-ID: KA-q6cGeP5ioUxXb4A1BZw_1744112984
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4394c489babso27086905e9.1
        for <virtualization@lists.linux.dev>; Tue, 08 Apr 2025 04:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744112983; x=1744717783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y007czW7nolro/BBbr+wWrRJwbjuQk2oO7pcjblsRYQ=;
        b=ZreLtDmIgbHXSQOYE8y8Jz7dFaySLlZ6iBAH0Qsi8z23m3iBGIMrxK1iCZWKA3K2K6
         Sh/8ZCUXwHOVoqfPwEY8cxy6Qcd4PZlMBdRAmGC3kvnRRLe5W7cHsWxtRhQZ2OXrJaJf
         852B3bajazl97vCoJNuSyZ79PmqwHTNqfQyibjSsmB6BNPiDg5oTpp69sFtv/cOUcyXg
         sXN4uJq3rZFjH+wOyGRexhy74R24X3BO1hONSIUGaNIqaWIJ464pzOyZSd1lTHapFVZG
         kLX6hTKPuKEVnfgPz9hl2QI3zQe/EoVzPqdnR3fK8UVfjsECACTnW1Bm5rRgFDG+zG6N
         PfmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbUHglQKL3u9Hm3Kyi7/5lU+662Wtfc2UqU4iqIBhnQobeJgKMx4KSNaI4sisgGTXS15MAxojHlsJ4voztNQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/qPBSfVQ+ygQP90iQcoNc8aeDfW8ED5OGzMoeS9GYB3fZdPsc
	NP/asE6MpD9gBi0OzN9738LhS9YCjpuMTqHbKSEIauvsBmnENT2FUrabNpSAIAGUV5iKY9pG1Tu
	ChLxqF0k8cj6wIzkh9KBJtL/G7VRUod3h6dg7Yx9yx5YSVen4fm35WwqeSjdJjfRj
X-Gm-Gg: ASbGnctVVY0YvlVdQckqsHGdnkII93iArDRWbCZHm3dPTsDJj7W7z8NTa5MGn8ToSyn
	lUhxq55aywuSXbI9Xu4g4KQI5x7bvBPF/5fPNXCmR6frBeWZfHXc7k++F7xeIjxogJfdju3SL/v
	YuNemunOdKgZtNsQAiUzLFbSTinVsgVgbK1qqymrh9XukManyMskYTDj4IX+mvIrwTsurNDfhI0
	qpAfUZT8vEFX6qyxMd9TaD9VHU59GDB0H/V0CQEZHrbt9G3a4zFdAQYiwlqtjsJG7HsWFy4L6hE
	SlTcCC+gUQ==
X-Received: by 2002:a05:6000:1a8d:b0:397:8f09:5f6 with SMTP id ffacd0b85a97d-39cba93cd39mr15652802f8f.47.1744112983547;
        Tue, 08 Apr 2025 04:49:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+o1zR3VRcPlBcclW24I6ljtmxJ4Chpl0YFxpgvpmk6R76rTIbQ1hLofb7K+neh4PaWzsX0g==
X-Received: by 2002:a05:6000:1a8d:b0:397:8f09:5f6 with SMTP id ffacd0b85a97d-39cba93cd39mr15652780f8f.47.1744112983180;
        Tue, 08 Apr 2025 04:49:43 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301b69c4sm14561074f8f.43.2025.04.08.04.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 04:49:42 -0700 (PDT)
Date: Tue, 8 Apr 2025 07:49:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Oliver Upton <oliver.upton@linux.dev>,
	David Matlack <dmatlack@google.com>,
	Like Xu <like.xu.linux@gmail.com>, Yong He <alexyonghe@tencent.com>
Subject: Re: [PATCH 0/7] irqbypass: Cleanups and a perf improvement
Message-ID: <20250408074907-mutt-send-email-mst@kernel.org>
References: <20250404211449.1443336-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250404211449.1443336-1-seanjc@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: e9ZpboW1K02SPu8M7vluAuqlY2Iyr_aIb1D_aPcndf0_1744112984
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 04, 2025 at 02:14:42PM -0700, Sean Christopherson wrote:
> The two primary goals of this series are to make the irqbypass concept
> easier to understand, and to address the terrible performance that can
> result from using a list to track connections.
> 
> For the first goal, track the producer/consumer "tokens" as eventfd context
> pointers instead of opaque "void *".  Supporting arbitrary token types was
> dead infrastructure when it was added 10 years ago, and nothing has changed
> since.  Taking an opaque token makes a *very* simple concept (device signals
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
> To address the use case where huge numbers of VMs are being created without
> _any_ possibility for irqbypass, KVM should probably add a
> KVM_IRQFD_FLAG_NO_IRQBYPASS flag so that userspace can opt-out on a per-IRQ
> basis.  I already proposed a KVM module param[2] to let userspace disable
> IRQ bypass, but that obviously affects all IRQs in all VMs.  It might
> suffice for most use cases, but I can imagine scenarios where the VMM wants
> to be more selective, e.g. when it *knows* a KVM_IRQFD isn't eligible for
> bypass.  And both of those require userspace changes.
> 
> Note, I want to do more aggressive cleanups of irqbypass at some point,
> e.g. not reporting an error to userspace if connect() fails is *awful*
> behavior for environments that want/need irqbypass to always work.  But
> that's a future problem.
> 
> [1] https://lore.kernel.org/all/20230801115646.33990-1-likexu@tencent.com
> [2] https://lore.kernel.org/all/20250401161804.842968-1-seanjc@google.com

vdpa changes seem minor, so

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> Sean Christopherson (7):
>   irqbypass: Drop pointless and misleading THIS_MODULE get/put
>   irqbypass: Drop superfluous might_sleep() annotations
>   irqbypass: Take ownership of producer/consumer token tracking
>   irqbypass: Explicitly track producer and consumer bindings
>   irqbypass: Use paired consumer/producer to disconnect during
>     unregister
>   irqbypass: Use guard(mutex) in lieu of manual lock+unlock
>   irqbypass: Use xarray to track producers and consumers
> 
>  drivers/vfio/pci/vfio_pci_intrs.c |   5 +-
>  drivers/vhost/vdpa.c              |   4 +-
>  include/linux/irqbypass.h         |  38 +++---
>  virt/kvm/eventfd.c                |   3 +-
>  virt/lib/irqbypass.c              | 185 ++++++++++--------------------
>  5 files changed, 88 insertions(+), 147 deletions(-)
> 
> 
> base-commit: 782f9feaa9517caf33186dcdd6b50a8f770ed29b
> -- 
> 2.49.0.504.g3bcea36a83-goog

