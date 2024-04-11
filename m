Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D041ED2E6
	for <virtualization@lists.linux.dev>; Thu, 11 Apr 2024 00:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712794097; cv=none; b=KvcI+4zGSEOsoVMTnvvQpsCwT3wyNfXmZWATVNYKUJNxvo3wIvbaCG6FF1ZCMEs8TifZ+Nxn1IOEWDl95RnP0rlfNcA1zU6B+aCTdpWFGANwNw0WZ7S6961YwSF4he2449amCl3I9sew3TxJO8xN/nNzaVJ+Aam/oxi3QYjEH4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712794097; c=relaxed/simple;
	bh=PCH+9nz39V3BSztS1z+ZZiAV+qP9h7YwF5oYKnRz76Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SEDLe90a+M0MJ5IBapGXHmEjSWrw8W7sRT1qtHVME/QR8f841OipOPMs3CByKC8Zws/c+Zbdu5C1BrQpIK6AVchzIpnIpddPbG3Fc10SNYp6vyv3w94/+rTGnKK9OX6NfkyyYTvue2ENf3AeE5RHfXAlNx/JjtJ+61je8Gs1lo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=RjEWb8VG; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="RjEWb8VG"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e3e56c9d2cso38854265ad.1
        for <virtualization@lists.linux.dev>; Wed, 10 Apr 2024 17:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712794095; x=1713398895; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUdjqPblbE6Q25Ekp/l365V3YEPrpPkLHh57fhpvEHQ=;
        b=RjEWb8VGIybeiOK3C/aoWPu7XfFZrvoOqDea1C7CzJe+wd9Y8eB0sqMWBVdgva/Gok
         jo/q+ACKOP8mgb/fNheJ2dWBN9ax3mVzijPAqhcDB4u15CBYyIf0PENIXp+mgj/pG1de
         4oOMnTLrCxHj62ndDhjjfCaYcZPI5yAiNczHyu6hAJewW8GAmM9MEjgSYiAKLqSn/SVq
         Bh/q19iqsxNtgQ0rq2GtThbxJiypNy7roC93HfphisEl3BfyO0aHm6g1LUgDn0vcpcdx
         6axeeAA8F6UBqpzFzAWe9FDECjCMb/XeRQ7tKSTRjKXhHpnG8sUHjSpjeAtaGM8b0cO8
         9SHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712794095; x=1713398895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fUdjqPblbE6Q25Ekp/l365V3YEPrpPkLHh57fhpvEHQ=;
        b=L+RtywHemRQXwigzX8XTnrdwxFY0ws36wVI+mLHDsJoFvuh7dJ/nKH5SpiRBtsoIPb
         cs5mDuFPQIrUSDXzhnUTKlKj6bsja7RpQ6Y97/WsFV7C7C7aTQ/TuWuIUi39M1C5HIEZ
         1GPyVc5z7xavTdg2WdUhZMgOGP740xhAH+gU9ejANJoM8/OwE4fikY/2AuFi3lVHg3bO
         pXbZhQGG/Wl/5pICj3/HcRRSp3nuNcxltz50Mm/RWppb0A5ZvnbJrrIMjK/g8V7Hs09Y
         GQDlUEUSL7TabHVEx+cJ3c128jFGQJoDmCBAftJVQqb3NxYUW3AswbFxqMn59tyDiLhn
         PF6g==
X-Forwarded-Encrypted: i=1; AJvYcCXGWxl8ofFhFDbb6L74uA98lDzZ9PrScjFIDr0VfrhlGXHcqNqaQUrlW2+9WS+l3BVsFjc1X3EhAP2Aumbp84mkC7vO+etOl2WtOlKTzCk=
X-Gm-Message-State: AOJu0Yw6YFUuVFqJl9osXYbKrBNtpiUdRnfAzJw7oBkjS+dfLfPLu/Op
	pAV03oMh1sR1fOEsRNin2XgtduG0wKhvZS/DkpXKj41TAaMEgdfop+Od1lpeWo4=
X-Google-Smtp-Source: AGHT+IFIBD1SOaWsgt2948dyeKGyG07Tn/ktfC4uoEXfuxeDgccQR9pNsvZjwG3GwFp5aB5INBJAQw==
X-Received: by 2002:a17:902:7618:b0:1e4:fd4:48db with SMTP id k24-20020a170902761800b001e40fd448dbmr4188157pll.43.1712794095332;
        Wed, 10 Apr 2024 17:08:15 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902684700b001e3d8a70780sm130351pln.171.2024.04.10.17.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 17:08:14 -0700 (PDT)
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
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
	Atish Patra <atishp@atishpatra.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
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
Subject: [PATCH v6 03/24] drivers/perf: riscv: Read upper bits of a firmware counter
Date: Wed, 10 Apr 2024 17:07:31 -0700
Message-Id: <20240411000752.955910-4-atishp@rivosinc.com>
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

