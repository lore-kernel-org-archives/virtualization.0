Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A154142905
	for <virtualization@lists.linux.dev>; Fri, 19 Apr 2024 23:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713570476; cv=none; b=B3ydZAN/ASoqPg6Po5spA6goEPc5Z92b+RnuxayBaREoc/bCy7zv5/5RWsjy+g6Yvls0vHhP0z0zJqVPgaqT51PAxaZlyKrOUQq95MvyH5LqMtO4wX9dubjJLZH4hcAyOCQyDWoir4eKvKxL2zB10E63scqhDGnToFj6EkXRrvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713570476; c=relaxed/simple;
	bh=Gs/9X2hzactn0W0hn5UFwracoeJp45KmCczLf6NHuME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BWMwejorlM0O6NIoS4cM/f3KP0i7HonRQFXwKT/Sm8o4KVaXfxgHLmBrHVKv6wWyzRYs8xaUI0E4MATUXBG6lMYErDqIjB4mRhq/BewU9vvFHVcvFs9j8qBj/neBuPtk/KnJg/AW8KcKbVFZIVERFXA0UGOvkVqLxoQ3/cI/Je0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Jky+5FIk; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Jky+5FIk"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e5b6e8f662so21355075ad.0
        for <virtualization@lists.linux.dev>; Fri, 19 Apr 2024 16:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713570474; x=1714175274; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0lXa0RA4+kQWkomLRJk1QW7kf666EFgaJ2j58l79bA=;
        b=Jky+5FIkwejT1WI3UfOcDFL5QExEWL+LgXoYpAEXS44C1oQov/C/AIesTqgG/kVX/3
         Wh/CJbGKKyv/Isle02rPEK+Hsd1lFVFympIaz20kYB45TcdtCjA7Kpq4m3U9ro0dKP01
         fY/c5rlr47u0Om97Ni6e+/AcOr1s7ccBMd2A1EV+kSRRSsYb/XFkfQJha1wbAesrc5u7
         G0wBdug0jRMQO6hcusTmbw8u7H6XqSvFlVuGoTg1H0pWzybAq/AiiCLJ3WflIwZppmAe
         wupFrbxrg2zuSz5nGyFAt+R2xnO4cLF7Xc+rVeZ2AeQ8OmOBKlUfIbJQhYFyo7CrVJMm
         cr/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713570474; x=1714175274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0lXa0RA4+kQWkomLRJk1QW7kf666EFgaJ2j58l79bA=;
        b=RVAooyv4wJ4ykoJmrnoQqL3Uq4x9r2FlMbnDERJBnquIf4O2aWTXc/Jd+84XLDaONx
         40jG6ToRXba5TAKC/XMssuXsD9da530D8NRj+EBt0jPivdkAUTYy7XWYg4UT43vtDjcK
         Zfcr4GWRsSanz1JEDl/IqPJenL+Tbh8iovhydt/qge2N8vsrqY5IquF9o6HhqUBtz8n3
         3MA0DpUbijS04vX9X/14vfJOEI2t0zn/C9j3Wa5z5QNt4dYy+FKlUggqCQDHKB8d5i5E
         4B0Cw0ncUmSwcczBh+DbzRbgirvKP7P7VwjrE4BWbXsKEH5sLcdkw5e61ggnZR/yUMeK
         CGgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFFIN9OoJ52EC4Qzk43Rz4KPt2eVE6X/rRs/JpGT+fHN7dCZ2MjB73aMVCgh4KEMA8x394xr9P0qSU8UIU++xaDUgoPwiKQwo3C+pDu84=
X-Gm-Message-State: AOJu0YxSFyvFVlMU8g6shHglLbp58YpK7dlmofZQZ1AbSfd8DvQ+UZBI
	d2wRYrLC1g7nYaEuqFHfw/qAWfvXizP7Lu2FbGzKRvulSaviku/GlgkGeNBKu3o=
X-Google-Smtp-Source: AGHT+IFXaW6wZywudrszg7M9K7pzeD0F1Y92Mkq1wCwVh8jMOhVOOMocPyY8L0Q71C8UhuUv6rBj9Q==
X-Received: by 2002:a17:903:120a:b0:1e4:70d0:9337 with SMTP id l10-20020a170903120a00b001e470d09337mr4759283plh.45.1713570473875;
        Fri, 19 Apr 2024 16:47:53 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902d11100b001e42f215f33sm3924017plw.85.2024.04.19.16.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 16:47:53 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	samuel.holland@sifive.com,
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
Subject: [PATCH v8 05/24] RISC-V: Add SBI PMU snapshot definitions
Date: Sat, 20 Apr 2024 08:17:21 -0700
Message-Id: <20240420151741.962500-6-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240420151741.962500-1-atishp@rivosinc.com>
References: <20240420151741.962500-1-atishp@rivosinc.com>
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

