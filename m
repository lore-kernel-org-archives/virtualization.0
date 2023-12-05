Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C34C6A333
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 18:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="TVsJOXfQ"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CABE161052
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 18:11:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CABE161052
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=TVsJOXfQ
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pi3NvL5ErZVN
	for <virtualization@lists.linux-foundation.org>;
	Tue,  5 Dec 2023 18:11:24 +0000 (UTC)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A73E560E64
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 18:11:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A73E560E64
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2ca00dffc23so35366761fa.2
        for <virtualization@lists.linux-foundation.org>; Tue, 05 Dec 2023 10:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1701799881; x=1702404681; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xd6mnNZNXMrACqsw59eZFOMt01rSUh441zyM1SI9n9U=;
        b=TVsJOXfQR7rvmTcrEMs4CetNl/iDPNNHtyJNtQ7FB5UanLX3C6d0f6lFyF9FuZ+U+K
         MBIKcsCCBx/u3QwdKebyEot4yyAL6SIhr8AkNDL1O+ruDxxu+aEkUkQ4zccc75QAHnk+
         TVDbOoiIS9ofwX7HXw0cUheOf8ZnjeKmv/q2cv1EGcnGh5+0vXkvw0CPcsF/zu0jbQpJ
         Wk+rw0JJlJhj7HemQFnHcK8AEu73XU94nKcKxQfPEDRAXhFdFvPZEqfvQTscM1Gfb3vg
         gE3tJgrtVHAGw3vQPZ+VTjiBqU5Hut7XVcx98TIK/zZcTaVISiIiiVs/EMTPH5EbFEmi
         9mwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701799881; x=1702404681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xd6mnNZNXMrACqsw59eZFOMt01rSUh441zyM1SI9n9U=;
        b=QwoSlOU9qWJqbiCqCVZiZi5lLi+QiRGD6glzuKij9jWO4u1NH/ZC017Nysxho7/eLA
         wIetK5/+/NpC/uHDQ9ues+qUcHITScDz+3zeQ713v7eHOdyxti0TCq8cn4uCNjZajFS0
         k/dCLeTkVHzv5aCbIX6jpEXtRO3Qm7Fg2tzskr8prJt5rWKT4/K+BWe16cPibHrT9KU0
         dZz4JA0/NIWNMo1b7krBRd3MOOFRRPo2+RRFOspvPs62JDyD5coCoKg8WJ5By/0QHReC
         ws1yWJ07PJLq8DN/GoiSfsZtOv9CuaQ+Zut+BD90LJesKv2nRX9ul0/80XQcfBh/RRmv
         WWlQ==
X-Gm-Message-State: AOJu0YyhqHlo5ze3W5gTZZHds8AE8f71BU1weYAP7h1wwJpyg6FJ9jTt
	yBiM+E7tJ9LseEtFcHmMr2Hhdw==
X-Google-Smtp-Source: AGHT+IGsOdi3SYNPl10ZLJRZP3ymPfonq+AFt3Kng2XtRFYN1/x+m4gzmIQItJqp4WK64uK1pN49Vw==
X-Received: by 2002:a2e:9a94:0:b0:2ca:fa5:83f1 with SMTP id p20-20020a2e9a94000000b002ca0fa583f1mr1333052lji.20.1701799881071;
        Tue, 05 Dec 2023 10:11:21 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id v19-20020a170906565300b00a19644675aasm6339368ejr.23.2023.12.05.10.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 10:11:20 -0800 (PST)
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
	guoren@kernel.org
Subject: [PATCH v1 00/14] RISC-V: Add steal-time support
Date: Tue,  5 Dec 2023 19:11:20 +0100
Message-ID: <20231205181119.207204-16-ajones@ventanamicro.com>
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
 1) Patches 01-04 - Add paravirt support to RISC-V and implement
                    steal-time accounting support using the SBI STA
                    extension.
 2) Patches 05-10 - Implement SBI STA in KVM so KVM guests, such as
                    Linux guests which enable the paravirt steal-time
                    support, can be enlightened about stolen time.
 3) Patches 11-14 - Add RISC-V support to the KVM selftests steal_time
                    test and the SBI extension regs in the get-reg-list
                    test.

These patches are based on the make SBI uapi consistent with the ISA
uapi KVM series, which is based on Anup's riscv_kvm_more_exts_v1 branch.
Based-on: 20231130183537.55203-8-ajones@ventanamicro.com

[1] https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/src/ext-steal-time.adoc

This patches are also available here
https://github.com/jones-drew/linux/commits/kvm/steal-time-v1

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


Andrew Jones (14):
  RISC-V: paravirt: Add skeleton for pv-time support
  RISC-V: Add SBI STA extension definitions
  RISC-V: paravirt: Implement steal-time support
  RISC-V: paravirt: Add kconfigs
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
 arch/riscv/include/asm/kvm_host.h             |   9 +
 arch/riscv/include/asm/kvm_vcpu_sbi.h         |   6 +
 arch/riscv/include/asm/paravirt.h             |  28 +++
 arch/riscv/include/asm/paravirt_api_clock.h   |   1 +
 arch/riscv/include/asm/sbi.h                  |  17 ++
 arch/riscv/include/uapi/asm/kvm.h             |  13 ++
 arch/riscv/kernel/Makefile                    |   1 +
 arch/riscv/kernel/paravirt.c                  | 138 ++++++++++++
 arch/riscv/kernel/time.c                      |   3 +
 arch/riscv/kvm/Kconfig                        |   1 +
 arch/riscv/kvm/Makefile                       |   1 +
 arch/riscv/kvm/vcpu.c                         |   7 +
 arch/riscv/kvm/vcpu_onereg.c                  | 105 +++++++++
 arch/riscv/kvm/vcpu_sbi.c                     |   4 +
 arch/riscv/kvm/vcpu_sbi_sta.c                 | 202 ++++++++++++++++++
 tools/testing/selftests/kvm/Makefile          |   5 +-
 .../selftests/kvm/include/riscv/processor.h   |  22 ++
 .../selftests/kvm/lib/riscv/processor.c       |  45 ++++
 tools/testing/selftests/kvm/lib/riscv/ucall.c |  26 ---
 .../selftests/kvm/riscv/get-reg-list.c        |  43 ++++
 tools/testing/selftests/kvm/steal_time.c      |  99 +++++++++
 23 files changed, 770 insertions(+), 31 deletions(-)
 create mode 100644 arch/riscv/include/asm/paravirt.h
 create mode 100644 arch/riscv/include/asm/paravirt_api_clock.h
 create mode 100644 arch/riscv/kernel/paravirt.c
 create mode 100644 arch/riscv/kvm/vcpu_sbi_sta.c

-- 
2.43.0

