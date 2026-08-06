Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34B54A8C71
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 23:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059429; cv=none; b=RyuDw0bCzHuRTBSLAz7Qs8TNZtHAlzoG7ec2vcZ6s/V+nRik1QYr61esXx8qSD/lj6V4AeAd1tOFEG3KXkRWyolNROYbfOxeCvJ8IFhPS1jybjIaUFSuNVK3Al74s8pgFIwjs/lI3JjBT+baFIb1qMpiMFTBRWqJkWO7YwbiiGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059429; c=relaxed/simple;
	bh=oL4k89x+CtNtrtSN/chXxcI7VW6e8o1GiS+d7EOGh0Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gAxD1H9MWpa+5W5AQFU/yeouQpD6fBJ1RBp0XLoDoodMSHcox8CaGBtqT1GLf4MzHhfsrXOr7IeGRoQQwwPWnYyvNqnPO9xP4HpCYsDmm19d0aIgkzBAxSDj/etmxukR1BA9Man0wkx+XcDOGrsga/nLzAnmfJXV77g3NuZm/b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I4VMfOVK; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I4VMfOVK"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d122bbc621so4929065ad.0
        for <virtualization@lists.linux.dev>; Thu, 06 Aug 2026 16:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059427; x=1786664227; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=f+UXuTD6z7zajVoSPLixW+N3kzbQtDvz4+hCO4pCJ+c=;
        b=I4VMfOVK5Y4sazEU3PAZSJ4ApLURXNbeGleCJfLaiHzdWMPeCnHLYzSBdZcFEsCd1Q
         vNtw1CdTkrekUbefv06J9SCDHl9X3w7zq7E5AHyYuklLgWVz0xewyi3qDynbIM+4hNnT
         w5f1yBKyiblClnPt8j9TcVGP1DsAYHfe1ffw0bxjRZ/mjYTRNSCxq28OGJzbeSDTWh1d
         pt16N99aQTsxDjaG4l7nfwxu0pEYCFJHCVqTbKUDqdKlYyka9R0qpp33nttdNhKg4FW6
         98/BZ2pU/z7Jyo4IgO23uBbMmm9ndIuHq0cPDJS5c6lrJY1sh51oUlwd0TJeUMMqjzRL
         wQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059427; x=1786664227;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f+UXuTD6z7zajVoSPLixW+N3kzbQtDvz4+hCO4pCJ+c=;
        b=s/X9cHN6Zie6wOzxT99y71GR8vefpP1YPjaM9673udhYINSSkQt6TyCoNBd8FZc07+
         c62d98IV2f+s3+1dLkZ0t7/krD5ta9HKYISMdmenk5HaFLur3Yy2Ww4eWh4PB3D+JNKo
         i0ezh+HubKXXb78xKaGAnBQ1CKAjqn3OdnmjBfwotvDB6RKNGnWg71rRt6PODQpR2AYL
         SoF8edc7WL++vV1Ud2VJ/5Cq/4g8COkSnxIlV56tMS1XIJMTnbg4J08iu5GL0EOcmZXe
         Y2mnDvGxCIy0OOmbtQ3GJ+gabgO7UAMWTJfcfufYQ0RsJKjvV+/h5NSeHroaOnHZK4LF
         IE0w==
X-Forwarded-Encrypted: i=1; AHgh+Rq86DCmi0Mj0809Hvu4ZjTBdO6XdC5h0rJVrz9Dnxxpi3R3UZlJ44Q2h604GWJQHbtzrR8u/LNtzb4UKSWzdQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyjCBd6/oAN/g8RQlplJgUJv8ED7VpyLLbcyh4onLp+8+8XR2oI
	xpqzWuhjiiQNPKJrwVsg4f00rcgATOZEXM16qgELI9DHoNRzc0sTYsp1UzANEkXjliblV3zoMGd
	r2wijyA==
X-Received: from plbi11.prod.google.com ([2002:a17:903:20cb:b0:2cc:6da3:442d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f546:b0:2cc:aa36:c046
 with SMTP id d9443c01a7336-2d0ca77ece3mr197228075ad.14.1786059426608; Thu, 06
 Aug 2026 16:37:06 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:51 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-35-seanjc@google.com>
Subject: [PATCH v6 34/51] x86/vmware: NOP-ify save/restore hooks when using
 VMware's sched_clock
From: Sean Christopherson <seanjc@google.com>
To: Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	John Stultz <jstultz@google.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, 
	Miroslav Lichvar <mlichvar@redhat.com>, x86@kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Michael Kelley <mhklinux@outlook.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, David Woodhouse <dwmw2@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

NOP-ify the sched_clock save/restore hooks when using VMware's version of
sched_clock.  This will allow extending paravirt_set_sched_clock() to set
the save/restore hooks, without having to simultaneously change the
behavior of VMware guests.

Note, it's not at all obvious that it's safe/correct for VMware guests to
do nothing on suspend/resume, but that's a pre-existing problem.  Leave it
for a VMware expert to sort out.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/vmware.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index cbe8b59ab79f..94fec990a02c 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -347,8 +347,11 @@ static void __init vmware_paravirt_ops_setup(void)
 
 	vmware_cyc2ns_setup();
 
-	if (vmw_sched_clock)
+	if (vmw_sched_clock) {
 		paravirt_set_sched_clock(vmware_sched_clock);
+		x86_platform.save_sched_clock_state = x86_init_noop;
+		x86_platform.restore_sched_clock_state = x86_init_noop;
+	}
 
 	if (vmware_is_stealclock_available()) {
 		has_steal_clock = true;
-- 
2.55.0.679.g6767b8d81c-goog

