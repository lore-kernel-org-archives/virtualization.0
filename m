Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091783F6C29
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067285; cv=none; b=aHqrA+aXQj7hiREBFpAHNbjGclejyBGIdU+GJH8DZqI0laBz1L23DtPYbZyK2ZvWvF5a+PrblLj1KmNT3v1ji2BB5laNPfak1U36iqAE0d3vEnEuZE0ZE/JjU4uOioR5KkzGzjsrBmm9/IMttQy8h+415sXo5xa7fyQyuFuLWXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067285; c=relaxed/simple;
	bh=oQBeCKjjhNFtUPINo6soUvc55PJ7W+tEXERwbtHRNX4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pmG2kVm7Jn09c1kjtkb6ljEW/mmjseoGehvE2RDXSao0PLihwiUpbNZnK6BGppa0nQKU/LdFlJB0zmzdX4HD9FSDC6jiq3OEfRQX2D0ZdglCsltkrnmluL+1EdIdlnVGYN5V7uUxj99gnI8f6Un6+dNpIdWAuqLYTz70jlVjA2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ot/bMwzH; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ot/bMwzH"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bc763c7256so291256465ad.3
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780067283; x=1780672083; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=A0LUKgY7WdUW5/UN6qkumXlSSdA1avjLrzVcdpZcOlg=;
        b=ot/bMwzHUBuh7Y08+1Qz3RFETNqSkHu697bDfhSUaSi9XUnmfLrHNgza4oPdftPWEc
         Pa8B0tJ1GNb4XdlpbcBuxP29soeqp9cLBQaTT3ovazL848bD9US7oJ4o7dcjKquteN8o
         3l8zYADQmKYcvi2wvgOQGCrYN4lUGMxOZRle0lgkn3DrCl/oT7nO4W3B1841VzZ53FV0
         32h9o24WJFGVfGvolB8413fIPo+IBJzNfYm8RONrAt1CKqOL0yp6x6dSgiF7zztSP5X3
         8FMbD0pbtT0Thk15p5nwW5F1hj6iH5ZSteTmk6stF11Jvh/hJx4VgT3TzPAKsouG7dV7
         AsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780067283; x=1780672083;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A0LUKgY7WdUW5/UN6qkumXlSSdA1avjLrzVcdpZcOlg=;
        b=NLecBAVIcOaxp9uQ6wEP7wd6unJ2BS3Nhpq/EA8SuVvNZt9P55qh2T3Y3+GzjLju8O
         jxVP9EsCLmDSrYDtwg3NrxsTYI0GtLEMC6YSj/p4o/yYVVwyMLBFwRiNr9Ukgxw1pY6i
         /6CujuaCKnyQo1OZItbk3CSwGBNKFNkPYPblArQjCY0E+2kO60IpMKE3unmDXNhllJXg
         kGMMVXB0ZLfiLreZBunLEtwS2AWo0P/g8rUYs2HSkvkwtLD0akT8xn/Ae5l7XCz37dKo
         krydPhwQgWmwz7zavxudsguIKkU2i7AaL+yX/g7vr8ArRoG+sNCo8+w2ffRB80RHYv8D
         feAg==
X-Forwarded-Encrypted: i=1; AFNElJ+7tevS7fUk30/Jc41EBcDgvGuFx9Hh+ZnSPxc8PNID+N4OeHVGB4BGti4tt/5w5IO0H67f/LEoBcnfvQWoig==@lists.linux.dev
X-Gm-Message-State: AOJu0YyoT+xS3ZW1N9awPhjxdR/W1VTUE28i4Pnxb1V9khH0bPTgDTfI
	aWbOY4OphjlFqwfEHLKrOilBiiGES6VooBCCD7W3koe5/YACEgtqbERQ/Ktj43eOQPwG39EFHPi
	//ImboA==
X-Received: from pldt15.prod.google.com ([2002:a17:903:40cf:b0:2bd:a5da:7a51])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da84:b0:2bc:8f62:990b
 with SMTP id d9443c01a7336-2bf368d7531mr1933905ad.41.1780067283075; Fri, 29
 May 2026 08:08:03 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 08:08:00 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150800.714453-1-seanjc@google.com>
Subject: [PATCH v4 34/47] x86/kvmclock: Move kvm_sched_clock_init() down in kvmclock.c
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	"K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, David Woodhouse <dwmw@amazon.co.uk>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	David Woodhouse <dwmw2@infradead.org>, Michael Kelley <mhklinux@outlook.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Move kvm_sched_clock_init() "down" so that it can reference the global
kvm_clock structure without needing a forward declaration.

Opportunistically mark the helper as "__init" instead of "inline" to make
its usage more obvious; modern compilers don't need a hint to inline a
single-use function, and an extra CALL+RET pair during boot is a complete
non-issue.  And, if the compiler ignores the hint and does NOT inline the
function, the resulting code may not get discarded after boot due lack of
an __init annotation.

No functional change intended.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 05bca2be0df3..6372b4dc7b0c 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -134,20 +134,6 @@ static void kvm_restore_sched_clock_state(void)
 	kvm_register_clock("primary cpu clock, resume");
 }
 
-static inline void kvm_sched_clock_init(bool stable)
-{
-	kvm_sched_clock_offset = kvm_clock_read();
-	__paravirt_set_sched_clock(kvm_sched_clock_read, stable,
-				   kvm_save_sched_clock_state,
-				   kvm_restore_sched_clock_state);
-
-	pr_info("kvm-clock: using sched offset of %llu cycles",
-		kvm_sched_clock_offset);
-
-	BUILD_BUG_ON(sizeof(kvm_sched_clock_offset) >
-		sizeof(((struct pvclock_vcpu_time_info *)NULL)->system_time));
-}
-
 void kvmclock_cpu_action(enum kvm_guest_cpu_action action)
 {
 	/*
@@ -303,6 +289,20 @@ static int kvmclock_setup_percpu(unsigned int cpu)
 	return p ? 0 : -ENOMEM;
 }
 
+static __init void kvm_sched_clock_init(bool stable)
+{
+	kvm_sched_clock_offset = kvm_clock_read();
+	__paravirt_set_sched_clock(kvm_sched_clock_read, stable,
+				   kvm_save_sched_clock_state,
+				   kvm_restore_sched_clock_state);
+
+	pr_info("kvm-clock: using sched offset of %llu cycles",
+		kvm_sched_clock_offset);
+
+	BUILD_BUG_ON(sizeof(kvm_sched_clock_offset) >
+		sizeof(((struct pvclock_vcpu_time_info *)NULL)->system_time));
+}
+
 void __init kvmclock_init(bool prefer_tsc)
 {
 	u8 flags;
-- 
2.54.0.823.g6e5bcc1fc9-goog

