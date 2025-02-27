Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BB821A44B
	for <virtualization@lists.linux.dev>; Thu, 27 Feb 2025 02:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622778; cv=none; b=KsVarMBx6Kav6Oc9nZqFYCSR7tdBrRGP/bALVlRN7eT5pNrrFh7ETjP3XsRYaa1To9GUUqF+lD4iCYGKcRPpPtMlVyCCaS5MgYHLIB3LmUCvxdc3wtHQ+fNQOKIl/fd3t0EPd4FLuZI6sJv0ifqGsOiIxV/7aDQBPx0HTvr1z6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622778; c=relaxed/simple;
	bh=6spaFA6jKPMfGFgmSBLcviB3IyQMP9osLaGs4X9wbRo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j+ncFzFRMUsNLOTfzfQsIwyhcuda3W9oXK8czXYEuEDbnqHgmIFw1aucemUfQlN5ndrU6g7Z1xFjLpv1i/hBK1Cm1fjIB0gBFmuPLVPvmr6IFhSRePBvkZX3gkODSYanqDdEiOLDDwmlsksPqOfkhVop/37o84rDdMKYrXpFnc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d/1tIEa7; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d/1tIEa7"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22109f29c99so8582635ad.1
        for <virtualization@lists.linux.dev>; Wed, 26 Feb 2025 18:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622776; x=1741227576; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=DqrQU03sQXOQDWLkbiIYCQHYscRa6LsfmxFd/y9lSQI=;
        b=d/1tIEa7vrec6jay0QtMWQguwWHp135SrENoYDsra6KRq4ZtTKpItjCnUtl/EHcyZt
         Gu56oEs5h3Gjl79vLM00xiLWytY8W086eiSCRrqaXHLa7C2lCwA54JPVp23EzlAbeI8E
         q7qnIdKD+8M0w6+Mh/H0i+scd0CWigYZs11iaUIIs9yjm7UM5gxoXDoZRaUOP0NMqhW6
         dQuLWbxNyMOn7ibriPLuS9YiokVoKzB7dF3E9VQH15aKYf9N3usMjxzFPjrz3OC/RTEu
         2xORsU0MFf0EQ+Jtz+I5i728sWTVe/cDbdk1GWlunUWfB5T/QwifO40NJHEAKpMyId5C
         ZvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622776; x=1741227576;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DqrQU03sQXOQDWLkbiIYCQHYscRa6LsfmxFd/y9lSQI=;
        b=huLx0N2qawcM8AgnKla46u/AQhioip+nZ7Rs0H+wSUeDUUrDgluKUSEI7MNFGHAue+
         R97cl3ljO3id3XWeUX8LuYR7dHhAJu6eLNJxwgRmM9ZVVVCn1xfji6XZ74DH0SFGfb/1
         z5BW3y0N7zyjzU5jj7AALoUilbGvJg+G4lpdcw45KlwhQWgoyuGh6mpbIDSuT+pE2VQL
         K/J+2ni1HBE6UfEAI48h88VqC778MyiymatGWpqhPylh3s7w8DCryDerHkd9tqjsrRWf
         A35d6RWs25NPSg8Qb7jGx7oy43o4kqr8HE4ox4jqPcZq3vhqyIs6IUp74yD4SOJU3QCS
         IRMg==
X-Forwarded-Encrypted: i=1; AJvYcCVD2O6AJ3YsWuyFk3yTVBiAtMSZqh0vRgqROnVaavuFLWCCBv6xlK/i/Em+zM5SHrdUPl19Ynm+hy4OzL2Mgg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKvHU2UfwdjCF9yQrLxZO5U6iVpOwPYPDaAelBcCXJ1vCFAxmP
	JJsUdj0LJihuTdXc3Ce9w0NdP1WNiigVrHGEl2/4Ap6Z2lxkQrOjdjcutLzsvYjOS+jD36vsgdN
	O2w==
X-Google-Smtp-Source: AGHT+IEOb0ihEjgZTJgsK50piH41vKgvY42fSlJ0VND1RngWC+UvT9KhzxC1r0flylu86Z/N4Su58D1alpU=
X-Received: from pllg7.prod.google.com ([2002:a17:902:7407:b0:223:2747:3d22])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d58e:b0:21f:140e:2929
 with SMTP id d9443c01a7336-22307b52eb5mr158736135ad.15.1740622776273; Wed, 26
 Feb 2025 18:19:36 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:35 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-20-seanjc@google.com>
Subject: [PATCH v2 19/38] x86/kvmclock: Move kvm_sched_clock_init() down in kvmclock.c
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

Move kvm_sched_clock_init() "down" so that it can reference the global
kvm_clock structure without needing a forward declaration.

Opportunistically mark the helper as "__init" instead of "inline" to make
its usage more obvious; modern compilers don't need a hint to inline a
single-use function, and an extra CALL+RET pair during boot is a complete
non-issue.  And, if the compiler ignores the hint and does NOT inline the
function, the resulting code may not get discarded after boot due lack of
an __init annotation.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 1ad3878cc1d9..934ee4a4c6d4 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -133,19 +133,6 @@ static void kvm_restore_sched_clock_state(void)
 	kvm_register_clock("primary cpu clock, resume");
 }
 
-static inline void kvm_sched_clock_init(bool stable)
-{
-	kvm_sched_clock_offset = kvm_clock_read();
-	__paravirt_set_sched_clock(kvm_sched_clock_read, stable,
-				   kvm_save_sched_clock_state, kvm_restore_sched_clock_state);
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
@@ -302,6 +289,19 @@ static int kvmclock_setup_percpu(unsigned int cpu)
 	return p ? 0 : -ENOMEM;
 }
 
+static void __init kvm_sched_clock_init(bool stable)
+{
+	kvm_sched_clock_offset = kvm_clock_read();
+	__paravirt_set_sched_clock(kvm_sched_clock_read, stable,
+				   kvm_save_sched_clock_state, kvm_restore_sched_clock_state);
+
+	pr_info("kvm-clock: using sched offset of %llu cycles",
+		kvm_sched_clock_offset);
+
+	BUILD_BUG_ON(sizeof(kvm_sched_clock_offset) >
+		sizeof(((struct pvclock_vcpu_time_info *)NULL)->system_time));
+}
+
 void __init kvmclock_init(void)
 {
 	u8 flags;
-- 
2.48.1.711.g2feabab25a-goog

