Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47B838D69D
	for <virtualization@lists.linux.dev>; Fri, 15 May 2026 19:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872833; cv=none; b=ZLNPuqo1VGiKW46jyFBZ6YWVkTtvog2c9dukW5LcD8tWYxc8U8cz1+5Z5qbwpNLWj6eRSj774gPigAVtJ8V4CUeGt5wlDB4ZU1yWe2bAUKXe/2KZrzuE8Kh8xKAXVToAupT0mIG3QctV8V4/bM+NUEl9BwGR5a0mdv8WvmgAHrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872833; c=relaxed/simple;
	bh=IfVwAYhwhIxzw01+s7FehLy05itlzurZzA6D640hoDk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rhB1K64C/Xw6RLWgWarf2mMuEdoUhSbdxja9EvhqZ9HMEICq9010Bb9evRzojpKh6Tii663uN2ErwPTuTrzd0w/ckbr6hoAsxIYEyJzyD19nrhKH89OMydYvrIbUPZ37xaCO+kmzwLpzbaXpFtKpZYFFpDf/mt8PXSKdRgE8V6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X5Imlt3t; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X5Imlt3t"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3684cb22502so72785a91.2
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 12:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872831; x=1779477631; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=SQlmIR1hnrcjkd+R45vwU7fSi2OSjNiqFudElplFZs0=;
        b=X5Imlt3t6JoTN/ZSwk6ROlo/AFcT49pObftvDWX1ZujOJ1lebxZEKsnmicEbK+re4J
         EYrcm7hY9Y5cMK3VCVDVeClGPGe7LD+6izsyrGE3Z5yKbu+EIgAVEGdIy/2pBCo01CTV
         ychn/UI0KjtMfx/TdtFhn6yIPJd8y958ZOVtAnANdxKb5/yFxMwSxhia2SGe65WrxtgR
         xKidJm8yqCiSNjE24r0NyfzCQfpYWDivtcoVhPbTNICcpjf77geQ8rPh2l2LdTQ/xE1t
         wIld/6E5aLEWzz3z+HcwiPz7ba8CFccKwm/zYtGv+1r55fuNrE7bethk4UhgckT+FKRT
         YQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872831; x=1779477631;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SQlmIR1hnrcjkd+R45vwU7fSi2OSjNiqFudElplFZs0=;
        b=WgsIGB8dIktMJTHOH/Hf46l3jZynUy5j0eLxDnbskKpAcMTBpPZmASTeiIU4iX0Sq7
         lGLL3aAfrERPAVMSadezYJzOh0A0D4nCyYkc3Cp/6hzife5UlXZxj1/m0sPmxTPZpWbN
         5IasupSfvYNhgNRYsV9KnHrHREoLhu+5KhLP3upAvidUYlzKwqXWARCBFZsph3+V+lIA
         XaaNRhQUbl4MruUJeDhPN/o54WdXvE3zKw6csAF0j2OXamlRNMCtRaYr2PwwQZ4BaGz8
         /ODGuZNKq7n9br3evLdYisYwfhG85bMoerYtJ7Mjdx2VCEOni0gzcOl/AhEwaoz68fGf
         Nt1A==
X-Forwarded-Encrypted: i=1; AFNElJ/eZT2LstgOjwv5+w4uV+OwarwqTwnjPMTJUi1DcbQqs199c7Bf2elxTk7/NgzN1bHZw1lnPQtqnOii7+RHcQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzm1oCaU8g7EKyWtTWNXR/wOdvUVdiSb3wp4Iqw3/vQXwjDn8qv
	VNcFgiaY3kjRXGvi4c8nq1YMy7iaHsMveQCXQMiLVNYS5UasmPfPmwCbS9/YrlZ4v6SJceAT/L7
	hQC5H+w==
X-Received: from pgmt14.prod.google.com ([2002:a63:224e:0:b0:c80:2399:151])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2fc4:b0:368:85fb:7b8b
 with SMTP id 98e67ed59e1d1-36951cb936amr5644652a91.22.1778872830766; Fri, 15
 May 2026 12:20:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:07 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-7-seanjc@google.com>
Subject: [PATCH v3 06/41] x86/acrn: Mark TSC frequency as known when using
 ACRN for calibration
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
2.54.0.563.g4f69b47b94-goog

