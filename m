Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B19648CC0
	for <virtualization@lists.linux-foundation.org>; Sun, 17 Dec 2023 20:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="WeEaQvP6"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 92499410A3
	for <virtualization@lists.linux-foundation.org>; Sun, 17 Dec 2023 20:40:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 92499410A3
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=WeEaQvP6
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id owxAu12iU6Ur
	for <virtualization@lists.linux-foundation.org>;
	Sun, 17 Dec 2023 20:40:25 +0000 (UTC)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3532640985
	for <virtualization@lists.linux-foundation.org>; Sun, 17 Dec 2023 20:40:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3532640985
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50e39ac39bcso130507e87.3
        for <virtualization@lists.linux-foundation.org>; Sun, 17 Dec 2023 12:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1702845623; x=1703450423; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N7njOxEMPBbtgvDsh+tIioXyQhIK2DCbcZAifd8D4ls=;
        b=WeEaQvP6XmqTw9/5Jr+Q2c+YmxncmOhoj/Px48eSjDM3A7B6Cu7RwtW/PP0eL5Gq8o
         M153aSvkajDAPsUr3IgtPS5Rou6X2XhfXU299conxA8qD7vACIfOp0LxOCPI7ELdojDa
         8pZNZFF9U66PeAzhqgUX6tAeg8Hb3b49vQhLvotrc4ZuS8+StfVh7VwbARrJ3soKm7D5
         Ovku7UJQ4uOFCrF4JmcMO5pLB1g/STJJnmS8PCcbuMH4uLaGQxDLrT/qIqRo84VlH0cA
         AFODKaVDN1GfcSkC5CEX/FDARKQjmlBqdvdL+G007W1xdOXz0TWKaL1R3z9vsllu+fr/
         IcHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702845623; x=1703450423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N7njOxEMPBbtgvDsh+tIioXyQhIK2DCbcZAifd8D4ls=;
        b=rqJFnQlwf89g9OaUKsOE8Pk+xXxGwKOffAdI0wBM0AXBlhgTuTn+0aQneKCYcXWjwu
         jdIz4kpq2cGgwYn84DasjHHZF+kn+SAY8jb87DqVf6CcB3fgme6feqGgA1jYrG7z8fuv
         sWRijJvnji/xJfWOYkH1W/m83Z0UnpquBpFWH34rQ6s3CVt2IpCLekxOAWNGCvqvLwxu
         ZfbfnaqXZ8tmy6t8XxhSO9tdTsPdrqQ/5W6cDl88rLj7l1eihi1LSEebxjKyvWj/PFdz
         xxHPgjr4xXMsy4fMS55jINWsmj1cX7fn+Mmj24mXqmkY/rXBE5utyGRbaQx4Q5v0v9mJ
         3pRw==
X-Gm-Message-State: AOJu0Ywgwz/tnvxBIWykX+5h0ujBmSEp4FIfjFTWLwTXwBVrhWKnEECb
	qXOEeVVATwfAYgzyTGb4bltMgA==
X-Google-Smtp-Source: AGHT+IHIqZ0UGnXDqm7/W1EgiPTD5LIezjEUrVBjl8lt3+XEzPjth1J2M3N9QlyYyzn/7M2gqwaV8Q==
X-Received: by 2002:a05:6512:3c89:b0:50d:1a16:63e with SMTP id h9-20020a0565123c8900b0050d1a16063emr4376298lfv.204.1702845622770;
        Sun, 17 Dec 2023 12:40:22 -0800 (PST)
Received: from localhost (cst-prg-88-42.cust.vodafone.cz. [46.135.88.42])
        by smtp.gmail.com with ESMTPSA id tk10-20020a170907c28a00b00a1cfa7e0d40sm13306123ejc.61.2023.12.17.12.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 12:40:22 -0800 (PST)
From: Andrew Jones <ajones@ventanamicro.com>
To: kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	virtualization@lists.linux-foundation.org
Cc: anup@brainfault.org,
	atishp@atishpatra.org,
	pbonzini@redhat.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	jgross@suse.com,
	srivatsa@csail.mit.edu,
	guoren@kernel.org,
	conor.dooley@microchip.com
Subject: [PATCH v3 00/13] RISC-V: Add steal-time support
Date: Sun, 17 Dec 2023 21:40:20 +0100
Message-ID: <20231217204019.36492-15-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit

One frequently touted benefit of virtualization is the ability to
consolidate machines, increasing resource utilization.  It may even be
desirable to overcommit, at the risk of one or more VCPUs having to wait.
Hypervisors which have interfaces for guests to retrieve the amount of
time each VCPU had to wait give observers within the guests ways to
account for less progress than would otherwise be expected. The SBI STA
extension[1] provides a standard interface for guest VCPUs to retrieve
the amount of time "stolen".

