Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6D7137C25
	for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 18:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713293087; cv=none; b=cwLQAjS0AMH+cmeb0Qj9Yw17yfakKm4XzHd2akPZUcMPiqN4swUzDYPDNw7WX0n/+31Sc7fE/Qlil23X8TymvcmIZgxFRcPfp+s1U7X4STasInu8c8XfO4tEMmaeQC+Qehjg6T5ifUtx/PKsU22OWWdN2H63d1lv8Z6VbiHZvgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713293087; c=relaxed/simple;
	bh=PCH+9nz39V3BSztS1z+ZZiAV+qP9h7YwF5oYKnRz76Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aREaBdoIK/C8Ls42aTyicU9BU+t8li9gqgozCnOsKkOplARJotAuLEVL/y7TPvC1FgcCiBkSnbvtOQlaZe6K2fcSRgEKrjskUtVRDDrtwRAETsDryu7xhr2m157zt+zBRj+KfG+Nv/gpE/kjuY8XZuvMGoRjiv6B3aymSeAt1wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=pVr1wCui; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="pVr1wCui"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ed32341906so4241943b3a.1
        for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 11:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713293085; x=1713897885; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUdjqPblbE6Q25Ekp/l365V3YEPrpPkLHh57fhpvEHQ=;
        b=pVr1wCuisYcjkT8pkj6d6O83NrxVLPJ+Fv6hULTClHFql3VmVKpvmC5gC6+fLuT+uL
         Cw9AvLpnwqi6w/dgJukCfXvLrvXLGq15rTCNeI/V7kTMy9Yrs7QAhxapLJ9yFAJcahod
         ADmzfvPr60Z6kChsDGp/LWKePEwRTUTzhT8RoLlPuQ/gCvcY3VXB6qhw53uaBzljAv0j
         lLjPO2XZvcqnyHPl3R6N6L48h/aj4bfU5GqS7K03MQzF80z5sXC6Ilx6of49TqtlGcFM
         q08nDCv0O14bSuFb8kAfUdF850CMer0UdAiOhgtPFCfJGVB2CAao7IG6Bxcs5RY7B4pB
         tO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713293085; x=1713897885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fUdjqPblbE6Q25Ekp/l365V3YEPrpPkLHh57fhpvEHQ=;
        b=cm8hCQOUpSvK0ED1zWnxWLMTZhFPw/dYrVxVLsna9MBpJu8jVTvNp65ucXz8j2Pm6v
         KVL7Seb0BBtx/r03ulipUfQnL5dqESlQQxTdpaKE2r7YMZiI3xL8G5Jh4+UyrJ/MLBnt
         sPgeQ18k8GGoBXGjZtnUAmlKqeyRe4RdLoVZ414y/9RJDH5gdJ2UPMdSc0Sl6Gsk28jN
         CnTHCvbDofztjTRsS+N6s96m3+BP8Dtv/YGomix1OhzPFU9eQSEcfye9ADMQ0SJBpt6F
         DklwIip2EQGc9rpRsPTJjr5wV2ET6VLhelmoAiuhB1J7CKtZrG6rRKKQU3GOuOaalEBE
         941g==
X-Forwarded-Encrypted: i=1; AJvYcCUbp/YS9NueS5sc5LLsaPy30N3hs+lzFDy1hbp1LxKOLPTVBqv3xWkKE4Fv7vNSSa3iVWcCeZlp5iWGQDXwtwqnqRyS8sY9sBBQ5nAQ7M4=
X-Gm-Message-State: AOJu0YzeC9crDfbC487bRZzNDepRnNyxs5YuA7LUQ6gF/ShmtQE+oMXD
	eZsk4QC+q0uqVavd0A2vGxqSa9nttuplKyMVyzTfQ8C4/P/EHsE6ax57LFt1py4=
X-Google-Smtp-Source: AGHT+IFtzoiZdYWwgHn6C8yyQkHaJfDcObm06QyEqTUpANSp5NXvj3BXClLqKq4hZWSzGhyKgSBRzQ==
X-Received: by 2002:a05:6a20:3c9e:b0:1a8:2cd1:e437 with SMTP id b30-20020a056a203c9e00b001a82cd1e437mr14111733pzj.11.1713293085603;
        Tue, 16 Apr 2024 11:44:45 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090aac1300b002a269828bb8sm8883645pjq.40.2024.04.16.11.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 11:44:45 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Anup Patel <anup@brainfault.org>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
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
Subject: [PATCH v7 03/24] drivers/perf: riscv: Read upper bits of a firmware counter
Date: Tue, 16 Apr 2024 11:44:00 -0700
Message-Id: <20240416184421.3693802-4-atishp@rivosinc.com>
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

SBI v2.0 introduced a explicit function to read the upper 32 bits
for any firmware counter width that is longer than 32bits.
This is only applicable for RV32 where firmware counter can be
64 bit.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 drivers/perf/riscv_pmu_sbi.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 3e44d2fb8bf8..1823ffb25d35 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -57,6 +57,8 @@ asm volatile(ALTERNATIVE(						\
 PMU_FORMAT_ATTR(event, "config:0-47");
 PMU_FORMAT_ATTR(firmware, "config:63");
 
+static bool sbi_v2_available;
+
 static struct attribute *riscv_arch_formats_attr[] = {
 	&format_attr_event.attr,
 	&format_attr_firmware.attr,
@@ -511,19 +513,29 @@ static u64 pmu_sbi_ctr_read(struct perf_event *event)
 	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx;
 	struct sbiret ret;
-	union sbi_pmu_ctr_info info;
 	u64 val = 0;
+	union sbi_pmu_ctr_info info = pmu_ctr_list[idx];
 
 	if (pmu_sbi_is_fw_event(event)) {
 		ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_FW_READ,
 				hwc->idx, 0, 0, 0, 0, 0);
-		if (!ret.error)
-			val = ret.value;
+		if (ret.error)
+			return 0;
+
+		val = ret.value;
+		if (IS_ENABLED(CONFIG_32BIT) && sbi_v2_available && info.width >= 32) {
+			ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_FW_READ_HI,
+					hwc->idx, 0, 0, 0, 0, 0);
+			if (!ret.error)
+				val |= ((u64)ret.value << 32);
+			else
+				WARN_ONCE(1, "Unable to read upper 32 bits of firmware counter error: %ld\n",
+					  ret.error);
+		}
 	} else {
-		info = pmu_ctr_list[idx];
 		val = riscv_pmu_ctr_read_csr(info.csr);
 		if (IS_ENABLED(CONFIG_32BIT))
-			val = ((u64)riscv_pmu_ctr_read_csr(info.csr + 0x80)) << 31 | val;
+			val |= ((u64)riscv_pmu_ctr_read_csr(info.csr + 0x80)) << 32;
 	}
 
 	return val;
@@ -1135,6 +1147,9 @@ static int __init pmu_sbi_devinit(void)
 		return 0;
 	}
 
+	if (sbi_spec_version >= sbi_mk_version(2, 0))
+		sbi_v2_available = true;
+
 	ret = cpuhp_setup_state_multi(CPUHP_AP_PERF_RISCV_STARTING,
 				      "perf/riscv/pmu:starting",
 				      pmu_sbi_starting_cpu, pmu_sbi_dying_cpu);
-- 
2.34.1

