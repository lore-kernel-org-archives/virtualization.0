Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716F0145B3C
	for <virtualization@lists.linux.dev>; Fri, 19 Apr 2024 23:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713570486; cv=none; b=lXqZjd1YbxIie5SLdX0ISyZJ34fDLh71F9VkYY8SQ2Cu8Id3NLdnVsAK9spe8CkR7ELNWu0nwLEW1xzPDI64r03WbSiO8bR6i334pdS1vC9yx84gdfkm36oEGlFTz4oQbP93NipbpNx4rks5kFSQs+zpcxKCt2gOEbbHe22e2ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713570486; c=relaxed/simple;
	bh=+BS7mctHpN9iWLFPEwC2/74zIoWzY97OXSTjHAOIU1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=do+ZSSeZk15vgNsn3SFzsvaRqYh8Z6lexiaD4DhuExBrUCRQvf5W23fLd1ZuEUN0fs206azICGMxPDlExPAH9D9VBWc+YE2gkmEJT+rrOCTWHs2vhHiWDdjfDzapqPK0IcqQSmZa7SnzdgTE8O957D08qjl01n67+O1eLW4qW6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=iKKctCsm; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="iKKctCsm"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e3ff14f249so19217325ad.1
        for <virtualization@lists.linux.dev>; Fri, 19 Apr 2024 16:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713570485; x=1714175285; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLadZMY/1E+aj61iqE390ie32fUnJXqsMN5cFXtebck=;
        b=iKKctCsmlyCbwtO8pnjFvLopvdY1N/8gju0sCvOl3PWpR1KworXFUqzMsf7j+Zb2JN
         wJ4kW9C0C1PpgjIeId2UOCWjQqshIUO0EphXsL/LyvjO4w/Ifrht3BNMQVAZM0jLua5q
         fpVVDjpLdGYD5p8feDtqSNoGSDfFiPaqu0H30fx5JX/mlF8bI5fm6QHtK/cXyiWZEUuU
         CY3mD9qTMTvWAe3r3El//UEgx1cA5kb3amZStxA8kSQ51ydRjZ9CMk+Y/gK7OL/n492M
         Ib0/5udBgQ+da4aarKAvcGDZnEq/nPzA1aEo8RPSUh5RiKr975JOUWlCzkzTYpvBm7ed
         sDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713570485; x=1714175285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLadZMY/1E+aj61iqE390ie32fUnJXqsMN5cFXtebck=;
        b=nDB6kvWFjNVNxNk0cX6KyBIJTv7PzfaSPWvCd6fSZCQF/UqL8HG7LHwrgrO5vGsTp9
         rB3eOzCruSFsvvi+3XNm8vHpbdNQV+LLb0sePiV2bTN1ICmNYdf1K+niltbgkDOYSY7q
         UbB4o0ZHLdWRRBl//2CpULGr8evCAWDzhSuvJyOf4e7A0jzBD3S8aJAFcjX5M3EQZbQk
         9OUG12JCNC92PJnYhJRDt5bB9EDpxpWcdKa3GCrp/WGE3BT1pQ6eQEm+6rEdRNFOFsve
         PIeBb6nrPwj0aZxBcOjs/0PleVWdHd/rUROSg/PLmjS7VIRqHJfi2NTvGLC90uTCd9/c
         x+Qg==
X-Forwarded-Encrypted: i=1; AJvYcCVVfwZ2GBU2N7cbOp1Fg1OmEMNKQUYPJU1IGMqppY6juShS9oYsNPfe5CUIfxKQQeK4CeQx4DG06GdzVRlBy3AqIWTcIdp/nqgtew4KM2w=
X-Gm-Message-State: AOJu0Yyr9U1sZ34vGM0BklrBVM480u2/mdmEB+QVS7gbrnYFNr3MK/SF
	UtL7Wsy+yYEJqyoLY7+U6zr6qENacNsP5t7AiAofMe0NXexIqq+BSK5tC7KS98gzYXsbpQSQyY3
	C
X-Google-Smtp-Source: AGHT+IEvBph6MwRCbI7XrCelJMnCCSQbSD7j1tJCROcKUOJKQW1V7Ng3imAkSqKF24OFdFi/RyQiKw==
X-Received: by 2002:a17:902:f544:b0:1e3:f622:f21a with SMTP id h4-20020a170902f54400b001e3f622f21amr10308080plf.24.1713570484830;
        Fri, 19 Apr 2024 16:48:04 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902d11100b001e42f215f33sm3924017plw.85.2024.04.19.16.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 16:48:04 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
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
Subject: [PATCH v8 11/24] RISC-V: KVM: No need to update the counter value during reset
Date: Sat, 20 Apr 2024 08:17:27 -0700
Message-Id: <20240420151741.962500-12-atishp@rivosinc.com>
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

