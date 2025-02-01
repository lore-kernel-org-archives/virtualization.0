Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E7D19F13C
	for <virtualization@lists.linux.dev>; Sat,  1 Feb 2025 02:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738376266; cv=none; b=QXjQeuR1AadHYxY+3GD0Sgg4dOiWeiIDBoavrl5usGfvS4hVLibFAnsszE2svGWVb8RForfRNhSoN0/LhNntCwGWzeoT9mELgAfl1ai3s6D7Z0QfFpm/QscnJOuGPmo227ubtnBLn3ti2is96iD0tdOqgGqUrbObZiy+RCPlsgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738376266; c=relaxed/simple;
	bh=kx1WuhibcuTx6WiHPmvUxDfP1htj6y2KJdDmu/FjmBY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WqXJdHWEurtTxuJZ1ggER2LJSRv8fKyN4FhspSW25e1AgprcMC691SQDbyGMshf9FWTyBc1lFjB7j3OsL9FWOfIHLZlj5DBYfGSxcAZT5nOrJd15ACDYdYmfAPp/FDk3c0ig3VPUwDDTdBoSaEpH1Ji/SUNOIsboNv1qOEqqeuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n5Qkt8WM; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n5Qkt8WM"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21640607349so59744715ad.0
        for <virtualization@lists.linux.dev>; Fri, 31 Jan 2025 18:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738376265; x=1738981065; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=W1XV2ZKxBzpt6fRRKseHNiWV51nuIILy1d39LBlT9SE=;
        b=n5Qkt8WMqLZ4fX+USlNT21VnLYb46eZrfIFoVD3aC0XYIxEBQbavYTs4LAmSuIxr5T
         ZgxHn+OZil5yRXa7onMPOWtg+niJMSv/MVL3niUeSGDG9YntvhcK60ru6fsRB28qQtWg
         mnGSuu6Impd4jnFDN8B+XtcIy2oJ1oSxVUaaKXexgZi03MFVMVu7hSQrYlSqc7GK8vjY
         eROPqGMloFmMANak5OBYZgvvx1wwOr8DphhY406l7AAKuHNHh/hYdVHrKw06Unri/P+a
         H87HgM0bhzysT2zWv6Yp/yQ5ncloCPSibk0E+zmfxBezZvCJPvL41nA8uSbVfBAutuGE
         Dzng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738376265; x=1738981065;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W1XV2ZKxBzpt6fRRKseHNiWV51nuIILy1d39LBlT9SE=;
        b=BP9y8yTrqVCV5beD6hXqrulwXU36zJlcDqzI6pEtjVtxp/c6OgKwc6S5LKTQ0rjLxa
         COOYszcsTZG3i5Ik/63wJB4+u1isoA7w1OFUHTsaKDvLqpdQ6gSLohyN2EK5uI+HKQPk
         c5ak7VEpO/dwyAvycbeCTGDBtOL4yZcq1367EBU2KgnlsueveuWGRgHHrUT5PUfj9u/x
         3fF3tQrsUPkObJ2ySW9n10sWBfu+eAqvZV1RlZH9eY+1NK+sZKjkwo+Vz+csX7bTLenO
         m/N6XwJFYv4EE6tL+ZiM5hT4jFj3shdPEAhqZAFEyICMRsGp7YgEAecvHv/Jmrfz+Icw
         0khA==
X-Forwarded-Encrypted: i=1; AJvYcCV+EKgVNwESH9QVvtous3W1NpU+wgdmPMlvWWbd+Vhz7KVFwconxFYvaElnc2vSyXQnQlOxuzL7xlf01XI1Hg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwjgKmH+AA6gY5s+IdUaM7/PGDIiCI+hVhG/mra159WOQGsrV5k
	PckejiBvLv5lB9+Agns8+0lyra9MUGRu2iMzPSl7IcgroLlOIy0+rYV28LLJjd4PsAdkB6tP8RX
	g2g==
