Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF9C139584
	for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 18:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713293091; cv=none; b=tw4Tg4wnrBiail2gJynjdBaoNPyQhjsVEXR1D9ajCE5F/Cyqfssiqhrvm9vFodq/uD4bGd1zmKIQG/zVvqlfozzUsqKlUfLRI8Nh6nYfOYr4TTaTAMeJMEs5YZhEIdd6MJR1R7xajdMPwkYn93Jc/ZBw/rubYAlCOxDXICtQd8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713293091; c=relaxed/simple;
	bh=Gs/9X2hzactn0W0hn5UFwracoeJp45KmCczLf6NHuME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OG+ZLmMIKl01ZCQXnyqTNbE177zyJI6xRGyNAUMrJh6O7StcV9aXcRcdb8sqCJaARo8y5EuE2YT+ub303RFrEL50kL/OuLB5u9vo6MI+OsiqRONL0u3BFrDWWaEOQmaRefLnzxeHO6axm7JYa0l69C2GCmwuRStHMs8q/8INYHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=R5hmLDXb; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="R5hmLDXb"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2a2e5d86254so35926a91.1
        for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 11:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713293088; x=1713897888; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0lXa0RA4+kQWkomLRJk1QW7kf666EFgaJ2j58l79bA=;
        b=R5hmLDXbehiTa13LfGBQ512ha0E8X7pToykmLGn7scTaLKQPqPCsU9zQvxfL35FGL9
         s4ZSn0NPyom0QNxyq+z+AcHzvvoZ7xKQ6H2lFRy40T8vmTAXJtTEQMiNUanWKpQkUvHO
         V9UL8ry+QNq+aVtd4rAgVwyAjFupsz+Ua7B1xKGa1v1TV7knu8vGuYl+mhw5rFAz2rKQ
         vt7ZoXK/2BxbeTxJMJdtL90HdGxumdzMzsOvirju4IcYoE+8yNyrUo6qK5DZ7MsQyPiD
         HC/tFfI43AMrvixDpRV7Ea2aWA8TGg6y9T+NT1JvouZl7UzDiDRb52iMhL8/kv60mRuk
         J1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713293088; x=1713897888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0lXa0RA4+kQWkomLRJk1QW7kf666EFgaJ2j58l79bA=;
        b=b75GVo6zuzckWi1bri7CCysCg31kJ2r1mdWI/h9hhU+KkboZs4idd4Um+47HNiZXE1
         5FZMEoWUFzm4lkCMZyXnh9QoFfm2ct8lz+R+RI1uUkM5A9PpwaXOQBpjoe9fSzhE/O0K
         3LXZq3SVFw/dqdN5BoEFqrGfVaWRZOwGWIYYwgHBth/au5w+yJRH6wkjzCEDn2ncaILx
         T27yw77k3dPzV8PKuliqKHPyFS0AuPGeaT9WWWslg3A2m/rjqBXpG+aQKI4f4AZblanL
         iR1Z48JiJdkFnHx+VK2vrhBbT11e0+3xn4ZgnJFGigEm8ZGGws61W2vONoU643SeJKNc
         WN+g==
X-Forwarded-Encrypted: i=1; AJvYcCUFLAEH/ADhoDjnI+fBOjYhgiwFwIlASrJe+YGB+TWFSEqcY07hIdzB5BLOaqQuNpgcR/U+RvEsc/EIwnDK80bKkIa5Auod0NyFZbLizgU=
X-Gm-Message-State: AOJu0YzPdyBKMnn8RzSthlIrg3Nb4jshA3tL0n2V9ND47df4d2TCk6PM
	eO5PwDl0fwJ2kEPEda60fJ/mG9Z9LM5jGcc9cxeaI4+ocKARdhAe3H4yOiG36/4=
X-Google-Smtp-Source: AGHT+IEy4ZrQc6VpWHcofWnBnFX841IYpr0DACATgSN6h23DP3YRcVds0NngKjdBNkuEvrMjPFCw+A==
X-Received: by 2002:a17:90b:4c8e:b0:2aa:b56b:5bdb with SMTP id my14-20020a17090b4c8e00b002aab56b5bdbmr3174156pjb.9.1713293088546;
        Tue, 16 Apr 2024 11:44:48 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090aac1300b002a269828bb8sm8883645pjq.40.2024.04.16.11.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 11:44:48 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
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
Subject: [PATCH v7 05/24] RISC-V: Add SBI PMU snapshot definitions
Date: Tue, 16 Apr 2024 11:44:02 -0700
Message-Id: <20240416184421.3693802-6-atishp@rivosinc.com>
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

SBI PMU Snapshot function optimizes the number of traps to
higher privilege mode by leveraging a shared memory between the S/VS-mode
and the M/HS mode. Add the definitions for that extension and new error
codes.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 4afa2cd01bae..9aada4b9f7b5 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -132,6 +132,7 @@ enum sbi_ext_pmu_fid {
 	SBI_EXT_PMU_COUNTER_STOP,
 	SBI_EXT_PMU_COUNTER_FW_READ,
 	SBI_EXT_PMU_COUNTER_FW_READ_HI,
+	SBI_EXT_PMU_SNAPSHOT_SET_SHMEM,
 };
 
 union sbi_pmu_ctr_info {
@@ -148,6 +149,13 @@ union sbi_pmu_ctr_info {
 	};
 };
 
+/* Data structure to contain the pmu snapshot data */
+struct riscv_pmu_snapshot_data {
+	u64 ctr_overflow_mask;
+	u64 ctr_values[64];
+	u64 reserved[447];
+};
+
 #define RISCV_PMU_RAW_EVENT_MASK GENMASK_ULL(47, 0)
 #define RISCV_PMU_RAW_EVENT_IDX 0x20000
 
@@ -244,9 +252,11 @@ enum sbi_pmu_ctr_type {
 
 /* Flags defined for counter start function */
 #define SBI_PMU_START_FLAG_SET_INIT_VALUE BIT(0)
+#define SBI_PMU_START_FLAG_INIT_SNAPSHOT BIT(1)
 
 /* Flags defined for counter stop function */
 #define SBI_PMU_STOP_FLAG_RESET BIT(0)
+#define SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT BIT(1)
 
 enum sbi_ext_dbcn_fid {
 	SBI_EXT_DBCN_CONSOLE_WRITE = 0,
@@ -285,6 +295,7 @@ struct sbi_sta_struct {
 #define SBI_ERR_ALREADY_AVAILABLE -6
 #define SBI_ERR_ALREADY_STARTED -7
 #define SBI_ERR_ALREADY_STOPPED -8
+#define SBI_ERR_NO_SHMEM	-9
 
 extern unsigned long sbi_spec_version;
 struct sbiret {
-- 
2.34.1

