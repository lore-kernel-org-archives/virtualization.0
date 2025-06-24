Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4DB1D63C0
	for <virtualization@lists.linux.dev>; Tue, 24 Jun 2025 06:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750746595; cv=none; b=oZ8aQhflFHhdDXSv2D52jPa6s0aD5dVPBSpPRDs4vcqb0mS0xy+9uB0iLmiPIH420ZyLnvkIngUuPzb75i91NgTipe/l8vg4iGfXfW/kw5m3rDd9pUXU8q92kB7rj24Pe52nWoMY8kmjliyerkRjREj+mJvIkyR+mkJo5Kt1sOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750746595; c=relaxed/simple;
	bh=Xlgt+AJdlMJAX9PYVZcWhhPh/iLrjRKOC69qLTabt28=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RgcUW1iUPPYyrvqgrlGLypQX2FMfkK8+yheFAtnV7N4H69UWdYv6qERMNoIEmhvR6qK23ik7iuMc+8P1OUjUo3zvt/RjoEkn6UkM2BqY8CbXxHIjMpS51axld4TX6GQ/XLg3ii5SyJL8H5S04YOkH908xnjYoaTJkTK47YMQL5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.149])
	by gateway (Coremail) with SMTP id _____8AxQK3dRVpo1QwcAQ--.45981S3;
	Tue, 24 Jun 2025 14:29:49 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.149])
	by front1 (Coremail) with SMTP id qMiowMCxqhrPRVpomGsoAQ--.33729S2;
	Tue, 24 Jun 2025 14:29:48 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>
Cc: linux-pci@vger.kernel.org,
	Juergen Gross <jgross@suse.com>,
	virtualization@lists.linux.dev,
	Jianmin Lv <lvjianmin@loongson.cn>,
	Huacai Chen <chenhuacai@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org
Subject: [PATCH] PCI: Extend isolated function probing to LoongArch
Date: Tue, 24 Jun 2025 14:29:27 +0800
Message-ID: <20250624062927.4037734-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxqhrPRVpomGsoAQ--.33729S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Jw1UAFWfCrW8JrWrWrW5XFc_yoWDtwc_Aw
	n3XF4xWrs7ZFy2ga9rWrZ7JF1rWw40yr1rZr1vqr4Ykas0ya1DGwnrJF9xJ3W8GF47ZrZI
	k3WfW3ySyr12gosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb7xYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkUUUUU=

Like s390 and the jailhouse hypervisor, LoongArch's PCI architecture
allows passing isolated PCI functions to a guest OS instance. So it is
possible that there is a multi-function device without function 0 for
the host or guest.

Allow probing such functions by adding a IS_ENABLED(CONFIG_LOONGARCH)
case in the hypervisor_isolated_pci_functions() helper.

This is similar to commit 189c6c33ff421def040b9 ("PCI: Extend isolated
function probing to s390").

Cc: <stable@vger.kernel.org>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 include/linux/hypervisor.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/hypervisor.h b/include/linux/hypervisor.h
index 9efbc54e35e5..be5417303ecf 100644
--- a/include/linux/hypervisor.h
+++ b/include/linux/hypervisor.h
@@ -37,6 +37,9 @@ static inline bool hypervisor_isolated_pci_functions(void)
 	if (IS_ENABLED(CONFIG_S390))
 		return true;
 
+	if (IS_ENABLED(CONFIG_LOONGARCH))
+		return true;
+
 	return jailhouse_paravirt();
 }
 
-- 
2.47.1

