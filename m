Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB041EFFA8
	for <virtualization@lists.linux.dev>; Thu, 27 Feb 2025 02:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622773; cv=none; b=soYf83XcDSo5Mc7Off4+Z9q88z+lf8OMiAzMOfv8xl/eBQaF25AqKCrV5qZZ2t6hSxWZL2beEj4/RpTtmVr/9EmU/Hw9o5VQIvbB3yOXIUNxLLWiOdEExwRT0DRVUJYGpE1Um5XYExJdlo5KpWU0g97GKQSa5rrJhDWrQ2YPF5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622773; c=relaxed/simple;
	bh=Ct4a9oRRcb4uCHXZ3lSQwfqmCTAwLfdRFXjQ6iMkxFY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l9wZfO9IgdxCNbqJ7BtS31af8jbSgW20i2x9xvjACAGnX/GgKkRvedPmbpmxWzZZEueS9uRdUT6JaAchoonBECjpv8Vle+FbGLRZ8q7ADGXavtfFRusouWKueQFv3sHgnMFGUd98swjOEZ+ukOK1tMgeWWI2Ze2D/7vKtHXN3gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JXQimqe9; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JXQimqe9"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc43be27f8so1571030a91.1
        for <virtualization@lists.linux.dev>; Wed, 26 Feb 2025 18:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622771; x=1741227571; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Cdk6AVEMbYJ/6Avsp+2Egdk5E71fbrI/hFT7BN4L+X8=;
        b=JXQimqe9c3xzBTFoO5VTD8plXW3jOMi5YGC2Kv+eL8CeLbwJnqr3r1UZXFGL4qZjui
         ijmlnkNS38I0O9owSpVEZHhsuGadkuEuBg74AbwgQkWP/y7mKd21pXm1iOF1SEDihMZA
         U5bxm8E+hNrM6tCs21BB+KrPsuN6fb+3xOmAkCMCFgQjkiYVvTNkAYf8Ukyyb8wCjEyu
         wD3cx12yfalKUXWnJNR9dVeByNwijO7OUDrOfhFBR/x+9fqmdjP/g75GfIRzQcUR9eDI
         Xq6qn/zufQjv8WUreOJGatdb23AV0YYT4JwQCiinISpz485LNuesXcxtxQ2IC58III4X
         PYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622771; x=1741227571;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cdk6AVEMbYJ/6Avsp+2Egdk5E71fbrI/hFT7BN4L+X8=;
        b=nBiGzpb3RdxaHtPKtVQaPWGW8H3llRDQmUX5nS9V75QFdkVb/NOPlVbIKve0/SIkBB
         UTAq8+BGrTjy31hlmC66CStjCKYTyYnEpNt+FzmK8cLdt/3GScL3nm4uR7H44b6IV2HF
         WemS/6H1UthK3URRTp+2FxpGDy8wrauJKf4Dvo4OmYeKU33khpLQdiMz/FPn7wzIyNMP
         JYR222s7UCSChbQtfIh54qYr+qbZeLIieGewyP5+y/1jBp2rOO+caoCOP3egXi0HhnIC
         jYgAZGSYnIbERrdVZYQbalv8XV1aq++Vh7uLC/l1ml9rU0TX2U2d6Xh6rUptBm0eqRfV
         1cyw==
X-Forwarded-Encrypted: i=1; AJvYcCUoq4D9aQ8ycNrIKGG3yTnSgKeKpXMwcO/7chyJbJa+HQ8NVTofAOirQ8PF43tZ4D0HZwtLc4Zj82cUXX3g8Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyC6n0ua2qwLkCN+YvXiJR6L5Ckdy4jHLqqadxE+NSL1HZpdA0k
	sHteFfulQFtSE3R3UEVQwMCS9NklFmaaSv2ZZKejrxCdyNfSJLEhC8JwT9CUt5IbzX1efHbRBpH
	hyw==
X-Google-Smtp-Source: AGHT+IGFILkiLdlR4RAAXuJxcaVfe/0bxh03RUlKL7+1zFXEwiB1qD3NnSdVhpPB8u60HxzWl62A5c233Wg=
X-Received: from pjbdb4.prod.google.com ([2002:a17:90a:d644:b0:2fc:2ee0:d385])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5688:b0:2ee:a4f2:b307
 with SMTP id 98e67ed59e1d1-2fe7e2eaca6mr8295061a91.4.1740622771119; Wed, 26
 Feb 2025 18:19:31 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:32 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-17-seanjc@google.com>
Subject: [PATCH v2 16/38] x86/vmware: Nullify save/restore hooks when using
 VMware's sched_clock
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Juergen Gross <jgross@suse.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	John Stultz <jstultz@google.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

Nullify the sched_clock save/restore hooks when using VMware's version of
sched_clock.  This will allow extending paravirt_set_sched_clock() to set
the save/restore hooks, without having to simultaneously change the
behavior of VMware guests.

Note, it's not at all obvious that it's safe/correct for VMware guests to
do nothing on suspend/resume, but that's a pre-existing problem.  Leave it
for a VMware expert to sort out.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/vmware.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index d6f079a75f05..d6eadb5b37fd 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -344,8 +344,11 @@ static void __init vmware_paravirt_ops_setup(void)
 
 	vmware_cyc2ns_setup();
 
-	if (vmw_sched_clock)
+	if (vmw_sched_clock) {
 		paravirt_set_sched_clock(vmware_sched_clock);
+		x86_platform.save_sched_clock_state = NULL;
+		x86_platform.restore_sched_clock_state = NULL;
+	}
 
 	if (vmware_is_stealclock_available()) {
 		has_steal_clock = true;
-- 
2.48.1.711.g2feabab25a-goog

