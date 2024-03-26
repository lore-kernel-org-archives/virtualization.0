Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56652134420;
	Tue, 26 Mar 2024 08:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711440396; cv=none; b=u1P2wZaH3j4/yCWBizkDJPfIaPQ2hu1L/pIkvRlSB+SwH6I/9OqFsN91N1JhS2il1BpR15Wm9kZ5CiSYAxKuVYXpMKZsSqlO20WZawyCCCKhrh9Sy746x0p8FxxuOB4S2TZ1hIHOIQ2luO6EstzJK4tExCHyeOGCcvB0jxIwsa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711440396; c=relaxed/simple;
	bh=f9hCfYedwpxEoNBuNNWZFPjqKzvQdVCG0xEb4sz+K0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S9Fry1/kvDHGClUd1X9zRHMwQmsMOE44hpbptBrY3J10EL8xTWwQuKQvqIKB+2J9WED02BgiWjLcylp/3bq6koxcrNQ12CRO9v2aF3Nce2nnWffPKRWaIxzuz/KUL9IiJOkKWdFD6/0wvLo2MlkJSl2LwILB6QYQYLIFN6ynar8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Bx3+sCggJmBkoeAA--.5277S3;
	Tue, 26 Mar 2024 16:06:26 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxbRMBggJmhaRoAA--.9600S2;
	Tue, 26 Mar 2024 16:06:25 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Tianrui Zhao <zhaotianrui@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: Juergen Gross <jgross@suse.com>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	x86@kernel.org
Subject: [PATCH 0/2] LoongArch: Add steal time support
Date: Tue, 26 Mar 2024 16:06:23 +0800
Message-Id: <20240326080625.898051-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxbRMBggJmhaRoAA--.9600S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Para-virt feature steal time is added in both kvm and guest kernel side.
It is silimar with other architectures, steal time structure comes from
guest memory, also pseduo register is used to save/restore base address
of steal time structure, so that vm migration is supported also.

Bibo Mao (2):
  LoongArch: KVM: Add steal time support in kvm side
  LoongArch: Add steal time support in guest side

 arch/loongarch/include/asm/kvm_host.h  |   7 ++
 arch/loongarch/include/asm/kvm_para.h  |  10 ++
 arch/loongarch/include/asm/loongarch.h |   1 +
 arch/loongarch/include/asm/paravirt.h  |   5 +
 arch/loongarch/include/uapi/asm/kvm.h  |   4 +
 arch/loongarch/kernel/paravirt.c       | 130 +++++++++++++++++++++++++
 arch/loongarch/kernel/time.c           |   2 +
 arch/loongarch/kvm/exit.c              |  35 ++++++-
 arch/loongarch/kvm/vcpu.c              | 120 +++++++++++++++++++++++
 9 files changed, 309 insertions(+), 5 deletions(-)


base-commit: 2ac2b1665d3fbec6ca709dd6ef3ea05f4a51ee4c
-- 
2.39.3

