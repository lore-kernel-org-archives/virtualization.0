Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811E42206A6
	for <virtualization@lists.linux.dev>; Thu, 27 Feb 2025 02:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622782; cv=none; b=EBrWJs9tzVRh5yw+OBr1Nq3OmnjFkBxft33rmI/HQyfLLaD45a9nrJWni7FhGYgVPWyBmCD2wq4fuenHCmLvDh2c92GPaekrfJtIqN63wccYcfOPtHJlaayaVHBUbAkfJQZuzgTlydONClKP1vWpe+MuJiQRGsNAR6tU/+uQkNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622782; c=relaxed/simple;
	bh=W77bDJioIxxlTCWtlgTvtUdQUjN+l9y/G05gekf8Apg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B/lsceSUj0QXRFj3LnnOx4z+XeH5sStRWKo7XLIuuvF6gsGAgujyKipxPQhcd58qaAukjt+0EUxU6xPHSanS9nnN2aB8tLpvCxPdv5rejV2iRujPNytopW2DisfrjTJ/3QaRO8I1Bxh5iXEYGtw/go14k3oBhNMQk3Cev+a4f/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BHAbiqq3; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BHAbiqq3"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fe8fa38f6eso1027030a91.2
        for <virtualization@lists.linux.dev>; Wed, 26 Feb 2025 18:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622780; x=1741227580; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=kU2lFcUz0RS/25JB9tsyegi1crsFJmJvQFST0gISHao=;
        b=BHAbiqq3XaKKPJJzUah8sdAH/1/1MTxarc0z6qwHZMfKgKYEIglTcv5tyJOXOSs2Gh
         ketyoRekcSNReNNs9UlZstVZ7IE/J0NV1i1AHxl8/nZRXJ7f4Wa5E+7IVIVCcqivhMpP
         9yPSttRxxuqWZx8qwyMNdr077W5HB4fn6Qt+lxDedoHrJBycKk29RfG/faE8hV/guiCn
         ZFKgInqe7Ovr61P9B0klLMcr5mBL9LYmabuFtgvSk7ReWfE64Umy2Xiqqs8BDbvqI76r
         9JWJqOawAjD7ppyIIOwje3mnbeD3bQ2kMcM5zmaGt7x9tXgvFSZIuzadHpigNUwLZBSc
         0I1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622780; x=1741227580;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kU2lFcUz0RS/25JB9tsyegi1crsFJmJvQFST0gISHao=;
        b=cNS4V+OwpCUW9u9LZU3xp7OcnQi94WYJZRXVmEesr+Zebd3DzdP4Wa1ahVzLk85cGU
         cNTJmOj/YJqOSyIhI4LtG99M8PpNFL8uWoI4Pzrx5WFGv0SEA1v4CuJM9UAW0zYSL5Ts
         vC+Nku468eCa8wMnBq3+YvqpqE+AnTTR2ZnG04zOk15pQZne3722Ly9Vy48FzN3bKNak
         oz25JAGVSKne/OXnhOWzojwWcHjqOa+ljfDbG6Q/bKTytbYJ/VryQ0BAhphaz7emag1s
         E2CqTfp4Dgguet4+tgZQUcJgXM5MLnlW+OmGK02hbxEPg5EVigwk6YblcMPEpMaMWTye
         Lzog==
X-Forwarded-Encrypted: i=1; AJvYcCXkZ/hoXGUwh3Z4T888vHefGspuyxI1glnTHaVwBGIH2bu5KuXJUuWENzAD5RBoD3yMdBCMu6mFhVRA6hbI/g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyd9N/A2liyoWRAaPie2LpJeDZlAaAVU3c7r4Fm8waCfZkr2QZU
	wxptyx0M05m9xytVWA28NzLEZ0S96R8Hu/Pvyal8JkcAgsFBCP6VM/E1dfTW0ttMQKm5UhZGlk+
	i6Q==
X-Google-Smtp-Source: AGHT+IGPqE+K3f21q2ak8FFNHYsAgDpuaP0E98T4gncRvFB5lVR5BPc4qf0azJ1lc37DAZgmd7FgPnilX0Q=
X-Received: from pjbsh7.prod.google.com ([2002:a17:90b:5247:b0:2f2:e97a:e77f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:fc44:b0:2f6:f107:fae6
 with SMTP id 98e67ed59e1d1-2fe68cf3f5fmr12813327a91.23.1740622779809; Wed, 26
 Feb 2025 18:19:39 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:37 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-22-seanjc@google.com>
Subject: [PATCH v2 21/38] x86/pvclock: Mark setup helpers and related various
 as __init/__ro_after_init
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

Now that Xen PV clock and kvmclock explicitly do setup only during init,
tag the common PV clock flags/vsyscall variables and their mutators with
__init.

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
2.48.1.711.g2feabab25a-goog

