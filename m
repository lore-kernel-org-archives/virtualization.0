Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9ED823DC
	for <virtualization@lists.linux.dev>; Wed,  3 Apr 2024 08:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131535; cv=none; b=r0ClUyRta2UC0XsFnZKnHm2Yd4WZf0RafMcI1UvwODgTW68NZlAzgn74EUmGWiK/3+SfMpaxT24Odpulb2LbRDCvWnY2EGb/KbWeikF+bk5Pnk6TZD2zqI0i4Fm/BiRD2nL1Us/JtvvwXPGgP4T3KGfW48zdh5m08CHtH3TPz8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131535; c=relaxed/simple;
	bh=+BS7mctHpN9iWLFPEwC2/74zIoWzY97OXSTjHAOIU1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E7v/Gjj/Ilx22hwOwcBTIeelMLst7z7g1S5IP0pvh0nLBUHrwIzFX6xTZDXsPB6wJPmaDdMlLoIgd4cvbXaBnb4R8Fur8b06Nmvp/0RH6HoClFeiYQkUQaAuFZYwYe8qA8Bij+Qbbo60bPHmrcw3R/ix9LtZRUQLQN/FQOhvh+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=O0cNw5cc; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="O0cNw5cc"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5d8b519e438so4424627a12.1
        for <virtualization@lists.linux.dev>; Wed, 03 Apr 2024 01:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712131533; x=1712736333; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLadZMY/1E+aj61iqE390ie32fUnJXqsMN5cFXtebck=;
        b=O0cNw5ccNmLdX8W3ugxHh9p+lx/Ik8DBkHFvI/IKQVqomvFxKhr2VxFGQXvbTA+nRv
         t6wb8qxUaPFqRb25BZrFgQ1Dic91NAVWPRqcYTAefwomI8XoJMleYUApAFtGXR/92Shd
         36Gg2yVnLmb6txUzSRdoO+3zIfzEeoygUlNyCfbwMoyDRVMuI1mtuM7R2vjQxYfaRU1o
         VpDHnjovO9kU+alXSsCNQjwHXcJ5cFwJdXL78V5G+TV4x3Qs9SH9lRy+iY+PqX+v8TBd
         kbx9JpIUpqcHmJ9C5UEGszPwsiMlb0zyH7Q7tD9WbFx8ACkX3micOEXJybXdBQWIua0Y
         6Ugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131533; x=1712736333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLadZMY/1E+aj61iqE390ie32fUnJXqsMN5cFXtebck=;
        b=qamVtNbo2Cwl740iRKQnRctOvqUtL5i//QK+4XNztpeonMQ7Fq9LNto7jTV3N2UeAr
         2BgiDGzfKIPB13j5yD+FIeoMos8OSsZYfQZ4u9I47ydvyKN3f4rbBkGb92rS5rpLjJBY
         xo35CmiQ36B6aCHpHwFs4lOkRyWWgnk0fqWTVWpD5O3ZoMTmc99AWfEVeY4lsUy59v+u
         fmaSwSKZb+F/RZMj7x3GhOK0lKR26Pev8pMkJT98qcZhAb4IjjKMIIaQ7MRpq35RA5jn
         7Mz34Sfx27HSvJSuGi8Bqlz5FEx8jsdsJcW3CjHFPt+EeycgSCy1LcN2Ow9JWL3PPImw
         EFEg==
X-Forwarded-Encrypted: i=1; AJvYcCVYOMZDLtyc5vogCfupuMwhYFg6sVNWmiAJRimuRacdCW4z8Mmq0OrV4XFSjyfBpRzoRGKzAVmTNpGG5oYIjQd6VtIcRLyDkgKRIzCzb+A=
X-Gm-Message-State: AOJu0YxhNQRohqXzeutcEXLaT0r3pzeGIKELQu7jY5JGydUvGjWMSDSs
	4VtvPsXv/eA26ikgL3bU+pTmy6UQLwZ47UszwufV7IpFAeDHIZRAuSw6Yyqp4o4=
X-Google-Smtp-Source: AGHT+IHYBgMwEeWVbd4P9PNDRXwi0PIWRTlB15cj+AGKTpxTy9q1IU7RrYP0KIGaFYPVod/3S9sbOg==
X-Received: by 2002:a05:6a21:3294:b0:1a5:6a85:8ce9 with SMTP id yt20-20020a056a21329400b001a56a858ce9mr2619252pzb.12.1712131533285;
        Wed, 03 Apr 2024 01:05:33 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902d48c00b001e0b5d49fc7sm12557229plg.161.2024.04.03.01.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 01:05:32 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ajay Kaher <akaher@vmware.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Alexey Makhalov <amakhalov@vmware.com>,
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
Subject: [PATCH v5 10/22] RISC-V: KVM: No need to update the counter value during reset
Date: Wed,  3 Apr 2024 01:04:39 -0700
Message-Id: <20240403080452.1007601-11-atishp@rivosinc.com>
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

The virtual counter value is updated during pmu_ctr_read. There is no need
to update it in reset case. Otherwise, it will be counted twice which is
incorrect.

Fixes: 0cb74b65d2e5 ("RISC-V: KVM: Implement perf support without sampling")
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kvm/vcpu_pmu.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index cee1b9ca4ec4..b5159ce4592d 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -397,7 +397,6 @@ int kvm_riscv_vcpu_pmu_ctr_stop(struct kvm_vcpu *vcpu, unsigned long ctr_base,
 {
 	struct kvm_pmu *kvpmu = vcpu_to_pmu(vcpu);
 	int i, pmc_index, sbiret = 0;
-	u64 enabled, running;
 	struct kvm_pmc *pmc;
 	int fevent_code;
 
@@ -432,12 +431,9 @@ int kvm_riscv_vcpu_pmu_ctr_stop(struct kvm_vcpu *vcpu, unsigned long ctr_base,
 				sbiret = SBI_ERR_ALREADY_STOPPED;
 			}
 
-			if (flags & SBI_PMU_STOP_FLAG_RESET) {
-				/* Relase the counter if this is a reset request */
-				pmc->counter_val += perf_event_read_value(pmc->perf_event,
-									  &enabled, &running);
+			if (flags & SBI_PMU_STOP_FLAG_RESET)
+				/* Release the counter if this is a reset request */
 				kvm_pmu_release_perf_event(pmc);
-			}
 		} else {
 			sbiret = SBI_ERR_INVALID_PARAM;
 		}
-- 
2.34.1

