Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B5FEEC4
	for <virtualization@lists.linux.dev>; Thu, 11 Apr 2024 00:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712794100; cv=none; b=Fu0Ft3a2JwJakZ3Ak1+l1RIn86B194EReOnfGib003aH5fNLXPpdlE1sZOU6Ofxt/8Y2s4DxKctwdb5p+jl0y9flqYiGVOxvtoYuGGeKcgYA3NUF5m+lCO2ICxEbQmhe0HziorEM0PMid9jVu5yqTcge1Um0uDb8qxrINN7ov44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712794100; c=relaxed/simple;
	bh=J8TrFuN//G6PmUvmCaqpAzaTIpoKbVOHs/yKTawHfLc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rcXmjV2K6CaQZPM77DKgpSG0aHBrA2dBIXivP+OMfhAb49wrnDQipvOCEFMtKOCozcEyh4UbSr8t++DW1z17DLhjo/EwUc7P9qJDAgaxE64vv5mrGlBpsQLCzVNb5JyCgcitjBVzniMgcrNFdKKVUQ1AJE2X3K6oAK/zUIBN4So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=RrVugeDO; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="RrVugeDO"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e504f58230so8950135ad.2
        for <virtualization@lists.linux.dev>; Wed, 10 Apr 2024 17:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712794098; x=1713398898; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITt+KwUVR5JlR3QMHjofp/8j27l4zwoSN907Yn7Ybbg=;
        b=RrVugeDOUireR+l6+Ig2L6s45ym1hDd7xzvbBAA9CwDmR35VwWMkoKeRM5UlJuq/pe
         94UgbynF37byRAIW4goOPHW3BfpkrnTOaA+Qd8Skxg4ZBvc4TKTMvkKoQdR3hxyBw0P7
         rJPuPDtxR1Mh2A3NoKiZwGg4M46m/IHNNYMf0aPVkhmkOn771lgcee+fd5hdCaVwa5TY
         PwgrCgBPHLL6y9chxLKfXIrUn16jfVu6kmYDjJkJnsVO7YY2ojIYPIA/is9EQCStmcfj
         fUe+cJqBBL4wvj0pg3kJ0OG2YwKw0WdhJwXtCDk895QZcwBPwZsGZPrO6MdgTHMrVx7J
         C1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712794098; x=1713398898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ITt+KwUVR5JlR3QMHjofp/8j27l4zwoSN907Yn7Ybbg=;
        b=NnH9TbldRGLI9eKZTXMVKUyU+4bEl2LiWZz1qeBlgRrWID+8EJQEQHE05OMTBuiDcn
         Ta9UatfQaylDydifDXFHOLTxns8ItHGrsY3+Z2nww6FyF86hGVcsvIARWED4vvLc4DV1
         InKnDMvLvtQuGcvu27TogLTBIiw4LEIAkH5liG7xbpxSFs0MFBKberyVygjgJIyIBxoQ
         7+tvnvNnBPAeQSCCHK+lmlUZDeCesqMo2U9h0LjJGIqTVCXXMDDqWmwc5ddjF5sAG10U
         VPPUUrWkqtFobyrIJ38qRqCtUrBUo3eV+7x7m0BqM9B7Cl4YoDprxvTgli1Hy7BFHocu
         bmlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUo8U7WNfsn4y5ZaAqBhUErnFDaxvKglLf2J13i7BRDphyDjNE/q2HJrmn2EoVtvc2NI6XubV5sjdeTHaE/e+K8bOe2G5t5IzX9HIiY/VA=
X-Gm-Message-State: AOJu0YztnVy9eOYAkceoLcMxOybt0GxCECrPwAeIjoGNtPjWzu6OXQDq
	sRQguRP9IgMFAJAvil7xDyP2/0OmFjwkD1g4tFQYaWRXbfINqXv0++BGQwmqeuo=
X-Google-Smtp-Source: AGHT+IH+Fv4XZX4/gx4XiswGPlN/TrMeCjxrmPnpJT+OZm0Rkqi3ood4AZl0My6G2DmtNin0INwRaA==
X-Received: by 2002:a17:902:d510:b0:1e3:c610:597d with SMTP id b16-20020a170902d51000b001e3c610597dmr4245035plg.60.1712794097994;
        Wed, 10 Apr 2024 17:08:17 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902684700b001e3d8a70780sm130351pln.171.2024.04.10.17.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 17:08:16 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
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
Subject: [PATCH v6 04/24] drivers/perf: riscv: Use BIT macro for shifting operations
Date: Wed, 10 Apr 2024 17:07:32 -0700
Message-Id: <20240411000752.955910-5-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240411000752.955910-1-atishp@rivosinc.com>
References: <20240411000752.955910-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is a good practice to use BIT() instead of (1 << x).
Replace the current usages with BIT().

Take this opportunity to replace few (1UL << x) with BIT() as well
for consistency.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
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
index 1823ffb25d35..f23501898657 100644
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

