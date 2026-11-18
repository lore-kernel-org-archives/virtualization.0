Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794984028;
	b=ARio5H6ZGZm7j0RiuSsq46c4vTtP/3jm+5l6iT90T/kYR9NIeSSoNPQ6XUF/4uA5vqTN
	 Z+1CN/UfQ2VWhXCkzogoNc+uAYGhGauuZuDCkuSkwC6SO239mP9Vn3c9D7vQuQk+ZfzWd
	 W9eGNiF4L3JaRJ4QfhoBXp2hifMS/CYu6seEljD7Sy+FdjepflBdyEsA8+2lDCypJeKW/
	 5JBkZmclEZl8jBKIebgIw+dSfAB6AHgA5U/yuDEouzRm2SDW5d+wNk5qp8hhA91znDDOd
	 hEGwjsyOZp1d7+E7pXV2YtD22Tdi7FqhrBdQsidPVCMjpQigHCBUHerIHCsTQ3LMUpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794984028;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=WGXSzPoaoRZhYGRZwzYW9Xi8SgZA3sFH/3kCEUuvBxU=;
	b=CQGOakHwg1+wK0ZFZsewc4wEXMYPCbj0Gy/2Be9p13UrMKJY4u7eW2Hrks+wLp4tN4Dz
	 O0AoeKoxT45wKBab+SC1ym6ZRLv+2z+UbpmOJ3jZ3LVQ8pv/At4phooqWvjcIq/jW2lnr
	 TkXZr2nN1cFt03CAQXI0mUvkmBNuR4g77mFh7LxkEQcXXKevCxJwCEas6iQp0GPEtrRj5
	 FP/hFsOoOrbl2vY1EtBKH3yzNSgmZe18fVI+lf2KkIliSm8tFfvB6pKgX8OFxOH23IK03
	 aMIaX1BdVW7TMFajzsr51QEu2BVWjbuGyFIsApcTeK/GqVem7LmhkXgSoFXOTEZKQgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=VmfRxsD+;
	arc=none smtp.remote-ip=209.85.215.228
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01ABC606A325
	for <virtualization@lists.linux.dev>; Wed, 18 Nov 2026 06:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01ABC606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=VmfRxsD+
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-cdde3597d8bso754184a12.1
        for <virtualization@lists.linux.dev>; Tue, 17 Nov 2026 22:40:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794984027; x=1795588827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WGXSzPoaoRZhYGRZwzYW9Xi8SgZA3sFH/3kCEUuvBxU=;
        b=O4avQqQxlH7pcMU2rktN4/HqwADDj07viKaskVvlitfL5HQNXXO4HmqGiPOJ6Qov7W
         nS0Q0fEIriOtSjNPDiYQ71JT5JaXAcxNZWBfmy4oZdkT32zPiOSyOFELmx2JHXQMGKIK
         E1floZGhaB7kssTPxRokJMkyzK6Ko2IaBbZXor9lzBKjTA69+z/NyxHVudRVSqdBoUyQ
         81RCqlXAL6TyRstIksfV3HLQqZ8/3jOPQpytbpKKynlH80GSP99yrD/MohFfep2oJAZc
         rvm5Yn3nOyp19inc2AzwLl5Z8oX0MIFJzCZFO9XCBe8bhjAxzgwLAKlzagfG+1+6Egfu
         k9pw==
X-Forwarded-Encrypted: i=1; AL+hErGmNAMEDUBlG7GO6q3VQJ0C5mUC1ihplrXFLp/KwLD434BBgqyl3PNe+hCX3mRQnSek7urci7LXWCWDzxfrdg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/GNuaunnNmCzf90MDTuLTWZbQ6zACbEtBHDezTcjnBtNdHip3I
	rYZHNPEIB6xxa0J7IQm5x3yVQAma1pjjDbvjGX2Re8nAaoe3fR06MlOp67I9Pxk6O+kellfpioF
	TFbe/S22ZXN+nYBLsoRh+sXY5or6J5RxegZRYttWsFDeqhRTTw01E9RKbo2miC6eVOa6Iez3RpT
	RhcWw5NTrKZXQmGYqRZcBmQep3sTSJn9DTmL6tvIp7jTiupbP4YhtbbQ2g6xQLI0SjwIuvKsQi5
	R5J/PcTf5DtAcstm4o=
X-Gm-Gg: AZFdTZcJryugWVeK+qherxey4i3ZVQBpv4wcDwGew0mqY8D0WYI8OvxJy6M8ed1nizj
	GT4ZRYMzkfmeQZboZzEi45b1cBFqTe8b5zMMiu75xRyIIxQ7/JAN3Z8/rs8z3MpNwD9+dCpFd/J
	791/PaAT2rNqZe/nAijN7p2Adjl+U/etBK9t0N5jGtRhW6PCuSHj+j59wzEy5Ox4heJcA76rbHT
	9IU0mNUmYZMWUuArRNeNa655wz+oByiwTyj3K7p/QbY6V2vi4TzcOVBX8nDtbEs8sH8RPjou025
	KvgTWk/aL8wi7ic90ju4n4KaMAVInLhZ67KmxkKNbegWocUiA85vt0JWTHxv0s8JjIJqxWeAjWk
	VQZn0g5Nevf+MkO56AaBLdGtRKjqbDWJk5TlOwMawWttnCqzQsUOQgskpxrBAM4ApIfYGZWUi6t
	hQ1HVmMSYRW6D3lTRQnA9D2Zpf+5+pEt7Q
