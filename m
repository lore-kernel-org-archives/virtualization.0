Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0204C70CDF
	for <virtualization@lists.linux.dev>; Wed,  3 Apr 2024 08:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131522; cv=none; b=ZMJuNcQJJR1q8gWo6NvRGyY4deudcQFL60pTWjtGPIEkOiu+A5Np3Mi2XHYp20usXuyqPxIJ/w9GNXd6QzYd6YAEl0I0NMeWMbGi4v79zI+yTC9iBwFteUFOcvd2dpdsmxL0Y8OQT0DyK8OnAi2tlBE/ME61TVGDga+IFh5TWB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131522; c=relaxed/simple;
	bh=IeCUKxpOMKG0zL7LcLS/wH2lWaOxpIfM9zaAAyQj4Uk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xya5kChyoRg+vIdCSsu0Z1V7EdtFd7V4XmvG8OHHsupklM6Cg2fDhoQhI0P1l5g19XtBSqUMwG5krQzwyJds3mh6GgyECFSoXFEzLU1fsrKAXQ74CzSN9FYsv5fO8v3CNugNvHyQuEgA8oXd51YIl+1F47XMOl6Om1Fj10AkHbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=W+KMdA1z; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="W+KMdA1z"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e0d82c529fso51751555ad.2
        for <virtualization@lists.linux.dev>; Wed, 03 Apr 2024 01:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712131520; x=1712736320; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ixjc/2duOe8tMNsDFapztE6WZpMRR0IqMx2Riyo3ljE=;
        b=W+KMdA1zN92nznVkmBS5qoyAYnwcohD253wM/kF3b9QSWXmpe+RWStWGTI0sTvuZdb
         i1pj/C6yOZkMCvKLDsTyslVYZi2k2jDwXoS1pNt/MFFkU6BjMZLNk96lBWXv+uzPz5qU
         oKrN4Ni5M5+R43HFs4cTI752/z7m/9FuiWLOYeeLJokfIOQm7C0/TIWQTyTgbk9qg///
         ieWJq4QYMFEmVegZtadO4shl4BqajM+CiTpvjUbi1APzjltVBnQeP78ob85Pl4VLE52H
         nCYVtf0tNRT7aSH5DD6K61Tmwp5U+1BSVQzJQ+KV9frSOJyH4umyn11Ar7F3olUvAkyi
         7hKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131520; x=1712736320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ixjc/2duOe8tMNsDFapztE6WZpMRR0IqMx2Riyo3ljE=;
        b=RdtDkHjYmmZHQH6pi21EIemrOTRuR8HMQSUhESL9guFvKt48sdP+/w3PjN95Wk8r9R
         Ee3FWiVbBDf8GY7GgIYclMZ/PyniyZBGWm9Nq9CLYs2UqzYPX/ic9C+Qgr3j1fASLCKc
         OipXKsStHroatN1HsCBGph8LWcfF3ODbONcL7ZaxF4gnKcPamYkXKOwQIpFJBDDi6ejA
         nvgNDyQgtQQmZhvsVene9XDOdqC/+m4dSGjicOBcd7U5vDOEpu7yolY32blkq3usa9Y3
         7AbrHBOTAT7WrJzm67+AXp0UPxh82v7x5kaxLtaUOenwfF8jmknZrWlY3FzrxlkjlIfR
         qIqw==
X-Forwarded-Encrypted: i=1; AJvYcCWBIJEAQCFDuRMSAlagfJYes3X5/3RBdOFZ/hzTiLEaDWCVlmcbPzIaRihY07/wVUgIJWZg5EYeRiG/rGFyTnq5FsjnPjz+MvloiowSdIo=
X-Gm-Message-State: AOJu0YyduP3zhhV7rG2JAUel/YQ4QhHRhJAHTx7sueN1KzAZruBsVgCN
	Yqnp4FSI3sGmgQjp3EUh34/UrTnon8DEPqlzST1p8o/YxsIEEFouURen1Lf904E=
