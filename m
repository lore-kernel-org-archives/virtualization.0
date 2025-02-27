Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B011DE3BA
	for <virtualization@lists.linux.dev>; Thu, 27 Feb 2025 02:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622764; cv=none; b=Akf+SXqpCs+ZXeEG8dZe0Dr/d0b9hGIiH6KIHdcnDNxyZPEypzwvJFSFi/ToXg0/bmzpC1wftKNPu6o95Xj3fVfP6skZd7+a5HpsY+1sCvWPmyVcXoFxCrssIDIhWkDz0ZriJw2CvxLXVZH0rR2HAz8+6EkNSkKMnudVvmwAKXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622764; c=relaxed/simple;
	bh=YBBFB7GmxuAVG9YiGJjI2SvbfrD7XwOfpFXbtpwvuc8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fcRVqTnQYqZ3yBVr18OjRy/2s6lEDxYO3YxiVKpWvL9WW3e1HHR5l2r6WmtCJM4YL4yPERJ3tvS8PMzHTHfIGZVRCHGbl+9YqM2DwHvWtFnTgpd+rO2JGbVBv1JfXLe3jI3Id74O3Rg8iyz7u6QQxnaOT4CQAV0ciLCbqajjPmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vz76w/PB; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vz76w/PB"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fce2954a10so1535175a91.1
        for <virtualization@lists.linux.dev>; Wed, 26 Feb 2025 18:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622762; x=1741227562; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=yPGNLLFa/vXB2a0UM8EIYJpWd3IhBx8wcQJSj3RCAHc=;
        b=vz76w/PBKjvB7l4B0UjxBVMuusjstJVQUfvPna+3GZXGmYZxcOtbTdulNJHiKFWKz2
         uYOGD5uuL9LHDcYfbNdXDpPt+74dYJ+0pG6zoXUvftjX9CitRvy5D/rysviXRh8kSr+B
         UfAoWASWfval7UPzuMKJHZwd3pH/Y8cKYjYLRdu3yycX7icny2znqapgu02n3DnQH65u
         iHHbOrDBX1zDmIuEU1LVY87JPajU3bSAzBxFsTUUJLg4hLcN7m1A41Zh83EsLhY36nwY
         jqSNmSJjFnAs0gNBMPspXVtfo+7MnXANAkg+x0AVQta6+0BDXC3iT3RascdLySIKZX5Y
         Mvlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622762; x=1741227562;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yPGNLLFa/vXB2a0UM8EIYJpWd3IhBx8wcQJSj3RCAHc=;
        b=W6+CN+XKCr6gb9nmhHy80OEWLkwWIWkAVgYhBqXtRy2Y8rz37l4cxOAJ944nFWupJh
         d5PdVW9TlM6OaMifflF3Mzyr5VaIOlWpduj0q9svzyQuk4ZUmPsBPzS0WYF8rilEl1iM
         k8viS+mV2t4Ep6CpgOOiEgjAPAyroHHCK/1R+wrgBzf44PZ6INR4S3cf6ncmWij2T3yy
         MYRm1PGTAV1XPjq4cU0qW8bLxQFnBIQe8V/axss73ZyzM/NJUrZ+MNi4e43fnl1EskbJ
         7KYO7vX+U69UVWfKymmgKIqab7jRdyYKQJIC6eIU2rAE/40OgT/LgoT1mG6JO/42JAzv
         gu3g==
X-Forwarded-Encrypted: i=1; AJvYcCVAmxuarAFWxe/ZTF6kigPhGPiOahbi/UYmZN0L2wxem6bsZuudgRkzx1pt4jnjR+4OdCVXwzp5RJbWOLY8ww==@lists.linux.dev
X-Gm-Message-State: AOJu0YwXZXTP/BzXKAwosIz/lYwX3c4YIzasvJBch1Ioh9OG0ZBErDgf
	0hsaF64Fq4QPJJPiwJJSAAMY9rL3E5Y72NMrtwCYeG0ZgfxEaUYpAfBFr8coh1vGtgcYL7xMGw8
	Zfw==
X-Google-Smtp-Source: AGHT+IGTG4bhtwk6xF9NkwSwRr4MZ0JMu1OW/uXbFyNTNSUBj4feLwfxPugt+I59qi4711mZsSVJuOvx1D0=
X-Received: from pjbqn3.prod.google.com ([2002:a17:90b:3d43:b0:2ea:5469:76c2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:fa14:b0:2fe:84d6:cdfc
 with SMTP id 98e67ed59e1d1-2fe84d6cf88mr6952534a91.35.1740622762299; Wed, 26
 Feb 2025 18:19:22 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:27 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-12-seanjc@google.com>
Subject: [PATCH v2 11/38] x86/kvmclock: Setup kvmclock for secondary CPUs iff CONFIG_SMP=y
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
index b898b95a7d50..80d1a06609c8 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -186,7 +186,7 @@ static void kvm_restore_sched_clock_state(void)
 	kvm_register_clock("primary cpu clock, resume");
 }
 
-#ifdef CONFIG_X86_LOCAL_APIC
+#ifdef CONFIG_SMP
 static void kvm_setup_secondary_clock(void)
 {
 	kvm_register_clock("secondary cpu clock");
@@ -324,7 +324,7 @@ void __init kvmclock_init(void)
 
 	x86_platform.get_wallclock = kvm_get_wallclock;
 	x86_platform.set_wallclock = kvm_set_wallclock;
-#ifdef CONFIG_X86_LOCAL_APIC
+#ifdef CONFIG_SMP
 	x86_cpuinit.early_percpu_clock_init = kvm_setup_secondary_clock;
 #endif
 	x86_platform.save_sched_clock_state = kvm_save_sched_clock_state;
-- 
2.48.1.711.g2feabab25a-goog

