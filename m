Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433563A8D0
	for <virtualization@lists.linux.dev>; Sat,  1 Feb 2025 02:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738376261; cv=none; b=Lz74X9MbNptK/nzHBl/H7RYyHlsd4iE7sbUpby6kgqOQ43IS9sCduniYxgA93hhlOAxiB+puz9J3yiOvU3YKvmhal2TC9NCenIEW8CQf5DeeXtwKVAR037xe4m/HTHGtAEdQBpSIhX5t9xUxdPhr/VIG1978paF4s3BH5VhpWE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738376261; c=relaxed/simple;
	bh=E6Iy1BiM9FEEtqnIX6/l7kPa8oyhyUi3aCV4SUPddsQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sWFdgMHMRDkP3W67+Z3nNT+07aLVCNWuTcWTtQei0yRDAQZJYw7uOMQDhROaI7Zkz/IAAolRqMYEkz1k/pvdpHASXb5rHPFpJ2ODjBdfn14g6uLOdRRoqjZrZVzwVtJB54o0Y87nlfFLhA4//SwuQiJ262ezM3umeeaAKcKrhnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RKMFFfE/; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RKMFFfE/"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ee5668e09bso5211306a91.3
        for <virtualization@lists.linux.dev>; Fri, 31 Jan 2025 18:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738376259; x=1738981059; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=IW8kJcAcrKvt4c0vMOL7jWV1OXPEd6lfnHsLFZy4QXA=;
        b=RKMFFfE/uXqWw0CRCAZlSQMQBNhZUgSAmRdQNazR/xc8RXZQ4eQfUX4838boAfV8BB
         zPuHFT8RyBCt7SIJWv6yfPnvfn5vWDgHUOMOOIgtM3CNzwG1xwadteDTTu45ML3lbzuV
         LL7dlo8UHZyJO2aoxnT1eyx0lqLqomKXNz/Xee16DvsZwytVBRI7Gj6GNsWexaWScTk1
         aXEeXZ13ROc68dqABX4xjNjG+gYhJxVYfC1tOODq9y9l9UerPzj9jDto/3/wJQA2xKjr
         A5Ic0rxKRARIEQZKCo4XzGfKKYqxJK9conpKhIWLnXlcdKdXtFX1hEEMt9+MJQI/F/Cz
         siuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738376259; x=1738981059;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IW8kJcAcrKvt4c0vMOL7jWV1OXPEd6lfnHsLFZy4QXA=;
        b=X18iT1U1snryL/eOHTAgWhu5E1zSYLfggeVoe9WM50q657gUab7Wjcm5AXOR5P7EqH
         hnmRupmcjyDXd3LBYgqMvI0U61XDg1na+F93nWM/D0Q0vS7AlxOqdUCwHyNWmBW9d1DL
         zfLgnDWWkN0e5WJZH7M5VAWM4WZ/+y8UJaZBhfEZTE8I0iWMJD/SIKHYwzuiqT7OddiD
         Ifz7iF9YkXhfAL5XN0T1IaaTohBj7cWo+cn4tCrFPdoZV8rL5x6CjTyv+gdLlZKQzV7J
         iiIv1/CbIM6LZNtYo1Ro0QfFHmw0yEzdjyN9Yy6LI3X86AHZy8ETbPPut1BHwNiuGVQv
         z33w==
X-Forwarded-Encrypted: i=1; AJvYcCXmTfSdQ2hXCtP/onrKiQ53zqUn15m7tucIUvzxrM90Y6LP1+LUd7x194BG4M/m26XEAEIkzM6pi+gG9DACBg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzF8OfLa9Ae0cMpe+UgRk0Y63Qt8GNiDRL4PCJeaTCOw4Ka3Dld
	cTP8wlswuVPrKpWjd4/PGDjEpptk5xDzA73C7PkAnaoRi+7sufroLDqDFJvNgeHm4UNeTNDrr9I
	rfg==
X-Google-Smtp-Source: AGHT+IF5rIJ4SRqkvzrTVMPpN2jn4obzhnrXzWmKwhKWojp8QTZ0kuVpAxPsfycQKPuD0sAxN2zkeFmWkds=
X-Received: from pjbsb15.prod.google.com ([2002:a17:90b:50cf:b0:2ef:701e:21c1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3a08:b0:2ea:37b4:5373
 with SMTP id 98e67ed59e1d1-2f83abe2135mr21011714a91.10.1738376259599; Fri, 31
 Jan 2025 18:17:39 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 31 Jan 2025 18:17:09 -0800
In-Reply-To: <20250201021718.699411-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250201021718.699411-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250201021718.699411-8-seanjc@google.com>
Subject: [PATCH 07/16] x86/acrn: Mark TSC frequency as known when using ACRN
 for calibration
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Juergen Gross <jgross@suse.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Alexey Makhalov <alexey.amakhalov@broadcom.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-hyperv@vger.kernel.org, 
	jailhouse-dev@googlegroups.com, kvm@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Sean Christopherson <seanjc@google.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

Mark the TSC frequency as known when using ACRN's PV CPUID information.
Per commit 81a71f51b89e ("x86/acrn: Set up timekeeping") and common sense,
the TSC freq is explicitly provided by the hypervisor.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/acrn.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
index c1506cb87d8c..2da3de4d470e 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -29,6 +29,7 @@ static void __init acrn_init_platform(void)
 	/* Install system interrupt handler for ACRN hypervisor callback */
 	sysvec_install(HYPERVISOR_CALLBACK_VECTOR, sysvec_acrn_hv_callback);
 
+	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	tsc_register_calibration_routines(acrn_get_tsc_khz,
 					  acrn_get_tsc_khz);
 }
-- 
2.48.1.362.g079036d154-goog