X-Google-Smtp-Source: AGHT+IGSSeREbj02hPb3cDa39T9c0oKEk7xpncELnx14V1Vrs2HnSpCp6+OTk/Z1j4CkHarX3h8UUIGOLcI=
X-Received: from pjbsb14.prod.google.com ([2002:a17:90b:50ce:b0:2f4:465d:5c61])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:244c:b0:215:f1c2:fcc4
 with SMTP id d9443c01a7336-21dd7deeff4mr227157665ad.41.1738376264849; Fri, 31
 Jan 2025 18:17:44 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 31 Jan 2025 18:17:12 -0800
In-Reply-To: <20250201021718.699411-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250201021718.699411-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250201021718.699411-11-seanjc@google.com>
Subject: [PATCH 10/16] x86/paravirt: Move handling of unstable PV clocks into paravirt_set_sched_clock()
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Juergen Gross <jgross@suse.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Alexey Makhalov <alexey.amakhalov@broadcom.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-hyperv@vger.kernel.org, 
	jailhouse-dev@googlegroups.com, kvm@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Sean Christopherson <seanjc@google.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

Move the handling of unstable PV clocks, of which kvmclock is the only
example, into paravirt_set_sched_clock().  This will allow modifying
paravirt_set_sched_clock() to keep using the TSC for sched_clock in
certain scenarios without unintentionally marking the TSC-based clock as
unstable.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/paravirt.h | 7 ++++++-
 arch/x86/kernel/kvmclock.c      | 5 +----
 arch/x86/kernel/paravirt.c      | 6 +++++-
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 041aff51eb50..cfceabd5f7e1 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -28,7 +28,12 @@ u64 dummy_sched_clock(void);
 DECLARE_STATIC_CALL(pv_steal_clock, dummy_steal_clock);
 DECLARE_STATIC_CALL(pv_sched_clock, dummy_sched_clock);
 
-void paravirt_set_sched_clock(u64 (*func)(void));
+void __paravirt_set_sched_clock(u64 (*func)(void), bool stable);
+
+static inline void paravirt_set_sched_clock(u64 (*func)(void))
+{
+	__paravirt_set_sched_clock(func, true);
+}
 
 static __always_inline u64 paravirt_sched_clock(void)
 {
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index b41ac7f27b9f..890535ddc059 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -12,7 +12,6 @@
 #include <linux/hardirq.h>
 #include <linux/cpuhotplug.h>
 #include <linux/sched.h>
-#include <linux/sched/clock.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/set_memory.h>
@@ -93,10 +92,8 @@ static noinstr u64 kvm_sched_clock_read(void)
 
 static inline void kvm_sched_clock_init(bool stable)
 {
-	if (!stable)
-		clear_sched_clock_stable();
 	kvm_sched_clock_offset = kvm_clock_read();
-	paravirt_set_sched_clock(kvm_sched_clock_read);
+	__paravirt_set_sched_clock(kvm_sched_clock_read, stable);
 
 	pr_info("kvm-clock: using sched offset of %llu cycles",
 		kvm_sched_clock_offset);
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 1ccaa3397a67..55c819673a9d 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -14,6 +14,7 @@
 #include <linux/highmem.h>
 #include <linux/kprobes.h>
 #include <linux/pgtable.h>
+#include <linux/sched/clock.h>
 #include <linux/static_call.h>
 
 #include <asm/bug.h>
@@ -85,8 +86,11 @@ static u64 native_steal_clock(int cpu)
 DEFINE_STATIC_CALL(pv_steal_clock, native_steal_clock);
 DEFINE_STATIC_CALL(pv_sched_clock, native_sched_clock);
 
-void paravirt_set_sched_clock(u64 (*func)(void))
+void __paravirt_set_sched_clock(u64 (*func)(void), bool stable)
 {
+	if (!stable)
+		clear_sched_clock_stable();
+
 	static_call_update(pv_sched_clock, func);
 }
 
-- 
2.48.1.362.g079036d154-goog

