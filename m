Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2612E13A261;
	Fri, 30 Aug 2024 09:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725010360; cv=none; b=uUxj2f3sU956FkjVFr8EWgDHcCXRY6N8o6uDP13aF/x+kIrM9zPjZjXjmAVUWJlhZ24sjanvD5D045D5LMdhURtIH3sCRiBWwNWSjR+QWTwefJjukKHVdL8zlza2tBXslbTPC9iPbm54C7Xg24e+WwwDfO6ASscJe1frwyTQYNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725010360; c=relaxed/simple;
	bh=O67aehAYE/Q6ac7Md45oCuRtovVbTK5tZ13BU6sXblo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kRlf5G7z4MxaK1AWhzDtz7xFNXogYS1a7p004j3a0JdAn1H/pHfn6H9UbT3pFlthiAgRS3tYycv55Afm8dVdjLP3SKkcM4Y1A7YNKfA3cRkqajv3bZS7Ew7L7VEMHTmk3Cdb1g+CiLchNDu/EczPBzjD2aWjxfrdvHDcMhhlvFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Cx+emukdFmXAIlAA--.8120S3;
	Fri, 30 Aug 2024 17:32:30 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowMAxrt6tkdFmizAAAA--.1421S2;
	Fri, 30 Aug 2024 17:32:30 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Tianrui Zhao <zhaotianrui@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: WANG Xuerui <kernel@xen0n.name>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	x86@kernel.org,
	Song Gao <gaosong@loongson.cn>
Subject: [PATCH v8 0/3] Add extioi virt extension support
Date: Fri, 30 Aug 2024 17:32:26 +0800
Message-Id: <20240830093229.4088354-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxrt6tkdFmizAAAA--.1421S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

KVM_FEATURE_VIRT_EXTIOI is paravirt feature defined with EXTIOI
interrupt controller, it can route interrupt to 256 vCPUs and CPU
interrupt pin IP0-IP7. Now EXTIOI irqchip is emulated in user space
rather than kernel space, here interface is provided for VMM to pass
this feature to KVM hypervisor.

Also interface is provided for user-mode VMM to detect and enable/disable
paravirt features from KVM hypervisor. And api kvm_para_has_feature() is
available on LoongArch for device driver to detect paravirt features and
do some optimization.
---
v7 ... v8:
  1. Rename function name virt_extioi_set_irq_route() with 
     veiointc_set_irq_route() to keep consistent with that on real machine
  2. Add comments before calling veiointc_set_irq_route()

v6 ... v7:
  1. Replace function name guest_pv_has() to check whether paravirt feature
     is supported with kvm_guest_has_pv_feature(), since there is
     similiar function kvm_guest_has_lsx/lasx
  2. Keep notation about CPUCFG area 0x40000000 -- 0x400000ff in header
     file arch/loongarch/include/asm/loongarch.h
  3. Remove function kvm_eiointc_init() and inline it with caller
     function.

v5 ... v6:
  1. Put KVM hypervisor type checking function kvm_para_available()
     inside function kvm_arch_para_features(), so that upper caller
     is easy to use.
  2. Add inline function guest_pv_has() in KVM module to judge whether
     the specific paravirt feature is supported or not. And do valid
     checking at hypercall and user space ioctl entrance with it.
  3. Fix some coding style issue such as variable declarations and spell
     checking.

v4 ... v5:
  1. Refresh annotation "WITH Linux-syscall-note" about uapi header file
     arch/loongarch/include/uapi/asm/kvm_para.h

v3 ... v4:
  1. Implement function kvm_para_has_feature() on LoongArch platform,
     and redefine feature with normal number rather than bitmap number,
     since function kvm_para_has_feature() requires this.
  2. Add extioi virt extension support in this patch set.
  3. Update extioi virt extension support patch with review comments,
     including documentation, using kvm_para_has_feature() to detect
     features etc.

v2 ... v3:
  1. Add interface to detect and enable/disable paravirt features in
     KVM hypervisor.
  2. Implement function kvm_arch_para_features() for device driver in
     VM side to detected supported paravirt features.

v1 ... v2:
  1. Update changelog suggested by WangXuerui.
  2. Fix typo issue in function kvm_loongarch_cpucfg_set_attr(),
     usr_features should be assigned directly, also suggested by
     WangXueRui.
---
Bibo Mao (3):
  LoongArch: KVM: Enable paravirt feature control from VMM
  LoongArch: KVM: Implement function kvm_para_has_feature
  irqchip/loongson-eiointc: Add extioi virt extension support

 .../arch/loongarch/irq-chip-model.rst         |  64 ++++++++++
 .../zh_CN/arch/loongarch/irq-chip-model.rst   |  55 +++++++++
 arch/loongarch/include/asm/irq.h              |   1 +
 arch/loongarch/include/asm/kvm_host.h         |   7 ++
 arch/loongarch/include/asm/kvm_para.h         |  11 ++
 arch/loongarch/include/asm/kvm_vcpu.h         |   4 +
 arch/loongarch/include/asm/loongarch.h        |  11 +-
 arch/loongarch/include/uapi/asm/Kbuild        |   2 -
 arch/loongarch/include/uapi/asm/kvm.h         |   5 +
 arch/loongarch/include/uapi/asm/kvm_para.h    |  24 ++++
 arch/loongarch/kernel/paravirt.c              |  35 +++---
 arch/loongarch/kvm/exit.c                     |  19 +--
 arch/loongarch/kvm/vcpu.c                     |  47 ++++++--
 arch/loongarch/kvm/vm.c                       |  43 ++++++-
 drivers/irqchip/irq-loongson-eiointc.c        | 112 ++++++++++++++----
 15 files changed, 374 insertions(+), 66 deletions(-)
 create mode 100644 arch/loongarch/include/uapi/asm/kvm_para.h


base-commit: 1b5fe53681d9c388f1600310fe3488091701d4d0
-- 
2.39.3

