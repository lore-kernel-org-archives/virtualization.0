Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA047353F
	for <virtualization@lists.linux.dev>; Wed,  3 Apr 2024 08:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131526; cv=none; b=aMY7OprnWkDKfmr7Djt0h26ckdy9kkpTxAtchCEWr1QHH266cvfDGqAPTMaXi6n0hihJvnOnYD6JHcaOFiLPqZqBQRu5J7kMuv7kEdv6mp8+/ZhR5ycC5YQjDUd0Zr8kKqnMDTIUtrLd9E6kJBbpLDoWnin/4gsSpJyVlJnUix4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131526; c=relaxed/simple;
	bh=hD4T8CbQGFqb30M4m5Qq8QzxJC1eOzrHV+Z0kwBj2NI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b7hAt/ORdmFzVlEbKAZysk51yjnrEvYF+4dWbkzoWbOTAi9UUwYYlim2a9hb1INZfPCXNICNELzlyss2U9lL6ZDyv+olAgQv9X7/mGd1azuJOZgOQrzrPI1rU0KeCrHLeFH05gLBgt6b5kkoG9nMFKozBW/tj750DA+xgaABqbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=VzwpTT8t; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="VzwpTT8t"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1def89f0cfdso5305575ad.0
        for <virtualization@lists.linux.dev>; Wed, 03 Apr 2024 01:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712131524; x=1712736324; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cY+c1Et8e4Cu0t4snI2MWrn2141KaT0UNrXkfFbuJA=;
        b=VzwpTT8t9l/MHxA7fvjuJ5ZSm3AdsmJVbFoqb6758kb1CGkGAkILSoCxQKIl5/NINi
         Sh4buO0M4xhNo9Vz1Ag6ri+ZReMkrQLzMIEiR1BMpIi358fHHoyxWR4Z9POcn08jthfu
         aWquAQL9BZbXLqZ8MvB5phDdia5BKtOGzXg/h/WoaCPg2Ge85MwblcafMjiTWGj9FWJo
         QJh0/MRCsJZDYtRrlvcRkNlQeJQ1nlMLTvVFvEP+J/Zeb2e/4SPTgaDE36wvjbx/IcYS
         fIZHoOLQEQoYgcz60oBJX/MJxk6v3sknUlCe3oXeVXWas7llWUbf54o3wbzJYSYAT6eG
         pUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131524; x=1712736324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cY+c1Et8e4Cu0t4snI2MWrn2141KaT0UNrXkfFbuJA=;
        b=vbepyfGtVzoFJGBOzjNFhnh0Rxc18kOKvEevcaatAH10gHDgjtgTWPL6U2fIBzCp7b
         xSOedTs2lTByfXrHWqhNw4kNzerj7X3tOnixd1PPlQ4F3PC0BCmH1uuG4ymO+Fv2Kh8y
         Xkfz9wt9H2lBM/oFAbhrpMzHf1mPdf1YRkocIKApmkztskIW6lwk4qSa4Uy/usqSCMoL
         Qk8PyEqoR/kxLguao34hZalImyOwK4dYf/IwEIasnzWSpnbKrVkyZvAGrsP66B8lLiaG
         SaFbTGy6zd+qnIDJeVUGUS/w1VevkwThL8AE/w79yJigvrDMRfovZullcga2sARU+V6l
         ecGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXi4j3AIJ/w6qtCdzEZshbSocmqWNX+xiov1kvrP21jlf1byHaiG7LpNOf7B88BWXV11WryyDCVcKVrZo446xX2xniH3RlB2faQC/WQyP4=
X-Gm-Message-State: AOJu0YyrpCEmZ+ildeKCvM7RckKEPECRi/diKYFK2J82v0dmDe4ahdEi
	iKzR37ExA//8jQfIusY1TR8ZvL7G1Q6e8+/cXUh4qvpD71yt3bsz4Ph52GnLPYg=
X-Google-Smtp-Source: AGHT+IFKoJgtWxPYCEvG4otnYA6GehE6Ju467AMTWra/Y4iLfyYQ+vCfm0Zt2yPKMvFR+PhSvC1EhQ==
X-Received: by 2002:a17:902:c412:b0:1de:fdf2:b483 with SMTP id k18-20020a170902c41200b001defdf2b483mr2836035plk.8.1712131524245;
        Wed, 03 Apr 2024 01:05:24 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902d48c00b001e0b5d49fc7sm12557229plg.161.2024.04.03.01.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 01:05:22 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Ajay Kaher <akaher@vmware.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Alexey Makhalov <amakhalov@vmware.com>,
	Andrew Jones <ajones@ventanamicro.com>,
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
Subject: [PATCH v5 05/22] RISC-V: Add SBI PMU snapshot definitions
Date: Wed,  3 Apr 2024 01:04:34 -0700
Message-Id: <20240403080452.1007601-6-atishp@rivosinc.com>
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

SBI PMU Snapshot function optimizes the number of traps to
higher privilege mode by leveraging a shared memory between the S/VS-mode
and the M/HS mode. Add the definitions for that extension and new error
codes.

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

