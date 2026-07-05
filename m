Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4FA1EBFE0
	for <virtualization@lists.linux.dev>; Sun,  5 Jul 2026 00:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783211152; cv=none; b=dYGajhISvWfQjyyVDR42czvNWhHNW65euMwSFgxu/vDy6khE7sqLitt5R9Xk2M5wLOhF2TcrQ+VwyqN+oRMopM0CVQhteIvBHykuAiwFR3605aygvUG7UoYrqLQLhDV8ZDk3ePOHPJDt32tyIFVF977M/oFOG3euvitfzXjFCjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783211152; c=relaxed/simple;
	bh=700BE7ty1R5dtVgiGpChZ1/+GllEa5/vJVbn/29DVuo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MVL7ePV+vMQ2Ca3ic+iFKwOks+9C+rp03rmXOm5Xps4zrDIfZaSJoh67GjphArH4fmTPH7OF3fWmc4UqOC9KLXSPNKl3QokeaQUAoc3YlsMmZMuO5zJ6fDoCpjSn/tJ77lUuhSDtehtz5kTg3+1c3FB+YxNDSapN+O2jVq1R2Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-03 (Coremail) with SMTP id rQCowAC3ydCMpElqd+jfFg--.16138S2;
	Sun, 05 Jul 2026 08:25:48 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: schalla@marvell.com,
	vattunuru@marvell.com,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vdpa: octeon_ep: add missing MODULE_DEVICE_TABLE()
Date: Sun,  5 Jul 2026 08:25:46 +0800
Message-ID: <20260705002546.85004-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAC3ydCMpElqd+jfFg--.16138S2
X-Coremail-Antispam: 1UD129KBjvdXoWruryUGF1fCF1rCF47Cr18Grg_yoWktrg_Cr
	18JF4a9Fs5CFn5K3WUKwnavryI9a48Wr97Cr97trn3Kw4xAw1fAasrKr13Jw1kWrW8JF9x
	Jwn8WFy8uF47ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoq
	2MUUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

The driver has a match table for the pci bus wired into its driver
structure, but the table is not exported with MODULE_DEVICE_TABLE().

Add the missing MODULE_DEVICE_TABLE() entry so module alias information
is generated for automatic module loading.

This is a source-level fix.  It does not claim dynamic hardware
reproduction; the evidence is the driver-owned match table, its use by
the driver registration structure, and the missing module alias
publication.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/vdpa/octeon_ep/octep_vdpa_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
index 31a02e7fd7f2..9bedcd81a174 100644
--- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
+++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
@@ -884,6 +884,7 @@ static struct pci_device_id octep_pci_vdpa_map[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, OCTEP_VDPA_DEVID_CN103K_VF) },
 	{ 0 },
 };
+MODULE_DEVICE_TABLE(pci, octep_pci_vdpa_map);
 
 static struct pci_driver octep_pci_vdpa = {
 	.name     = OCTEP_VDPA_DRIVER_NAME,
-- 
2.53.0

