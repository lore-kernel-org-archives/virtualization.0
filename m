Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593733F23CF
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067274; cv=none; b=jG+e1hGKX0K+uImTRTVyg1lOxQSzY0S2jv9I7IDnu/6qMOldffvlO9Gq4WXFnj184IdCrIqoEdEPMGaAGZGqBbKlaOVtSkmwvVAKpj6eKm+Q25gXo1ch5dvfzKSScVAwKECfTFNY41bWkI8nqC1Xs/B4iBa+VqRq2poMnjFMXI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067274; c=relaxed/simple;
	bh=jVoGol12bIRznjNhieU5A4Tdk7z3jKrmByZepFDORvs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QU00GtlffRFvIVGKTKjZv5g8z3ALF1P4/V0UWaBY/X/eMpqE9KJd+XYGdjtVp4RbhAggSzhlFSrxjLk2EPvrrtpVMajNH2XwcNOeB9T91w8UYPVLL7nJdt1jYVXgAxIqQhfRoA5i8pc/ySywEjslO8uIUHyCm+VxEFrlWOF9MtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ryz0heY9; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ryz0heY9"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36642d2f4deso26603522a91.3
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780067273; x=1780672073; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=kJfvO9zjLIcNgxwydf05ic8q1+t5yL6F8Cppp5YBjVQ=;
        b=Ryz0heY92yZ7c3tyWpt7CXtXsCLaQLUxT3sYTfBknu0I8GcQmBEfameSmMmncEI/Fi
         AiD8eRiGvjLr5K2xkJWFgr1coRNToUujt5rU6Dz9XwFvgqwP5UKC5i5hzyq4Ujfzt/Lv
         mqg03M5uSQHAvLaw7mGwjWjx67VPxCN8nLx8zBlfan1fSkwmTvh6wvw+hBfy0HnJcu2j
         rxINxhv6oOpKr3UDycps2T8kQq9rZwUfTo4xwgzxq5qau8/VFISvAcSjGH57eN+eit/K
         Amga3uHu9V62xU5BU4DAPgZulwKVi4ku0kQZr4Bt4vc0Yhr2Ji4Ocay8wzvb282pOWC5
         U+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780067273; x=1780672073;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kJfvO9zjLIcNgxwydf05ic8q1+t5yL6F8Cppp5YBjVQ=;
        b=PWEt81UCJUF2YPjoqDIAsp/3c8XBMB2Eijk11vfWqiZ3kaZzZ1PpqwSAp15Tly6lCf
         HHW9juAvABrJ3gZstJzabLeRWt3ym2D0EGQJziAQcxaIWOHpcetssHnnPEq4snQJPslq
         p/DL7Yw8SPeA1cnqZ66M2++L5oaFa20OFKhGJxk2noRzsE2RU4Hhd60ymAjg9PFxfTJc
         LhhCt0po5a6Vj/V/+UffzDLW8cYLJhPH2EyTiYX5BPSceCe3hgT/YwfEI+x7WzWfy1pT
         nrgOVA/65oGEX8qKVbcTcEJ0MHt8JTdFDRyE7amNYhBNRHFuC/ebIVCRDdce0NYOe5kT
         FLWg==
X-Forwarded-Encrypted: i=1; AFNElJ8g9uXMxwXLJFyzcZKnZQ7PeUaOriF+iYSXPsmxgJ8F9MY8daqa9RFn1sU9n47GG3xzH10zbhvye/KKSIs7AA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxMLurpg+23/byrFnFRxS13zAy2VJ9we83wOdRITVmj7ekXxysA
	KtX2m0CvvaVps4y2rFIxuPUZhm+yXYqtd3E9nksR9ICdbHXBH5X2WYDk08Jfs+vk5cp0ex70lsK
	P5P9FVg==
X-Received: from pldy13.prod.google.com ([2002:a17:902:cacd:b0:2b2:a70b:98ea])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b64:b0:2bf:305a:312a
 with SMTP id d9443c01a7336-2bf3680a163mr2618575ad.22.1780067272464; Fri, 29
 May 2026 08:07:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 08:07:41 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150741.714145-1-seanjc@google.com>
Subject: [PATCH v4 30/47] x86/xen/time: NOP-ify x86_platform's sched_clock
 save/restore hooks
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

NOP-ify the x86_platform sched_clock save/restore hooks when setting up
Xen's PV clock to make it somewhat obvious the hooks aren't used when
running as a Xen guest (Xen uses a paravirtualized suspend/resume flow).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/xen/time.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 36d66abf5379..640b71d22d97 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -578,6 +578,12 @@ static void __init xen_init_time_common(void)
 	xen_sched_clock_offset = xen_clocksource_read();
 	static_call_update(pv_steal_clock, xen_steal_clock);
 	paravirt_set_sched_clock(xen_sched_clock);
+	/*
+	 * Xen has paravirtualized suspend/resume and so doesn't use the common
+	 * x86 sched_clock save/restore hooks.
+	 */
+	x86_platform.save_sched_clock_state = x86_init_noop;
+	x86_platform.restore_sched_clock_state = x86_init_noop;
 
 	x86_init.hyper.get_tsc_khz = xen_tsc_khz;
 	x86_platform.get_wallclock = xen_get_wallclock;
-- 
2.54.0.823.g6e5bcc1fc9-goog

