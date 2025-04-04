Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE55B1AD41F
	for <virtualization@lists.linux.dev>; Fri,  4 Apr 2025 21:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743801306; cv=none; b=I068XD+ziyzp41CfNZczr9qPWgbheE6qXpLrFflbk5vuc87YaRSpydiHqT47nvdLupJW2cFgomKowFh+oaxtR+Ojig0U8tZb/ituF/2Zx75Inmr+K2TIl74FYsbWRjqzWtV9KYVBgNM0YHLjTMUHAUYy+GeRwnLYUWOd0td3niU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743801306; c=relaxed/simple;
	bh=ItUeEJxyPrZVjz5fmXJVd+IubAfuc0Tp3x2Umz+G76g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KizZaVeBDts/WJ/4bUCwSTKRDz4vye6AP5Muw8vjriyrAYxzQXm/rERc6o91K8PkvY86YWLHxYyebWkob71ycqMjITU1MHjy8m6sAIHIXlD/a3YvffPwJyxcJZ+fN6KV4x+fFATVCzxReqVYI5KAekhFcErziAku2OPBOmMu9MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gHlhtgd3; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gHlhtgd3"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff58318acaso3968545a91.0
        for <virtualization@lists.linux.dev>; Fri, 04 Apr 2025 14:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743801304; x=1744406104; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SkG9/Gie3NkMh7eSDfJzty3mxspo7ZZ0xVy2Q3dHWOM=;
        b=gHlhtgd31oX0OQwHtZ9F2yjh4GLcr82/pWEs6xlSnXykAx+Ufj+MLGvDcjRPdCLiKI
         AL4PtiZBzp+/NVZ/CuXdw3FRfyRPqivYQkku9bRFPyZkeyh5b17m0NjWcZMLbKQlZSQH
         JJ1svDClzNQrUOldgBnliZSejDHxN9RIpHJFs/sX6FJtvLmQVoFmFECMeaES4PAcDDoE
         Ah6NLSZJZNdbLVo0j38jVw/3l/sPEHbMrnlt6naW8HSE5KD/AnALQxm+rkYYal4NA25E
         MD6Xlxq3pWavB82n9GZtsmdxYKsbPEWs+NNmxmAEChIqn3pMdRM7rfFSnsYgH2B322LT
         OHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743801304; x=1744406104;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SkG9/Gie3NkMh7eSDfJzty3mxspo7ZZ0xVy2Q3dHWOM=;
        b=aO2SdrQNxAWdfXI/RgLonuNs6by5FERwKhHNpeovUiTtkOI0cGuUymPG2uQxEJ6I1W
         W7ML7hy/Exg8L1KgAWTh8Holy+96/fFnnQTwcHp9NNszsdsnXZ22VqimjKqp3Z9Us1yc
         FU4Yb3LYFNLB+m/BDLRlwP8BzmvGHqWFHFQ5O8/CqIfMIjHyx5XL18QLK/pLuebgLs05
         pFQBNbqd0oFGRbZRG2PZaEAkcio9ie8Z5Sc8KksjK99hAK4lHJNYflLNPK9Bz+2THWCM
         hVTIOka0MvG9unEBfvmEE37qNfF9sE8DwhbbRguPmAqqE85awLCD98hduXJDno8glbNs
         TeTg==
X-Forwarded-Encrypted: i=1; AJvYcCWSqBG+jGU5X91M3xqxT5CczDWhR+GMp5FiLAkVdb8sQ3Nros7CTSSQnNwKw5xxbvc2V6iqk3CqQWrStV0+fA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJPrgGF10JQDlMiRqwaWVCEzU1AA8i+fGhTKB9cb6aYODjpzl6
	TiINYDiLFSIAOSJkDHsxccPoTIjLtr8jaYUeY/qpmZGGRVIlA414MgfvQ9mrpEqk/FwP8HfRlcN
	hmQ==
X-Google-Smtp-Source: AGHT+IFs32FT+Ce+FtTQ8URjvqmCz/3ftaqwgA6qZrIK3r+Twdavhp7tQfXy+gW0pJuBHlqTt3ifIanpTwI=
X-Received: from pjbsf11.prod.google.com ([2002:a17:90b:51cb:b0:2ea:46ed:5d3b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:6c3:b0:2f4:432d:250d
 with SMTP id 98e67ed59e1d1-306a617d201mr5610182a91.21.1743801304083; Fri, 04
 Apr 2025 14:15:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 14:14:42 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404211449.1443336-1-seanjc@google.com>
Subject: [PATCH 0/7] irqbypass: Cleanups and a perf improvement
From: Sean Christopherson <seanjc@google.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	David Matlack <dmatlack@google.com>, Like Xu <like.xu.linux@gmail.com>, 
	Yong He <alexyonghe@tencent.com>
Content-Type: text/plain; charset="UTF-8"

The two primary goals of this series are to make the irqbypass concept
easier to understand, and to address the terrible performance that can
result from using a list to track connections.

For the first goal, track the producer/consumer "tokens" as eventfd context
pointers instead of opaque "void *".  Supporting arbitrary token types was
dead infrastructure when it was added 10 years ago, and nothing has changed
since.  Taking an opaque token makes a *very* simple concept (device signals
eventfd; KVM listens to eventfd) unnecessarily difficult to understand.

Burying that simple behind a layer of obfuscation also makes the overall
code more brittle, as callers can pass in literally anything. I.e. passing
in a token that will never be paired would go unnoticed.

For the performance issue, use an xarray.  I'm definitely not wedded to an
xarray, but IMO it doesn't add meaningful complexity (even requires less
code), and pretty much Just Works.  Like tried this a while back[1], but
the implementation had undesirable behavior changes and stalled out.

To address the use case where huge numbers of VMs are being created without
_any_ possibility for irqbypass, KVM should probably add a
KVM_IRQFD_FLAG_NO_IRQBYPASS flag so that userspace can opt-out on a per-IRQ
basis.  I already proposed a KVM module param[2] to let userspace disable
IRQ bypass, but that obviously affects all IRQs in all VMs.  It might
suffice for most use cases, but I can imagine scenarios where the VMM wants
to be more selective, e.g. when it *knows* a KVM_IRQFD isn't eligible for
bypass.  And both of those require userspace changes.

Note, I want to do more aggressive cleanups of irqbypass at some point,
e.g. not reporting an error to userspace if connect() fails is *awful*
behavior for environments that want/need irqbypass to always work.  But
that's a future problem.

[1] https://lore.kernel.org/all/20230801115646.33990-1-likexu@tencent.com
[2] https://lore.kernel.org/all/20250401161804.842968-1-seanjc@google.com

Sean Christopherson (7):
  irqbypass: Drop pointless and misleading THIS_MODULE get/put
  irqbypass: Drop superfluous might_sleep() annotations
  irqbypass: Take ownership of producer/consumer token tracking
  irqbypass: Explicitly track producer and consumer bindings
  irqbypass: Use paired consumer/producer to disconnect during
    unregister
  irqbypass: Use guard(mutex) in lieu of manual lock+unlock
  irqbypass: Use xarray to track producers and consumers

 drivers/vfio/pci/vfio_pci_intrs.c |   5 +-
 drivers/vhost/vdpa.c              |   4 +-
 include/linux/irqbypass.h         |  38 +++---
 virt/kvm/eventfd.c                |   3 +-
 virt/lib/irqbypass.c              | 185 ++++++++++--------------------
 5 files changed, 88 insertions(+), 147 deletions(-)


base-commit: 782f9feaa9517caf33186dcdd6b50a8f770ed29b
-- 
2.49.0.504.g3bcea36a83-goog

