Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1FF1FDD;
	Tue, 21 May 2024 02:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716259571; cv=none; b=A7GpoMYJrr49VpmwQf459442pen/VNflgL372XU5KPh8xgoQiagel64LJ7AI6zo6uqGCmqyhjaHI1jMuxMQ3IunLUuPJSEMCX0TVOMpqfYvjMewX7ZX3WBe8r8AHOLfEFyq8tJi0eP/Esh+OWhxIJSvtqZH90ICW2vNAIAz/mbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716259571; c=relaxed/simple;
	bh=YD4wh2WZRW/jyu8qIATM5gSWoF9yUhPX1JDPYJj10Aw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WE1cISvX4LmS+JYihD0e1uOidFKaHF7sOwpUiVRbmI/KpUQuLJFJ4rsA9XpZZlGHoGDmhqY01mhJ7DEVyx+NgwqhH384jfdrSoHwcasNJujh/+x/jczC7a+vyknb8oGlrBgsBCIjZprR9JQoslJxy5M6rbDWxzeLnICvqPjOjJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxPOvmCkxmbRoBAA--.2866S3;
	Tue, 21 May 2024 10:45:58 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxHMfkCkxm764CAA--.9740S2;
	Tue, 21 May 2024 10:45:57 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Tianrui Zhao <zhaotianrui@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: Juergen Gross <jgross@suse.com>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v3 0/2] LoongArch: Add steal time support
Date: Tue, 21 May 2024 10:45:54 +0800
Message-Id: <20240521024556.419436-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxHMfkCkxm764CAA--.9740S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Para-virt feature steal time is added in both kvm and guest kernel side.
It is silimar with other architectures, steal time structure comes from
guest memory, also pseduo register is used to save/restore base address
of steal time structure, so that vm migration is supported also.

---
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
 arch/loongarch/kernel/paravirt.c              | 131 ++++++++++++++++++
 arch/loongarch/kernel/time.c                  |   2 +
 arch/loongarch/kvm/exit.c                     |  38 ++++-
 arch/loongarch/kvm/vcpu.c                     | 124 +++++++++++++++++
 12 files changed, 336 insertions(+), 3 deletions(-)


base-commit: 3c999d1ae3c75991902a1a7dad0cb62c2a3008b4
-- 
2.39.3

