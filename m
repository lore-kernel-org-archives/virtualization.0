Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA83140E40
	for <virtualization@lists.linux.dev>; Fri, 19 Apr 2024 23:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713570472; cv=none; b=rBDwRsmw0/1Fv4Agv0YXuKL9JWLl3/H6gobt4/gxRwa+RMThuR23RLR/eLjUA0rlJ2fL9BrbSREY5AZhEWIpuKayLJP4dKxb5CmQCDjTfKOKm0SsuGM3r4Qetx6AE18lUFwz2RieTBS0xf7PqhJ5Unz07BPlcgt3dPkeJLpGpqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713570472; c=relaxed/simple;
	bh=PCH+9nz39V3BSztS1z+ZZiAV+qP9h7YwF5oYKnRz76Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lf8D94a1gIyXJnVau5hHJKKwkdXX9zy7Q+KEASOj9cvaUdTx9YSiLa2kGg5uuPv/1H8S/Uh/z3/TJAoVER1MHiCaok3icoOROP/R7OahD6nl9my+WAPbsmvH4v09TGhEiOS9r0aWSQ5F00eU0s+Odwkpux4qvDUb5BjsZXYewhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=b0xVDn3q; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="b0xVDn3q"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e3ca546d40so22550235ad.3
        for <virtualization@lists.linux.dev>; Fri, 19 Apr 2024 16:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713570470; x=1714175270; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUdjqPblbE6Q25Ekp/l365V3YEPrpPkLHh57fhpvEHQ=;
        b=b0xVDn3qvhtlMVp3Z7o0M9YokxHzmormruxE+tVU02ItCMNzro7FuhTGUQKj6La7Qd
         rXqwvcGqcPcwgVOFDteoCzyfWUOBtajF7UFTUg7/55bdbPr/VHEOmFyy9feBPDRYCWZT
         TCTKiqxJw5E0VanvJ77pC595hu/+K5r3rHPTI959/QsGoyxv7fSgChmo47nR42yDnOwq
         AML6n7+4Y06hTpve22q5aFcMgD360UryvwDUu0oGB2Uw7CG5kdSXml7POwXPUje0ZwUE
         dY7Q54zVToPj5l+ruGjhFWKULX6D7ZD5gZOtRcQt7EoNZ1V89cPo+o+VPKZetlp4a//s
         J6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713570470; x=1714175270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fUdjqPblbE6Q25Ekp/l365V3YEPrpPkLHh57fhpvEHQ=;
        b=cJJA/mloxltSPYNT4rza1g1wnRD5Goiy1yK40V4Z6Dnin7x9LpqKKMLmUOFVDCAfA3
         hvrZrw3/tkpN7RUU6eWCcJ12yaO+gIyzzVfxaRZA+IRigSIIs8tL7QFX7StKnfMaaoV7
         /vrbkt2fsZwxx9nfsSzEQOo21OWUZd8ziy1o/fggAlSrV1JQv9yXQvyLuT11Nngd9Qkj
         UYIpqnMf2VH7b/XZiNaD3pu33E4IGXoDhCxPi+HH9KQwCWbZhcnSziub7dvK5AqWSBeQ
         FYbXf2//NhP2txG4kmksfmb3xSgs649oZRYoPxD3nNNXq6Kopgv3Djl6jzvbijvBK43m
         yr9A==
X-Forwarded-Encrypted: i=1; AJvYcCWVRjTlH4BiCKvO5I6/8V6VF5PWZoMYXs9RJ4H14300KExPl4ZDFaWmf+dyrsWIzKQoWNm/2XvzkjoYqGKth5I0z+KrxxtpyRPxuZYuhs4=
X-Gm-Message-State: AOJu0YyCjioIo4UX66SAy0um1/PQtSg6vB+ypwqHcz7iFNThtWBN6O9R
	kGoHpND+NxShkg85Q2ewHklqRSHE6enMbhZhpQczs3AJN5lmd/r6h5ijW1/rvbw=
X-Google-Smtp-Source: AGHT+IHHwHHNr57vk6UY+3yPVXMTfYgGKJY/BylkfQbNFTOXtEPd/o7PF2mQkqkaeyzxGO6UPPizVg==
X-Received: by 2002:a17:902:ce85:b0:1e2:3e7f:3b08 with SMTP id f5-20020a170902ce8500b001e23e7f3b08mr4580616plg.38.1713570470144;
        Fri, 19 Apr 2024 16:47:50 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902d11100b001e42f215f33sm3924017plw.85.2024.04.19.16.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 16:47:49 -0700 (PDT)
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
	samuel.holland@sifive.com,
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
Subject: [PATCH v8 03/24] drivers/perf: riscv: Read upper bits of a firmware counter
Date: Sat, 20 Apr 2024 08:17:19 -0700
Message-Id: <20240420151741.962500-4-atishp@rivosinc.com>
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

