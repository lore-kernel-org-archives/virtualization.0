Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF3218E361
	for <virtualization@lists.linux.dev>; Sat,  1 Feb 2025 02:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738376265; cv=none; b=GCj8DzgT0xkLyu7nkTGECDsH57S2L3T+qXAUPyxYL/dIKrBJUCH0J1IxfWlBkrHCA0ev8SQazehDKtW5vgquc5y0wwU8tS70fS+oiSrdJNIuEMulGYzXWU7G6FaSDNu56MYsyWb8qIajrdZ+Qcp9b4gBvOiBk4Z/bRFRnKaLkuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738376265; c=relaxed/simple;
	bh=SMb+ptqn3Y2lAemdJfa8mzgfJB25QAWQ7cmu+kYKQzc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fj7x9atIOyCmGgM/ghe9Edn2KbtZW8qREh93SXjv9cfnWv1R9HlZ4/f7LpJyFsP8a1nEySlFvCCzFNnxBuibuiglndLUvHekke20f9dciNu/W/VXFEOJm+p4Nb47BUzHMQg06NSuIHlO3bXqF8dVEWwZ+hchZZSOgvGNQdIYBtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M35SV7Kz; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M35SV7Kz"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ef9864e006so7283052a91.2
        for <virtualization@lists.linux.dev>; Fri, 31 Jan 2025 18:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738376263; x=1738981063; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=T4DEhCWG0SuSvz0a+mPR7euxpU0fSN+tQ/CkCS9MqCY=;
        b=M35SV7Kzmn2OjIUtJJGPoMRun0afcFo7z+UorufgydoD/RDmobI3u6lSHXjDj5PzE9
         ybigv+VYmlMSfUc9Emh8MYgzpYEqr+qW40ADz7sDROvK14PdzzHnb4aI0pOhFh69d/r0
         bKMj5jkbgXGdCz4v/1iZBE81nR2giqrm0FbYnQH39ngMUuwJEJv9vNYscqe1RGBOQ/PV
         2KScFanToZOrCYC70Ojip+zPuCjyubflsampLiUFklWpV+PDf6bhB7zQYuk0eErvCJIb
         oZu2/cSKvW7Rs5BabBwmo19iqVrFWeaB+52IAxwGV8KG4ExTGFNawnn3kwWKZLydlGRV
         eogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738376263; x=1738981063;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T4DEhCWG0SuSvz0a+mPR7euxpU0fSN+tQ/CkCS9MqCY=;
        b=sbev+4on2CcYdlGz+JVKc7Bu5LtG5uRn83v/R0wAMFsCtMh53Y27Il5/95edLVYghU
         8dXSxiaGhWoSRYDM3Ak92ykTlgAcuDTASwIsurJb+h7hICuI29ApgfEZKy19g95kuw7n
         k8X+ffco7/ZNu+ghBps57SuhB+he4Nbh5jIqe+NPogGoU9K1OGaxSNrvceBRuUQVRap6
         LF/GMHLMQ2T+ufg1aQeIbgGBbY0yUTZi5oKOvFVXho+u4XhH75VVCb9MkaEhQHZHQhZU
         hE8A4Q+A1ojOgMmLI1I/CnXb3Gs8t82moh4H+K+fqg+PwWpwoWFTR1gFzv5V+8eN5IiE
         oVTw==
X-Forwarded-Encrypted: i=1; AJvYcCXZGHZcQ6EO/G/peubPRZ+9ejkLXQqJJq5d3UQui727/DRHkWfLK+ZccqCevw5qF21m3dvr3e8EAXEh9COLXA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywxh3Fvd9fGRXHuvNRYPxuBGqQAz7IqLF3Jgs/qBE6LQ6pH7TY2
	EBNpVdxMvbxjAkGdnr0ZgGI2nIhpwjSbrmUi0ph7Wp1fFwPBeaD9hc6xobRKfNg+881UVletA3t
	DSQ==
X-Google-Smtp-Source: AGHT+IHof1w34LjQ30XVM2gwsfD2n69eJy7Rgvm5USApfq7itvhXgigdwO4D30qo87G/8bS8xHYNlWrIUTM=
X-Received: from pjd6.prod.google.com ([2002:a17:90b:54c6:b0:2e2:9f67:1ca3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:51c1:b0:2ea:7cd5:4ad6
 with SMTP id 98e67ed59e1d1-2f83ac86a44mr17727640a91.32.1738376263046; Fri, 31
 Jan 2025 18:17:43 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 31 Jan 2025 18:17:11 -0800
In-Reply-To: <20250201021718.699411-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250201021718.699411-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250201021718.699411-10-seanjc@google.com>
Subject: [PATCH 09/16] x86/tsc: Rejects attempts to override TSC calibration
 with lesser routine
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

When registering a TSC frequency calibration routine, sanity check that
the incoming routine is as robust as the outgoing routine, and reject the
incoming routine if the sanity check fails.

Because native calibration routines only mark the TSC frequency as known
and reliable when they actually run, the effective progression of
capabilities is: None (native) => Known and maybe Reliable (PV) =>
Known and Reliable (CoCo).  Violating that progression for a PV override
is relatively benign, but messing up the progression when CoCo is
involved is more problematic, as it likely means a trusted source of
information (hardware/firmware) is being discarded in favor of a less
trusted source (hypervisor).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/tsc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 47776f450720..d7096323c2c4 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1260,8 +1260,13 @@ void tsc_register_calibration_routines(unsigned long (*calibrate_tsc)(void),
 
 	if (properties & TSC_FREQUENCY_KNOWN)
 		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
+	else if (WARN_ON(boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ)))
+		return;
+
 	if (properties & TSC_RELIABLE)
 		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
+	else if (WARN_ON(boot_cpu_has(X86_FEATURE_TSC_RELIABLE)))
+		return;
 
 	x86_platform.calibrate_tsc = calibrate_tsc;
 	if (calibrate_cpu)
-- 
2.48.1.362.g079036d154-goog

