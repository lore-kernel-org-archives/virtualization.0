Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666113F0AA8
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 14:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065900; cv=none; b=s8xkDAz5nbChxi025i4rZZkUlqW5QyhBC2PhUfs2/ywIPAMqPbMNLp4o1KTkpPAV9hCrgYrPCafJvutwux+0ueQkVql0FUvdQVh0eyWQ8a1naw9WCmwH6YICfzR8f3Rzl//CG1pG9t1fumjukZml3H8uKpgaNRyTGQH+iToKRpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065900; c=relaxed/simple;
	bh=4J2pj4ueUfr2Orv6DMZFsQiWACDGMV6nbqR/DR58gVc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=afO9pe+1t1MsOPjcnbZXd1dTV9YwUncv52XXoxfWRCPF5EuU+nl5TiLDpQ9JKC4pISAW/8LtafJrbZqCU0HBxUxWq0wX6X2lcmt4t9x7VChKnCnRorDbKwuznXR/riuzLSOwQt/Zhge4be3buV4aElsGMfHfFcLz7gf//WOLYRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iW4oifZT; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iW4oifZT"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36781927b4dso8539685a91.0
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 07:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780065898; x=1780670698; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=xjTz/hwdMHYqh+2ceX2noAC2jls+xA7f9jce5I1nRMU=;
        b=iW4oifZT/MfF5utP0kzdBycOuYNSvd7eRzj6mGsBjFfapKvi2UAPvPbEp7KFvJ3Lcv
         SSJ5ySuRuMF/Vyc5Sclv4INDq2JEvkysgLUni3UbXbgbvo55mhvI3X5fkqJ6srVmYuiu
         ALK+E1BsFRT/9wuvepsaNUzgVCZuX7sOBDzfX2rwVxn4XHAbmfV8OEyNSaL/duGYcSHG
         Q/11d8B9gjOWzjrTO6xbrDAQ94Q6a1PRf421FI+ilhvDPE71sQbOeWzmroV2UZQ06sen
         gBr9REyvcxXLnzyJXBZw1gFzvJVP1o+JjjxYM1Jm3sG/2ZBSGITSBiMAmrqApBSL+s0A
         SRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065898; x=1780670698;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xjTz/hwdMHYqh+2ceX2noAC2jls+xA7f9jce5I1nRMU=;
        b=sT5s4IDwJbX4nz3MLp9GHaTZcadFqXc1y5ZQ2f4f1Qgi9xP13n8SFsm7vgRZjidJNb
         8aMvzcShUoHfPDZ3/cUGVgFSToeHXNF5uSeeRcQmgyPdaTYXGEPeq+YLgwCAsIly1kXu
         +RYaB67TC4AAB5qq27frg7ZFE15qdVNIpvVuTLCAevLgVR+Me2/VTfuS6T04MvRkgt+3
         EKFTE1x6vZC5bhwO+4kB7vo9PJq2tl1TUZSvcaHwWEH/u3G+dqzt1izpH93UBZxBBLJZ
         U9k+96h1QXw5lPI+yQx0BZZTh53Jj5lSU+0mH3X/HaXpjZt2FZ8O+V6lvG3m3fDQcYY9
         2cgQ==
X-Forwarded-Encrypted: i=1; AFNElJ9pFR9CiYwipPCd4ZOsLlAKCOY5vqHIq34HwUb1GiMviGbvS9Qe+mxDoE3PHoewlkMgtOoWzGjjsNY2VlAMqg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz3dZrfdkL0pgQjcAUs+TNzQR09Q2J25na8QDgiT+tlsiBEy6z2
	aIAH+b9mpnpZUOxP5ICjF+bXFuc995OM+YZe1hHfa+aQ3SaNQgXh0Tmqf/mlZgzVQ+lFI0ZimZN
	vAls7mA==
X-Received: from pjl14.prod.google.com ([2002:a17:90b:2f8e:b0:36b:be8c:b289])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4cca:b0:36b:82cf:f779
 with SMTP id 98e67ed59e1d1-36bbd1305dcmr3958387a91.21.1780065897442; Fri, 29
 May 2026 07:44:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 07:43:52 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529144435.704127-6-seanjc@google.com>
Subject: [PATCH v4 05/47] x86/sev: Move check for SNP Secure TSC support to tsc_early_init()
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
index f7f561722efa..833eed5c048a 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1543,7 +1543,8 @@ void __init tsc_early_init(void)
 	if (is_early_uv_system())
 		return;
 
-	snp_secure_tsc_init();
+	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
+		snp_secure_tsc_init();
 
 	if (!determine_cpu_tsc_frequencies(true))
 		return;
-- 
2.54.0.823.g6e5bcc1fc9-goog

