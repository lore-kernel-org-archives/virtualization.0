Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7759B212546
	for <virtualization@lists.linux.dev>; Wed, 27 Aug 2025 19:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756323674; cv=none; b=opR0hwO72jtAK+OC9cUvTr3QoXAwLXLwYMDPCqlhFp0IK6n7CipuV292C6wDUST2ujzPzgYRBoq7yfuyQ4WavUVB/1JfNKqx3zPR0OEh+7nxjvIu1F9RrrEPyzNLWdAAoPpeDEn8JZzrg4/Qugu0ppK6tr9S4xVUf9cErxGHxfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756323674; c=relaxed/simple;
	bh=x/i6BRd0cWtRfp3CxZsaVLLtvufEWdcUwwghTxEVFpA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qAYC5uJQMA/aGVT2MMx/Eg+22DOetxAiPXrAch7JhIGkyOrqZsQOQnTmqSMdrKAA89QsqrKzVuLdxmIVE/YTJf5mnwb7q89X7/pMPejo8tKn9IX+e+2ICIOYENRXd/ag205A/Fuvy7a89MuUDq8/bPbbRRDEdesNmUHxPp6AHiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1/AySTaY; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1/AySTaY"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76e2e614889so209520b3a.0
        for <virtualization@lists.linux.dev>; Wed, 27 Aug 2025 12:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756323673; x=1756928473; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vWAmWKV0YCAe3PkG8+/flyHk3YjgRL//qGGe4nfIRiE=;
        b=1/AySTaYElWsoyKbDmvRAH0lY3j5emd35lVawwZ69L7xO/2GXSCeLLZfE6qkbNNiTm
         1sElhNwi1K3jdU59aAMi6CUz61q++7RA8IXD5zpQrud6rvSVeYDeL/8jbs1LZ2OHt3uv
         qk+WlADwWgw9Pkm0RUm8F/TJN08cX0zm3MLJL4Gw4pd1qzQNaKwls+shELoCB3IFL6CH
         HERvSpoiPmtdY0ZhC1eE1yiLAGp8nG6TAVziLg+QYf4fjuHNtmmt5H6e7gHP3kxZIhs+
         o2gIjL/9WDBRxvWfyDFOTjLq8PKjKS9UX65G8f8TALVHsGroQvNP4RJrc30m8D3iJSL7
         pkTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756323673; x=1756928473;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vWAmWKV0YCAe3PkG8+/flyHk3YjgRL//qGGe4nfIRiE=;
        b=BR9zfANVKvCS63/amZ0bZfd5r7ef+AG0KDqzmOlvtusBFuYhr3D5dPPl6HbBQ/Z8mp
         m/Ukl/Nl6rG6Pt2dmnzG0oM3xuQ2QOUd20/tJeAMTnG4OUR3mi8gZS0mAxQIzZitWfjN
         tqE17zyGVpobe3WBSMShDexPvfCP7Csbw7P16RDRFpk0vqMMcgdrS3FrcUV2YeT9g5z2
         hEuR8CcQclg1U2TOljl8MIdnuegse7wjqm5HEBY//iURg4W8u+6oFxVfZZd+3q8BODb+
         QO8JdeRuy39Kk2Ehpc13OW5pP/Zoxat1yuk9xhqFAjNeV5AVCu38nYmn5Q/yeqdJHWY2
         eYdg==
X-Forwarded-Encrypted: i=1; AJvYcCU8Z3kO0dp7vbSPUQZMEGGk14YU+9fXtMuAanQAFiuX9nh4ldrkVZTESfwABKhOGsRI83ncJlZImmoWySKHow==@lists.linux.dev
X-Gm-Message-State: AOJu0YxuC8ZO1TayHB0jUnER2m7N+At5Ce/iqe4ZsinGVkqAtYrtP/QG
	cX/30p83mlgzdx3Y3wsEbclUDx8+DzR1p2gAnMa4t4sSj1MtENDjPpNc0TXM+8ns56QoQgZFgdM
	71jtJnQ==
X-Google-Smtp-Source: AGHT+IF3kgndwMxobuC1w46DvzTQVQ+70Io5X5LupzuJERdtYH2UT2HutkGftTPmJvqTvDvQz3iwKQFDQfQ=
X-Received: from pfjf14.prod.google.com ([2002:a05:6a00:22ce:b0:772:49a:524f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:b45:b0:770:556d:32e8
 with SMTP id d2e1a72fcca58-770556d5e86mr17407883b3a.24.1756323672784; Wed, 27
 Aug 2025 12:41:12 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Aug 2025 12:41:04 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250827194107.4142164-1-seanjc@google.com>
Subject: [PATCH v2 0/3] vhost_task: Fix a bug where KVM wakes an exited task
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Michael,

Do you want to take this through the vhost tree?  It technically fixes a KVM
bug, but this obviously touches far more vhost code than KVM code, and the
patch that needs to go into 6.17 doesn't touch KVM at all.


Fix a bug where KVM attempts to wake a vhost task that has already exited in
response to a fatal signal, and tack on a few cleanups to harden against
introducing similar bugs in the future.

The issue is firmly a KVM problem, but I opted to fix the bug by making
vhost_task_wake() safe against an exited task as doing so is far simpler and
cleaner than implementing the same functionality in KVM, and I suspect that
if there are other users of vhost_tasks in the future, then there's a good
chance they will want/expect vhost_task to handle that detail.

Note, this only started causing problems when commit 56180dd20c19 ("futex:
Use RCU-based per-CPU reference counting instead of rcuref_t") landed, so
the explosions are "new" in 6.17, but the bug has existed since KVM switched
to vhost_task back in 6.13.

v2:
 - Drop the "safe" postfix variant and make the "default" vhost_task_wake()
   safe. [Michael].
 - Use vhost_task_wake() and __vhost_task_wake() for the public APIs, and
   vhost_task_wake_up_process() for the local helper. [Michael]
 - Drag the signalas back from their Spanish holiday. [Sebastian]

v1: https://lore.kernel.org/all/20250826004012.3835150-1-seanjc@google.com

Sean Christopherson (3):
  vhost_task: Don't wake KVM x86's recovery thread if vhost task was
    killed
  vhost_task: Allow caller to omit handle_sigkill() callback
  KVM: x86/mmu: Don't register a sigkill callback for NX hugepage
    recovery tasks

 arch/x86/kvm/mmu/mmu.c           |  7 +---
 drivers/vhost/vhost.c            |  2 +-
 include/linux/sched/vhost_task.h |  1 +
 kernel/vhost_task.c              | 62 +++++++++++++++++++++++++++-----
 4 files changed, 56 insertions(+), 16 deletions(-)


base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
-- 
2.51.0.268.g9569e192d0-goog

