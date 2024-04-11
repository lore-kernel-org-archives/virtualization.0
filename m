Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0F811702
	for <virtualization@lists.linux.dev>; Thu, 11 Apr 2024 00:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712794103; cv=none; b=JtNtZINjPrG2pvDvS6eZlAR4mHtxiSvOwC/bybN5J7JdliD0xgSHyzOeHpeMUxoPQD+75C8hAcrLR07YSSC5xise2XIabgbKhLUPvWPAU98oy+ESaYqjx6J6dPnT1Ri0OOvKOLa7nNnygFQDJtsA9pwwDIdihAr2ttI4ySKnsFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712794103; c=relaxed/simple;
	bh=Gs/9X2hzactn0W0hn5UFwracoeJp45KmCczLf6NHuME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aYY1AMbEo/0jW+iWeTQQ+LTffhZ0SsOzCf4M1yXniBeQqw51Fuaghz8jH5c1fgfxBDijvzJRVygHShb/e7VqiGxSNgFVkMZfaAOhNktG3h3+XoE/Vxfa+nr46GuXO5eJEUaBfx3nBBZF9iCc99MVrld/RvHFTOx8ZMiAhinbqdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=cIByaZQw; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="cIByaZQw"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5d4a1e66750so4486359a12.0
        for <virtualization@lists.linux.dev>; Wed, 10 Apr 2024 17:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712794100; x=1713398900; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0lXa0RA4+kQWkomLRJk1QW7kf666EFgaJ2j58l79bA=;
        b=cIByaZQwMfopKpGMjCWgWmbBOxrelp7D7dy23tWEtHumC+da69sI1ZdFejPRpwTccC
         4LUWL8YTPLMOXbLzkAONFu2gZi4dZhdJI2OjjL0hdoPfCngS7Wcws6HIbfWDiLkeFQza
         pebpeH1qUztek1dPdH5+5OIR1o+rbntScXQ853JUYHxwqASb9azoRkx6G2C+ufdIugyY
         ig8JN4LM5zyUAMjp9z5xcJAvlqy3HISFgbix73Xahe1gW/T3AmYvPd7gPgLKYqVPUWa2
         hW7RQG1bUFblyjAq+bP/lUFgGaPzbe2FI32evsUUX/wg8fWcxyytwHgkVtEr5cSuPd+L
         u4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712794100; x=1713398900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0lXa0RA4+kQWkomLRJk1QW7kf666EFgaJ2j58l79bA=;
        b=DoPDEGiuPB4WuBDxXe7oeES9cHfqjbbZgbeIFSOvieoGFAAWLFRDpM0W8ysVaxwtSi
         SdsBxmTPu324bPrD//1rSIhx8uKFI0piDooBEMtB/TS0ns26jTDf2tAOwxHi3uDI3bYq
         6hEi5ezuEegDWT3gp4i17D0n9u/m3rI1wpQhepR8Zsucpc0WlR8JYJu4JcDFATiyiNX6
         IfNiQszcpiJ5mGj2oda9EmLU6rA8X34SdKdmTZHkkxEhzsZv5YT8TLmqfUFQPjEiSd9N
         9LC4MhXKDdCC/2fXRaiJo6t2Zs8aapAk9n3865W+jr9QtQxSNv/6Bk9t1HuwZNhQXsnt
         BGuA==
X-Forwarded-Encrypted: i=1; AJvYcCVmAN9y01UuiC7xi0AL6pwv7NgVfKkJv00FPvCwKmXb4S87i+BXz90bi7XObhfNY6YdRKVoKGdkuk8ZrGXLjx4fjuj7ow9uW8zLY3Qz/+g=
X-Gm-Message-State: AOJu0Yy/7xeql2IXTQfdcIYvniXE2XSy0mLJZuyXOZ20vuS4P/XcjdeA
	w3r/3vy6BDy55Z1YrT+DJDjRLZgs71K4vptn8Ff3lV8aKA3nni42bqojeWmf+cE=
X-Google-Smtp-Source: AGHT+IG4zwixXE+Dj2Z6xxpk3Mi1/VNCBH2ZloMZOp3yafHfcqNRvPGneczPVceqD8IMMcr1Pkob/w==
X-Received: by 2002:a17:902:e886:b0:1e0:11a4:30e0 with SMTP id w6-20020a170902e88600b001e011a430e0mr5583510plg.19.1712794100294;
        Wed, 10 Apr 2024 17:08:20 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902684700b001e3d8a70780sm130351pln.171.2024.04.10.17.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 17:08:19 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
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
Subject: [PATCH v6 05/24] RISC-V: Add SBI PMU snapshot definitions
Date: Wed, 10 Apr 2024 17:07:33 -0700
Message-Id: <20240411000752.955910-6-atishp@rivosinc.com>
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

