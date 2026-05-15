Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB54C3E277A
	for <virtualization@lists.linux.dev>; Fri, 15 May 2026 19:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872865; cv=none; b=OiHYtn/iSMYyIEvcNd7ObxPzBZGUcUjCgTlYBkVDWRFCzaYUNr68pcv/iN4hpYB1bDQgHHYci/UvgDqZdMRb/GgmWpRRv1azyrpt7Vw/YEJVTd2M+RNJtS4YKMpOUeJ6HgDgC4W73iI62SG3l4hfchpPQe3xFmGn6Mvy7FBV834=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872865; c=relaxed/simple;
	bh=++iwLO4D9TJzPz8kuVQ32pM9hy17JXnAFhkjXdC7Tyo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B9gvNmr5SBn717e5mA9r1bYA7rxTHl0X1fVuNTYukhZCsGCNIWjiVFzY2maDYjZFHlsHDPcDP+elL5omRg+CISM8IGmuWyV0VXwmIo0JhQQdHoSBV+oxBfjrd9r3p/XnJ4xyZym9we3tszgc34zALpu60D9x9WjHmsCKO1Ghw8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VsLUDJgl; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VsLUDJgl"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f9f49e4beso89429b3a.0
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 12:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872863; x=1779477663; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=cmCCoVXH/wzfqmDby7kD+g/lqwg2CVoD5UqPiffRRm8=;
        b=VsLUDJglH3NLxH+gtzaraEvmoaOIizk6/Ugysw5bhZVNavb6ezw3ItReNBxIt0Vr3K
         yTGHl2BIKDANMeaqOgTsXRZfTV4uNLdEthWn/MdVvfVmo5O+jrqERaWBAz7VG2QCR1gL
         trnm66x5Hik7B+16d9RAJlYxMOrGXXtVk7pf0Pcq9UPMFN6ELtHCLw5pVM91oi8+67Mh
         cqv9HPEheBUizRarJxpHu1T3eJw10dN5tmqxOmrZcY0auSUjoFZK/2Bnv6602wJyMpc0
         JTaV3WBbHS9eP4166VfFo2lZU3ZzyHgLu02Y5xS97qTOU/ICzKUoVI3f5mHbQM2LoOYR
         Z0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872863; x=1779477663;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cmCCoVXH/wzfqmDby7kD+g/lqwg2CVoD5UqPiffRRm8=;
        b=glpgZncWiOyZyYz4sTZUeWrQlkQiNR/rr8xWgsMg4cNuXz1fuQtUYH1VBXSE6IObzI
         5KrduQiZlKKcwyQT/rz6zgazOElSsDkb97UAJT53D3TCRbP8O3vL89Ef/aa7kQUo77EI
         3a0Z3sl2OrriQgAlwmH3DzBj2kXR3CsUcw9UDMVRsno68h3rTtHGuhhzXj/aNTCebocP
         TGbvGFNkAmPDKvdaGAy137q0kOZDxUSIg6QCVhrtsTGGJbYpGuUfQJ9AmdsnfiO93vDv
         k04xPuiv9W/tKl/Zqe6mpZ8tXjHTj1oO2CRvTFGgW+8E+LeXpSi89aAcODH1d5bzbQv/
         /dCg==
X-Forwarded-Encrypted: i=1; AFNElJ8l3J7i+0Bh2d3Dm/BWnoJeQ0VLfMWTNYVo6XiUuGlKjPhmbDszbhBlpspsnEYETVU2CCQ7ZZ5kAIHkOsi1hA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzIjMmFzsk4Tjmw/RK6+K9nqyIpMSUORceGTL8vDGWmEVtim6Rf
	8t9K7ao5VSkZ37MU5/17wtBvBacpJnMSdWwfOVzJXDiDyM4T2GPkTKblU69e/uQcjC5P4lkcPVG
	zsxr8Qg==
X-Received: from pfbeq3.prod.google.com ([2002:a05:6a00:37c3:b0:82f:ad57:40bb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:44c3:b0:82c:6da7:2d3d
 with SMTP id d2e1a72fcca58-83f33c2a8fdmr5145208b3a.11.1778872862416; Fri, 15
 May 2026 12:21:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:26 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-26-seanjc@google.com>
Subject: [PATCH v3 25/41] x86/kvmclock: Hook clocksource.suspend/resume when
 kvmclock isn't sched_clock
From: Sean Christopherson <seanjc@google.com>
To: Kiryl Shutsemau <kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	John Stultz <jstultz@google.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, x86@kernel.org, 
	linux-coco@lists.linux.dev, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Michael Kelley <mhklinux@outlook.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"

Save/restore kvmclock across suspend/resume via clocksource hooks when
kvmclock isn't being used for sched_clock.  This will allow using kvmclock
as a clocksource (or for wallclock!) without also using it for sched_clock.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index ccb2aff89b2f..655037949446 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -131,7 +131,17 @@ static void kvm_setup_secondary_clock(void)
 
 static void kvm_restore_sched_clock_state(void)
 {
-	kvm_register_clock("primary cpu clock, resume");
+	kvm_register_clock("primary cpu, sched_clock resume");
+}
+
+static void kvmclock_suspend(struct clocksource *cs)
+{
+	kvmclock_disable();
+}
+
+static void kvmclock_resume(struct clocksource *cs)
+{
+	kvm_register_clock("primary cpu, clocksource resume");
 }
 
 void kvmclock_cpu_action(enum kvm_guest_cpu_action action)
@@ -202,6 +212,8 @@ static struct clocksource kvm_clock = {
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 	.id     = CSID_X86_KVM_CLK,
 	.enable	= kvm_cs_enable,
+	.suspend = kvmclock_suspend,
+	.resume = kvmclock_resume,
 };
 
 static void __init kvmclock_init_mem(void)
@@ -297,6 +309,15 @@ static __init void kvm_sched_clock_init(bool stable)
 				   kvm_save_sched_clock_state,
 				   kvm_restore_sched_clock_state);
 
+	/*
+	 * The BSP's clock is managed via dedicated sched_clock save/restore
+	 * hooks when kvmclock is used as sched_clock, as sched_clock needs to
+	 * be kept alive until the very end of suspend entry, and restored as
+	 * quickly as possible after resume.
+	 */
+	kvm_clock.suspend = NULL;
+	kvm_clock.resume = NULL;
+
 	pr_info("kvm-clock: using sched offset of %llu cycles",
 		kvm_sched_clock_offset);
 
-- 
2.54.0.563.g4f69b47b94-goog

