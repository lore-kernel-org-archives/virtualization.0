Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD063E1227
	for <virtualization@lists.linux.dev>; Fri, 15 May 2026 19:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872850; cv=none; b=JksqSzxdJgdBGrg9I/AL3nSlgOA6I+LVdn3F8TKP75D/F3H7IpddUORgP/eQl2bPVKz4AiiM8KlKcL+HGzWbQDwoUAZbL8snWLntnvDbvYDHw2AGyYYYNwn6EfvhVD0O0Qexqz3Cja79Wqacfx06kxRHG/nXzB4LlrWUxVeJPE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872850; c=relaxed/simple;
	bh=7t7bZAkjWH8tEuvlMroGRphDuT5a2BO5RqjwXybBung=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I5F9cTT1emUpECFfmpOLGXfoayyTgpO/IBaZiYqCRmItL0gWhFj6/8GzSanJo6wjgHb6N01S2GXkhkkESCwoFhMlR9P/rwhidctVIsnkfV1Iqh22U2E6luCpny0b9t/5/+twDjBCLVJb6tB0S6m1qRILACu7mtJ1X/6rg1jHP9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ICEgfvG9; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ICEgfvG9"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-83536dc3be5so248213b3a.1
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 12:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872848; x=1779477648; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=c0VSXuwvwTL0EdvBxlPRCLOC48TzlA2S3UU4EaITdRg=;
        b=ICEgfvG9mscE7boNRUqgd9ZHKO7hf/Gv/vMoImo9dKy86hCDEAqzp7rK0fCz5PKRQM
         nbG1ltUvirc+/RY9DAoW4SnTx5tzqnWnkmA+8tbEVPZnQUel68bWX15t9VJTG8nhdARF
         Y0reArQg9ZBJFoh1IN1AadXFTe94A+r7nlidXo8SsR+OW+S0ZA9074M54x5SGUsBxGYB
         KPUOrJp+dzp5JvZ0U4Xebv+nCZRmjQOUZxBOHoHEEHD01MNOUDrj/wT7AR2mCRWTGh0w
         b23ktxvyZCz9QXmbUfziJFUcjQ21gMRrkdD+mkLRQJa8Pg0bTK6I3rdv/8cJNMn/zAWn
         iTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872848; x=1779477648;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c0VSXuwvwTL0EdvBxlPRCLOC48TzlA2S3UU4EaITdRg=;
        b=KL3KOqEHdsdiViPtITdwl5xZfdIaMttwJRhNUnZtqUkSvZXehBlNFvMQLIEv1gAuQM
         9NzoY4AmBOI2+BobUFCYxQwb7nz0+tVelyhRm90VHvIoeEkDmdP+y5mBUvmS+2zegBxa
         +Xl3u1z11WgkD97h4ASaobiB2FC3jVsVV+mRRQ4mXzOUDh5Kq7cb2wYEVyjTlaaTpa1+
         8e1FSso7ior22ihfoBn6xRcmjraZxJBlF8xmsnJr/y2unnBCy8cik8HeKOhhF2UUDdRD
         GyJb5Ed9rO5HUcHEtpERe3lSH28zJ4cHhZdiUw+rycAEh+U3N1qobo5/lKvMD5Qb52UU
         wvkg==
X-Forwarded-Encrypted: i=1; AFNElJ8pBDi/jrPmnOuJGtYV35I7J2vcteAt3R96b1yp3XX+Y9M/on/h5KlKWOP13FCBhbn9FiTAfbCczfIM/aLwOw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6DHqWK6lby/sAUrR0s4ZdRVHJ2+GqY63NNSpKRqlr84Dpf+QR
	FQ1JL6e3PQaAy5x1ueJt92R/D8VMgrKDo3li0SXSO08kN1E1bYsZOlTrzKNl7jFCHWyxZHNAxTa
	xlioX8g==
X-Received: from pfbff26.prod.google.com ([2002:a05:6a00:2f5a:b0:83e:dfc6:971])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1908:b0:82f:50cd:e586
 with SMTP id d2e1a72fcca58-83f33cb2c40mr5886442b3a.13.1778872848066; Fri, 15
 May 2026 12:20:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:17 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-17-seanjc@google.com>
Subject: [PATCH v3 16/41] x86/vmware: Nullify save/restore hooks when using
 VMware's sched_clock
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

Nullify the sched_clock save/restore hooks when using VMware's version of
sched_clock.  This will allow extending paravirt_set_sched_clock() to set
the save/restore hooks, without having to simultaneously change the
behavior of VMware guests.

Note, it's not at all obvious that it's safe/correct for VMware guests to
do nothing on suspend/resume, but that's a pre-existing problem.  Leave it
for a VMware expert to sort out.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/vmware.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index b88d9ca01202..b5cb66ca022b 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -347,8 +347,11 @@ static void __init vmware_paravirt_ops_setup(void)
 
 	vmware_cyc2ns_setup();
 
-	if (vmw_sched_clock)
+	if (vmw_sched_clock) {
 		paravirt_set_sched_clock(vmware_sched_clock);
+		x86_platform.save_sched_clock_state = NULL;
+		x86_platform.restore_sched_clock_state = NULL;
+	}
 
 	if (vmware_is_stealclock_available()) {
 		has_steal_clock = true;
-- 
2.54.0.563.g4f69b47b94-goog