X-Received: by 2002:a17:90b:2b4e:b0:3a0:d82b:237b with SMTP id 98e67ed59e1d1-3b3d07e3796mr1006421a91.25.1794984027248;
        Tue, 17 Nov 2026 22:40:27 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b3d4373b48sm459220a91.4.2026.11.17.22.40.26
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2026 22:40:27 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5364f562140so10507211cf.0
        for <virtualization@lists.linux.dev>; Tue, 17 Nov 2026 22:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794984026; x=1795588826; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WGXSzPoaoRZhYGRZwzYW9Xi8SgZA3sFH/3kCEUuvBxU=;
        b=VmfRxsD+cQh0XkNnaqxKQobxnMpeFRnSnS0i/RCyewvi0wrM2IDdxES/P9bOUh2WNG
         AnZB3xkLjuJSUxHsXi1KyfoHU+fbnfWYlmuJLN8PWsMuRlpjyFBbRJPfhVe2mHsKDpRs
         zNFJn/H4d1kJiUHyoKbtxCyElVZ/fe6GK76kI=
X-Forwarded-Encrypted: i=1; AL+hErGl1+tZpQgf1C3HehPBKK+rUgPaXCdITQesXBfKq9AN4tASf8woASZFGyaNhaeZiLwgX3rzSR3KeF7oqVzBpg==@lists.linux.dev
X-Received: by 2002:a05:622a:4185:b0:545:de78:a6ef with SMTP id d75a77b69052e-55d5a747c5amr22156121cf.38.1794984025896;
        Tue, 17 Nov 2026 22:40:25 -0800 (PST)
X-Received: by 2002:a05:622a:4185:b0:545:de78:a6ef with SMTP id d75a77b69052e-55d5a747c5amr22155911cf.38.1794984025512;
        Tue, 17 Nov 2026 22:40:25 -0800 (PST)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d61cf3b56sm2078141cf.13.2026.11.17.22.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 22:40:24 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Borislav Petkov <bp@alien8.de>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	x86@kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Zack Rusin <zack.rusin@broadcom.com>
Subject: [PATCH v4 3/3] x86/cpufeatures: Remove unused VMware hypercall feature bits
Date: Wed, 18 Nov 2026 01:40:13 -0500
Message-ID: <bcc9b471c176d5b162e6935b2c0c7f96c65ac8a6.1794206170.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794206170.git.zack.rusin@broadcom.com>
References: <cover.1794206170.git.zack.rusin@broadcom.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

The static-call conversion removed the alternative instruction templates
that used X86_FEATURE_VMCALL and X86_FEATURE_VMW_VMMCALL. Their remaining
users only force the bits during VMware setup; no code tests either bit.

Remove the forced capabilities and mark both positions free in the kernel
header. Neither feature has a cpuinfo name, so this changes no
userspace-visible flag.

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 arch/x86/include/asm/cpufeatures.h | 4 ++--
 arch/x86/kernel/cpu/vmware.c       | 4 ----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 61930f0d4578..b7633930020f 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -233,8 +233,8 @@
 #define X86_FEATURE_VMMCALL		( 8*32+15) /* "vmmcall" Prefer VMMCALL to VMCALL */
 #define X86_FEATURE_XENPV		( 8*32+16) /* Xen paravirtual guest */
 #define X86_FEATURE_EPT_AD		( 8*32+17) /* "ept_ad" Intel Extended Page Table access-dirty bit */
-#define X86_FEATURE_VMCALL		( 8*32+18) /* Hypervisor supports the VMCALL instruction */
-#define X86_FEATURE_VMW_VMMCALL		( 8*32+19) /* VMware prefers VMMCALL hypercall instruction */
+// free: was #define X86_FEATURE_VMCALL ( 8*32+18) /* Hypervisor supports VMCALL */
+// free: was #define X86_FEATURE_VMW_VMMCALL ( 8*32+19) /* VMware prefers VMMCALL */
 // free: was #define X86_FEATURE_PVUNLOCK               ( 8*32+20) /* PV unlock function */
 #define X86_FEATURE_VCPUPREEMPT		( 8*32+21) /* PV vcpu_is_preempted function */
 #define X86_FEATURE_TDX_GUEST		( 8*32+22) /* "tdx_guest" Intel Trust Domain Extensions Guest */
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index c104681d0945..39f0bdbd1eab 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -505,10 +505,6 @@ static void __init vmware_set_capabilities(void)
 	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
 	if (vmware_tsc_khz)
 		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
-	if (vmware_hypercall_mode == CPUID_VMWARE_FEATURES_ECX_VMCALL)
-		setup_force_cpu_cap(X86_FEATURE_VMCALL);
-	else if (vmware_hypercall_mode == CPUID_VMWARE_FEATURES_ECX_VMMCALL)
-		setup_force_cpu_cap(X86_FEATURE_VMW_VMMCALL);
 }
 
 static void __init vmware_init_hypercall(void)
