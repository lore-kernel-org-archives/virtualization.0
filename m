Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791413A8C9;
	Thu,  1 Feb 2024 03:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706757597; cv=none; b=fqweUZiwcyaxlUXtXmKcxyQldwO9TGVkBimVE3Sv9Ev5oUddqRaD/q7+wMkHmx+hs8Mf9XXPYVjEkBD0YDCaOCzJyYvj+CmGhH5xadcAx0J7njaDjjPeciGq2CuAssn/2kN1e8VUjAKon1rxP2EDrRS0tT+3nP4SGa/RUCZX6vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706757597; c=relaxed/simple;
	bh=+9YB0WxuNQOB7N11Y9bprkm23A0whVNmF4nZDYquEGw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VTw7SZ2c4gsJ0kdhwGc23FSaS+9vWWIrKUBhUnZE+aTmOiovRpQmLwBGH92WT7nFsec4fiWIlIFXKM1ZHD9thJeDr5E9o5FCCMAA7oYP+95mrltxmrqLeULb/A96s9Ieu0M4+PIaBvELNIsD1a4tCn9jYw3SMOP0GQSNx3jlsJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Bx3+vXDbtlKVQJAA--.27469S3;
	Thu, 01 Feb 2024 11:19:52 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxfRPWDbtltkIrAA--.3273S2;
	Thu, 01 Feb 2024 11:19:50 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Tianrui Zhao <zhaotianrui@loongson.cn>,
	Juergen Gross <jgross@suse.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org
Subject: [PATCH v4 0/6] LoongArch: Add pv ipi support on LoongArch VM
Date: Thu,  1 Feb 2024 11:19:44 +0800
Message-Id: <20240201031950.3225626-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxfRPWDbtltkIrAA--.3273S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCw47WF1kWF1kuFyUGrW8Zrc_yoWrXFW5pF
	W7urn5WFs5Gr93Zwnxt3s3ur15Jw1xG34aq3W2yrW8C3y2qFyUXr4kGr98Za4kJw4rJrW0
	qF1rGw1YgF1UA3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcZXoDUUUU

This patchset adds pv ipi support for VM. On physical machine, ipi HW
uses IOCSR registers, however there is trap into hypervisor when vcpu
accesses IOCSR registers if system is in VM mode. SWI is a interrupt
mechanism like SGI on ARM, software can send interrupt to CPU, only that
on LoongArch SWI can only be sent to local CPU now. So SWI can not used
for IPI on real HW system, however it can be used on VM when combined with
hypercall method. This patch uses SWI interrupt for IPI mechanism, SWI
injection uses hypercall method. And there is one trap with IPI sending,
however with IPI receiving there is no trap. with IOCSR HW ipi method,
there will be two trap into hypervisor with ipi receiving.

Also this patch adds IPI multicast support for VM, this idea comes from
x86 pv ipi. IPI can be sent to 128 vcpus in one time.

Here is the microbenchmarck data with perf bench futex wake case on 3C5000
single-way machine, there are 16 cpus on 3C5000 single-way machine, VM
has 16 vcpus also. The benchmark data is ms time unit to wakeup 16 threads,
the performance is higher if data is smaller.

perf bench futex wake, Wokeup 16 of 16 threads in ms
--physical machine--   --VM original--   --VM with pv ipi patch--
  0.0176 ms               0.1140 ms            0.0481 ms

---
Change in V4:
  1. Modfiy pv ipi hook function name call_func_ipi() and 
call_func_single_ipi() with send_ipi_mask()/send_ipi_single(), since pv
ipi is used for both remote function call and reschedule notification.
  2. Refresh changelog.

Change in V3:
  1. Add 128 vcpu ipi multicast support like x86
  2. Change cpucfg base address from 0x10000000 to 0x40000000, in order
to avoid confliction with future hw usage
  3. Adjust patch order in this patchset, move patch
Refine-ipi-ops-on-LoongArch-platform to the first one.

Change in V2:
  1. Add hw cpuid map support since ipi routing uses hw cpuid
  2. Refine changelog description
  3. Add hypercall statistic support for vcpu
  4. Set percpu pv ipi message buffer aligned with cacheline
  5. Refine pv ipi send logic, do not send ipi message with if there is
pending ipi message.
---

Bibo Mao (6):
  LoongArch/smp: Refine ipi ops on LoongArch platform
  LoongArch: KVM: Add hypercall instruction emulation support
  LoongArch: KVM: Add cpucfg area for kvm hypervisor
  LoongArch: Add paravirt interface for guest kernel
  LoongArch: KVM: Add vcpu search support from physical cpuid
  LoongArch: Add pv ipi support on LoongArch system

 arch/loongarch/Kconfig                        |   9 +
 arch/loongarch/include/asm/Kbuild             |   1 -
 arch/loongarch/include/asm/hardirq.h          |   5 +
 arch/loongarch/include/asm/inst.h             |   1 +
 arch/loongarch/include/asm/irq.h              |  10 +-
 arch/loongarch/include/asm/kvm_host.h         |  27 +++
 arch/loongarch/include/asm/kvm_para.h         | 157 ++++++++++++++++++
 arch/loongarch/include/asm/kvm_vcpu.h         |   1 +
 arch/loongarch/include/asm/loongarch.h        |  11 ++
 arch/loongarch/include/asm/paravirt.h         |  27 +++
 .../include/asm/paravirt_api_clock.h          |   1 +
 arch/loongarch/include/asm/smp.h              |  31 ++--
 arch/loongarch/include/uapi/asm/Kbuild        |   2 -
 arch/loongarch/kernel/Makefile                |   1 +
 arch/loongarch/kernel/irq.c                   |  24 +--
 arch/loongarch/kernel/paravirt.c              | 154 +++++++++++++++++
 arch/loongarch/kernel/perf_event.c            |  14 +-
 arch/loongarch/kernel/setup.c                 |   2 +
 arch/loongarch/kernel/smp.c                   |  60 ++++---
 arch/loongarch/kernel/time.c                  |  12 +-
 arch/loongarch/kvm/exit.c                     | 125 ++++++++++++--
 arch/loongarch/kvm/vcpu.c                     |  94 ++++++++++-
 arch/loongarch/kvm/vm.c                       |  11 ++
 23 files changed, 678 insertions(+), 102 deletions(-)
 create mode 100644 arch/loongarch/include/asm/kvm_para.h
 create mode 100644 arch/loongarch/include/asm/paravirt.h
 create mode 100644 arch/loongarch/include/asm/paravirt_api_clock.h
 delete mode 100644 arch/loongarch/include/uapi/asm/Kbuild
 create mode 100644 arch/loongarch/kernel/paravirt.c


base-commit: 1bbb19b6eb1b8685ab1c268a401ea64380b8bbcb
-- 
2.39.3

