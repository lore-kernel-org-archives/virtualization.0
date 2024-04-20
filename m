Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D1E142E81
	for <virtualization@lists.linux.dev>; Fri, 19 Apr 2024 23:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713570477; cv=none; b=Pky5ePE1GAAhgeVWUMR3arS8c/gOrD9fD+QTyRTuadIapRbwJoqzxhD81yRR4dDVjeyFpfjTwElmRtiJ4U1XYrKbQNctdMIrff+ILvXPs//jcUZbwIzUO2dkcRSPratmONo9TdrnNGeq/tFio2mjAKcioxk5wLAg+Oa+d7KgJLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713570477; c=relaxed/simple;
	bh=akgdKSazpCJozBL9deA+0ximAc5a6b6WW9ag1TZQiU0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TE7G4+H9qAXBqxwU3PSPkuWS0FQWWlD5eUa10ibAhyP8xs3+IQqEo41sw38/P707WjvKq5AHkhWwIQUHm1oF0XcvbHIX6IpqU3B5iqawiA4OsVl3n/EvDeHIY226404bUPaeVoPsk5GJf1pxFzZAtv3O0XcHpdQWg3gIWhEKdEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=e32ltZDV; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="e32ltZDV"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e504f58230so23820715ad.2
        for <virtualization@lists.linux.dev>; Fri, 19 Apr 2024 16:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713570475; x=1714175275; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkMvEzo278xPIa/MSXztYs2ivQ6wYMeKBg/aNDTTbzU=;
        b=e32ltZDV2qkqNNoNqYlGddCu71HJqZXurjr6xxUzBQveIQxo8djWaWE7E89QBFEc6x
         LmDQ6XPRhiLuDisazCi9lCzQ0/MYpb0XNJF2nFh0SrdA1Maphaz6ju3hofQ9VNvwuO0/
         cJWXIRnSVv+f6KWv9dOD7dglkKj2dMy5PSyCuIYKVF2WLCP6KDaj7GXfssPSy+WsBtG7
         g5011G4ZsYSMs9KGnJXtoI3uLHLjJcMXusu0RlaqD/Muj7Y3hE3fhOLLCq1uAFawa5dr
         G/WLk5KTE6s//QuRX1vmOB/8sEemStXpeaglwXIGVqlY5mSi/nqqk5MjZnuuaHa8YUXk
         kyEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713570475; x=1714175275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CkMvEzo278xPIa/MSXztYs2ivQ6wYMeKBg/aNDTTbzU=;
        b=CF7WbNidBgJRgUj81S4MP+fbMrGaMKKvZJjyrXsXPLapGdtncqfd3TC5ysodwL/9aA
         7xI/dE7+nLQ/iJoYrRmhkWOoGul5pH9T/osRcniY4eple8/4cL9p+q0wT+R+kEmzb4Ze
         f0v3qhJ38F8WFyBask1jydt8Ris+/lxdi6UeG0IHiw6+eloWnrgbF81PG4x9XxA3cymf
         DqgxjQi9y/+NYag+6oyc+h9M+ek/IZBMQtslpOsWi644jl6W9DdnfDmWqlBvTEaE4qaX
         BWRYSozLjWhAZv3awdn5N9ntWEPNzwUeTgDeDPbL3qSejtDs+Uzj9mtHT2dIVgfDnhiM
         Rj2g==
X-Forwarded-Encrypted: i=1; AJvYcCXpj50WorbVyqDAKwlp8PaQqTkFPnGhDFbd+rXi1ZxVRLmiDILKUiivUlULofZV6okyLJrSj2EqspcaHmE78dvGwi6i9KdMLGxbBMntZX8=
X-Gm-Message-State: AOJu0YwCeXofsbfdbCwXh8vlU7kvQs1N8xZyAnXJtYYMbVm2kj3Oylnh
	QGf34uc6QecFfu95ohW8A8+va9ieFOKSnYu1xYKJ3wxzE8giGi3jj4WE5c/R3wo=
