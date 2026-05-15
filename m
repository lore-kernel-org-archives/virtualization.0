Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9074237C0E9
	for <virtualization@lists.linux.dev>; Fri, 15 May 2026 19:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872832; cv=none; b=UPEjj7nnoy9A58qRc9UpBmD+0Q+SElRTwTDzpU+MbxTzXXJF+1QjmdD46P07iFcPjMNjtwGXsTUO944bFQCsY7cZuUEv9XpiVYq1urEdPfR2Xn5ZFbhZzqpnrBhTqcsczLk2aG1ri7F2af8TpavBGXaNlmtUJ06cTaagEbDNwSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872832; c=relaxed/simple;
	bh=nvaTcMbyfjZXZc1w2lrIIDutznVhYZokau/9P9cewsQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VW2RXFEOEEdprn06skgoNLpUCzgdglfC/Ybo5tZfrJXaO+frMjCflU4BYCs6KVcXNsRS/gdrqAksQuKVCPJUJ8U4V7Y/SP43jeIXcraL1Du1JegtsBR6Rv+mJSqa6654QWJLoVP6FkSusw0faRWp0v22vIhFTass9U7QPitxdKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qbc9j9T7; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qbc9j9T7"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82fa1c94b37so1317715b3a.0
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 12:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872829; x=1779477629; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ikDY1x359wvY/+q3wacNdXpEm487YvEWh2udCoEd+NA=;
        b=Qbc9j9T7SSHK0XeOFPqhYTprGFcJ0NfqfpHXG25Kvjl3Px/MJFVeIQktcMhSkk1yIr
         lI2zktXH3PRmZUwa9+grosV2fBA+YC6sXA+ma10I6nFKR3C9n2oHK/mCylyn2viNEVby
         9ZgQQxpOyFbJKn+gZzv267ESz1LEMoL+5oK1guxmIYmU0mlY7x37+siwkrCCHwupkTXc
         CXa2pyqWDN1r3KiKAQzPqhOgrxRER7GozrPCB5+Mx6x5JiLbQRoyaBpiDvfDc3mMlAmV
         slmWrFHlzukD4ebY681E5Z4yACrPZVTwjYuXufBMhFDqzZI+/QnphuS/LasBR5V77Ri5
         4bdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872829; x=1779477629;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ikDY1x359wvY/+q3wacNdXpEm487YvEWh2udCoEd+NA=;
        b=mjS3GzlNSLC4N1Tc0RHZAjbm0IYRJDscenFS8KsaNLGQDyAEmsHKBHhqyxxFHRnU5m
         qhpIdEICrfMAXfPvBZhKKwrEjgDq3kzJdN90fwdPBu9V6aiJEcSiiU6NO17uqMIX3hJX
         hPx2c4RsPxk5HQfeMyJ5BgjMVlqu5v+ncE71Gk+KiW4fdf3ZSU1IxoJqWM7KCnEzADkO
         xgyECa3afXHF68f6BBbNy9t97DDLZpZCQDwNTkT4def6UgN7IUjxLuxmTU4CgRhn7cXg
         lYA19UQQW3d1pDm3JpIJwvOP+YY1+cg32zq5g9X0ZNuO4VHCEN2Yq5gDu7bI638m+oRm
         wV0w==
X-Forwarded-Encrypted: i=1; AFNElJ9dHguayBvzJoH+7eUel0HxCXD9yGvqDfr1DVJYbXAX+J9sl1lQoIudBkrQfGvvsoJAOe96ZNMBYWOpr0CkDQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwDJ/vr31ko9qhP1Kcd1WRqdGRnRoJn/fURGDtjYz2W7mNGqmma
	d5mcWnm3GqJ8T1riMAtH3kyVYbCIhk4+dHHJziNcYWxiUyjG2ggT31SbgnjBdIpHRfSKJfsQpKB
	Xgo9krA==
X-Received: from pfbgg10.prod.google.com ([2002:a05:6a00:630a:b0:83a:d498:99fb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a907:b0:835:447b:a2ac
 with SMTP id d2e1a72fcca58-83f18d5b8f5mr8777489b3a.5.1778872828431; Fri, 15
 May 2026 12:20:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:05 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-5-seanjc@google.com>
Subject: [PATCH v3 04/41] x86/sev: Move check for SNP Secure TSC support to tsc_early_init()
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

Move the check on having a Secure TSC to the common tsc_early_init() so
that it's obvious that having a Secure TSC is conditional, and to prepare
for adding TDX to the mix (blindly initializing *both* SNP and TDX TSC
logic looks especially weird).

No functional change intended.

Cc: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/coco/sev/core.c | 3 ---
 arch/x86/kernel/tsc.c    | 3 ++-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 14ced854cd83..39fb50697542 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2029,9 +2029,6 @@ void __init snp_secure_tsc_init(void)
 	unsigned long tsc_freq_mhz;
 	void *mem;
 
-	if (!cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
-		return;
-
 	mem = early_memremap_encrypted(sev_secrets_pa, PAGE_SIZE);
 	if (!mem) {
 		pr_err("Unable to get TSC_FACTOR: failed to map the SNP secrets page.\n");
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 7e639c0a94a2..243999692aea 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1559,7 +1559,8 @@ void __init tsc_early_init(void)
 	if (is_early_uv_system())
 		return;
 
-	snp_secure_tsc_init();
+	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
+		snp_secure_tsc_init();
 
 	if (!determine_cpu_tsc_frequencies(true))
 		return;
-- 
2.54.0.563.g4f69b47b94-goog

