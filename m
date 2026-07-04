Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97BA30C62D
	for <virtualization@lists.linux.dev>; Sat,  4 Jul 2026 15:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783178858; cv=none; b=LM5Ii1tQpoWcRaH2lA9HQxN54h9gZx647CPpRwMID1R52LoQzVTtIibiUItGcBRHbMtrAw8UKERgU6BGigf6sSl01LpA5AiXNkFSPM73idozqvO1EGQu+MQrIUGSc+2sCRlMuS5JKuHEcbcVXdjRWA+58GHH2nSqH+TWvp62siA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783178858; c=relaxed/simple;
	bh=sjHZoCgK8Cc7P2EJ7VLziBPmKChlopzeE6fk6uyELhA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lhtLjp8w8jGwHY3bVhKFQbUNSFt/UmZcApXHA+pK//oAwMSobGN5kq2qGOus5EBSs2fuVFVxUA2aS667dAx3nbx/C2El1Hd8lt+ruTsWBHFVTMl/5uQD8WUWjgx5iyxM6NV9qfu2l2M01ot8YqP1WEjPWI2O5Wr/uaxEuGuDfYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowAAnf9JmJklq2d_bFg--.19805S2;
	Sat, 04 Jul 2026 23:27:34 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vdpa: alibaba: add missing MODULE_DEVICE_TABLE()
Date: Sat,  4 Jul 2026 23:27:32 +0800
Message-ID: <20260704152732.55338-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAnf9JmJklq2d_bFg--.19805S2
X-Coremail-Antispam: 1UD129KBjvdXoWruryUGF1fCF1rCF47Cr18Grg_yoWDuFbEkr
	1kXFZxWr1UCFsYkw1xKrWfZFy0ka4rurn7Ja92qr9Iq3W7twnrJa97Cr9Iyw1qyrW8tFs8
	J34DWr18ur42yjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_
	Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x0JUJuc
	_UUUUU=
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
 drivers/vdpa/alibaba/eni_vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni_vdpa.c
index e476504db0c8..fd6fdba46094 100644
--- a/drivers/vdpa/alibaba/eni_vdpa.c
+++ b/drivers/vdpa/alibaba/eni_vdpa.c
@@ -545,6 +545,7 @@ static struct pci_device_id eni_pci_ids[] = {
 			 VIRTIO_ID_NET) },
 	{ 0 },
 };
+MODULE_DEVICE_TABLE(pci, eni_pci_ids);
 
 static struct pci_driver eni_vdpa_driver = {
 	.name		= "alibaba-eni-vdpa",
-- 
2.53.0

