Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F372E4D8D9A
	for <virtualization@lists.linux.dev>; Wed,  1 Jul 2026 19:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934358; cv=none; b=M+wcLxo18bJ+7GKLGaaKsilrg8jlomJZcGxxxUy3sqD7DOvb477Cn2p7uiLQSNHVGIFGSNE9PL3F1nOAd84fLCKS8aAoG5tN3JWlhs7ZuhebFNf4JiO//iyg+vE0yy3FoHn1vAdTiKwh/qJO1YaCwZhb3blVtrAWqGenO9Ci8ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934358; c=relaxed/simple;
	bh=T5bF1Z/GMWtlvXOwBd1i/KRQmfJQmniOO2jcbAhz2Ng=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n1tIGjLjhSiTNgZdc+fOv5PeZn+oETeTGAfKyzsD879a8YomTr9MlQfu2TsCDlktbXOxezD3YvopLw8W+mznh6wdvXA50/V59CWJm+WbMVVlnZEf5r5VX7fIXW2A+kU+HXXlUqM/8xYfPII0Rb3WOYvX2uWY4ByyQ2UW86fBI+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VUNJV2+O; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VUNJV2+O"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c892143db7fso669500a12.1
        for <virtualization@lists.linux.dev>; Wed, 01 Jul 2026 12:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934355; x=1783539155; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=IPCn9toL5FYXOHslttK0Lqj/45O4+f3kFotppLV6+ls=;
        b=VUNJV2+OboBAJ6uhz4/q/bvqYCDjehpG7hTD6qRFtjl5g90gDa6nVYizp8pN7wkkK0
         gqc/l/sw9oa4Ex3GpSG6apDxiCEpAAaZtiWuCz8dMHKp5NzXAl9nHcB3r6LZOrV9kaOG
         MDzKT3I3mPPyfwIjJhEFvXnq6IbTkxqVlItLJDaoyfD2flznnzfkAObjs3r/IBMMv/v0
         Wb1uzn31diET4rRS4haNMvA3AjUkPG25vGgJf/ZW7cw130QznLWea12gPMMkQtL92lPS
         6hEEs+0lUqKc3W+GdR+3fqIP8Rq5BkEjLRVYcSIh/l4UxmD8ssSvEKnA/AnTjHLdFg7w
         iQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934355; x=1783539155;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IPCn9toL5FYXOHslttK0Lqj/45O4+f3kFotppLV6+ls=;
        b=QnHbL9IqbCVkgfzNWxxWO/S2cGq9TLI7oU43lAUMIo7KHKRcEhDWRZ0ETZLy+78DB8
         7tFJa7exug2hnxhjL/sYMf4hHlmC90Xjts3iC8GdadQZoeJeVFsDMn2GxdfAn9L1QhOr
         xoOYlmkNJGMw1iUeEBlXjUgGp8pE+DP83QXwccQsFpU8CVoYRv4DS+D0OMYhnFaMOx6Y
         x7IRduOuvZBsS0KJl/2wgfMQGIKQnugjxz1G9sl5hHZiUzXU26+89793Olz59L9WBlfc
         sUsKlogQa3Jta1AehtREzYh0S+y68fDUYY6TxRlTs8JcaXn1h1KnndmFmVw6iOflCBGU
         tbEA==
X-Forwarded-Encrypted: i=1; AFNElJ8yNgp9GgkmHkmeTc9HUwdjnY7jXtqVjJnfojIuaE9cgBGKiQRPBWrJyysH8MMF5xxgChBShUXVzHW2Cwzuzg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzppH+OrFbm4k9vJpdCY/Lrik8gB+cuf9mzDoEUXPBRd+xdkXry
	A5CGw6tVuPitX0ryl21+IQZQhy4SfnnowA3dxepv3nI2N0cldrwOTOArczaE1uW9usgHeu2NUff
	Eu1uMLQ==
X-Received: from pgll126.prod.google.com ([2002:a63:2584:0:b0:c85:1159:ffb2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:6705:b0:3bf:7bf7:7913
 with SMTP id adf61e73a8af0-3bff40c93d7mr2592804637.14.1782934354816; Wed, 01
 Jul 2026 12:32:34 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:28 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-8-seanjc@google.com>
Subject: [PATCH v5 07/51] x86/sev: Move check for SNP Secure TSC support to tsc_early_init()
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

Move the check on having a Secure TSC to the common tsc_early_init() so
that it's obvious that having a Secure TSC is conditional, and to prepare
for adding TDX to the mix (blindly initializing *both* SNP and TDX TSC
logic looks especially weird).

No functional change intended.

Cc: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/coco/sev/core.c | 3 ---
 arch/x86/kernel/tsc.c    | 3 ++-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 665de1aea0ee..403dcea86452 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2025,9 +2025,6 @@ void __init snp_secure_tsc_init(void)
 	unsigned long tsc_freq_mhz;
 	void *mem;
 
-	if (!cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
-		return;
-
 	mem = early_memremap_encrypted(sev_secrets_pa, PAGE_SIZE);
 	if (!mem) {
 		pr_err("Unable to get TSC_FACTOR: failed to map the SNP secrets page.\n");
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 482cc3a8999a..8f1604ffe986 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1509,7 +1509,8 @@ void __init tsc_early_init(void)
 	if (is_early_uv_system())
 		return;
 
-	snp_secure_tsc_init();
+	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
+		snp_secure_tsc_init();
 
 	if (!determine_cpu_tsc_frequencies(true))
 		return;
-- 
2.55.0.rc0.799.gd6f94ed593-goog

