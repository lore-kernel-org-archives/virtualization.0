Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7D913D286
	for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 18:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713293111; cv=none; b=bM4WWte5PF1mhx1Pm5ir3edorti3PLkzqRn0y/Nsy10Y08DbT8ZeEnRn4IQinoB2biWaP/sDZjTkaNl0TnZkRWNP0ho70HKZNA5Lon4Ysm6PRQ9zNwDdO5IthcqKK7VXl5omE9+QmI7SGQ2d/mT1kYBT+NxCCuNt9K4Rdv7hms0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713293111; c=relaxed/simple;
	bh=XaYtSkDqV2Gk6SkR/vZ7T7PA/8MDDP7ooY8/f+ym4MI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uEWhT/QOrJJxbjsOHXHJikqsRqikj7607zi1lLVS6G9dRwKyRFo6uPCKtX3XFyN4su9VifbK4u2VC1Z3JRmns2LzOVsEDd/bTX5eHWI0E1R06lgnc4NDPVYYJ6epQZbIR2hOVSNTVm4HuSFyxd4DZT5s48OcGTPbcP6tjdfd3aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=keMn7P12; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="keMn7P12"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2a87bd53dc3so2072366a91.2
        for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 11:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713293110; x=1713897910; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9soA5cn4wIINjbEEbaSFa4z0U18KoF+cjavdbqPH+4=;
        b=keMn7P12UPWw0IzQjsDaXDlmBnby61aHPTcwcKoRkw7cyVi8lzJq6foxRLqnd1qsuv
         yVRfbzJOnavVOzwQw5CCN1fYiX0T9wlC94n7FuGvaJaXLQTpxj351avekN239dKiIDU2
         p04oIxJRJEoKWZ2z4V5iH8l4+dE/3VnJDJnao8YoYkuTzVa/DSfyGxT42453Alw4lKV0
         mvmxKzzjtjlDMJN+94M0sZSkncncFf9j2lUXelRGzEzOniiIV6aQiV4D/DYBvgx14bw7
         ybxbNLi/L292SS+wIcEBqNkK4ebDtrDz2fT2JMWW2fQnkfsZ6XZ/IRbyCS4yt3DcS0kS
         PSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713293110; x=1713897910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H9soA5cn4wIINjbEEbaSFa4z0U18KoF+cjavdbqPH+4=;
        b=Ge4JyfmqW/1Ri1H0U8jVBqMH12YrBwE7ywWZQl9sC2K7n/9rGktqxX4wSLBIpzkTkL
         lsi1SriwsJ0W9muMVU2a66Tr8fJOse1I1p+HBcghl74xpRFCMSq7v56dmn6Mir9iCMsv
         lgrjokP7di+4bn9LK1SxNZ4PCbras0Spqz2TaZNxsRNfKANZt7KXSHeGahz1Iqs1v/sS
         ESWKfAIY3KaXwZy86DoYgjkg0KHOECVDs+Rfnm75hnMmJiV1RxyY/JqvEdKGTJsZvjRx
         7O6ytcCLJz4ez7UZq0RfhAqzOifaQ/ixk8jL+PQlD2quM8XSQgeC0kJWX5WYYxp9+TY6
         j0bQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7xfPFEds7K/ZH3gtTJMu+0E3y4WmQu4fyt3Lgua9taw/AF8sEpD/hFifBAS5kT8eFCOD/u702VHWb0GCs62U6ezMkS0wWZt6vdQy1+PU=
X-Gm-Message-State: AOJu0YwKEWESosRT7q8MnqOC0hHlpIHWyrgZDO4Md9qv+NQeDXLVanth
	nAnYfuA6WZZ2hBRs2aYvhmXWHo0LwpP6Rkhp5PVLDtn/W1BhAfg9NM28Wc4pKy8=
X-Google-Smtp-Source: AGHT+IHDTeNVga9tFzBdGXfnm4TEDY0Ha5j2XCWgAdGdaU558CfadIkSKiQQwMLkSusHLb3PPhohFg==
X-Received: by 2002:a17:90b:180a:b0:2a2:55de:93eb with SMTP id lw10-20020a17090b180a00b002a255de93ebmr11036026pjb.33.1713293109672;
        Tue, 16 Apr 2024 11:45:09 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090aac1300b002a269828bb8sm8883645pjq.40.2024.04.16.11.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 11:45:09 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
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
Subject: [PATCH v7 20/24] KVM: riscv: selftests: Add SBI PMU extension definitions
Date: Tue, 16 Apr 2024 11:44:17 -0700
Message-Id: <20240416184421.3693802-21-atishp@rivosinc.com>
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

