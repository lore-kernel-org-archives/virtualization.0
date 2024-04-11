Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CD9171B6
	for <virtualization@lists.linux.dev>; Thu, 11 Apr 2024 00:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712794106; cv=none; b=PTpuhx4Tf4umMS275QSpX6JNeRdKwbCqhUPZnE4mGZrPI98pxZCK/5m/eS8uDw9HTVIJMZcCUw2SB3KDibjOJM+m4n8QMrqu5LGRVkAn7zMRXaYjd3VKffYU+mCr+vC16Mk8V/fhKaDfvQAgCQTnJ7qV8eaChq2dLzaUK/nybhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712794106; c=relaxed/simple;
	bh=akgdKSazpCJozBL9deA+0ximAc5a6b6WW9ag1TZQiU0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mmTMd2ML60Cb4vV5rhHNq4ysJ01oRE3hIrZm/7VfWZmp5uJxac2qBc8t24OVfNZoIoKe5qkYAYNVK7fkwTB3Em5B8kO6ckrffPqAT1IiN3WjeLilwkbB+2yuPHKxn2SbO6elzp0gG+9K4F9FxeBhGRygdjyfyFj6KTKNnhUglg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=BMQh3VJz; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="BMQh3VJz"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e3ff14f249so2792305ad.1
        for <virtualization@lists.linux.dev>; Wed, 10 Apr 2024 17:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712794103; x=1713398903; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkMvEzo278xPIa/MSXztYs2ivQ6wYMeKBg/aNDTTbzU=;
        b=BMQh3VJzXGk3rYcDaTSB7oQEOlNcckbh2jYT28XFIDPv6c9n+f6uk0z+dBr8eGcEOe
         vXJgNHv1T8AAnHd2zAtO52ZP1XY5Cg8pgmQ9L6TxC436ns9WgSTa/6VLt+HFcvfpnHBD
         3h4dc/lQAaUVobeRzHl3J6ZVuu6o4Fux1oX8PcAwgN6E6zVPSAN4TVZV1OWFbjeuS2JN
         uBZhSft7zSju60XGJNWA8+OUBoWEUZqsGNwIAWRVflb6sIzGZviEh+LtAr8zkT/Com/2
         h1JBZ9RIe+yyiqZJaR53sJkN4whIFNhGJE4awQQhOyvFS7z8h7CRPt+RQJvWg5Zw7VBL
         ey+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712794103; x=1713398903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CkMvEzo278xPIa/MSXztYs2ivQ6wYMeKBg/aNDTTbzU=;
        b=n6oYwWeoOVsBoB+9m9V2LzLp5z0GkUY2jaIXKx0AnP1afDGVGLOTo3Cxu1eiyiSWIe
         SHGAhHUXNHqUa3D/OGPkYeUrVCSAKYWfgNQGjDs5uCSheRmgv82imot1GNdHadU4jVWS
         r/MmSqdZrkLB8xwf1UZbC3aDIJVj9EbX4yC27FGGIlskocBCKEugO7T6mGqUzjD5HZFS
         OV/1Lt+j9JMbbdMBcoyseaQCmEGc1Lrq0OTSk7TWuCIue7L3Okd6M8QBkx98uxVEME0w
         1XG6O3c+yUarM3NEp3nWzM/GhpxADPThxRefqnV4M60czoiQN2FxW/7WxSGgZvk2whIP
         K0qQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhkwt9Ep0mdGnGf2WjuOnG69+RpyiUTX6oVWNOYO4mFrsCDG4DOmUlXw7A3Fn46vRA4nKbwh3r9uTOohYt4wggRcKu8MxenjzIsYzdpMo=
X-Gm-Message-State: AOJu0Yx3ZUXkvBrdo4v0HBkjwfhuHQL8boGVNuQjUKWG9OLKqyYvSuYJ
	4Zqdzcy4mQqBdOITVb5b3/kBZCqjFl+4yeV41LmPu3aZQUbrXnqikoief4HJl6w=
X-Google-Smtp-Source: AGHT+IGgRaxQYW8bBoO59l6g97lF6DWJlZ8qPVf66iIYAUNC2ixkF2eOsdNbKg8PB+Igg7J274SeEA==
X-Received: by 2002:a17:902:ec8b:b0:1e2:bdef:3971 with SMTP id x11-20020a170902ec8b00b001e2bdef3971mr1459480plg.16.1712794103281;
        Wed, 10 Apr 2024 17:08:23 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902684700b001e3d8a70780sm130351pln.171.2024.04.10.17.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 17:08:22 -0700 (PDT)
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
Subject: [PATCH v6 06/24] RISC-V: KVM: Rename the SBI_STA_SHMEM_DISABLE to a generic name
Date: Wed, 10 Apr 2024 17:07:34 -0700
Message-Id: <20240411000752.955910-7-atishp@rivosinc.com>
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