This series has three parts:
 1) Patches 01-03 - Add paravirt support to RISC-V and implement
                    steal-time accounting support using the SBI STA
                    extension.
 2) Patches 04-09 - Implement SBI STA in KVM so KVM guests, such as
                    Linux guests which enable the paravirt steal-time
                    support, can be enlightened about stolen time.
 3) Patches 10-13 - Add RISC-V support to the KVM selftests steal_time
                    test and the SBI extension regs in the get-reg-list
                    test.

These patches are based on kvm-riscv/riscv_kvm_queue

[1] https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/src/ext-steal-time.adoc

This patches are also available here
https://github.com/jones-drew/linux/commits/kvm/steal-time-v3

Changes since v2:
 - Always check sequence in case the SBI impl isn't writing steal
   atomically [Anup]
 - Create a reset function for sta and also reset last_steal [Anup]
 - Picked up Anup's r-b's

Changes since v1:
 - sbi_sta_steal_time_set_shmem() now maps SBI errors to linux errors [Conor]
 - Squashed v1 patch 4 into v1 patch 3 [Conor]
 - Moved kvm_riscv_vcpu_set/get_reg_sbi() to arch/riscv/kvm/vcpu_sbi.c
   which seems like a more appropriate file for them
 - Rebased on kvm-riscv/riscv_kvm_queue which has all the dependencies

Changes since RFC:
 - Rebased on v6.7-rc3 (plus the patches mentioned above)
 - Added defines for the -1's [Conor]
 - Added a comment to the steal read sequence [Conor]
 - Only do the steal read sequence for 32-bit and added READ_ONCE's
 - Check for SBI v2.0 implementation
 - Rename set_steal_time_shmem to steal_time_set_shmem
 - Add get-reg-list support and test with get-reg-list kselftest
 - A few other minor improvements
 - Picked up one r-b from Conor

Thanks,
drew


Andrew Jones (13):
  RISC-V: paravirt: Add skeleton for pv-time support
  RISC-V: Add SBI STA extension definitions
  RISC-V: paravirt: Implement steal-time support
  RISC-V: KVM: Add SBI STA extension skeleton
  RISC-V: KVM: Add steal-update vcpu request
  RISC-V: KVM: Add SBI STA info to vcpu_arch
  RISC-V: KVM: Add support for SBI extension registers
  RISC-V: KVM: Add support for SBI STA registers
  RISC-V: KVM: Implement SBI STA extension
  RISC-V: KVM: selftests: Move sbi_ecall to processor.c
  RISC-V: KVM: selftests: Add guest_sbi_probe_extension
  RISC-V: KVM: selftests: Add steal_time test support
  RISC-V: KVM: selftests: Add get-reg-list test for STA registers

 .../admin-guide/kernel-parameters.txt         |   6 +-
 arch/riscv/Kconfig                            |  19 ++
 arch/riscv/include/asm/kvm_host.h             |  10 +
 arch/riscv/include/asm/kvm_vcpu_sbi.h         |  10 +
 arch/riscv/include/asm/paravirt.h             |  28 +++
 arch/riscv/include/asm/paravirt_api_clock.h   |   1 +
 arch/riscv/include/asm/sbi.h                  |  17 ++
 arch/riscv/include/uapi/asm/kvm.h             |  13 ++
 arch/riscv/kernel/Makefile                    |   1 +
 arch/riscv/kernel/paravirt.c                  | 134 +++++++++++
 arch/riscv/kernel/time.c                      |   3 +
 arch/riscv/kvm/Kconfig                        |   1 +
 arch/riscv/kvm/Makefile                       |   1 +
 arch/riscv/kvm/vcpu.c                         |   7 +
 arch/riscv/kvm/vcpu_onereg.c                  |  50 ++++-
 arch/riscv/kvm/vcpu_sbi.c                     |  67 ++++++
 arch/riscv/kvm/vcpu_sbi_sta.c                 | 208 ++++++++++++++++++
 tools/testing/selftests/kvm/Makefile          |   5 +-
 .../selftests/kvm/include/riscv/processor.h   |  22 ++
 .../selftests/kvm/lib/riscv/processor.c       |  45 ++++
 tools/testing/selftests/kvm/lib/riscv/ucall.c |  26 ---
 .../selftests/kvm/riscv/get-reg-list.c        |  43 ++++
 tools/testing/selftests/kvm/steal_time.c      |  99 +++++++++
 23 files changed, 781 insertions(+), 35 deletions(-)
 create mode 100644 arch/riscv/include/asm/paravirt.h
 create mode 100644 arch/riscv/include/asm/paravirt_api_clock.h
 create mode 100644 arch/riscv/kernel/paravirt.c
 create mode 100644 arch/riscv/kvm/vcpu_sbi_sta.c

-- 
2.43.0

