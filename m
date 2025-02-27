Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28782343AB
	for <virtualization@lists.linux.dev>; Thu, 27 Feb 2025 02:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622795; cv=none; b=aIM0kcv7Dpu7eIljaUV7I0VtEFKpzSnpFYkLy4hTSwocpkwxrbw2vGgpGNJfBJ3CdncxsJHwqYxLtgmCEUvvQDPyyFEBjl4RSwcK0W8LPJ5yXONUtdADbwk1bjXVhLYMpqiB6mnIVCZ961zxkkmx+crSsKDswweL0qUlh+XWP1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622795; c=relaxed/simple;
	bh=rD+knfVmlT64JQ1lkKWQu4cILK/xQrLi9CqFuuTpl9k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QcBPOQxrqT5Xl8WUyPt0KZOvrtYVjC2vNfXOkivnKggsnBg/cyfCesG4Vq6e1kxeS5Tt2jW7rGxEqQTyoHzbVMOWaF+lF38oGPY9VUj1QLn1L9YxQZg2tMFDDaDq+13rx73GU42JWgkzvI5IHNpgo2LB3QiLN1VHIFax+4rebBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yXU81a3I; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yXU81a3I"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc404aaed5so1540654a91.3
        for <virtualization@lists.linux.dev>; Wed, 26 Feb 2025 18:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622793; x=1741227593; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=P4tBmLUacP8DGxGQBI6X9mo8c2uhJ9G5VZle1I388Hk=;
        b=yXU81a3IHi8u83HhqQgx41MoYxKGwVOe11XoBE7I6omyje0stXlXeCIleUH6s8++tn
         O6OviQxc4ZSczOmpWxNfg54LwowIXfJ3cnNRaiY82fSasVrZUdmMAuwRlVeuCn3Fi/cF
         WyVhI4xLwN8z+8PO9z91A7LmSm8nc7Zrlaefr5i6MrJmpG5+3Bex0AvPAPmglJLCwD/g
         4rEj/0HxA7T0Xw8BBsdg+WscdMPUpM4Z2caddCsT/4f6vcTdh3ZguGjJhCHFjRRnP8rs
         S/yia2/iPPAFHK6ffxw7tmsmGmCUYtQio1n60dlspYNZzZr93Uj7TXOU5TnQY7FWtLxB
         xcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622793; x=1741227593;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P4tBmLUacP8DGxGQBI6X9mo8c2uhJ9G5VZle1I388Hk=;
        b=ks6lPNDZT4ZeEsIX+MLcF84NkIcb1GVMsK7Y6vh3K/gLG9o9hxAKn2h7y7GR8GK4Wq
         Bwkq4QluVJRgABe0Gr0NMaQwmvxNEH/83OI/2Wg/wxSp5cgEXKi/akJyGxGDzLKdc8v/
         ee/vXCAD6M47pDxaUCjN7hWfVT3ROGfxj2XoxxofMjJ6xqc+zOQcBALencJhKqLlRiQt
         f4jlA0ldTDfsbTh3jwYdbUiMlyfhMWYpZwqRIbi0SgJMf0EWixb1+1veE1EiFz7nWpnG
         29yl9ZrvSNpLvUDF/nq/9+MoeKs2l7RrFESxlvwSA1ZOfU0iJyR6gX5yQ6ohIhzX2sbU
         RRXA==
X-Forwarded-Encrypted: i=1; AJvYcCWRU0fZ1BikU2P8EpydwIs8nWXf7ewkMrf+4afPqBhtEUk6IR+K3pdnOkUIe2OsZgOtU6iWr9mLN1EJKXAhqA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwAv+qNSUcD7VAJjOLWeQdOj+NP7oa2e6W6uPfvlEzpl7zRumRa
	DhDRVccD+6VWBdbt/Sni2YJbuFkzv5fw58MqbiDb3GL8BnmOTuMFLjRjkSWR3A3F7EDFnij8jem
	vbQ==
X-Google-Smtp-Source: AGHT+IGdVjOlq0BY70ioN6i4xVGmLOeDmFSQNBlkaPaHsOsARCADALqyiFXLpG70t8VDnA7M1OSlhaskPoo=
X-Received: from pjbsw3.prod.google.com ([2002:a17:90b:2c83:b0:2fa:15aa:4d2b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:54cd:b0:2f2:8bdd:cd8b
 with SMTP id 98e67ed59e1d1-2fe7e3b1756mr8832651a91.29.1740622793310; Wed, 26
 Feb 2025 18:19:53 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:45 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-30-seanjc@google.com>
Subject: [PATCH v2 29/38] x86/paravirt: Plumb a return code into __paravirt_set_sched_clock()
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

Add a return code to __paravirt_set_sched_clock() so that the kernel can
reject attempts to use a PV sched_clock without breaking the caller.  E.g.
when running as a CoCo VM with a secure TSC, using a PV clock is generally
undesirable.

Note, kvmclock is the only PV clock that does anything "extra" beyond
simply registering itself as sched_clock, i.e. is the only caller that
needs to check the new return value.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/paravirt.h | 6 +++---
 arch/x86/kernel/kvmclock.c      | 7 +++++--
 arch/x86/kernel/paravirt.c      | 5 +++--
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index e6d5e77753c4..5de31b22aa5f 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -28,14 +28,14 @@ u64 dummy_sched_clock(void);
 DECLARE_STATIC_CALL(pv_steal_clock, dummy_steal_clock);
 DECLARE_STATIC_CALL(pv_sched_clock, dummy_sched_clock);
 
-void __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
-				       void (*save)(void), void (*restore)(void));
+int __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
+				      void (*save)(void), void (*restore)(void));
 
 static __always_inline void paravirt_set_sched_clock(u64 (*func)(void),
 						     void (*save)(void),
 						     void (*restore)(void))
 {
-	__paravirt_set_sched_clock(func, true, save, restore);
+	(void)__paravirt_set_sched_clock(func, true, save, restore);
 }
 
 static __always_inline u64 paravirt_sched_clock(void)
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 76884dfc77f4..1dbe12ecb26e 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -337,9 +337,12 @@ static int kvmclock_setup_percpu(unsigned int cpu)
 
 static void __init kvm_sched_clock_init(bool stable)
 {
+	if (__paravirt_set_sched_clock(kvm_sched_clock_read, stable,
+				       kvm_save_sched_clock_state,
+				       kvm_restore_sched_clock_state))
+		return;
+
 	kvm_sched_clock_offset = kvm_clock_read();
-	__paravirt_set_sched_clock(kvm_sched_clock_read, stable,
-				   kvm_save_sched_clock_state, kvm_restore_sched_clock_state);
 	kvmclock_is_sched_clock = true;
 
 	/*
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 92bf831a63b1..a3a1359cfc26 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -86,8 +86,8 @@ static u64 native_steal_clock(int cpu)
 DEFINE_STATIC_CALL(pv_steal_clock, native_steal_clock);
 DEFINE_STATIC_CALL(pv_sched_clock, native_sched_clock);
 
-void __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
-				       void (*save)(void), void (*restore)(void))
+int __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
+				      void (*save)(void), void (*restore)(void))
 {
 	if (!stable)
 		clear_sched_clock_stable();
@@ -95,6 +95,7 @@ void __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
 	static_call_update(pv_sched_clock, func);
 	x86_platform.save_sched_clock_state = save;
 	x86_platform.restore_sched_clock_state = restore;
+	return 0;
 }
 
 /* These are in entry.S */
-- 
2.48.1.711.g2feabab25a-goog

