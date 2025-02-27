Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811041B415F
	for <virtualization@lists.linux.dev>; Thu, 27 Feb 2025 02:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622753; cv=none; b=ZG+7riiAsa/AGgNt0ddibyVlItreS5OPlbS0Yqg9UhIvLLkGDQDlunkL0lJ3KFo3kTqMrkqRcQb7xmxOPBV5ZtFur83z65VD2EpvP0/rUj9kqmDUBiJ8mQv5g/ilNpBGn2uTYQJT5Wjs2NpniI2X899foyMZgs5nowmtlTJ8Sq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622753; c=relaxed/simple;
	bh=cbbEYbCk5kmrOnFY4+pyu6dZHx8scVaupy5RtKUOy+Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C4GmmlPNRHzvt/kLQZqiPNZvPcu4+w+zOPU5kijhVw2vEA3CFnQw1NKGG1c6Zbi4Y7E0p6HuMOC4jBI15Os/4Qx4tHpQC4DlgKiRq48W/dORP9F/qxRfhBJU77ii2YzFihmpQW/1c34E+zZZlxophTvMG9oKu4WQzLsFK4GIGzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XA/0OWGQ; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XA/0OWGQ"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc5a9f18afso1085237a91.1
        for <virtualization@lists.linux.dev>; Wed, 26 Feb 2025 18:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622750; x=1741227550; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=HbJ/1jLoPDWkVBe7cDWaMugTDenciqtu5nrTgQ9Zvm0=;
        b=XA/0OWGQO0nTZyKHIHtHHXwvnca7vbhoMVExw9ZLMS1Am4FL5d0H80NvPHgCXn9eli
         3cixdGgLjmuQEgP7Ia4aZxTG1wqBH/cDDa73ex76JoZ6leiAKcJAELWFfwC4QPONoei7
         emJFhBlKSyPWep3R88DZ6FHu5jE1IFE8RK6+FCyIfvFYNCRMAjTqGYof64Y9unxDDJLj
         KbNAQ1MkRRSaIV4fEkLGxq189EhnavhlMjeJ791S0Ho7uJhF9n1XeccgMj7y+Nd2E4Ro
         rIjHch8Z3apg49XU78/A/XI7ycYxL9+65SM8+xOof51X4jCsnWJVYOjjaESDo/YlGT7E
         p02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622750; x=1741227550;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HbJ/1jLoPDWkVBe7cDWaMugTDenciqtu5nrTgQ9Zvm0=;
        b=UmHKKjmp3fS55lWo2eNxB/M9zGhI/ZfW7+y4Dar3CfThUSzJY894sDJ/RlDW/ZsmmZ
         ET6/BOcaxkjAnqnEjWDq5iDV+QmtotiY45IO+JMExp/v/eKZ0b+iMdPV7oZ1rTGHXnVf
         di4AnqvbvTFT6B+3Ry2NRkLXzvMw7L/BVRCW4NaTj9vl2jw1ngyuxJtNqCY+Rz6uLUuJ
         qtEBrnBwpdzo62x1b5HLmfC4UainNGZPDcdTCL6SRTZgUGBTtOQOo6zZSPh3rOmXKnmb
         v+iG2kdc7lOHisXXxbxHD6eVPB/D9DpQDSmyARSTsJnHAr4Sj1Ry86n0UheG73EOCDcP
         SMDg==
X-Forwarded-Encrypted: i=1; AJvYcCWPZ/1h7gbgSzqJpJ8v2oOkWJggp47Eaa34O3bvKjDpCSFX2iSZDGm+tmNxdr2rAEILgWlnL7flL4JQ5AhTDA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzE8Jv1VzaBuE7O7q2RhFlxmNC6xL8udZV7QxjFkHc+T+Uqfdwf
	9rTow5Qb00BgFEbRJJLFqcAJNty6PUlW3D/4F6xVHmsr8HdtzDyryhfxgpaopXJtp5IaMHQp7qp
	ILw==
X-Google-Smtp-Source: AGHT+IFmgEsUJJ1z3bRk5Nf8mtm9mdRWiQdO+4qbvCwBd/hyjI3jP5eNnlt+3d6bfd4x/QDsZrTqSfxiFQY=
X-Received: from pjbsw3.prod.google.com ([2002:a17:90b:2c83:b0:2fa:15aa:4d2b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:56cc:b0:2f1:2fa5:1924
 with SMTP id 98e67ed59e1d1-2fe7e39f2afmr7133368a91.26.1740622749803; Wed, 26
 Feb 2025 18:19:09 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:20 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-5-seanjc@google.com>
Subject: [PATCH v2 04/38] x86/sev: Mark TSC as reliable when configuring
 Secure TSC
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

Move the code to mark the TSC as reliable from sme_early_init() to
snp_secure_tsc_init().  The only reader of TSC_RELIABLE is the aptly
named check_system_tsc_reliable(), which runs in tsc_init(), i.e.
after snp_secure_tsc_init().

This will allow consolidating the handling of TSC_KNOWN_FREQ and
TSC_RELIABLE when overriding the TSC calibration routine.

Cc: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/coco/sev/core.c      | 2 ++
 arch/x86/mm/mem_encrypt_amd.c | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 684cef70edc1..e6ce4ca72465 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -3288,6 +3288,8 @@ void __init snp_secure_tsc_init(void)
 		return;
 
 	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
+	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
+
 	rdmsrl(MSR_AMD64_GUEST_TSC_FREQ, tsc_freq_mhz);
 	snp_tsc_freq_khz = (unsigned long)(tsc_freq_mhz * 1000);
 
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index b56c5c073003..774f9677458f 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -541,9 +541,6 @@ void __init sme_early_init(void)
 	 * kernel mapped.
 	 */
 	snp_update_svsm_ca();
-
-	if (sev_status & MSR_AMD64_SNP_SECURE_TSC)
-		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
 }
 
 void __init mem_encrypt_free_decrypted_mem(void)
-- 
2.48.1.711.g2feabab25a-goog

