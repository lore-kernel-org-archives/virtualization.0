Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911A04C3A8
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="emKQ09QV"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0E2274206B
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:00:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0E2274206B
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=emKQ09QV
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wd0JdQPFkjDX
	for <virtualization@lists.linux-foundation.org>;
	Wed, 20 Dec 2023 16:00:18 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C46294206A
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:00:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C46294206A
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40d13e4f7abso38388955e9.2
        for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 08:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1703088016; x=1703692816; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bdwtBlVh4a6VJznudagsfLt7Pfjqobs9eaykgvatq8c=;
        b=emKQ09QVOqKJv4zL7l/iP37EgOtUJLZwY0rf+rAOuReWA7bjGBW5Y6CQXjDEFgltRq
         Nt+We4sciM3QI2WAqNdFkjJVKDA2cuSNMIqvES6tswN1KmO+PcL7yXVx01zY9M0Z07RP
         u6a0Dx7vcUP5BoINKx7C3zwO6En7pcoSdKpzmOwY9tdGgI9SzitmdvynvIQC9seXhSLh
         UwLjnOk10A0wrxdktkY4nTP0+jww1eOZAGQkVyzD98Svc7oBgVF0GXrqTqeJ+Gp5qZEg
         j8uGHDCt7JcuminB4Tr9rNvm0dYSn7QmZRVjd7tQAE0rHs3BZCPAJp2dxjHZ5ckkeJ4A
         l52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703088016; x=1703692816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bdwtBlVh4a6VJznudagsfLt7Pfjqobs9eaykgvatq8c=;
        b=EiyDRSUqvwhcaRSGsIwYFEeGENiqHEOEc15FR6TP7S4XZ/Wg7g/uAAoX/nFBhuM3sy
         vJaJ9Z2bAeSVdRWyoEVTg5izRmpE3nri7TMfoMZOfXrIcn6aq5A+xDuI6g+nFjt0j/8e
         YWCpdSXZa+oReSQykr2dfNVISKAB67QxgzpygRPD0ZMG97TtdI/xYc6ast+KlBhHt5L+
         kKvokhw0un3o0BJDM/PRDKelpxK1hxDazSIevAAvVeib/N/7rwWXvYS0xzo2U3WuCZHS
         HVVx5lLTCVfsYrHr3HyU3vmLXlpUbeTH/0//RM81oKN7Rc8YF90k2IlqwQLCZKlF+XuU
         ogVg==
X-Gm-Message-State: AOJu0YwKnBfhhAGicUms5PDOmQojpz1k8AQ2KCDNrVNp0CUogZoaXwkk
	ATctx+DpdlPwQPZstIOMJg6SWg==
X-Google-Smtp-Source: AGHT+IHd6SyiQhZpvX4TfWnzQTmYm4xiRdNZLQCuRk9AY73nABijgjzHeJnJeK5afQVncsLmvGAAUg==
X-Received: by 2002:a05:600c:19d4:b0:40b:45e2:1f56 with SMTP id u20-20020a05600c19d400b0040b45e21f56mr11508290wmq.39.1703088015723;
        Wed, 20 Dec 2023 08:00:15 -0800 (PST)
Received: from localhost (cst-prg-16-115.cust.vodafone.cz. [46.135.16.115])
        by smtp.gmail.com with ESMTPSA id bg5-20020a05600c3c8500b0040c4c9c52a3sm7944624wmb.12.2023.12.20.08.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 08:00:15 -0800 (PST)
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
Subject: [PATCH v4 00/13] RISC-V: Add steal-time support
Date: Wed, 20 Dec 2023 17:00:13 +0100
Message-ID: <20231220160012.40184-15-ajones@ventanamicro.com>
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
https://github.com/jones-drew/linux/commits/kvm/steal-time-v4

Changes since v3:
 - Use work "Computing" instead of "using" in pr_info [Atish]
 - Rename KVM_REG_RISCV_SBI to KVM_REG_RISCV_SBI_STATE [Atish, Anup]
 - Picked up r-b's from Atish and Anup

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
 arch/riscv/kvm/vcpu_onereg.c                  |  51 ++++-
 arch/riscv/kvm/vcpu_sbi.c                     |  67 ++++++
 arch/riscv/kvm/vcpu_sbi_sta.c                 | 208 ++++++++++++++++++
 tools/testing/selftests/kvm/Makefile          |   5 +-
 .../selftests/kvm/include/riscv/processor.h   |  22 ++
 .../selftests/kvm/lib/riscv/processor.c       |  45 ++++
 tools/testing/selftests/kvm/lib/riscv/ucall.c |  26 ---
 .../selftests/kvm/riscv/get-reg-list.c        |  43 ++++
 tools/testing/selftests/kvm/steal_time.c      |  99 +++++++++
 23 files changed, 782 insertions(+), 35 deletions(-)
 create mode 100644 arch/riscv/include/asm/paravirt.h
 create mode 100644 arch/riscv/include/asm/paravirt_api_clock.h
 create mode 100644 arch/riscv/kernel/paravirt.c
 create mode 100644 arch/riscv/kvm/vcpu_sbi_sta.c

-- 
2.43.0

