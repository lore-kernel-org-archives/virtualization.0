Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345629475;
	Fri, 24 May 2024 07:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716536305; cv=none; b=YwXxJ+vhAj4RD1tEhbK/JOVSJxssAN5Ho0mkdrA8nKYlHnB2rUS+RbQFjn3GRX4ci7yRnuGslr/BwCvcpTb3HOMQR5/lkj3KdYzRWM14STgSl4teiCOrICZ9B0x6FjTlEc7vE6nlV0jQkqnqJnJf3LYwFIgV7m7xSiYcJqrus9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716536305; c=relaxed/simple;
	bh=iQvVWMmNWY2muA4rMvVgeuF8u4UtlmePBbkozhT5u/g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hJjRQOuYatTshX4SJVuXHYnt77NejA4LtxaifsijozXHWMyjPSpqFmzO3gBkZlgUX3ErK+hNW4Z2xst2TaB3Skdd0TM9xx0aTUshENrHerIXho1JpMit2qtPAHhv3w+4RMgkVflz2ARu9FAw2HV6rRgRZ63Cawqt4VEAvAJYhP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxQK_lQ1Bm1ksDAA--.3487S3;
	Fri, 24 May 2024 15:38:13 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxZcXlQ1BmScUHAA--.10650S2;
	Fri, 24 May 2024 15:38:13 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Tianrui Zhao <zhaotianrui@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: Juergen Gross <jgross@suse.com>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v4 0/2] LoongArch: Add steal time support
Date: Fri, 24 May 2024 15:38:10 +0800
Message-Id: <20240524073812.731032-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxZcXlQ1BmScUHAA--.10650S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Para-virt feature steal time is added in both kvm and guest kernel side.
It is silimar with other architectures, steal time structure comes from
guest memory, also pseduo register is used to save/restore base address
of steal time structure, so that when vm is migrated, kvm module on
target machine knows the base address of steal time.

---
v3 ... v4:
  1. To resolve compile dependency problem, enable SCHED_INFO option
section if KVM is enabled.
  2. Put new added option PARAVIRT_TIME_ACCOUNTING in one submemu with
PARAVIRT in file arch/loongarch/Kconfig.

v2 ... v3:
  1. Solve code confliction based on the kernel 6.9.0
  2. Add kernel parameter no-steal-acc support on LoongArch with file
Documentation/admin-guide/kernel-parameters.txt
  3. Add strict checking with pv stealtimer gpa address in function
kvm_save_notify() and kvm_loongarch_pvtime_set_attr()

v1 ... v2:
  1. Add PARAVIRT_TIME_ACCOUNTING kconfig option in file
arch/loongarch/Kconfig
  2. Function name change such as replace pv_register_steal_time with
pv_enable_steal_time etc

---

Bibo Mao (2):
  LoongArch: KVM: Add steal time support in kvm side
  LoongArch: Add steal time support in guest side

 .../admin-guide/kernel-parameters.txt         |   2 +-
 arch/loongarch/Kconfig                        |  11 ++
 arch/loongarch/include/asm/kvm_host.h         |   7 +
 arch/loongarch/include/asm/kvm_para.h         |  10 ++
 arch/loongarch/include/asm/kvm_vcpu.h         |   4 +
 arch/loongarch/include/asm/loongarch.h        |   1 +
 arch/loongarch/include/asm/paravirt.h         |   5 +
 arch/loongarch/include/uapi/asm/kvm.h         |   4 +
 arch/loongarch/kernel/paravirt.c              | 133 ++++++++++++++++++
 arch/loongarch/kernel/time.c                  |   2 +
 arch/loongarch/kvm/Kconfig                    |   1 +
 arch/loongarch/kvm/exit.c                     |  38 ++++-
 arch/loongarch/kvm/vcpu.c                     | 124 ++++++++++++++++
 13 files changed, 339 insertions(+), 3 deletions(-)


base-commit: 6e51b4b5bbc07e52b226017936874715629932d1
-- 
2.39.3

