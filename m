Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B6A426422
	for <virtualization@lists.linux.dev>; Wed,  1 Jul 2026 19:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934398; cv=none; b=NiZ1cYnjuW4hDK/grEiqaaZ6VKdFqNOnw+mLL8AUOEQhlMCA4+YzFt7byWRJm1Fgp8brP/MfHAfb3jQrXlVVZUXmSL6fqumu/kgE47ovXWQwE5xPpswAewI8yTYHybQyfiP8mMKviUE9YoCMuS29cQtQ4e+o+53s8ixtpyeQpZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934398; c=relaxed/simple;
	bh=ktUv4JiVG9cTXmS+Hdc614GouDZnZJtPdGZ3jvL606g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NkAtCpjgUNLEmAOFBmZlkQajoRXUMDbuwv4tFutqYbKZRcVTzUEbrTdjDsjc9ytJm367kVXvRelFb7ljQA+FSrWrEs2A8wzkWx45zQDcK0vbSrf7RvVkw83WB0i+N94kgeSllmQZZFm1ZmxEjgxTKxLMcb4Eh41lmpTi8Lu4enQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jRG9h3eC; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jRG9h3eC"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c916d17dd43so1230777a12.3
        for <virtualization@lists.linux.dev>; Wed, 01 Jul 2026 12:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934395; x=1783539195; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=gy5b+9Ie1Ki1M0iB4wQwCtkzcjH6HRhEeykN2jC/eJ8=;
        b=jRG9h3eC7dAVjnC3OggBgfMxETUpAf6AN8EbP1YSO3uhtgDVPwx/2/E5AY+Kgtakaw
         XxBUeYudX2nd0PDZgUG61SK7CqTG4292+pTGf2VJyZqdMY0xTfMldsSciC953Beh+aVA
         CBaCIHu+kJ4VYGrdeG7Kao/+Pxwxsp+gR/MyWE7ByEOqtAQbFwBM4GvlHywT4L4r1MwT
         beKUxxPIzLkQQYA2eLYu6u/zwwYiXNoJJe4lGxAv0Mg9BsOWyDcJKOHga/zH8tOZ8Lnc
         0zYB624ozGx1x/P7u5Gi8iLq85XXYKgz5QS1T9vTbv+GkmvtPkPAeA5j9AESxiEuj9Vv
         qOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934395; x=1783539195;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gy5b+9Ie1Ki1M0iB4wQwCtkzcjH6HRhEeykN2jC/eJ8=;
        b=FoNGSJl8uQHFTy9mA0KyuEwjXdy/nZvxNqTZe4zZolGK+PYZuOcvpfcglwLZGyvZ2F
         W4xqEq6VAsjEgtQTEJ6lYXdu7GZWRFkOjC18DQ22AuMay/dk3hKwRhMETUtH8fX4MVBP
         sFaHwQE2NvzxSeFxic1uTuse74Uibs9VoVpy5Irfke1TbeEvZLJkUcEsEz532kW7FsWy
         zAWQ9M9clPeWFMOnyww+uXPcjEioa83eLUaqVBN92WNklXuIkdmrGdRYmEmOr7gtblXx
         Cw80Qi5dz3oN9sW2wnJAzhpGYryhW2qS6re2b5fjT805GzW5yYpHoydKutkmptXOAyuR
         yaFA==
X-Forwarded-Encrypted: i=1; AHgh+RpuxlutpGqqDb+Tq1hXtYGlaCbNkDKcMxF+54P2Bea4oE3MQa7KC4fFSxGPNDcca27+sBXEiQqnVP/XzIplQQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzt1t4F3gtaxK9nzoejSmwwhLmR+hW7GK3g8niK4RW7SXFvR+J/
	ilKn7zHFhEt1riyqVcO+kUcXxZylAmcLgz8sNnjWA0VKJxd80jtDbU6yRFGkE0uSVQrRJKu+vat
	BxbrZDQ==
X-Received: from pfbbk23.prod.google.com ([2002:aa7:8317:0:b0:846:7503:7350])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3d56:b0:845:36a0:9eb2
 with SMTP id d2e1a72fcca58-847c096d1f0mr2944243b3a.34.1782934394416; Wed, 01
 Jul 2026 12:33:14 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:32:00 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-40-seanjc@google.com>
Subject: [PATCH v5 39/51] x86/pvclock: Mark setup helpers and related various
 as __init/__ro_after_init
From: Sean Christopherson <seanjc@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sean Christopherson <seanjc@google.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, linux-doc@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, Tom Lendacky <thomas.lendacky@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	David Woodhouse <dwmw2@infradead.org>, Michael Kelley <mhklinux@outlook.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Now that Xen PV clock and kvmclock explicitly do setup only during init,
tag the common PV clock flags/vsyscall variables and their mutators with
__init.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/pvclock.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/pvclock.c b/arch/x86/kernel/pvclock.c
index b3f81379c2fc..a51adce67f92 100644
--- a/arch/x86/kernel/pvclock.c
+++ b/arch/x86/kernel/pvclock.c
@@ -16,10 +16,10 @@
 #include <asm/pvclock.h>
 #include <asm/vgtod.h>
 
-static u8 valid_flags __read_mostly = 0;
-static struct pvclock_vsyscall_time_info *pvti_cpu0_va __read_mostly;
+static u8 valid_flags __ro_after_init = 0;
+static struct pvclock_vsyscall_time_info *pvti_cpu0_va __ro_after_init;
 
-void pvclock_set_flags(u8 flags)
+void __init pvclock_set_flags(u8 flags)
 {
 	valid_flags = flags;
 }
@@ -153,7 +153,7 @@ void pvclock_read_wallclock(struct pvclock_wall_clock *wall_clock,
 	set_normalized_timespec64(ts, now.tv_sec, now.tv_nsec);
 }
 
-void pvclock_set_pvti_cpu0_va(struct pvclock_vsyscall_time_info *pvti)
+void __init pvclock_set_pvti_cpu0_va(struct pvclock_vsyscall_time_info *pvti)
 {
 	WARN_ON(vclock_was_used(VDSO_CLOCKMODE_PVCLOCK));
 	pvti_cpu0_va = pvti;
-- 
2.55.0.rc0.799.gd6f94ed593-goog

