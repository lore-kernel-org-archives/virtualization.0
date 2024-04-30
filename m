Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7048F6D;
	Tue, 30 Apr 2024 01:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714441514; cv=none; b=FJsBS2ZBLc85mQSGeZ6zdo4409cJMwt52nUWvlUxoVVTSu/E9h74pNSxlY+ULFIiPMQV43QZEXHFSlNpezoGo5gCyaCHo6BrDemrjrpR2CT3zixDfYRDiT4zVstAfW/FlqvBQPPyw+/poakBwNI4/sXJkWjSFdxBtBHMxcL2uGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714441514; c=relaxed/simple;
	bh=FCCUCcSRQzl70WCsycckCWI1PlotsQL9ggX/zV1th3M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IABtEZGAlY24RZX9z8bXvLFGTOLT1PnTP1LDSs7/gmjcyc9kBInHcxJYvqddZ/Lxqc7ecxp5PhVGSglylKAMoFVxHQXTxYTJ6GlDtTDXFrY5k8FKFC7FPWDXmPHLMH5R9CsHphiitBsiz6f0++ehMjzKFX58nXoIVjEKLYIvIj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8BxtOolTTBmrzoFAA--.5348S3;
	Tue, 30 Apr 2024 09:45:09 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxyt0hTTBmfrwKAA--.25728S2;
	Tue, 30 Apr 2024 09:45:05 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Tianrui Zhao <zhaotianrui@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: Juergen Gross <jgross@suse.com>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v2 0/2] LoongArch: Add steal time support
Date: Tue, 30 Apr 2024 09:45:03 +0800
Message-Id: <20240430014505.2102631-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Cxyt0hTTBmfrwKAA--.25728S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Para-virt feature steal time is added in both kvm and guest kernel side.
It is silimar with other architectures, steal time structure comes from
guest memory, also pseduo register is used to save/restore base address
of steal time structure, so that vm migration is supported also.

---
v2:
  1. Add PARAVIRT_TIME_ACCOUNTING kconfig option in file
arch/loongarch/Kconfig
  2. Function name change such as replace pv_register_steal_time with
pv_enable_steal_time etc

---
Bibo Mao (2):
  LoongArch: KVM: Add steal time support in kvm side
  LoongArch: Add steal time support in guest side

 arch/loongarch/Kconfig                 |  11 +++
 arch/loongarch/include/asm/kvm_host.h  |   7 ++
 arch/loongarch/include/asm/kvm_para.h  |  10 ++
 arch/loongarch/include/asm/loongarch.h |   1 +
 arch/loongarch/include/asm/paravirt.h  |   5 +
 arch/loongarch/include/uapi/asm/kvm.h  |   4 +
 arch/loongarch/kernel/paravirt.c       | 131 +++++++++++++++++++++++++
 arch/loongarch/kernel/time.c           |   2 +
 arch/loongarch/kvm/exit.c              |  29 +++++-
 arch/loongarch/kvm/vcpu.c              | 120 ++++++++++++++++++++++
 10 files changed, 318 insertions(+), 2 deletions(-)


base-commit: 2c8159388952f530bd260e097293ccc0209240be
-- 
2.39.3

