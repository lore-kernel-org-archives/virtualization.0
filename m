Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6324CA285
	for <virtualization@lists.linux.dev>; Wed,  1 Jul 2026 19:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934355; cv=none; b=JEqHxOAFIFjfOdL+KEA5G7sFT9kmeomBLg56RIObneJSXAh+yLScMTRl1kf/suoMEyx6U9koeP+n8uFYKpnqU7MbWUBl8jNO0W4KOTRNwy8RAmEY1l7xEBtCQU4z6CQ0F3zncpO7HjMhns5e125LY9kideNWJ33vprNdC5TxCDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934355; c=relaxed/simple;
	bh=iW4jDVvGqXNgRDhwZg+mkot4mv4vuA+G0sHIjbvfvgc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KD7LOLhq5pHnsnziA15/pPRD3Rse/r1a74UNjB5DhSTVOIpvMrPdodhOXAcclImAjzXNUdQeCHBT1Pxeii7wPPQJM8gUEe32QX0mHiwBo/Jj1evXMJLA/8Mx1Xii1NeNHnWeqlD4vjHUzK+JpQgdwhgS0bDRb4kwQU8s8UIo0kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k4GGQZE8; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k4GGQZE8"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-37d4eede8ccso843378a91.0
        for <virtualization@lists.linux.dev>; Wed, 01 Jul 2026 12:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934353; x=1783539153; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=a+o8BZyrs+hCKgt2M2jOo1gfN0drsi4lQngccMqCRwE=;
        b=k4GGQZE8fgJPF+dgsEqrC6J6homnmKLXcplmhEQ3jvGCCvb6JOthDtKmjwZ0ZJDa5H
         MDSLkbwDi1HuwMKfvDGDKjKBC77bG3Nue2OSum+yppKV6jHoGWMTUyZMOktwj6Y8TB9N
         l/GBtYfi0a2VJQwZh0t4nn2gQ7XJWrbfB3qecNl0dzRjvJcQ2LxDsUgM26JvfzKHiUA3
         Z3w+qXpFs1RnW1d+OiPAolbgdbIZEuX61slaVzgo83qGw/z5c+fwyKEUN7jLaUxNW7uJ
         uHDdLJwG7aB9TmaOW9Js8N3hddtTaWYOVhfT0GINhdKrEB/KL2JNcBbbZis9WsXblw80
         rBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934353; x=1783539153;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a+o8BZyrs+hCKgt2M2jOo1gfN0drsi4lQngccMqCRwE=;
        b=DBifxb474PvTG6Sd0Xv4DhtZO5eMY/0OkdlRv1l3Xa1HWpB8k+LcGmyAAgvXKWlPJ+
         HHqR3xiN8x5m6C4JIGKLfuYFHq7zhJqJOMZAdLExbc4hyXF29TwYUtA/pLzWuQacwjlh
         70cL91Ijy/HrF00p5UxIp3CDAClaiP4cYXzCBwQE5YARL0gokQKzg1fK6rXt05TvC7+Z
         wZKEQsgek3niE1Ni32wSe34A2ONvZYgzLb908OcZYOPeB8fK/glR+WKH5uSEKYLVOLMy
         CJDDLesSElqJQ0FmjTCTHxsE7LHBSeOkGnw1swW5gLzyarGSE/zJxz3/RVAbip1IT0es
         VGoQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqhyr+5lyS1hrPeC9Q6WR+V0G7oUaBsUoDEeGm9qjDmw83uX6Qu1j8kzynIPp+iOBa8rxTRy0Pp17khD21QWA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyXG7DttIjQaOETIWfGbpMZ8ZefsS/Xe+B6+GeWvP1sSct52HRL
	fQeBulnb47Oqjd/KIu816mgiwYb6Ty0FpcQpiPnRY5a9GN+5Ol6fPvY02tHLu7gRof0tSQq/7h1
	0BCnhmg==
X-Received: from pja11.prod.google.com ([2002:a17:90b:548b:b0:37e:1dd6:f70c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:28c4:b0:37f:9ce0:af32
 with SMTP id 98e67ed59e1d1-380aa204608mr2862792a91.29.1782934352462; Wed, 01
 Jul 2026 12:32:32 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:26 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-6-seanjc@google.com>
Subject: [PATCH v5 05/51] x86/sev: Mark TSC as reliable when configuring
 Secure TSC
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
2.55.0.rc0.799.gd6f94ed593-goog