X-Google-Smtp-Source: AGHT+IFNP2TORKh7//FzhNMEZN9MBNitQSqhLOnah919WVqeHY+e2MYv0jsRIRUc8mtVSGHiLEDhcg==
X-Received: by 2002:a17:902:b701:b0:1e0:a1c7:56fd with SMTP id d1-20020a170902b70100b001e0a1c756fdmr13300312pls.61.1712131520248;
        Wed, 03 Apr 2024 01:05:20 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902d48c00b001e0b5d49fc7sm12557229plg.161.2024.04.03.01.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 01:05:19 -0700 (PDT)
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
Subject: [PATCH v5 04/22] drivers/perf: riscv: Use BIT macro for shifting operations
Date: Wed,  3 Apr 2024 01:04:33 -0700
Message-Id: <20240403080452.1007601-5-atishp@rivosinc.com>
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

It is a good practice to use BIT() instead of (1UL << x).
Replace the current usages with BIT().

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h | 20 ++++++++++----------
 drivers/perf/riscv_pmu_sbi.c |  2 +-
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index ef8311dafb91..4afa2cd01bae 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -233,20 +233,20 @@ enum sbi_pmu_ctr_type {
 #define SBI_PMU_EVENT_IDX_INVALID 0xFFFFFFFF
 
 /* Flags defined for config matching function */
-#define SBI_PMU_CFG_FLAG_SKIP_MATCH	(1 << 0)
-#define SBI_PMU_CFG_FLAG_CLEAR_VALUE	(1 << 1)
-#define SBI_PMU_CFG_FLAG_AUTO_START	(1 << 2)
-#define SBI_PMU_CFG_FLAG_SET_VUINH	(1 << 3)
-#define SBI_PMU_CFG_FLAG_SET_VSINH	(1 << 4)
-#define SBI_PMU_CFG_FLAG_SET_UINH	(1 << 5)
-#define SBI_PMU_CFG_FLAG_SET_SINH	(1 << 6)
-#define SBI_PMU_CFG_FLAG_SET_MINH	(1 << 7)
+#define SBI_PMU_CFG_FLAG_SKIP_MATCH	BIT(0)
+#define SBI_PMU_CFG_FLAG_CLEAR_VALUE	BIT(1)
+#define SBI_PMU_CFG_FLAG_AUTO_START	BIT(2)
+#define SBI_PMU_CFG_FLAG_SET_VUINH	BIT(3)
+#define SBI_PMU_CFG_FLAG_SET_VSINH	BIT(4)
+#define SBI_PMU_CFG_FLAG_SET_UINH	BIT(5)
+#define SBI_PMU_CFG_FLAG_SET_SINH	BIT(6)
+#define SBI_PMU_CFG_FLAG_SET_MINH	BIT(7)
 
 /* Flags defined for counter start function */
-#define SBI_PMU_START_FLAG_SET_INIT_VALUE (1 << 0)
+#define SBI_PMU_START_FLAG_SET_INIT_VALUE BIT(0)
 
 /* Flags defined for counter stop function */
-#define SBI_PMU_STOP_FLAG_RESET (1 << 0)
+#define SBI_PMU_STOP_FLAG_RESET BIT(0)
 
 enum sbi_ext_dbcn_fid {
 	SBI_EXT_DBCN_CONSOLE_WRITE = 0,
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index babf1b9a4dbe..a83ae82301e3 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -386,7 +386,7 @@ static int pmu_sbi_ctr_get_idx(struct perf_event *event)
 			cmask = 1;
 		} else if (event->attr.config == PERF_COUNT_HW_INSTRUCTIONS) {
 			cflags |= SBI_PMU_CFG_FLAG_SKIP_MATCH;
-			cmask = 1UL << (CSR_INSTRET - CSR_CYCLE);
+			cmask = BIT(CSR_INSTRET - CSR_CYCLE);
 		}
 	}
 
-- 
2.34.1

