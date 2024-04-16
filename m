Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C71E13BC09
	for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 18:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713293099; cv=none; b=Kkdo+/5MnMLEzlq48BnJ9Tormk6yhLMa0MFdIAzIZhMPejhuPBOm6TenzfTVfvYz+/v2Y439pUTkWl7OMb6vqhRPWuK3lCi2O6N5STpi0KH0JBW8T8/JTfvwpZnT3Moo3hM7mkToniFOgRggEKMDCaqB8fEdB9ltPKma6eHpEQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713293099; c=relaxed/simple;
	bh=+BS7mctHpN9iWLFPEwC2/74zIoWzY97OXSTjHAOIU1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z8RMW4gQy8NAdr/swbgHW3OyF/zC3ZbuoHJUjTWVPRcKK4ralWUITQGVN0iSQLMNH7YeZjCh0tC7ReoxszSOheiqWOhY/t4MDmtdywA8TrFUmh+W/vzOE9rP5niLAU/fnE8oY7YZEVFQxUBvEfQFYn/AYWBDiMXuAMdxEfcQHTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=kGwVNhXR; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="kGwVNhXR"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2a7e19c43faso1867058a91.2
        for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 11:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713293097; x=1713897897; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLadZMY/1E+aj61iqE390ie32fUnJXqsMN5cFXtebck=;
        b=kGwVNhXRiKOsdYsG2Ei4TXwO5zzFvC5mBg5yGwd+lwIUozwITQ9PBfF/RHjkqWuKgK
         +FwEI3+r7i9GF5dpOurr95r19a9uzi7Cq/gKnGAtOs0wZYmyTHJ6/7myKPeXqEmbCzaf
         oAWPCbfQg+RZUDmj6t4QQiB5lpN8g56MalOo4P9Bf05c3ZPNO1jznQQgzm/SofgWOFFH
         Ttbj6WxluhjASwH/S5llF4kOCrpPZLlRrTDCesWxO6l37lJo9xxGs3q/MIo4DulHhKEk
         od5Ko8DVsVCLDMuxdCwWvJp16wUd5rDgREN9s/fKFRhSfq3FNo1Wqs1UE69tbM538GXR
         rx7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713293097; x=1713897897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLadZMY/1E+aj61iqE390ie32fUnJXqsMN5cFXtebck=;
        b=FgQK9HUbIIhruGHCRpudWDO9oxH8X3QP8wknLdKZJiMytwReX5i04zsolSEW76eH4q
         C9vmUuGcAOyw/DnENU4yxYYzPJODWR/j5wvFf2l+O3Rmo1YOrpPDI9XCbx7hxP0jwLyU
         QuTGz6KoKmzjOHlW8Z78P+8ceX6b2iQ+z9v24Xvay49qokOliv/wqByfLea8lcRTm2re
         IpJEYFVVUcKx1vBV3TTbJRQGDfxlgXkgSM/5kfPM4pKPy5jNCLEdhRCwV32vq4Vxy6ww
         Q6UusRhu3AvWFoZc0CrQ/SUlRg2ea+/hcyKyOcUyZUa5ZB4BbL27nrYCO9qpDfQc09Xf
         9HlA==
X-Forwarded-Encrypted: i=1; AJvYcCWEBa0AMFsLZ+wBDRyi/F6SE2zqX8k8v3ju/3wzP8WXLgUevmUTXydC4QSNgcA9mhWHIowgjsZ/TFZEF2eiUkFWjev7MKwwdIBUhlqDRaI=
X-Gm-Message-State: AOJu0YyvCJBzd+NMbK6ObopJ00YvYc7guLHeVoHQyovh3WB4gQfaYwq+
	U1OU/3NP8NmEOBlIwGl76RcA8ZxZPYP/MiUBgC/WMLohOiUtgc52iZESiaG5Y0c=
X-Google-Smtp-Source: AGHT+IFO7WHFR9Rl28v65gUEiDT2PQZV3q/4Cya2K/e1Lz1G/MiHbevY0IrWH/uczf0ujzNAu6TxBA==
X-Received: by 2002:a17:90a:130c:b0:2a6:f414:4e0b with SMTP id h12-20020a17090a130c00b002a6f4144e0bmr9113440pja.41.1713293097058;
        Tue, 16 Apr 2024 11:44:57 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090aac1300b002a269828bb8sm8883645pjq.40.2024.04.16.11.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 11:44:56 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Juergen Gross <jgross@suse.com>,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Shuah Khan <shuah@kernel.org>,
	virtualization@lists.linux.dev,
	Will Deacon <will@kernel.org>,
	x86@kernel.org
Subject: [PATCH v7 11/24] RISC-V: KVM: No need to update the counter value during reset
Date: Tue, 16 Apr 2024 11:44:08 -0700
Message-Id: <20240416184421.3693802-12-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416184421.3693802-1-atishp@rivosinc.com>
References: <20240416184421.3693802-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The virtual counter value is updated during pmu_ctr_read. There is no need
to update it in reset case. Otherwise, it will be counted twice which is
incorrect.

Fixes: 0cb74b65d2e5 ("RISC-V: KVM: Implement perf support without sampling")
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kvm/vcpu_pmu.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index cee1b9ca4ec4..b5159ce4592d 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -397,7 +397,6 @@ int kvm_riscv_vcpu_pmu_ctr_stop(struct kvm_vcpu *vcpu, unsigned long ctr_base,
 {
 	struct kvm_pmu *kvpmu = vcpu_to_pmu(vcpu);
 	int i, pmc_index, sbiret = 0;
-	u64 enabled, running;
 	struct kvm_pmc *pmc;
 	int fevent_code;
 
@@ -432,12 +431,9 @@ int kvm_riscv_vcpu_pmu_ctr_stop(struct kvm_vcpu *vcpu, unsigned long ctr_base,
 				sbiret = SBI_ERR_ALREADY_STOPPED;
 			}
 
-			if (flags & SBI_PMU_STOP_FLAG_RESET) {
-				/* Relase the counter if this is a reset request */
-				pmc->counter_val += perf_event_read_value(pmc->perf_event,
-									  &enabled, &running);
+			if (flags & SBI_PMU_STOP_FLAG_RESET)
+				/* Release the counter if this is a reset request */
 				kvm_pmu_release_perf_event(pmc);
-			}
 		} else {
 			sbiret = SBI_ERR_INVALID_PARAM;
 		}
-- 
2.34.1

