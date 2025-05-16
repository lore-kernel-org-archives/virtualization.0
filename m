Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E61CA6B
	for <virtualization@lists.linux.dev>; Fri, 16 May 2025 23:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747436861; cv=none; b=YW+TcTednyiCWWX/D9KwD43er6sa4MSStVv/736Hf+mVN7AXV74JC7slUrF8pEkoWQSKFGiLF10/tizeRQ0yaj4QTo/MAe4/Hm0Xngb8wzWtVP5VQWLAJCknqPtt3DtJodixzk+JFUA7uWsyP7dhtqQQsb7FCZQCUxmq1auEHwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747436861; c=relaxed/simple;
	bh=AVnn78Uc3EWeUJSQ7ziRvaqm0OPYoWQKB0eMNz4K9JQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=H+YmrSyWPG9Q6ktwpvDnmhFN3Z/ZqTCQNuQwpxKwXHC846FvESUY7JjaZCyFNOfAWZYr0MUdHJQOq/9McIfty1zxon+Cz31oSIFSWCfAIkMWdrUgq5/+6BAR1m92pbasJGITeR6bXT8nNU0qE8wSh/+M8t1AjwJrxFNoRgIc6cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fUs25PCi; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fUs25PCi"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30e2bd11716so2681445a91.3
        for <virtualization@lists.linux.dev>; Fri, 16 May 2025 16:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747436858; x=1748041658; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nuPZrVo3m9ILiCK6u6rwy2V97Y83MmsuXvc2pUzideg=;
        b=fUs25PCiYxdISQwg1OZeZxUXY+sgRsVBfxGvclBzKF8kijoamqiAfSRlz37Lebu+8a
         phOXhwgVjj5+Un4t1FymN+7g2+kbcqN7Zj1P66PNtrcQldW8bUZJ8MgxDOPh31jjoxET
         EyFNq3XUnOkvub/PqACRqL4t81uiDDzD83yVL5TN/CHiN8vvZQt9juJKZh5QBSg5sgnZ
         QEJP59DIsJMJw+PZAdBkVDDLMsRTsDtnlq1VP8zfXvMcxalRwy+eTyMFnIzE7apvng7a
         kX0zuF9gJ36fTVLh7mkMDiOVNBOTuvSl8/FpRr4NhFVKQk1NV0IsYfCHav+d1IbGbPci
         Wl/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747436858; x=1748041658;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nuPZrVo3m9ILiCK6u6rwy2V97Y83MmsuXvc2pUzideg=;
        b=RUNIShSu0s0pk4fPqDvPt/8n8QhlHkQcPxGEQZ9EXFxQQYPntrWBZpiN8uvyq2iaeE
         58kkNl9a5w72nSpnVJDne40+KdwmsXoF5MzCnLa/XOqTlXGij0sxwwBg1EYJFyEL5blk
         XtpAQxfQt6kMqZ21VQfxjtewY3ZDbvSG8wH8ePA2cVw8qP5dgNO8G79cs4cHx5GOj7PF
         HamGrkjecaDGkluJ8iJnchLCS+lb2ohMH/R71dq9UILCSJU0K9BQsoOOAmqGgSRadeBw
         f6bulVtooLA0U8UxUeT5nci7kKcSDOr8/6L2aYij9tBmWIcnDi98jXHvi4EdYdHHYmZF
         yckA==
X-Forwarded-Encrypted: i=1; AJvYcCU5YPrAPbDErRmwgmq0XCzuqDC4hTwzoYf6YMa+KFEWSlWPjV5rewad2M5coCFfEIiD0AcP7XlQWCiLFPG8pA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyVfEKG40Dt794zDi1gb91KZHxJndsquyWtrqHQ2sOyZeebTTIy
	DgKBsWGirCm098r1MbWHhOLrsMHCsLIvFlvMmLSgC8G8eCR4IApBMRDRsLD9oHliY/idOEkp/Eb
	ftAreUA==
