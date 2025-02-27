Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029BE191F7F
	for <virtualization@lists.linux.dev>; Thu, 27 Feb 2025 02:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622757; cv=none; b=Odn09sC/rNsGaLwWYqBbY4+Wb3bSegdlbP6PIax2Rc8hl3d68W4JamkBu70KwjGLYtZYOX5Th5gq5x8/l6RyDb7m+95mhMz0dKMixCWr6LmB7JKzMsp+E/y0/wcjFe+qZYCUAqFCBfsiYvpQHNA5LfYUToKAMyL51GE/1P1gcBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622757; c=relaxed/simple;
	bh=X5UL+eTktXYoDPfW4LhmVxWuD5wQW055Sxbi/QZyZe8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pj+a6FDK8XCidRGNwhaYhhkM1pu3IzMBVq/cy3qQjND08gcaRqraSiSXFNeDPQMvFepc95KwabBdsMwdPLg3HW8+bkn59H8jNxobXputB3QXYoU9EPU+mU0zfYaJtdS7yC3ivL9z3U4uHMcIGZTonPj7hPQUZbs+xBkH+HQA/7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jsjvxQyd; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jsjvxQyd"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc1cb0c2cbso1525770a91.1
        for <virtualization@lists.linux.dev>; Wed, 26 Feb 2025 18:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622755; x=1741227555; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=YtBqucRQyVVjFtgUlGbh/U8C9xbSv2L/3t5kwpG/0fs=;
        b=jsjvxQydjKxgyD6VVGBBnPRmwUbMoY6Osw+jLlg7uRrHEdyjF2C+I3VGhYD37j3rei
         bFeCRhAsmmGe8ZGaF1M7BSUGdOAfcQGaQgZ4Tq7ygIFi5rNXZfrKwe7m7ZpxPE1AytHC
         72eOXGMqRlQCF0v/LJXJnduepdfERnSOg3LJdWRhZPjypyk6gCNFE1+wBBfo6A9R8EnY
         wCxXgA7vvLCiPD9ajnR0bsgimsigCAK7w9pKnZ9lmTrpxEc+j+paARMDN8KHft49tUwv
         qutxUl6xqUyWMc1jksv0uCTHGsxucPN26QdbUaC5dVkzrFmhVlEwIomuRPjCVfHAsazY
         r39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622755; x=1741227555;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YtBqucRQyVVjFtgUlGbh/U8C9xbSv2L/3t5kwpG/0fs=;
        b=jHoUwno2b0ePgBD9iCHokguxG7h4hfzXk5AJG0ZWADMpGeaGzn+ysOch6KCO60Y4Xw
         2wbcL131Hiz5RjBCiw8MZvB6FfVPPv5exZQAxzIMUueDciV6dgwTF8SM/q6yhKFjmLsa
         h69kAJr2LJHvQFUYEJrGxkSsLXor1zkcjqYQ272TDvqKTPfhqVMs3Ar5IBjzYrmrSqR9
         WU3J/lpgcZ6h76C0g5fkqdMFoRYViACmxnfxzZ0MaHlxAD+RIOEGPsu1u1BDYXvvcUaD
         WvSaxAL57hZ/dQf7Kj8PEtfwvpF+8WQw2hJuG6lITnD7tikpyHuVzTHB3PX/WTWpFVyU
         d7HA==
X-Forwarded-Encrypted: i=1; AJvYcCW9pg88dqB9SeD77E/58MY1yy9k2yyl1xXzKY2M3rOCNpsCz3Z2/D4hYDiKREgB2RL6UhSFtCPMgsmPnwbApg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxKySwYdby5u//dUqcrZq/TMwbHRkeRFq2XCkxZrXN/wPyRsBc1
	F4D5QQz42y2wjZMNBKWbp3OPXI7BIgQfxEr2zfgT+oiAlkPpgkU5PZmlMV8HtXGBbicdNgCEf+W
	DDw==
X-Google-Smtp-Source: AGHT+IH9Y0SwBcAS02xHNq+a4IakpnWSLKqVw4P68iCQM2m6waYT1AwLAOPZPnrjzYdSpJiao+kBYkSTr34=
X-Received: from pjb4.prod.google.com ([2002:a17:90b:2f04:b0:2ef:78ff:bc3b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2dc8:b0:2fa:ba3:5457
 with SMTP id 98e67ed59e1d1-2fe68ae6c4fmr17520974a91.17.1740622755379; Wed, 26
 Feb 2025 18:19:15 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:23 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-8-seanjc@google.com>
Subject: [PATCH v2 07/38] x86/acrn: Mark TSC frequency as known when using
 ACRN for calibration
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Juergen Gross <jgross@suse.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	John Stultz <jstultz@google.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>
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
2.48.1.711.g2feabab25a-goog

