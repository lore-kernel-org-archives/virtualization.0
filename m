Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EBA18C91F
	for <virtualization@lists.linux.dev>; Mon,  2 Jun 2025 23:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748907016; cv=none; b=dR8FVEm1C969LiLFzH+RHImfyQsSjP8yMu7YGgs859A53+U6cKSglqQFx7Yw1F7bcbQWLA675fSSA1kwudIvteEK9CdXaf8tw0VEU+ETVeJmq9uJubkuPtZTKfjSnuE0x4ON947DroPtqwyNvn9iqDtCQXD3s8o7rXVfx0UYTGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748907016; c=relaxed/simple;
	bh=ERPVRkIbILIUcIjfV+EhBnHrMs9fZ3Q4qRlPwExSKOU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UwBSWFw9qaw0iuyd5e6Ck8/4sPQ9rZo7n5LA3W1x0naAy1HuMEukIzPOuXZTDiIywkm4Ga9PAjF+IZkFKRue/D6k0pKgUrMcHeTgKm4zG4hncN2foigBjmf14lxewOvtAImuu5qqj5Dj6KfMdOJSYHOuZ3D35WDdF66Fam7WTu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gsebseMk; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gsebseMk"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-310efe825ccso4872247a91.3
        for <virtualization@lists.linux.dev>; Mon, 02 Jun 2025 16:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748907014; x=1749511814; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yve1ZiL8T7g84JmBt/tikyI/6Bv4C2Bg0e+B1xxTdfo=;
        b=gsebseMkxi67MImod5O2Agr7XBZHfK+dEjq660ukYsh1g0hngTwFPhqNZfweUHrNxC
         s3WvJa9tUKB7vgAuKC1+vaGelv+kwHIZI23HFe0VSf6QVTKm9tsCiBkOE2p5O/umVQ1d
         EAaT0VBHI6yXLwM6ybd0pgKlmhM+Ce/Z5/IYqSS224OUnYj8k4u/4kETvFb0N4kmUza1
         gw0JOSqGeCl0zVrN/jUlJqitzJbG4CHo/zY/ccz2JyS4xIc9h1XLfkOTyK2Ifr88ja8c
         9c+a/ty3Jxf1wZQLIz164gsnFLMcW3B4kwKpOocz/36wO3ZKs+agaqSLKPS03aCxvyo0
         KMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748907014; x=1749511814;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yve1ZiL8T7g84JmBt/tikyI/6Bv4C2Bg0e+B1xxTdfo=;
        b=gKiyjS/dhs8cHsePImO37JZVT53T2PfBGliQIKcGrwYIfh3Ga+fTWLWXsJmZORW9eI
         AemfLaqmMUvGyphoGuG9/JtUG3Mt6O5+ThoKeAY9qilAGq3pox+K+kTrlZUmxgFAux99
         XchP5RWyB0qxjG3yACDSVky/Rj8jdmEzhP4+G8i9+BXtlJ5LcAUaoczHquVJyWlueWyH
         bwa56bDSiGz3FRkmfDZhobAWmNTkUEndFhd6RmhHvbACDHfjfTT/LqnQbJjmlxJ4Bz9p
         1KNgHNb+8TMxadgL4g6DqW2nW+OZMGtIK6rQLb8xqrWUP2jtLIsKqceoZC9cn4HbTfsd
         ZcuA==
X-Forwarded-Encrypted: i=1; AJvYcCXXPLGtwXuxJ9TIxuhSry9Jx4C4dmMj0UNfNnQKb5Xnyv3aAVpiItfgvQD+oY5MWMC3k1akVIvZInWqgK3pUg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5jpqgDwLym724GNdHhBw3laKAlR5JaDRPPWON/I/SNtXlbz15
	w/H6wBW2/p4UNUmb21ry104zcF8QY1am/nSL3y9pl96Ie6yyeAur55KfqzZ4x9GsoXJCQFYu8Hx
	z9xno+g==
X-Google-Smtp-Source: AGHT+IE14BFeGM0J7uhuk33V5fPG5r1MtBBSniKvSePrbW7/nzVp1S6VXU7zoEWKiW8wpnHDPojK7VzfMl4=
X-Received: from pjur7.prod.google.com ([2002:a17:90a:d407:b0:311:ea2a:3919])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4f4d:b0:312:1cd7:b337
 with SMTP id 98e67ed59e1d1-3125034a47amr19482649a91.5.1748907013702; Mon, 02
 Jun 2025 16:30:13 -0700 (PDT)
