Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DA06F06D
	for <virtualization@lists.linux.dev>; Wed,  3 Apr 2024 08:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131520; cv=none; b=o+I6v/Rp1ioRomuvBdngu7SaPdkIIMtvIcUrHEZXQg5xsXEsoiio5U+VtZbkVhjHD+IOfM08KjIJoK107CRWchK/lqR1W2CPKKGAYDLkele79Nl4zRT+oUDnoUl3QqzQE277VYX4bmi4Glo85vRb9Vw70RqSHQACtf8s/8ZN5AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131520; c=relaxed/simple;
	bh=5SixT0kcz+8IGtYwvZGhA9Q1KZ5SaAWo/BakwlxdqZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=novrVhfWVuhhwMWssdAOfQgUxzXZcixgEtDrxIB9YnxJ74BZm2ugK5qIGa0vCKoDtF2VZsXME9bjRiJE71BAzW5EWr/cskX6gFxBs6u2TOv+ZK6fIkgdivgFV+5C0waz5VP168sx8LQ4neno3aNQtOaEK4jGWcxjYJmBhdGkK5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=HT3oTg1E; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="HT3oTg1E"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e0b889901bso49280345ad.1
        for <virtualization@lists.linux.dev>; Wed, 03 Apr 2024 01:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712131518; x=1712736318; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ukUdwvkRaeQmBPwRJpu6uMxNPU93zNWp+RJiBVsFw4=;
        b=HT3oTg1EeDOpttgRC/Fpl5GfuCQLgreRPXKCYuNE1hSq9EbVbmkFKyXR++qohTuoSU
         0dJ3UzUnxTpjrjh/EKHapSLLNQA1ipRBl7epZj7BaVqEzcxHF+cNyELvnmvqVoPGSJex
         tF3wTOktVq9l7pykQO/OgwCx1rfIaIDCWFH7phkeCB6H272JAVv4QZx92i4tl2gqGvYC
         AuPMJtEI+XvIe0QeZNJxPqVA21dUHbaLg7M9MotcZvynqeZfTv+3L3xi3KavSuI0IaiE
         Cl29NHXXugnF0ULBmeluZ/ZdYg0MdoFdcKFMsJAphrc4dKbnwuiC/GehjJaeleVHwFhQ
         Bjsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131518; x=1712736318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ukUdwvkRaeQmBPwRJpu6uMxNPU93zNWp+RJiBVsFw4=;
        b=RK34FCQ68nUu+PhhWaJTkpSSXk4W31zqItO6nzmKaAcL7Q6M98FuBO8XGYQ05BW5Vr
         wJrEYeFlYEvxAYDov2YZmV3GcxDvZg7RYz8+bushJz0SDwtOoQul7c5RDy/9hZSNvNvv
         RSpgPsheQ9AtkWnIoS4IRbYzfhzZ5jHeAlryMbogrKBMMRssFZFj3eylfX1G1IE/RoKl
         Eb7GuIECWcRm1bjxGSzIkvGIgkXMue9ccKerdxFhaR9CUUyrYDXxQO1WJ4k9Ie5O0usa
         rMDQ9Yf382HluoHdHOJKg0gZGJfldPYA7ucoT68Cvymm0D9BK6IKQNs6S09FW3IJUjeF
         FyhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqVsoYR/aAYdr8d556F513Lwav5R0llw/Fcm9fBBD+p+Zp1ptUoWaTtYMTjp1B/MIIuZoi58sSU7h6DB93sLn0aD/49+f4tWm9GR4NQEE=
X-Gm-Message-State: AOJu0YwgABra1HSBjr0WuKxMsX9j5SBEc1vbSGY8fkzl+QH2bvOS/Xk7
	LTzz0AYTidKeDEjLRdLzKTFd/cEzlAY37FxsNHTRgiqIJKspy/Ezhgvd9vKmm24=
X-Google-Smtp-Source: AGHT+IGzCaqR/FZVf4jG8/W5aRGI+FZChKgtdmsu22b2KjgU9hzL33Vhb0robWHwzAUPtLmResHVWQ==
X-Received: by 2002:a17:902:e741:b0:1dc:a605:5435 with SMTP id p1-20020a170902e74100b001dca6055435mr16071106plf.31.1712131518213;
        Wed, 03 Apr 2024 01:05:18 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902d48c00b001e0b5d49fc7sm12557229plg.161.2024.04.03.01.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 01:05:17 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Anup Patel <anup@brainfault.org>,
	Ajay Kaher <akaher@vmware.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Alexey Makhalov <amakhalov@vmware.com>,
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
Subject: [PATCH v5 03/22] drivers/perf: riscv: Read upper bits of a firmware counter
Date: Wed,  3 Apr 2024 01:04:32 -0700
Message-Id: <20240403080452.1007601-4-atishp@rivosinc.com>
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
index 3e44d2fb8bf8..babf1b9a4dbe 100644
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
+				WARN_ONCE(1, "Unable to read upper 32 bits of firmware counter error: %d\n",
+					  sbi_err_map_linux_errno(ret.error));
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

