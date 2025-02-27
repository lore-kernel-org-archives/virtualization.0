Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26509233128
	for <virtualization@lists.linux.dev>; Thu, 27 Feb 2025 02:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622794; cv=none; b=TxNXw1nzVbmtW7KwhUD4JSd9t//5sOq5Ahl2NWpej6Xi7FH3toxJ6vcKTp1bgHC9FpJltrjmG+IyoVMOwSbRnzfLnbvoDnflj9/Lz95ArviqXAiga+ULG04ANOHGgzxIC3JBwfD9PbgopTd+pjurGKQ4pdcYG14tdPyArLjjZXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622794; c=relaxed/simple;
	bh=Bgq2jKvITCPJGjInNMTg9hShy45LprwLheePx172YI0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CgfgsKWJWyqs4sL1RTl7R7d+yV4nVkkUpWa3RXsvvKc2jRWFj3nUU9Ay6AXFc3dmQLQjc8KzZvcC7wSIUZftZXdrYGiqBFo4L6V3MiAesjdnzI4TIAgiJQCGuqds5gDTSCjhkM9tRh1c9tqBTwtrXD49r3I5SPYIg6CM6e+hXW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zSn7g1II; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zSn7g1II"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fea1685337so792115a91.0
        for <virtualization@lists.linux.dev>; Wed, 26 Feb 2025 18:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622791; x=1741227591; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=w772IaQ5YRbZvSP+H3ufucBFIq7F/07nn6vrGLJgcY8=;
        b=zSn7g1IIEkGelbeTokxAsXETDE/n5gJnEutZmE/blSNXuNigIrVd8HDIa/LyM76YjQ
         yf9TDFB4qV5Gh039ZcbHRdqXZ2b3SvIFK6ySDOwM3O25f0P5lmhtTmcZ2iB/asIvp5Ie
         +3RInXL6A1XhBzasb1fCkoFRTz5jhrIZKZVbPrB2ZTTTTqVqFA3iuODGokF3WlvzMzUf
         eC4W7FITJAkNPzw3XCc9jVKwRYANcb0RvE3Ak202vugAin5VXmQpwTqKwZV6Pf9Nupde
         u99Ox4WCdLjKm0jDe7mMom+YuZq5pJUJOw4Qi3tCIjmQS4tiAEfDygUktjoadOnXdmuW
         PL2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622791; x=1741227591;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w772IaQ5YRbZvSP+H3ufucBFIq7F/07nn6vrGLJgcY8=;
        b=uY+t9VZbZSCcSeqUhrYidxZ4iv6CtnNL8BIngqao5vEfvIZeZuxtEmMJVPNvkDCYMh
         notVmekRxpcuorG24RyLF+h/Yt2F789k1z9wwg021HYE4kVykZIDrjQUpx9CSba+ujM8
         Cy+gVcUfodHvalY+W2xVhqCXCO5nyGDjGgJXrqkUEz9gwsrFuYTTLVSRvV5pkn75D1ew
         WcAJFWxMLFGfAbKz3A/3v2ijzQ7bMVx4Bi+fc1e1RL1dE/VBy3j3XCwPZu53C3/uvBn4
         bpqMgV+4eRNfv+SvU+2JagsUyh7umqB1jC4VzngktE05C7egAU9bYvrFNRisKexII8B/
         7DUw==
X-Forwarded-Encrypted: i=1; AJvYcCVwAfrJibnkf7XfImsW7E2gBNvfdf53KWJnKftaCp3d8OE9T/B9eLkznKdWkMs93PNW+G33IicD1hT+5oI7FA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyc9a4Wb5LtAbVwtysderCS5XJRgFT3nJyefmmuNPD0WchBWmUb
	kFvc6KqB+RrLFXa4Sj/rwFiO+ETPMtb00zc3uUf8PTOjhhc9qiPph+ecKuUW/ej2R8Dg6B2gBD8
	9yw==
X-Google-Smtp-Source: AGHT+IFwaP3Gmshvc7uvq62wN2IryjydNwW4vN0WeuDaKx0968TrkTSYTEdNA9orJIr9gY0PmdxDWYBBhxM=
X-Received: from pjbsm1.prod.google.com ([2002:a17:90b:2e41:b0:2f8:4024:b59a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2688:b0:2f9:d0cd:3403
 with SMTP id 98e67ed59e1d1-2fea12fcb22mr2427211a91.16.1740622791492; Wed, 26
 Feb 2025 18:19:51 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:44 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-29-seanjc@google.com>
Subject: [PATCH v2 28/38] x86/paravirt: Mark __paravirt_set_sched_clock() as __init
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

Annotate __paravirt_set_sched_clock() as __init, and make its wrapper
__always_inline to ensure sanitizers don't result in a non-inline version
hanging around.  All callers run during __init, and changing sched_clock
after boot would be all kinds of crazy.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/paravirt.h | 9 +++++----
 arch/x86/kernel/paravirt.c      | 4 ++--
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index dc26a3c26527..e6d5e77753c4 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -28,11 +28,12 @@ u64 dummy_sched_clock(void);
 DECLARE_STATIC_CALL(pv_steal_clock, dummy_steal_clock);
 DECLARE_STATIC_CALL(pv_sched_clock, dummy_sched_clock);
 
-void __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
-				void (*save)(void), void (*restore)(void));
+void __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
+				       void (*save)(void), void (*restore)(void));
 
-static inline void paravirt_set_sched_clock(u64 (*func)(void),
-					    void (*save)(void), void (*restore)(void))
+static __always_inline void paravirt_set_sched_clock(u64 (*func)(void),
+						     void (*save)(void),
+						     void (*restore)(void))
 {
 	__paravirt_set_sched_clock(func, true, save, restore);
 }
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 9673cd3a3f0a..92bf831a63b1 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -86,8 +86,8 @@ static u64 native_steal_clock(int cpu)
 DEFINE_STATIC_CALL(pv_steal_clock, native_steal_clock);
 DEFINE_STATIC_CALL(pv_sched_clock, native_sched_clock);
 
-void __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
-				void (*save)(void), void (*restore)(void))
+void __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
+				       void (*save)(void), void (*restore)(void))
 {
 	if (!stable)
 		clear_sched_clock_stable();
-- 
2.48.1.711.g2feabab25a-goog

