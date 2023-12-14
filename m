Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058C739FF7
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 10:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="mxi76Vyw"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7E98F436E8
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 10:15:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7E98F436E8
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=mxi76Vyw
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zPuDpzD_Oics
	for <virtualization@lists.linux-foundation.org>;
	Thu, 14 Dec 2023 10:15:56 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D81C9436DF
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 10:15:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D81C9436DF
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40c41df5577so47518965e9.0
        for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 02:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1702548954; x=1703153754; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=osF9PtT0XneIHaK1AbmcqNBCF71s2lHM1BpRF0PJptY=;
        b=mxi76Vyw29x4V8IqSkADAuBui9mgUP1nMxsoKjuhyUQC8FGqbcQDPomZ1GkhzCnfaW
         ghhpPgT+YX1J/gkzNscAFHmrw+nKvHaefCP/PzzXegRQS8NDmrGXLjgiVBKlbFxORprU
         hKadRgn9ap9xp4B+vyUc7dz++N0o3G1ImSC+Nv2fHitj2GWz057pdTnE0gKvTfcfD7s2
         mtfpwwMNQ4Ovz3GFzoxKErfEoeSUU2ZKEUzjgz54u6s4FTZ5WVJ6RJInQjQvg4/Of53n
         +0MkYhex61BmjZjlNJJ5UoLXIDSMQu18E2Lo54UIaDrQWbKsarO3+NSRkKas/6e8n3s+
         4wiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702548954; x=1703153754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=osF9PtT0XneIHaK1AbmcqNBCF71s2lHM1BpRF0PJptY=;
        b=GQifmEDmCOAr/qqCj1HVGuOgvbCwshQbzT+6we95Ad3Ody1faZI6RShaQt6jQOnSwb
         4ssVn+vXdj+/RqdetpdFSt3Dbc4cpfylV6umBw8PKsk57IvpfHVf8aJPjcKKY0Dc9LXQ
         TmNzkL4f7dGsX8yf87oepBs8pi6ekIYPIbuMNhgcqd4ya3X9t9tMIpdFK0hrrJbdwHpT
         HJExAefN2GA9vh9vCI1U70j3ROOP+59Vplcw7w75STExc82OpLcnfg3O47Uap+aGM+Ye
         jx3YAJhn3zkBZj10cUfKOIo6zWLDYzA2Y6H3s2d1OhsoCay4XwYs9rNV9sL3GT3b606t
         FZ2Q==
X-Gm-Message-State: AOJu0YzGTPsvXAJDrC8HhxZ3xyCsDCllA4AEUGztE7rKoeml1iYpN/sR
	QaVJAEavp7ExyZrx7UQfQ3bxOw==
X-Google-Smtp-Source: AGHT+IF3W4UDaTU9TkmFl4OfPOr2R5VlDkPBD79hepfEio3hAZAvosVlYJ75fB+u130xi70fmXErGA==
X-Received: by 2002:a05:600c:138e:b0:40c:4b4e:959d with SMTP id u14-20020a05600c138e00b0040c4b4e959dmr1661065wmf.167.1702548953649;
        Thu, 14 Dec 2023 02:15:53 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id v6-20020a05600c444600b0040c4886f254sm14134218wmn.13.2023.12.14.02.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 02:15:53 -0800 (PST)
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
Subject: [PATCH v2 00/13] RISC-V: Add steal-time support
Date: Thu, 14 Dec 2023 11:15:52 +0100
Message-ID: <20231214101552.100721-15-ajones@ventanamicro.com>
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
https://github.com/jones-drew/linux/commits/kvm/steal-time-v2

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
 arch/riscv/include/asm/kvm_host.h             |   9 +
 arch/riscv/include/asm/kvm_vcpu_sbi.h         |  10 +
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
 arch/riscv/kvm/vcpu_onereg.c                  |  50 ++++-
 arch/riscv/kvm/vcpu_sbi.c                     |  67 ++++++
 arch/riscv/kvm/vcpu_sbi_sta.c                 | 202 ++++++++++++++++++
 tools/testing/selftests/kvm/Makefile          |   5 +-
 .../selftests/kvm/include/riscv/processor.h   |  22 ++
 .../selftests/kvm/lib/riscv/processor.c       |  45 ++++
 tools/testing/selftests/kvm/lib/riscv/ucall.c |  26 ---
 .../selftests/kvm/riscv/get-reg-list.c        |  43 ++++
 tools/testing/selftests/kvm/steal_time.c      |  99 +++++++++
 23 files changed, 778 insertions(+), 35 deletions(-)
 create mode 100644 arch/riscv/include/asm/paravirt.h
 create mode 100644 arch/riscv/include/asm/paravirt_api_clock.h
 create mode 100644 arch/riscv/kernel/paravirt.c
 create mode 100644 arch/riscv/kvm/vcpu_sbi_sta.c

-- 
2.43.0

