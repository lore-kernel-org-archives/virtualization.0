Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74174148312;
	Mon,  5 Aug 2024 07:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722843351; cv=none; b=icFW6wbb0ytkEPL+SZKOdyiLtUpnEWxRXUw++twkVYqd+GZz3rGKDWaXABvxdWP1VbDAedAuppvndrxLRfS7UGFYuSRQlmqOUaxASTlpJF0QM83vEMzoD06l7PcjPgtyS4BIHSgjVdquYKe+H7YHc2z9HwsPajn6R+6JOg5+y54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722843351; c=relaxed/simple;
	bh=IbpWo76oZEiAmnrd4n1GIFjyldf1Vc/SNlEwkgHYCzY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LkBYpYCTKL+FG69vLX2PZEBfkXroUtSkl+7kqvohr8CXZdDNHL5cY2e1Q4lS0AyBUAeria0k+zou1wo7flUHCIkYjy3wzAqX/lUL2pb+7AG9tEBWbmbr9YSS+kFOedFSlzv9/Jf/6Wn7yGVREWRMPviUQknSrSxErSjJHxT0S+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Cxe+rSgLBmH+UHAA--.27044S3;
	Mon, 05 Aug 2024 15:35:46 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowMAxz2fSgLBmaCgEAA--.11106S2;
	Mon, 05 Aug 2024 15:35:46 +0800 (CST)
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
Subject: [PATCH v5 0/3] Add extioi virt extension support
Date: Mon,  5 Aug 2024 15:35:43 +0800
Message-Id: <20240805073546.668475-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxz2fSgLBmaCgEAA--.11106S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

KVM_FEATURE_VIRT_EXTIOI is paravirt feature defined with EXTIOI
interrupt controller, it can route interrupt to 256 CPUs and cpu
interrupt pin IP0-IP7. Now irqchip is emulated in user space rather than
kernel space, here interface is provided for VMM to pass this feature to
VMM hypervisor.

Also interface is provided to VMM to detect and enable/disable paravirt
features provided in KVM hypervisor. And api kvm_para_has_feature() is
available on LoongArch for device driver to detect paravirt features and
do some optimization.

---
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
 arch/loongarch/include/asm/loongarch.h        |  13 ---
 arch/loongarch/include/uapi/asm/Kbuild        |   2 -
 arch/loongarch/include/uapi/asm/kvm.h         |   5 +
 arch/loongarch/include/uapi/asm/kvm_para.h    |  24 ++++
 arch/loongarch/kernel/paravirt.c              |  32 ++---
 arch/loongarch/kvm/exit.c                     |   6 +-
 arch/loongarch/kvm/vcpu.c                     |  41 ++++++-
 arch/loongarch/kvm/vm.c                       |  43 ++++++-
 drivers/irqchip/irq-loongson-eiointc.c        | 109 ++++++++++++++----
 14 files changed, 355 insertions(+), 58 deletions(-)
 create mode 100644 arch/loongarch/include/uapi/asm/kvm_para.h


base-commit: de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed
-- 
2.39.3

