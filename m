Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7DD13D2AC
	for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 18:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713293109; cv=none; b=DlyCffJmoOyaQEPC+4MfHGIdqV8TA4cGgLV94FD/ZQ+5MkLnDB/56JUsb1S0OdV3C15QI74T6MVLJkIq6eYj/F9TJiXo/v3WcphaO8WqM0EzYJ/msx+uRhj2+P5fQZ8ZSA26yZnLrTXYms/AItJBcoJlTBvFAYDlyX4oGCXCv88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713293109; c=relaxed/simple;
	bh=RcVsdOTpWmQDe3QFQB057eZKtxuHNPDvA9mLhc2A9Tw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AKc7Uc8sOX+zkyENFobMcixSMLuOZ7jI74X9Mbuz1242KQzrAxV+wESKaziGxNBesZl4lFTrwujHznV7GRdn+bgvdTH1kSkvuPEtpqJttoM870VuXgYndiyf+15I+sRl8Mbtjf2veT43Ugt46B6mxqQPVx0utNhwJgBuK8ux6HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=EE7cEEyC; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="EE7cEEyC"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5cf2d73a183so27021a12.1
        for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 11:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713293107; x=1713897907; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBWeKaYtpXhvKjSg+whNN/rWnhjngNSIx7A/W77I8WQ=;
        b=EE7cEEyCMJ2RYm9zlFB/x/057R3DO2DKWvrKDRUsEkMAcpiZMRNw2SxTe8W7p4pk8M
         bH5OnjvHq2x7LHRZ+GmZRkZ2zMSCYOcHGuK8ycJf6fAkDc1n8Jxt3hHTYfc/IozesZlc
         6uWMR0vq98OPH8wAnzdbgIJMFMrhKQ6Eoe66SqxEDTu5JTMoRKeGMoPnu8+EgG+W6bOg
         R7TpKCy+eWJ7JHd3Z2DXjChnSzKvatDJoheapGGohFmKkBLmST9M6jgLNUFXkqVc4reo
         58I55ItHOgwoYMsnNd0Se+ZnHOTzVPhZVXQ69l09bSkyIpQ/7YmiSuEv03JfXudD0Nh3
         Yc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713293107; x=1713897907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vBWeKaYtpXhvKjSg+whNN/rWnhjngNSIx7A/W77I8WQ=;
        b=GHT6+yEDS+gRrjaOMGIPygU6MNO1R7f1BJL3jbePS9hbGd/6IjFdHzWPnAz++SgvR6
         qioi+faOHwAmYmSbIPeKhxq5NF/VKiehGCGibvGJ9Z3BCAJs9pcVN1FTbUCKKOOkhx6O
         P8saQWBv6Fmgj/AYPvundLzijsmXSQR4kEbd7i1Fk+BElpWHuUzidDRiS0IexTonR+aA
         zYg1bBhFBH2Ym24g8vh05/OUNrcCOKSqDhu8SBVzBRnUC7z3ncm2IlCBw+MtL2CY13CU
         kAHmstgEJc9NJF8qRHACh7CXoxG11PJu02NEzDHaWQbyaIzrbgQZsHockLRSCZFY6AWg
         z7dA==
X-Forwarded-Encrypted: i=1; AJvYcCXzYgwcYBsckgGxGPbBmEDKQtAcJCE59vfjl3hbNHWQ6Q0q9kWFYd13R3zzGa5SvGnOEllzs3wATk7k0t6pTBUghBhVwQxxifSQ3l2qHkw=
X-Gm-Message-State: AOJu0Yyy5eJtkV9eUBslxHn+lIcopAqSwSbb4IZAzfuj9JHf1SpqVKu5
	wOACSvUAKHHqNJUm6GV2q4KBPbMHaMIXHSDz1nuz+komZGvsPMEevIXgbLtZuKI=
X-Google-Smtp-Source: AGHT+IEmOJnsCqKgMiSjK9JvIG/qr/zmtZv2INOC30OQkmamLtid+925iE6tPmkwso7m5t8fIgxSaw==
X-Received: by 2002:a17:90a:bc1:b0:2a1:64a:bb63 with SMTP id x1-20020a17090a0bc100b002a1064abb63mr4135416pjd.2.1713293106909;
        Tue, 16 Apr 2024 11:45:06 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090aac1300b002a269828bb8sm8883645pjq.40.2024.04.16.11.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 11:45:06 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
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
	Will Deacon <will@kernel.org>,
	x86@kernel.org
Subject: [PATCH v7 18/24] KVM: riscv: selftests: Add helper functions for extension checks
Date: Tue, 16 Apr 2024 11:44:15 -0700
Message-Id: <20240416184421.3693802-19-atishp@rivosinc.com>
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

__vcpu_has_ext can check both SBI and ISA extensions when the first
argument is properly converted to SBI/ISA extension IDs. Introduce
two helper functions to make life easier for developers so they
don't have to worry about the conversions.

Replace the current usages as well with new helpers.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 tools/testing/selftests/kvm/include/riscv/processor.h | 10 ++++++++++
 tools/testing/selftests/kvm/riscv/arch_timer.c        |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
index 3b9cb39327ff..5f389166338c 100644
--- a/tools/testing/selftests/kvm/include/riscv/processor.h
+++ b/tools/testing/selftests/kvm/include/riscv/processor.h
@@ -50,6 +50,16 @@ static inline uint64_t __kvm_reg_id(uint64_t type, uint64_t subtype,
 
 bool __vcpu_has_ext(struct kvm_vcpu *vcpu, uint64_t ext);
 
+static inline bool __vcpu_has_isa_ext(struct kvm_vcpu *vcpu, uint64_t isa_ext)
+{
+	return __vcpu_has_ext(vcpu, RISCV_ISA_EXT_REG(isa_ext));
+}
+
+static inline bool __vcpu_has_sbi_ext(struct kvm_vcpu *vcpu, uint64_t sbi_ext)
+{
+	return __vcpu_has_ext(vcpu, RISCV_SBI_EXT_REG(sbi_ext));
+}
+
 struct ex_regs {
 	unsigned long ra;
 	unsigned long sp;
diff --git a/tools/testing/selftests/kvm/riscv/arch_timer.c b/tools/testing/selftests/kvm/riscv/arch_timer.c
index 0f9cabd99fd4..735b78569021 100644
--- a/tools/testing/selftests/kvm/riscv/arch_timer.c
+++ b/tools/testing/selftests/kvm/riscv/arch_timer.c
@@ -85,7 +85,7 @@ struct kvm_vm *test_vm_create(void)
 	int nr_vcpus = test_args.nr_vcpus;
 
 	vm = vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
-	__TEST_REQUIRE(__vcpu_has_ext(vcpus[0], RISCV_ISA_EXT_REG(KVM_RISCV_ISA_EXT_SSTC)),
+	__TEST_REQUIRE(__vcpu_has_isa_ext(vcpus[0], KVM_RISCV_ISA_EXT_SSTC),
 				   "SSTC not available, skipping test\n");
 
 	vm_init_vector_tables(vm);
-- 
2.34.1

