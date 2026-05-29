Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CD63ED5A3
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 14:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065911; cv=none; b=QHLMHXnffqzxoT5FD2Hf9bOE2eq5K8pUPDBEiHHMXzlmtVEYXH1amEwr6b5OY+3KhObZB4FpUqnk1b7rfa+gy5YL9kxgFGP1yMW6DWh65nasV82KNweMvVzTxMfyeL7dmVa+8TjKK2MArki7DWGHJI3FphgpJihvjzwdTJv15nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065911; c=relaxed/simple;
	bh=H4O1Uc1N5QXpjXIPDVIAG3zCuTw/l761jFnyTqpLBcc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TVpsnMlnHA4TJsnpha/42kAlaLhxbF509Cu5f0KV6jdsQBPo9WXeT6dkem4yfcNOdySxcT/MCoW57d3wmb+uCgqM72jTBbezGPNzEturvdcE+9ebrJTEuNt4b0SuN5wxQcVOYDuY3mR0GlWbOiKcQu03uEvu5x7aSkL/UhhpenI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sdfGw/tE; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sdfGw/tE"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-366344513a3so26702762a91.3
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 07:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780065909; x=1780670709; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=dFi7v06+6W1FLZftWdDZ5nEL1MuL8W1WaU9VoOY7VWI=;
        b=sdfGw/tEU+xzDEoQ7bUt1REoukYNykpLjCZ4rPalNjUciFjPdG99x92faeQBGA/lpi
         dtZAqil/uIt44+JV4U0BN9+b+RbGvTxp4ZAEz42sVXHX5v01ZClFzunVc+pjXq2glbnd
         17a/0txHzK7e8lH4gl1vmQ/OGoOq6CHk4oE3A0xWIXztt5j3fLs4AAt/D0W190fwDWNx
         tu9f1eKSLzzWsw+hXWvzDgj861WgYihkp/L/rNyhho3qXwuyBnduN/xRUVy6qbgXUSkm
         fJ/I1m6KZ3jxJhalv85wgVH+5Jv4/djmM3bvJCxsM6/C1CP+KDRcrlqkGxHg0oMt5e63
         vHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065909; x=1780670709;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dFi7v06+6W1FLZftWdDZ5nEL1MuL8W1WaU9VoOY7VWI=;
        b=Qqk28oyFT8aJ4kXXLEC+80yW6801+61nf3sHnWL7Zn2uHSRz/C/cwZkV5xswrfpGlO
         DAKCzBR/3ewOS4riMrBAn4sxYxIvLqyptPTlZPZYa0KwP9f0HHeLcyvhEApLmkjsYm/f
         NlYgIkGNZidWBsMb0wmQZ+rFObtPmqPc7uYUjQRO9JnlPB7lZ3vAhpuz6ZiZUwOP8vm8
         rU45RQ0q7AO0+J7X05S6yr5ErbeC26PWCO5W5C1herOhFVD4MErEgmCOIUn23ylkdB2a
         JqCuWMpNFJho8x0aqnkcpBY9RV1kEVooLF5tjpbxrotLURvCBWdEKLSCXUokJshLt+Ug
         rJpQ==
X-Forwarded-Encrypted: i=1; AFNElJ9p7JaswlVkeuuiWWsWyGa7JdAOuAT/K3OOrYwUAC7rGW7OT6FIURS+oss2ZJfeL2NQWflBXrOQOLMiO5D30w==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywa6Yt4UXrvjJV8GmcFfbdLuLplybzZP2oGumyJBL6mI/YkZ/Pe
	MfMuIBckWlwaaAo7hBB69FbvVm31IbgfwjnZ1iAIpvpVntxWAH7S2Gt/s62qnu2Ei8pvbrcbck0
	EkWrktA==
X-Received: from pjwy3.prod.google.com ([2002:a17:90a:d0c3:b0:369:1a1a:82d5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:518e:b0:35f:b6a1:8d27
 with SMTP id 98e67ed59e1d1-36bbcd92760mr4080563a91.18.1780065908349; Fri, 29
 May 2026 07:45:08 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 07:44:01 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529144435.704127-15-seanjc@google.com>
Subject: [PATCH v4 14/47] x86/kvmclock: Rename kvm_get_tsc_khz() to kvmclock_get_tsc_khz()
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
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

Rename kvm_get_tsc_khz() to kvmclock_get_tsc_khz() in anticipation of
adding support for getting TSC info from PV CPUID, i.e. in a KVM specific
way, but without non-kvmclock.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 69752b170e0a..c4a782a0c903 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -115,7 +115,7 @@ static inline void kvm_sched_clock_init(bool stable)
  * poll of guests can be running and trouble each other. So we preset
  * lpj here
  */
-static unsigned int __init kvm_get_tsc_khz(void)
+static unsigned int __init kvmclock_get_tsc_khz(void)
 {
 	return pvclock_tsc_khz(this_cpu_pvti());
 }
@@ -125,7 +125,7 @@ static void __init kvm_get_preset_lpj(void)
 	unsigned long khz;
 	u64 lpj;
 
-	khz = kvm_get_tsc_khz();
+	khz = kvmclock_get_tsc_khz();
 
 	lpj = ((u64)khz * 1000);
 	do_div(lpj, HZ);
@@ -320,8 +320,8 @@ void __init kvmclock_init(void)
 	flags = pvclock_read_flags(&hv_clock_boot[0].pvti);
 	kvm_sched_clock_init(flags & PVCLOCK_TSC_STABLE_BIT);
 
-	x86_init.hyper.get_tsc_khz = kvm_get_tsc_khz;
-	x86_init.hyper.get_cpu_khz = kvm_get_tsc_khz;
+	x86_init.hyper.get_tsc_khz = kvmclock_get_tsc_khz;
+	x86_init.hyper.get_cpu_khz = kvmclock_get_tsc_khz;
 	x86_platform.get_wallclock = kvm_get_wallclock;
 	x86_platform.set_wallclock = kvm_set_wallclock;
 #ifdef CONFIG_X86_LOCAL_APIC
-- 
2.54.0.823.g6e5bcc1fc9-goog

