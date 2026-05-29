Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7066A3EDAD8
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 14:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065897; cv=none; b=IVxpRUfNgn3o2vuoR2T0y4O1dInX5ZL4iyDRl7P/EzETFjz+VrmIdAnfGKYQLYcJ4Xm8bAnLGqhSSeWdA0gj7i6IXyVdb53ZXOUSTrSec+CUfaEUfqzKH2QQVlx4hcWXvnhRVhq+pWqx0Vysb7BYpUuLAGLhiHIgRW4vHUjAsow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065897; c=relaxed/simple;
	bh=pj/SB186PtPxR/4ct+s4/b3QnbdSVX96HwJWxY+zG4Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MWIXIi9SZq6bByXtPhb0GVOcl/TiNpNw22BNhSreE8CaNDt6ab4zEpywK2Xocngc1nC2Ea7yUWX+lFloDLmsEOc2ShIKa6MlVfmPj8y74zpEOZrIkGNdjNCGQvANnTMgqYq1WoWvNOQN7w63isnq8/ZIvVOC/FKCZCUFo3pPgCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FKCQfGeV; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FKCQfGeV"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36781927b4dso8539627a91.0
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 07:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780065895; x=1780670695; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=BmTkJVHUffmv2iD67o3GahQBnXBWwXEIKjsjKzRmdQg=;
        b=FKCQfGeVwQTc27w4MeYj0fZynyQN69exjSLqlYwJ/nufuM0PbdOo5M1JsMGkXauvVJ
         zF3293KBO9HaCUxRi56RYRwR57eFKApcXQhZaQLjFN9p61+NisiyatzgVLvhEks3vAk/
         BDGJf1nIR5uWamFC2JonJU/tK7JVTTxg14sCeW5Y5jXNTXuQuQ4rz8tMjByxFFTFN3BR
         XGneEPH3q4nQs8x6x9dSiyRRUiSeGQPkWKjqPeCPkoWOm1wNHAimNe5+Rj7M7xaHoJjG
         xgJnWltBoTcZxebzUcagOO8cBcxdnyrKhfwXXSAYNDRTEDSK8iqWnYI4SR96zl0uTjAm
         /mRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065895; x=1780670695;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BmTkJVHUffmv2iD67o3GahQBnXBWwXEIKjsjKzRmdQg=;
        b=JDRSPOREa/1Kb2S1voAKAS0FEjpUFNQ5FovUOZKCYvuh7T4yFyOK602dndzHIVjlkg
         WgFS5LDrBHXsPEH8B4Y8SDqogaF6U+zJEZwQtOTm9vat3prjV4orCxCoD8J4908kzzMe
         r0XTMIWumK9NYkbnn/zi1wH6pfbrBdf86CU65RIzNkKIcjSxeiNnvHG25ix0Lekn5RvW
         3AwiXHqWQ6i3cLSOPyNseu53hO3DvYPGVJgFYhQmYMI+f6aZWyVWeL6NgDaC/zKgx1Sl
         4bdqUShH4CPfZPGAeJnzjnqYKM+i32CqOixdZeRBTJ3NA4d5oGeaYXpTZdj53YrpIiu+
         lzCg==
X-Forwarded-Encrypted: i=1; AFNElJ8eAq4BKd/bdYLXOIAOrNxCwojgNNGy1y3J0y2rKfVoi0/fePOcnG0bsa75h2pmu+Gvt2EznFycO+vdldeKrw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxSHifPIdz+q82zRQ0AB+5d0FUJlH5OOS3eTOAeaP98jr4hZAb7
	GLZ6ryCQz4hnlFSaW6GX62hJA7oC2twvG/RaFQJT0L3HlEz/dYfdZfK4E846tlQ0VQKUmzEoycX
	s4SxUSg==
X-Received: from pjbfv16.prod.google.com ([2002:a17:90b:e90:b0:36b:7407:9b72])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2fcf:b0:36b:9c4a:e05d
 with SMTP id 98e67ed59e1d1-36bbcfe11camr4074961a91.17.1780065894470; Fri, 29
 May 2026 07:44:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 07:43:50 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529144435.704127-4-seanjc@google.com>
Subject: [PATCH v4 03/47] x86/sev: Mark TSC as reliable when configuring
 Secure TSC
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

Move the code to mark the TSC as reliable from sme_early_init() to
snp_secure_tsc_init().  The only reader of TSC_RELIABLE is the aptly
named check_system_tsc_reliable(), which runs in tsc_init(), i.e.
after snp_secure_tsc_init().

This will allow consolidating the handling of TSC_KNOWN_FREQ and
TSC_RELIABLE when overriding the TSC calibration routine.

Cc: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/coco/sev/core.c      | 2 ++
 arch/x86/mm/mem_encrypt_amd.c | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index ecd77d3217f3..ed0ac52a765e 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2037,6 +2037,8 @@ void __init snp_secure_tsc_init(void)
 	secrets = (__force struct snp_secrets_page *)mem;
 
 	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
+	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
+
 	rdmsrq(MSR_AMD64_GUEST_TSC_FREQ, tsc_freq_mhz);
 
 	/* Extract the GUEST TSC MHZ from BIT[17:0], rest is reserved space */
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index 2f8c32173972..6c3af974c7c2 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -535,9 +535,6 @@ void __init sme_early_init(void)
 		 */
 		x86_init.resources.dmi_setup = snp_dmi_setup;
 	}
-
-	if (sev_status & MSR_AMD64_SNP_SECURE_TSC)
-		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
 }
 
 void __init mem_encrypt_free_decrypted_mem(void)
-- 
2.54.0.823.g6e5bcc1fc9-goog