Date: Mon, 2 Jun 2025 16:30:12 -0700
In-Reply-To: <20250602125442.19d41098.alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250516230734.2564775-1-seanjc@google.com> <20250602125442.19d41098.alex.williamson@redhat.com>
Message-ID: <aD40BIYA1ecnbX73@google.com>
Subject: Re: [PATCH v2 0/8] irqbypass: Cleanups and a perf improvement
From: Sean Christopherson <seanjc@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kevin Tian <kevin.tian@intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	David Matlack <dmatlack@google.com>, Like Xu <like.xu.linux@gmail.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yong He <alexyonghe@tencent.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Jun 02, 2025, Alex Williamson wrote:
> On Fri, 16 May 2025 16:07:26 -0700
> Sean Christopherson <seanjc@google.com> wrote:
> 
> > The two primary goals of this series are to make the irqbypass concept
> > easier to understand, and to address the terrible performance that can
> > result from using a list to track connections.
> > 
> > For the first goal, track the producer/consumer "tokens" as eventfd context
> > pointers instead of opaque "void *".  Supporting arbitrary token types was
> > dead infrastructure when it was added 10 years ago, and nothing has changed
> > since.  Taking an opaque token makes a very simple concept (device signals
> > eventfd; KVM listens to eventfd) unnecessarily difficult to understand.
> > 
> > Burying that simple behind a layer of obfuscation also makes the overall
> > code more brittle, as callers can pass in literally anything. I.e. passing
> > in a token that will never be paired would go unnoticed.
> > 
> > For the performance issue, use an xarray.  I'm definitely not wedded to an
> > xarray, but IMO it doesn't add meaningful complexity (even requires less
> > code), and pretty much Just Works.  Like tried this a while back[1], but
> > the implementation had undesirable behavior changes and stalled out.
> > 
> > Note, I want to do more aggressive cleanups of irqbypass at some point,
> > e.g. not reporting an error to userspace if connect() fails is awful
> > behavior for environments that want/need irqbypass to always work.  And
> > KVM shold probably have a KVM_IRQFD_FLAG_NO_IRQBYPASS if a VM is never going
> > to use device posted interrupts.  But those are future problems.
> > 
> > v2:
> >  - Collect reviews. [Kevin, Michael]
> >  - Track the pointer as "struct eventfd_ctx *eventfd" instead of "void *token".
> >    [Alex]
> >  - Fix typos and stale comments. [Kevin, Binbin]
> >  - Use "trigger" instead of the null token/eventfd pointer on failure in
> >    vfio_msi_set_vector_signal(). [Kevin]
> >  - Drop a redundant "tmp == consumer" check from patch 3. [Kevin]
> >  - Require producers to pass in the line IRQ number.
> > 
> > v1: https://lore.kernel.org/all/20250404211449.1443336-1-seanjc@google.com
> > 
> > [1] https://lore.kernel.org/all/20230801115646.33990-1-likexu@tencent.com
> > [2] https://lore.kernel.org/all/20250401161804.842968-1-seanjc@google.com
> > 
> > Sean Christopherson (8):
> >   irqbypass: Drop pointless and misleading THIS_MODULE get/put
> >   irqbypass: Drop superfluous might_sleep() annotations
> >   irqbypass: Take ownership of producer/consumer token tracking
> >   irqbypass: Explicitly track producer and consumer bindings
> >   irqbypass: Use paired consumer/producer to disconnect during
> >     unregister
> >   irqbypass: Use guard(mutex) in lieu of manual lock+unlock
> >   irqbypass: Use xarray to track producers and consumers
> >   irqbypass: Require producers to pass in Linux IRQ number during
> >     registration
> > 
> >  arch/x86/kvm/x86.c                |   4 +-
> >  drivers/vfio/pci/vfio_pci_intrs.c |  10 +-
> >  drivers/vhost/vdpa.c              |  10 +-
> >  include/linux/irqbypass.h         |  46 ++++----
> >  virt/kvm/eventfd.c                |   7 +-
> >  virt/lib/irqbypass.c              | 190 +++++++++++-------------------
> >  6 files changed, 107 insertions(+), 160 deletions(-)
> > 
> > 
> > base-commit: 7ef51a41466bc846ad794d505e2e34ff97157f7f
> 
> Sorry for the delay.

Heh, no worries.  ~2 weeks is downright prompt by my standards ;-)

> Do you intend to take this through your trees?

Yes, ideally, it would go into Paolo's kvm/next sooner than later (I'll start
poking him if necessary).  The s/token/eventfd rename creates an annoying conflict
in kvm/x86.c with an in-flight patch (significant code movement between files).
It would be nice to be able to rebase the in-flight patch instead of having to
resolve a merge confict (the conflict itself isn't difficult to resolve, I just
find it hard to visually review/audit the resolution due to the code movement).
