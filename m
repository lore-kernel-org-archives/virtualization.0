Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0063D34BB
	for <virtualization@lists.linux.dev>; Fri, 15 May 2026 19:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872839; cv=none; b=iKyaETQgkxYiZojbpWWtXqun27jM9BbEJCxVrVGn6L9TyPQpl3UXTIgu4fIPMpEW3THxNk+R7ud4LumyNtSaOu4CFmzNS0mrWFCLy08QMDvSS27Sw7eJ9b6HEZHkqmmfh3E3uW0UJKCocOFABQ0IiWFdV7OAgihZu/utwbyKfwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872839; c=relaxed/simple;
	bh=O7JO2spBMPL1ycg94DN7ybYVsLuLSpeqr0A1pVho4MY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RT/s3WaKIJG7xIu5TKdr0fAR5fBSUsvgQkjGwOXhESjRTTMuIemxSy2MsmeSD7GiiasM8ao6P3o762mj1vJ3Zk1V1lt7ihRdYn3tbaJZdPiHbTpXinnfpBS5odT+pz8F0IR/1bS2G7HHDWwB7EURcHbiQMDjjb/mxbxEGMasnQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HduVn98P; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HduVn98P"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c828cee4fcdso122177a12.3
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 12:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872835; x=1779477635; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=rYtqxRsyPTn9zcEDwit0IKYSbyTf6XV6vC/bmJj4kzY=;
        b=HduVn98PLp2XxnZHakZWxgGgWzdlaREqohD2ZXCgjYACAfZ9u6NoLoshXl7KGLDtpA
         XzQYbRLVvrv3fY88BaMXuVGuHOgDHS2iX/jP8WpL44cPdLt8/UF6mGMWe4bzPVbgsVgC
         B3qh8njW8RRgz6r57AoqOtvvhMi0yteLRYyce7yBy8mNrbhXejLiUGPZQo/S/Qjdt6Ya
         TrdxN/v8EWTBdZ9HDAN29je0NJjKNTXUdJ4Z/WZLt75O9SRBfbmE5Od+FTSJpFiQseo7
         Y0aiVXXisWwVC4qKxmk1AnsbrV6VNbLp7CS8iugMse0kux6hG9NFDgA0c+eUxhXCXt2Q
         UQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872835; x=1779477635;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rYtqxRsyPTn9zcEDwit0IKYSbyTf6XV6vC/bmJj4kzY=;
        b=TAkDTg+ET41wSv1DqjLAxEostXPDbCyjdWSx1XVCRULaePxt3rBfigP2wUosSCH25V
         LBT+HBPnedfyKzxKcjB0/qK592OyAvklZUATaSTDpaVtWunYFJOzNfKS9AhCL4prhCl8
         C0gZF1Ao2z7q/pbUtR9qT7KtBHQtT6C94+kCJXC+QGTkgEk7hPBZXsDz6J/PkdgmTa8B
         lTt1oGirnYo/Rj7MCnSdu0wpZvgrrlSk/F7edDKlqx8kmW02YaKySwdhEDokpBQmqy25
         c4X9mmYQ59Wx7ZCfxvmbLJ/qCtxTJSBGqqCcQowUgdUOqA+eVpMvFI4Qw7B9qUvwOyDz
         b4Jw==
X-Forwarded-Encrypted: i=1; AFNElJ8tj6DfnaF6vmWTG7OO+WXP/NDxLwiRZ/kx2qvGooXrkSM5PC0Mg4MzunIR3fBEFmpT7czCjVzhfSrT83VTkQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwqOWpKf9x441oFr9Hn+/vig13/OCQUCFjFPTtgCvYtcfWCgfDd
	GkAGKJqCE2ZZCoqtXl6RW+1TFpjDM4AXYXV2zKOd3qU8nH3sHQ3i64Gi8NKaXcKIcgVMDEx2ATS
	/oUkE6Q==
X-Received: from pgbgj3.prod.google.com ([2002:a05:6a02:4943:b0:c73:8741:7555])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a24:b0:39c:241:65a3
 with SMTP id adf61e73a8af0-3b22e6668b2mr6600745637.1.1778872835218; Fri, 15
 May 2026 12:20:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:11 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-11-seanjc@google.com>
Subject: [PATCH v3 10/41] x86/kvmclock: Setup kvmclock for secondary CPUs iff CONFIG_SMP=y
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

Gate kvmclock's secondary CPU code on CONFIG_SMP, not CONFIG_X86_LOCAL_APIC.
Originally, kvmclock piggybacked PV APIC ops to setup secondary CPUs.
When that wart was fixed by commit df156f90a0f9 ("x86: Introduce
x86_cpuinit.early_percpu_clock_init hook"), the dependency on a local APIC
got carried forward unnecessarily.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index e9e7394140dd..df95516a9d89 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -187,7 +187,7 @@ static void kvm_restore_sched_clock_state(void)
 	kvm_register_clock("primary cpu clock, resume");
 }
 
-#ifdef CONFIG_X86_LOCAL_APIC
+#ifdef CONFIG_SMP
 static void kvm_setup_secondary_clock(void)
 {
 	kvm_register_clock("secondary cpu clock");
@@ -325,7 +325,7 @@ void __init kvmclock_init(void)
 
 	x86_platform.get_wallclock = kvm_get_wallclock;
 	x86_platform.set_wallclock = kvm_set_wallclock;
-#ifdef CONFIG_X86_LOCAL_APIC
+#ifdef CONFIG_SMP
 	x86_cpuinit.early_percpu_clock_init = kvm_setup_secondary_clock;
 #endif
 	x86_platform.save_sched_clock_state = kvm_save_sched_clock_state;
-- 
2.54.0.563.g4f69b47b94-goog