The SBI PMU extension definition is required for upcoming SBI PMU
selftests.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 .../testing/selftests/kvm/include/riscv/sbi.h | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/riscv/sbi.h b/tools/testing/selftests/kvm/include/riscv/sbi.h
index ba04f2dec7b5..6675ca673c77 100644
--- a/tools/testing/selftests/kvm/include/riscv/sbi.h
+++ b/tools/testing/selftests/kvm/include/riscv/sbi.h
@@ -29,17 +29,83 @@
 enum sbi_ext_id {
 	SBI_EXT_BASE = 0x10,
 	SBI_EXT_STA = 0x535441,
+	SBI_EXT_PMU = 0x504D55,
 };
 
 enum sbi_ext_base_fid {
 	SBI_EXT_BASE_PROBE_EXT = 3,
 };
+enum sbi_ext_pmu_fid {
+	SBI_EXT_PMU_NUM_COUNTERS = 0,
+	SBI_EXT_PMU_COUNTER_GET_INFO,
+	SBI_EXT_PMU_COUNTER_CFG_MATCH,
+	SBI_EXT_PMU_COUNTER_START,
+	SBI_EXT_PMU_COUNTER_STOP,
+	SBI_EXT_PMU_COUNTER_FW_READ,
+	SBI_EXT_PMU_COUNTER_FW_READ_HI,
+	SBI_EXT_PMU_SNAPSHOT_SET_SHMEM,
+};
+
+union sbi_pmu_ctr_info {
+	unsigned long value;
+	struct {
+		unsigned long csr:12;
+		unsigned long width:6;
+#if __riscv_xlen == 32
+		unsigned long reserved:13;
+#else
+		unsigned long reserved:45;
+#endif
+		unsigned long type:1;
+	};
+};
 
 struct sbiret {
 	long error;
 	long value;
 };
 
+/** General pmu event codes specified in SBI PMU extension */
+enum sbi_pmu_hw_generic_events_t {
+	SBI_PMU_HW_NO_EVENT			= 0,
+	SBI_PMU_HW_CPU_CYCLES			= 1,
+	SBI_PMU_HW_INSTRUCTIONS			= 2,
+	SBI_PMU_HW_CACHE_REFERENCES		= 3,
+	SBI_PMU_HW_CACHE_MISSES			= 4,
+	SBI_PMU_HW_BRANCH_INSTRUCTIONS		= 5,
+	SBI_PMU_HW_BRANCH_MISSES		= 6,
+	SBI_PMU_HW_BUS_CYCLES			= 7,
+	SBI_PMU_HW_STALLED_CYCLES_FRONTEND	= 8,
+	SBI_PMU_HW_STALLED_CYCLES_BACKEND	= 9,
+	SBI_PMU_HW_REF_CPU_CYCLES		= 10,
+
+	SBI_PMU_HW_GENERAL_MAX,
+};
+
+/* SBI PMU counter types */
+enum sbi_pmu_ctr_type {
+	SBI_PMU_CTR_TYPE_HW = 0x0,
+	SBI_PMU_CTR_TYPE_FW,
+};
+
+/* Flags defined for config matching function */
+#define SBI_PMU_CFG_FLAG_SKIP_MATCH	BIT(0)
+#define SBI_PMU_CFG_FLAG_CLEAR_VALUE	BIT(1)
+#define SBI_PMU_CFG_FLAG_AUTO_START	BIT(2)
+#define SBI_PMU_CFG_FLAG_SET_VUINH	BIT(3)
+#define SBI_PMU_CFG_FLAG_SET_VSINH	BIT(4)
+#define SBI_PMU_CFG_FLAG_SET_UINH	BIT(5)
+#define SBI_PMU_CFG_FLAG_SET_SINH	BIT(6)
+#define SBI_PMU_CFG_FLAG_SET_MINH	BIT(7)
+
+/* Flags defined for counter start function */
+#define SBI_PMU_START_FLAG_SET_INIT_VALUE BIT(0)
+#define SBI_PMU_START_FLAG_INIT_SNAPSHOT BIT(1)
+
+/* Flags defined for counter stop function */
+#define SBI_PMU_STOP_FLAG_RESET BIT(0)
+#define SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT BIT(1)
+
 struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
 			unsigned long arg1, unsigned long arg2,
 			unsigned long arg3, unsigned long arg4,
-- 
2.34.1

