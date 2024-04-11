Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BEC40872
	for <virtualization@lists.linux.dev>; Thu, 11 Apr 2024 00:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712794139; cv=none; b=pLvSQaEoql5N8kFfAI/h0lHrEvN4byD1BG/ImRedGISlCUgd8hrTKS0TLHmpJM9WvHcuyUAwrWO+3dWKWSFzCGVR1nvtwck29CXdGkNPSQV1fbs0uj6ubwxRt4UYc8eHyHXhzdcnF0dURJFZwWmtSFR1kPV7+HqfgDS262NphdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712794139; c=relaxed/simple;
	bh=RcVsdOTpWmQDe3QFQB057eZKtxuHNPDvA9mLhc2A9Tw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eL6Olpwrn2lTTVyvmOLCz8jcc4w69b0c1OP6/ie4lzS3dvx7+ZCg863kn85wmhQ0qSC+oHIARrntjkDqX7ChFi0C7ANJ4PqgsTEDfDwwUswyHANVHRZf4bvMVa/MENWo0knNkzCxOA3wYpTns7FOI9efbBbOalX5xpoeO6QClAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=g1rZ4j1J; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="g1rZ4j1J"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e40042c13eso27810165ad.2
        for <virtualization@lists.linux.dev>; Wed, 10 Apr 2024 17:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712794137; x=1713398937; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBWeKaYtpXhvKjSg+whNN/rWnhjngNSIx7A/W77I8WQ=;
        b=g1rZ4j1JxyXeBOoH30Gff2UHi48lRosUQYLZoYrGTGG+Vbi7d8Tac+3IOel7otKZnX
         B+Sb9L1m0ag4fqAR3dF2AP4/UA95tvBOUQ7hqxwUZu7u++WDePsTkxlNbprgD9GdVC2r
         zxZnVGSn8cjRKNFka1kKFzVZtXji/qudh8j9xVDsla+eRc0YlEYo6xj13iIZ8gGbjuT8
         Yo+2VRSdMdaVBrVvyhn4fUSlvBjEzAl04evDR9hOTosqOrwzYcEEiMSPxfWEHEX4+vg6
         LrMRaBgUMSmzNT25FiRCuHu0I+dftHAVSAhCfFwadyecvW64z3nYg7UC9uxDiwnjgpi1
         mMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712794137; x=1713398937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vBWeKaYtpXhvKjSg+whNN/rWnhjngNSIx7A/W77I8WQ=;
        b=UO9N/lZZ8THZRSw0QKgE6nv+QA/WB/P4L7It4oQk5V/BSd+zhlV7QUfeDG2Q8VWaAk
         NEewA1ESnB5+3O22/mjWmiB74q0eRw+80We0DY+UEw+MlFfsx21beTDthCtB1auyN7pI
         2g5ET7zhGbdZNu9R/W+PcPtDqHuVYUaZz69/lw+ll7mWMyS/vZI5AUSKw3e0QB2AwoQR
         a9tn994VcySS0HF7dVK5lCVeStvVw9egod1KJYIlsYl4Bh8DMEZyJQEAhrPEaornx+/o
         kiG4mXQE5O3SFpjSKVDRH+ZELlULxg8GTD2HN0nv0cMc7pJFasTKy64yICWqrwzluktl
         VxSQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1hVMKWifAyUhFh1Y0jUTV5VvYqv6mqvx/5mhFgDTu3kPdF8g1xNNiIh+QB3bmnU2zrsGBvsGr2dBwmZZmA6YCGaBy6haaC5NLSztPtD8=
X-Gm-Message-State: AOJu0YzFcena9/dkt3x7uea/U62bMelUZo3zeeKHPD+rMjFY1WsJlob5
	ZE+mwGalVHGepCyJHLw7ZH5lWb51E6zvB+yY3heF9A8cnBexFMchdhgBJ7FmRZ0=
X-Google-Smtp-Source: AGHT+IEa3xx8oArN/IoY7wAtC3j2te3RJOs0/oMI1dFP2uB60BXEpobDgtseQKJuD3PiJcXC8QDIAw==
X-Received: by 2002:a17:902:d2c5:b0:1e3:e0a5:4cab with SMTP id n5-20020a170902d2c500b001e3e0a54cabmr5221897plc.63.1712794137419;
        Wed, 10 Apr 2024 17:08:57 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902684700b001e3d8a70780sm130351pln.171.2024.04.10.17.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 17:08:56 -0700 (PDT)
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
Subject: [PATCH v6 18/24] KVM: riscv: selftests: Add helper functions for extension checks
Date: Wed, 10 Apr 2024 17:07:46 -0700
Message-Id: <20240411000752.955910-19-atishp@rivosinc.com>
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

