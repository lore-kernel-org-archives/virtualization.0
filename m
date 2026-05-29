Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37FC3F4DEC
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067280; cv=none; b=TIwHnBk+2ulNk3F7s7ej0o7jz2V5dkhdUGG5WrEPxZmeM2dxJdkLecsq5pGhz4iiS3IKEaWswOTJQHDB4O9vklzP1Ds+GBvUrqWgDDu55WlNyVwrmP7L4bjDF4Kf1ZTJWS3n5kPvuYko3hiUsVIScar1A6N6BEPDdSSNVKimNgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067280; c=relaxed/simple;
	bh=FpeYXKUVm9PMkFdOsJA/iB3JokpDn1J3KKT5u4Rg4HU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PDHm3u6Vx5T+xG6DGND0e5DtsCH79HuaPjyLf5g/7HEQj786wBbZGFwluKkZcqJZA3Y2o9WhPBvY7GFGGrMxfseb0JG4zFx3KM9QK8Nwky7/igwyBQNfH+6iBR/tHvrYaPqTIhxNSTkjPNDbKYfR0qm2ZOnMutuBfvXzOHVaNq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b9JNIt1I; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b9JNIt1I"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8582b167f7so40250a12.0
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780067278; x=1780672078; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=xxACJL8GJmmB0S+liLqaHbVRa5fkFAryvwd+hR3Tj1U=;
        b=b9JNIt1Ic+EAvLbmi/VvDrnOyiWdpByg3+YYJAXpK7v1JnO4lZvzr9j4po50wErPWE
         OsS7HnnVBtX7zV9TlehJ8HL278P6jxU+QluPqt28UefFE1mwCP6IaR2cHHn1Tfcxc5dJ
         Bgk8L3KiXlvWc00cKuEA/X5EbAZ9rWUxWCzZ7L8ZI0aFEy+c5qLFoA9Weo0gN1cMbvSI
         wlsmk4urgLQIWj3cs1BfIUxNoIAWY4rOt7JKI7SCOGM5HEHTTC1MVJfMk1+vMRHykn+z
         XTL/mE8+zQS2mLsi9/K8KrtfkbcHrhsPuIrhf23k9obEU11bSIkdRgg/QnwZV/8kzwyx
         N6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780067278; x=1780672078;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xxACJL8GJmmB0S+liLqaHbVRa5fkFAryvwd+hR3Tj1U=;
        b=B+WKAFnAlw0pgN/VvT4kqE/rYUBpMUR5u/iuQX8rBBroOxRbQFod3e6n2QQ+7pRBi1
         oQCD7j8iV++txnp0Hx3WKdIcGgNBHawk28Lx3LToag4rNgRr59XMle1Uu2zI4ReEi3tb
         efKrU8/IJLsA53Tp/PIKRVyxBtvbnAMNGjTrubo3BZcbMo8Dz9GueZjXBIc4KtC9U3sL
         /4zrjmutiu4+b6zOV0yn194ICx5CTGH9Z7K3dodb7XrC2h9VmROjELF607hkGLOOQiEB
         GIRKc10YVE+tWIMEOJhm0ShbpDfX9f+SQMj8jnTtfLb+t6xKvd2QjfaCQmyuGBDaHYpT
         OzWw==
X-Forwarded-Encrypted: i=1; AFNElJ8y/Nb3QJ6khKOJ/AQfpLSDCK9E0WIKfjCJXvcX6O68n9FglNkgKcMYNjwq/QAH6arp7hqs8hyKDZM3EwPHsQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzVujMimz5yMohVsTXVMt+1hyZieulqYKv4JEMpOBSmpci4jqNI
	RiHqvuYDjVaGET5bC4MKyrgTUBycKDwBXrpqVfvPWaV3jhlSJjoU801HJPZcLZ2G+8hPc5Mcx8q
	9ksJn+A==
X-Received: from pgbda10.prod.google.com ([2002:a05:6a02:238a:b0:c80:2987:4220])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9f88:b0:3b3:1951:489b
 with SMTP id adf61e73a8af0-3b411e714f7mr3887670637.45.1780067278068; Fri, 29
 May 2026 08:07:58 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 08:07:55 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150755.714364-1-seanjc@google.com>
Subject: [PATCH v4 32/47] x86/tsc: WARN if TSC sched_clock save/restore used
 with PV sched_clock
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

Now that all PV clocksources override the sched_clock save/restore hooks
when overriding sched_clock, WARN if the "default" TSC hooks are invoked
when using a PV sched_clock, e.g. to guard against regressions.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/tsc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index a9b6d3399c23..19da1a3d2126 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -972,9 +972,17 @@ EXPORT_SYMBOL_GPL(recalibrate_cpu_khz);
 
 static unsigned long long cyc2ns_suspend;
 
+static __always_inline bool tsc_is_save_restore_needed(void)
+{
+	if (WARN_ON_ONCE(!using_native_sched_clock()))
+		return false;
+
+	return static_branch_likely(&__use_tsc) || sched_clock_stable();
+}
+
 void tsc_save_sched_clock_state(void)
 {
-	if (!static_branch_likely(&__use_tsc) && !sched_clock_stable())
+	if (!tsc_is_save_restore_needed())
 		return;
 
 	cyc2ns_suspend = sched_clock();
@@ -994,7 +1002,7 @@ void tsc_restore_sched_clock_state(void)
 	unsigned long flags;
 	int cpu;
 
-	if (!static_branch_likely(&__use_tsc) && !sched_clock_stable())
+	if (!tsc_is_save_restore_needed())
 		return;
 
 	local_irq_save(flags);
-- 
2.54.0.823.g6e5bcc1fc9-goog