X-Google-Smtp-Source: AGHT+IGEcLDoOHIz9L/25Y8tUwRQ1QjkAgk02ekGmfUqzvYD+khJ3Bpko7abF51ab2s/Z4NznTgSOQ==
X-Received: by 2002:a17:903:4294:b0:1e6:1a9b:6d24 with SMTP id ju20-20020a170903429400b001e61a9b6d24mr3578224plb.30.1713570475638;
        Fri, 19 Apr 2024 16:47:55 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902d11100b001e42f215f33sm3924017plw.85.2024.04.19.16.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 16:47:55 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
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
Subject: [PATCH v8 06/24] RISC-V: KVM: Rename the SBI_STA_SHMEM_DISABLE to a generic name
Date: Sat, 20 Apr 2024 08:17:22 -0700
Message-Id: <20240420151741.962500-7-atishp@rivosinc.com>
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

SBI_STA_SHMEM_DISABLE is a macro to invoke disable shared memory
commands. As this can be invoked from other SBI extension context
as well, rename it to more generic name as SBI_SHMEM_DISABLE.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h  | 2 +-
 arch/riscv/kernel/paravirt.c  | 6 +++---
 arch/riscv/kvm/vcpu_sbi_sta.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 9aada4b9f7b5..f31650b10899 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -277,7 +277,7 @@ struct sbi_sta_struct {
 	u8 pad[47];
 } __packed;
 
-#define SBI_STA_SHMEM_DISABLE		-1
+#define SBI_SHMEM_DISABLE		-1
 
 /* SBI spec version fields */
 #define SBI_SPEC_VERSION_DEFAULT	0x1
diff --git a/arch/riscv/kernel/paravirt.c b/arch/riscv/kernel/paravirt.c
index 0d6225fd3194..fa6b0339a65d 100644
--- a/arch/riscv/kernel/paravirt.c
+++ b/arch/riscv/kernel/paravirt.c
@@ -62,7 +62,7 @@ static int sbi_sta_steal_time_set_shmem(unsigned long lo, unsigned long hi,
 	ret = sbi_ecall(SBI_EXT_STA, SBI_EXT_STA_STEAL_TIME_SET_SHMEM,
 			lo, hi, flags, 0, 0, 0);
 	if (ret.error) {
-		if (lo == SBI_STA_SHMEM_DISABLE && hi == SBI_STA_SHMEM_DISABLE)
+		if (lo == SBI_SHMEM_DISABLE && hi == SBI_SHMEM_DISABLE)
 			pr_warn("Failed to disable steal-time shmem");
 		else
 			pr_warn("Failed to set steal-time shmem");
@@ -84,8 +84,8 @@ static int pv_time_cpu_online(unsigned int cpu)
 
 static int pv_time_cpu_down_prepare(unsigned int cpu)
 {
-	return sbi_sta_steal_time_set_shmem(SBI_STA_SHMEM_DISABLE,
-					    SBI_STA_SHMEM_DISABLE, 0);
+	return sbi_sta_steal_time_set_shmem(SBI_SHMEM_DISABLE,
+					    SBI_SHMEM_DISABLE, 0);
 }
 
 static u64 pv_time_steal_clock(int cpu)
diff --git a/arch/riscv/kvm/vcpu_sbi_sta.c b/arch/riscv/kvm/vcpu_sbi_sta.c
index d8cf9ca28c61..5f35427114c1 100644
--- a/arch/riscv/kvm/vcpu_sbi_sta.c
+++ b/arch/riscv/kvm/vcpu_sbi_sta.c
@@ -93,8 +93,8 @@ static int kvm_sbi_sta_steal_time_set_shmem(struct kvm_vcpu *vcpu)
 	if (flags != 0)
 		return SBI_ERR_INVALID_PARAM;
 
-	if (shmem_phys_lo == SBI_STA_SHMEM_DISABLE &&
-	    shmem_phys_hi == SBI_STA_SHMEM_DISABLE) {
+	if (shmem_phys_lo == SBI_SHMEM_DISABLE &&
+	    shmem_phys_hi == SBI_SHMEM_DISABLE) {
 		vcpu->arch.sta.shmem = INVALID_GPA;
 		return 0;
 	}
-- 
2.34.1