X-Google-Smtp-Source: AGHT+IEva6akKzygsV3eTjAuHUFzTW5RKHcvkYUPembdBdAiDgn0hyDfnrXciaaTEYE+lnp6Pa6eayl2kZA=
X-Received: from pjbse12.prod.google.com ([2002:a17:90b:518c:b0:308:6685:55e6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a83:b0:2ee:9b09:7d3d
 with SMTP id 98e67ed59e1d1-30e8313da6fmr5609248a91.19.1747436857700; Fri, 16
 May 2025 16:07:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 16 May 2025 16:07:26 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1112.g889b7c5bd8-goog
Message-ID: <20250516230734.2564775-1-seanjc@google.com>
Subject: [PATCH v2 0/8] irqbypass: Cleanups and a perf improvement
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kevin Tian <kevin.tian@intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	David Matlack <dmatlack@google.com>, Like Xu <like.xu.linux@gmail.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yong He <alexyonghe@tencent.com>
Content-Type: text/plain; charset="UTF-8"

The two primary goals of this series are to make the irqbypass concept
easier to understand, and to address the terrible performance that can
result from using a list to track connections.

For the first goal, track the producer/consumer "tokens" as eventfd context
pointers instead of opaque "void *".  Supporting arbitrary token types was
dead infrastructure when it was added 10 years ago, and nothing has changed
since.  Taking an opaque token makes a very simple concept (device signals
eventfd; KVM listens to eventfd) unnecessarily difficult to understand.

Burying that simple behind a layer of obfuscation also makes the overall
code more brittle, as callers can pass in literally anything. I.e. passing
in a token that will never be paired would go unnoticed.

For the performance issue, use an xarray.  I'm definitely not wedded to an
xarray, but IMO it doesn't add meaningful complexity (even requires less
code), and pretty much Just Works.  Like tried this a while back[1], but
the implementation had undesirable behavior changes and stalled out.

Note, I want to do more aggressive cleanups of irqbypass at some point,
e.g. not reporting an error to userspace if connect() fails is awful
behavior for environments that want/need irqbypass to always work.  And
KVM shold probably have a KVM_IRQFD_FLAG_NO_IRQBYPASS if a VM is never going
to use device posted interrupts.  But those are future problems.

v2:
 - Collect reviews. [Kevin, Michael]
 - Track the pointer as "struct eventfd_ctx *eventfd" instead of "void *token".
   [Alex]
 - Fix typos and stale comments. [Kevin, Binbin]
 - Use "trigger" instead of the null token/eventfd pointer on failure in
   vfio_msi_set_vector_signal(). [Kevin]
 - Drop a redundant "tmp == consumer" check from patch 3. [Kevin]
 - Require producers to pass in the line IRQ number.

v1: https://lore.kernel.org/all/20250404211449.1443336-1-seanjc@google.com

[1] https://lore.kernel.org/all/20230801115646.33990-1-likexu@tencent.com
[2] https://lore.kernel.org/all/20250401161804.842968-1-seanjc@google.com

Sean Christopherson (8):
  irqbypass: Drop pointless and misleading THIS_MODULE get/put
  irqbypass: Drop superfluous might_sleep() annotations
  irqbypass: Take ownership of producer/consumer token tracking
  irqbypass: Explicitly track producer and consumer bindings
  irqbypass: Use paired consumer/producer to disconnect during
    unregister
  irqbypass: Use guard(mutex) in lieu of manual lock+unlock
  irqbypass: Use xarray to track producers and consumers
  irqbypass: Require producers to pass in Linux IRQ number during
    registration

 arch/x86/kvm/x86.c                |   4 +-
 drivers/vfio/pci/vfio_pci_intrs.c |  10 +-
 drivers/vhost/vdpa.c              |  10 +-
 include/linux/irqbypass.h         |  46 ++++----
 virt/kvm/eventfd.c                |   7 +-
 virt/lib/irqbypass.c              | 190 +++++++++++-------------------
 6 files changed, 107 insertions(+), 160 deletions(-)


base-commit: 7ef51a41466bc846ad794d505e2e34ff97157f7f
-- 
2.49.0.1112.g889b7c5bd8-goog

