Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4F6745EF
	for <virtualization@lists.linux.dev>; Wed,  3 Apr 2024 08:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131529; cv=none; b=B6Hb3YppYrsSXv2DeMWjJJFNHEs/uaqR1OBRpvlzncy0Y/kSp0NQXS9JzZBAbZUFiJfLkef8GCHoSxsBarnC7RewczFwAFe7AXdq56dBK1F8Jf0Ay5LmsY+J21aDw5bGBMuQLF8ACmBlNt9y7Pam2olyfsuvKM43BLCO13tgTyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131529; c=relaxed/simple;
	bh=aDfanLTs21GL0maDPQpRseQyiyuKg+u1j0b2hveDXpI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SfvzYX82uN5zluU4Ie+upKWBbmbTPkpVCe+aamgaFNo194+Ztc1Aa8CQ67tYcyIZuClwmHQVDsgjy4HrkGbfrptXstanvCH6AjhJ9Dgh3R9qIMbSyMOcbzABnE37NxNq95ITgY/geoNfcQ3T6cUPy85h30JFMFp5LzC5zKhUTEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ZiCfZE3g; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ZiCfZE3g"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e73e8bdea2so5530563b3a.0
        for <virtualization@lists.linux.dev>; Wed, 03 Apr 2024 01:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712131527; x=1712736327; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4rw21DNPDWpaXnd5Gs3cWE2qTmUGGOZ0JnLHhYLDMiI=;
        b=ZiCfZE3grsjxe0cjh37ePpNXu+F7c2i9B56qtBxBLLdIKRx7xWkPYjwotzC92oQxeu
         7KnEP/bNH3OrPDc9EWhGBa/gHXzNi6cqGU8Cs5Adm8dfp2jctbSen1rKeItUwlN8thJf
         sJ9Fbe/fq13zZZU5UDd14FxIjUGNx7m6ghKDaWDznAUMEjZBsVv2a4V/27KwlAWOfRi0
         MRstpmE5KHsKZMJ1AxDm8uv0GZlQbjSw7M2L1BkGwguIT8V7LVyOGUB36MxUF8foeUlJ
         j97n8Jg0TvaUwGs/K5cXlnaeCXHUCMxWI5QSTtBCWdk2VOQN2yDUjrrQi/cDgILENSf3
         6lkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131527; x=1712736327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4rw21DNPDWpaXnd5Gs3cWE2qTmUGGOZ0JnLHhYLDMiI=;
        b=mS2tGh5dVimz+A22J7SfYHURxLHIbS1cD8bgiZIojWUhUtKDtYe3adP/u5k3V+vBlG
         sOxg2V/7qGulvbncRJKNYTlJiUSdUBPSauVibsl2QAeRUwg82G8zySKdrlFPs/WpanqA
         VzGjaISgh4DiC09FrsDa/hOwsDiOBHu1SHFaqiIcvZwRo3emk4IMLySSX2a06my1farp
         g3E8CvcWEqITbcMZTki7lzg5H8ornDb3LvLqhXc+EzbZwOrSk39soPt5ca+ueOOXy8ic
         Se7F/suFK4Q+8LISH6A0IHK0ntw2SUPuGJURDZgJM5qmU964L9WCnRYRgPxln/0dGzZl
         tzrA==
X-Forwarded-Encrypted: i=1; AJvYcCXMDpYtn5Pfo8ko2rC9lIklOx0f8wjLmPH5oogje1G7x6rSqAYLtObKfaWvCAuF4xtvvDsdp/s8tDeHdFB9MkPJcrsb6CS37G/iqkImsRY=
X-Gm-Message-State: AOJu0Yydmk28nZUTgdmza18/0uKGzmoRdzXheYnc2l1HyEC4ezhjUlEB
	fCHAT3kHNySGHE8gZz6I5vhT24UmnFAUFlHbtLqhOYyJJPQD1vNCpREZFlW2d3w=
X-Google-Smtp-Source: AGHT+IHZeguUWEErPiWxvNkeVU9lmGoRHX/48aTBnxr2DMrqRPKV9Qdy9c2zpt6UamZ4tC6ZYgwGwA==
X-Received: by 2002:a05:6a20:17a7:b0:1a3:34c4:b184 with SMTP id bl39-20020a056a2017a700b001a334c4b184mr13823636pzb.19.1712131527654;
        Wed, 03 Apr 2024 01:05:27 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902d48c00b001e0b5d49fc7sm12557229plg.161.2024.04.03.01.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 01:05:26 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Ajay Kaher <akaher@vmware.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Alexey Makhalov <amakhalov@vmware.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
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
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
	Will Deacon <will@kernel.org>,
	x86@kernel.org
Subject: [PATCH v5 07/22] drivers/perf: riscv: Fix counter mask iteration for RV32
Date: Wed,  3 Apr 2024 01:04:36 -0700
Message-Id: <20240403080452.1007601-8-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403080452.1007601-1-atishp@rivosinc.com>
References: <20240403080452.1007601-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For RV32, used_hw_ctrs can have more than 1 word if the firmware chooses
to interleave firmware/hardware counters indicies. Even though it's a
unlikely scenario, handle that case by iterating over all the words
instead of just using the first word.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 drivers/perf/riscv_pmu_sbi.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 8c3475d55433..82336fec82b8 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -771,13 +771,15 @@ static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
 {
 	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
 	unsigned long flag = 0;
+	int i;
 
 	if (sbi_pmu_snapshot_available())
 		flag = SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT;
 
-	/* No need to check the error here as we can't do anything about the error */
-	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, 0,
-		  cpu_hw_evt->used_hw_ctrs[0], flag, 0, 0, 0);
+	for (i = 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++)
+		/* No need to check the error here as we can't do anything about the error */
+		sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, i * BITS_PER_LONG,
+			  cpu_hw_evt->used_hw_ctrs[i], flag, 0, 0, 0);
 }
 
 /*
@@ -789,7 +791,7 @@ static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
 static noinline void pmu_sbi_start_ovf_ctrs_sbi(struct cpu_hw_events *cpu_hw_evt,
 						unsigned long ctr_ovf_mask)
 {
-	int idx = 0;
+	int idx = 0, i;
 	struct perf_event *event;
 	unsigned long flag = SBI_PMU_START_FLAG_SET_INIT_VALUE;
 	unsigned long ctr_start_mask = 0;
@@ -797,11 +799,12 @@ static noinline void pmu_sbi_start_ovf_ctrs_sbi(struct cpu_hw_events *cpu_hw_evt
 	struct hw_perf_event *hwc;
 	u64 init_val = 0;
 
-	ctr_start_mask = cpu_hw_evt->used_hw_ctrs[0] & ~ctr_ovf_mask;
-
-	/* Start all the counters that did not overflow in a single shot */
-	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, 0, ctr_start_mask,
-		  0, 0, 0, 0);
+	for (i = 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++) {
+		ctr_start_mask = cpu_hw_evt->used_hw_ctrs[i] & ~ctr_ovf_mask;
+		/* Start all the counters that did not overflow in a single shot */
+		sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, i * BITS_PER_LONG, ctr_start_mask,
+			0, 0, 0, 0);
+	}
 
 	/* Reinitialize and start all the counter that overflowed */
 	while (ctr_ovf_mask) {
-- 
2.34.1

