Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0D0BA42
	for <virtualization@lists.linux.dev>; Tue,  3 Dec 2024 01:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733187610; cv=none; b=I/LJHm/vlhh7CNkbd9Z4hrCW0wKn0dfKYjOHMlbj8yBG2ajhL1MRLbDXKS/ezO+H8phgHlnnX/Joe7TFSOKFwa6oZDnYMGbGU78aJqOlGyplR7aEr2L095HY6uvJRFO/imHHyuv/VseApKdwdbEelOpDO18RJZKSsk19GtvZmT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733187610; c=relaxed/simple;
	bh=tt1n7+zJzjSkuUlJGp2Vz5ZrLaY83PHy98RvVR/1bSU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Cs1E+pivS+lehM3KBPfkO90qhGzje/l5UoshVmr5Esc0FhHwnFb0ckWa6haDj/mKSuhnfjB5uPzZ5Wydkqyw+ZqHb+0Z7zlfiL8Z7Usv7Zv+5idPfkVlacUOoIbczfjzVKSgOYpx0QcvgNBK2YdHhxQ33QtSVXYz3owNRUPobl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kevinloughlin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ulv7HY1E; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kevinloughlin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ulv7HY1E"
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-843dd952aa7so469059839f.2
        for <virtualization@lists.linux.dev>; Mon, 02 Dec 2024 17:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733187607; x=1733792407; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gPDpv/chkg5p0fi43rAQfMRL2kKLevnRZ1FyVaa7akc=;
        b=Ulv7HY1EQSEohA1W5aBAh3jQ/CTGINYd7xEJaJWi6RV9BKvsT2pC37yAnvWCEO/32m
         cX6N26gxYJSlQB53HDvZqaXWVEY0dbYOjFLwpSxR01M8ZrjxLEv34fg8fMh22xxN0x0d
         S7kAuocga8HczBimLT7MiaYdTYyQP7xs4hFxFDY2rfpWFc+yw26UMcoZw4nEI+zRdXzh
         eH8rtxyxvhT+T2orQCT5VIVU2OehiyP+o7vAohIOudZqh4p/acDIOTvHzj7lSbmpkB0S
         6dcFW9JwuHZJlrovaw6jC3WGqEqIRumvgKpx1NlwDmOwSaA7C1IeN239bQKbKzwJHJRz
         mL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733187607; x=1733792407;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gPDpv/chkg5p0fi43rAQfMRL2kKLevnRZ1FyVaa7akc=;
        b=DnnE366K8PYsBkyAB/fFcgb8stOI6muNYfeNBPYM7ImRZifGEtiYeRQhqzev7EbJ7H
         X9YDBrJaVcX2u9sVQb0fEbMSJA0f0CgOnCjSQ12aYooayp6FZYjcSpLGjusPKT0L6r88
         CPhaLUxwFCOEVP9tU+90dMR+FU05FPhXA54fSOByB2ST/dPKxx/6wxRJvDRIyMvqROhU
         gBBTnhVQ/PESpsCjvOjoVOfcN2Y+6EhCercU6g81SpssUn7C8sufsy37X/mIL0YYkOtp
         0AoyetT5MRNhWYCGeEeUvVWk1d9TXh4la8FCQYbf0JtkFgU4LSso2MvPA/pEqt6L7H+p
         CXtg==
X-Forwarded-Encrypted: i=1; AJvYcCXFE+V8GjCcEXFtamQckJkGbOkKIXB0eiR8ndHEsrpfcfMvuaFHJFsd/Y11FFE7BswwZ9qV2XiCURAoJWpp1Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzm88grDLpnri/1blnK+LXXjnuZHlyAJhAiyELLnDkqpGqMZy3G
	da2L2u5IGK+g3YTNS2HEUW9poV7bfmQwArtvAC0lKf/aNIBqoq1Y0O04LBc7d/eJ/vFvnnlrcLh
	3BxXz7UKPMyPINz7Krsjsu+zR+W3FPQ==
X-Google-Smtp-Source: AGHT+IHqJwhD7dDrPHnnwi0nKSyWpAXx88t8MplXy6qAA9f67EUD1JW80naumNLzsou5U5ZEc/gbCz70e8AwEIt7ij7T
X-Received: from ioay19.prod.google.com ([2002:a6b:c413:0:b0:841:802b:8e24])
 (user=kevinloughlin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6602:1546:b0:82a:2a67:9429 with SMTP id ca18e2360f4ac-8445b554fbbmr110164539f.5.1733187606796;
 Mon, 02 Dec 2024 17:00:06 -0800 (PST)
Date: Tue,  3 Dec 2024 00:59:19 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241203005921.1119116-1-kevinloughlin@google.com>
Subject: [RFC PATCH 0/2] KVM: SEV: Prefer WBNOINVD over WBINVD for cache
 maintenance efficiency
From: Kevin Loughlin <kevinloughlin@google.com>
To: linux-kernel@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, kvm@vger.kernel.org, thomas.lendacky@amd.com, 
	pgonda@google.com, sidtelang@google.com, mizhang@google.com, 
	virtualization@lists.linux.dev, xen-devel@lists.xenproject.org, 
	bcm-kernel-feedback-list@broadcom.com, 
	Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

AMD CPUs currently execute WBINVD in the host when unregistering SEV
guest memory or when deactivating SEV guests. Such cache maintenance is
performed to prevent data corruption, wherein the encrypted (C=1)
version of a dirty cache line might otherwise only be written back
after the memory is written in a different context (ex: C=0), yielding
corruption. However, WBINVD is performance-costly, especially because
it invalidates processor caches.

Strictly-speaking, unless the SEV ASID is being recycled (meaning all
existing cache lines with the recycled ASID must be flushed), the
cache invalidation triggered by WBINVD is unnecessary; only the
writeback is needed to prevent data corruption in remaining scenarios.

To improve performance in these scenarios, use WBNOINVD when available
instead of WBINVD. WBNOINVD still writes back all dirty lines
(preventing host data corruption by SEV guests) but does *not*
invalidate processor caches.

First, provide helper functions to use WBINVD similar to how WBINVD is
invoked. Second, check for WBNOINVD support and execute WBNOINVD if
possible in lieu of WBINVD to avoid cache invalidations

Kevin Loughlin (2):
  x86, lib, xenpv: Add WBNOINVD helper functions
  KVM: SEV: Prefer WBNOINVD over WBINVD for cache maintenance efficiency

 arch/x86/include/asm/paravirt.h       |  7 ++++++
 arch/x86/include/asm/paravirt_types.h |  1 +
 arch/x86/include/asm/smp.h            |  7 ++++++
 arch/x86/include/asm/special_insns.h  | 12 ++++++++-
 arch/x86/kernel/paravirt.c            |  6 +++++
 arch/x86/kvm/svm/sev.c                | 35 +++++++++++++++++----------
 arch/x86/lib/cache-smp.c              | 12 +++++++++
 arch/x86/xen/enlighten_pv.c           |  1 +
 8 files changed, 67 insertions(+), 14 deletions(-)

-- 
2.47.0.338.g60cca15819-goog

