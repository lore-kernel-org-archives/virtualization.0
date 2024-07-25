Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951A11993B6;
	Thu, 25 Jul 2024 12:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721910500; cv=none; b=NQXa9p1YjUh0YqAwg805lCYgie2YXUNwgb41FTuyOBy4baLZN1IbDyP4juY+IAf11wmT80nrq3DfZRSmCwL+xxDmfoAxVDekYPrvVQARI0ac7ETYJNNuNjQKXWiKkQwqKxYHQlCiPzeD/SwScJKGm8gfPQFtld/J1jdcxuc+G/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721910500; c=relaxed/simple;
	bh=MvUCDXs2wFdaYwczgJ0I/v9jzVlvm5YIot1iKRT+yaM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U4A6mjHviCn4U7yZf4MJG0qS3qD8J8icR724mzU+wKyLKvdgWjVQcSJF7qExGZvIS+sbzIv2yb0vVn0bT+Mc030fp62tPf2XgHso4qUz4hUVZMZ4hyYbCcXwuBhUrCJHVyRB0EIIIoMDwVoR8c8zpL2Z9TJ723JbvqXWg1H4f90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.10.34])
	by gateway (Coremail) with SMTP id _____8Ax2endRKJmTocBAA--.5690S3;
	Thu, 25 Jul 2024 20:28:14 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.10.34])
	by front1 (Coremail) with SMTP id qMiowMDxIuTcRKJmog8BAA--.7001S2;
	Thu, 25 Jul 2024 20:28:12 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Tianrui Zhao <zhaotianrui@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	x86@kernel.org
Subject: [PATCH v3 0/2] Add paravirt KVM_FEATURE_VIRT_EXTIOI feature
Date: Thu, 25 Jul 2024 20:28:10 +0800
Message-Id: <20240725122812.3296140-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxIuTcRKJmog8BAA--.7001S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJrW5Gr47Cr1DZF45Xr45XFc_yoW8Ar15pa
	sxArn3Jr48Gr4fAwsxtan5ury3Xr1xG3Waqay2k34UAF4a9r1UZr48KrZ8ZFyDt3yfXr10
	gF1rG345W3WqvabCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0epB3UUUUU==

KVM_FEATURE_VIRT_EXTIOI is paravirt feature defined with EXTIOI
interrupt controller, it can route interrupt to 256 CPUs and cpu
interface IP0-IP7. Now irqchip is emulated in user space rather than
kernel space, here interface is provide for VMM to pass it to KVM
hyperviso.

Also interface is provide to VMM to detect and enable/disable paravirt
features provided in KVM hypervisor.

---
v2 ... v3:
  1. Add interface to detect and enable/disable paravirt features in
KVM hypervisor.
  2. Implement function kvm_arch_para_features() for device driver in
VM side to detected supported paravirt features.

v1 ... v2:
  1. Update changelog suggested by WangXuerui.
  2. Fix typo issue in function kvm_loongarch_cpucfg_set_attr(),
usr_features should be assigned directly, also suggested by WangXueRui.

---
Bibo Mao (2):
  LoongArch: KVM: Enable paravirt feature control from VMM
  LoongArch: KVM: Implement function kvm_arch_para_features

 arch/loongarch/include/asm/kvm_host.h      |  9 +++++
 arch/loongarch/include/asm/kvm_para.h      | 11 ++++++
 arch/loongarch/include/asm/loongarch.h     | 13 -------
 arch/loongarch/include/uapi/asm/Kbuild     |  2 --
 arch/loongarch/include/uapi/asm/kvm.h      |  2 ++
 arch/loongarch/include/uapi/asm/kvm_para.h | 24 +++++++++++++
 arch/loongarch/kernel/paravirt.c           | 22 ++++++++----
 arch/loongarch/kvm/exit.c                  |  4 +--
 arch/loongarch/kvm/vcpu.c                  | 41 +++++++++++++++++++---
 arch/loongarch/kvm/vm.c                    | 12 +++++++
 10 files changed, 111 insertions(+), 29 deletions(-)
 create mode 100644 arch/loongarch/include/uapi/asm/kvm_para.h


base-commit: c33ffdb70cc6df4105160f991288e7d2567d7ffa
-- 
2.39.3

