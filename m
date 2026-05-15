Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD82548A2D9
	for <virtualization@lists.linux.dev>; Fri, 15 May 2026 19:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872858; cv=none; b=L/eTRFwsKCurMsCdtEWOtKUwogDNrBc8sgn0BnOoq3XBYpKIf923Y7qtRK6GQ5UCTrENNzZhINK5kwg0F/Eg7hshL/30xVxLpdBshYFyTbFoQ+boodQnfCqVDBhAKbvyd4WtMhW08T2cf4bN0f51+5vqYkTNftuBCSu0rvwrz0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872858; c=relaxed/simple;
	bh=XHuFwpmRMigDS8aPY2gzeqSH8+iLJhWYuJEhRhC21LM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d6zLJyHUBu2D0IZ7X/WOvBr+kOKTjHPMV0T9JJjwRyo5zvP3xED/QZXCb++5NYccr6W/DX1iCyZLD1nU+ydzO52H3k/KBJyXgqfJ8Qq5vcDinuijFvHL8NC+uBzOXtOH4KSMDCN0kgN/nE7nsBTQTXlhjXQ3va8bfYPgSM7YUDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eUPq0DBy; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eUPq0DBy"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b99eb06178so4590535ad.2
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 12:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872856; x=1779477656; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=7w7qT+Z66rWfxvtZ1IzSRlO054bgZsKsszMlQ0FarYw=;
        b=eUPq0DBy2Ud9j1dRLabCDt13MLF7Y1kNR83HHPkU2erkmGHVP14hnocKJXUg9vi8/v
         EhxfwcAFHvd4pJJJqToShcEYICMSQSqs3yzNjLVwmWjfnWwXpjUtYR6ta1Wem66feVG9
         T0EFqDxaN5jPYFIpEot0HuUQjxXFI6O3+IRoxWWiAfWos/hn4yIpreHhis9TprcWX9a9
         6ySBJGHvdzHnJCpEMLB2rjS4rROBvBJt+kOvdRx72q/yhzvEW0PW+9HIaXBd0EmWVp3L
         k/L6Y9By8QQ+52KpxQrvaEED5aSz4uz2vqVzdqsNtnV79cuH5q6CUJV8xLpRxAeTT7zl
         LJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872856; x=1779477656;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7w7qT+Z66rWfxvtZ1IzSRlO054bgZsKsszMlQ0FarYw=;
        b=Af502FWF7rcwFKjuvh0Nyd6FWABGLQy8PKCBuvvfXJfqVjzIPmB9Oa9Y/rOcsNWaTq
         9CGs4HJ9o8HSN+g0XMXR/PeKP1W5jO7rj3hUeiq3NgRA2LuqpYcb5FGIeXOPP/FK7qmA
         X1fIdMnBQLh+v0UXuar6oZDU6bKB43SvQJeQYsD/hMze5A/ypphMBb/ceFv0kKmE5qbM
         PZf6jW5qxYbv+Q84yKzxluxzicLEzy0HFJFhlG4NgNnltIp33xr7YzjpzqKY991ZFew6
         RzPAuAvtGyQ2Trh3rCLtifnEDaAdHt40m2KD8hFSb1GpG31vxgpCXTcs8adw7EqkURMt
         6anA==
X-Forwarded-Encrypted: i=1; AFNElJ8k4XQHIGZxVU70Nl0auuxYBXkSG7fqru2YjvSIuS0SMTqoV+etGO5YGiXPuXBBNQcUXwySavqhG0b0b0vnGA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1cNfc7i/IRGsxG+9EAVpbhzifLbS+ViHt8q3+pROpHHxPc1Ei
	5Q5mOWMK2PefqC1OCJZk7gTGUk6xI+Wa0QXwXXDCP+tnB737hrUzitA+WoPT/m1x/8pCpISshfM
	BvDQ2vA==
X-Received: from plcm4.prod.google.com ([2002:a17:902:f204:b0:2b0:b12e:1b07])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ee09:b0:2b4:62bd:ee3
 with SMTP id d9443c01a7336-2bd7e937a4bmr42674815ad.33.1778872855638; Fri, 15
 May 2026 12:20:55 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:24 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-24-seanjc@google.com>
Subject: [PATCH v3 23/41] x86/kvmclock: Refactor handling of
 PVCLOCK_TSC_STABLE_BIT during kvmclock_init()
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

Clean up the setting of PVCLOCK_TSC_STABLE_BIT during kvmclock init to
make it somewhat obvious that pvclock_read_flags() must be called *after*
pvclock_set_flags().

Note, in theory, a different PV clock could have set PVCLOCK_TSC_STABLE_BIT
in the supported flags, i.e. reading flags only if
KVM_FEATURE_CLOCKSOURCE_STABLE_BIT is set could very, very theoretically
result in a change in behavior.  In practice, the kernel only supports a
single PV clock.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 8df6adcd6cd8..ccb2aff89b2f 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -306,7 +306,7 @@ static __init void kvm_sched_clock_init(bool stable)
 
 void __init kvmclock_init(void)
 {
-	u8 flags;
+	bool stable = false;
 
 	if (!kvm_para_available() || !kvmclock)
 		return;
@@ -333,11 +333,18 @@ void __init kvmclock_init(void)
 	kvm_register_clock("primary cpu clock");
 	pvclock_set_pvti_cpu0_va(hv_clock_boot);
 
-	if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE_STABLE_BIT))
+	if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE_STABLE_BIT)) {
 		pvclock_set_flags(PVCLOCK_TSC_STABLE_BIT);
 
-	flags = pvclock_read_flags(&hv_clock_boot[0].pvti);
-	kvm_sched_clock_init(flags & PVCLOCK_TSC_STABLE_BIT);
+		/*
+		 * Check if the clock is stable *after* marking TSC_STABLE as a
+		 * valid flag.
+		 */
+		stable = pvclock_read_flags(&hv_clock_boot[0].pvti) &
+			 PVCLOCK_TSC_STABLE_BIT;
+	}
+
+	kvm_sched_clock_init(stable);
 
 	tsc_register_calibration_routines(kvm_get_tsc_khz, kvm_get_tsc_khz);
 
-- 
2.54.0.563.g4f69b47b94-goog

