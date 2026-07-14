Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FB1381B16
	for <virtualization@lists.linux.dev>; Tue, 14 Jul 2026 02:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783997087; cv=none; b=CaDqDV+guCm57oQ/58HIph4AGACRrDVL4Q4QtWef5pRiSkK08GH2+YbtJQTo3YXstQpkm1Mx392ucEGXKTOEWhncq0D8ufmWXKG7HNh7KQ1lAku4+ApJJ0COz6bAMtb9bpMAvA6+k7WoYXmmZf/07b7udmV6ohIpT6BTyA02GIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783997087; c=relaxed/simple;
	bh=r+BhOWwHZR/nXn933MZz2l4J+vv7UjbRlj2bs9BJtFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jlsfa0DuwKagz28Oq6E2Oit43iQN6400GJvh93O+e/qDiMF0L5VW5FDGpePagBj0sHPLZlBjOvL8+zvHi3Hgotrh9J8ZQ+YGql04FdCkos3yV5CthQgSr1sd5kYo3d5G0Ai8qBxcsqPl1d+2qB79jnx5RZre36un+DrqO1uUu+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eJZWLYGe; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eJZWLYGe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=eg
	NvZkkgF0O2goDym7Bxh4vIiL8gXxR26e03veP3E3I=; b=eJZWLYGeTPSdRKxJDs
	lxXiXSpWdTAOy9lO9b+vJ0vCbEWMdQTnTZcRYxKrpPdIsUMA4eLysplG49r9fmnl
	Z7Cazs2S6DSk+9v6ZhiOKzE+XsBSsF3F5BTThgi9FzIOVwbV6cf9KfY3uIopT/HM
	7jIMPfdAB34TKOENeQgHtEqrw=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgDX0kKSolVqaKemGA--.24446S2;
	Tue, 14 Jul 2026 10:44:34 +0800 (CST)
From: weimin xiong <15927021679@163.com>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	kvm@vger.kernel.org,
	xiongweimin <xiongweimin@kylinos.cn>
Subject: [PATCH] vhost: fix inaccurate kdoc in iotlb helpers
Date: Tue, 14 Jul 2026 10:44:34 +0800
Message-ID: <20260714024434.188302-1-15927021679@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgDX0kKSolVqaKemGA--.24446S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF4rKr48ur4fZr1UZw13Jwb_yoW8Gw4DpF
	4xW34UKr1jvw1UJw4DC3WfGFnYg3WxCr48CrWfW3W5Zrn8JryUGrsIk3WUtr1xCFW8CF13
	XFy0vF15KrykC37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j8J5rUUUUU=
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC8xO8RWpVopO9bgAA3E

From: xiongweimin <xiongweimin@kylinos.cn>

Correct missing "if" in the add_range_ctx return description, and
align vhost_iotlb_alloc documentation with its NULL return on
allocation failure.

Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
---
 drivers/vhost/iotlb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/iotlb.c b/drivers/vhost/iotlb.c
index e1414c774..10d1c4073 100644
--- a/drivers/vhost/iotlb.c
+++ b/drivers/vhost/iotlb.c
@@ -44,7 +44,7 @@ EXPORT_SYMBOL_GPL(vhost_iotlb_map_free);
  * @perm: access permission of this range
  * @opaque: the opaque pointer for the new mapping
  *
- * Returns an error last is smaller than start or memory allocation
+ * Returns an error if last is smaller than start or memory allocation
  * fails
  */
 int vhost_iotlb_add_range_ctx(struct vhost_iotlb *iotlb,
@@ -143,11 +143,11 @@ void vhost_iotlb_init(struct vhost_iotlb *iotlb, unsigned int limit,
 EXPORT_SYMBOL_GPL(vhost_iotlb_init);
 
 /**
- * vhost_iotlb_alloc - add a new vhost IOTLB
+ * vhost_iotlb_alloc - allocate a new vhost IOTLB
  * @limit: maximum number of IOTLB entries
  * @flags: VHOST_IOTLB_FLAG_XXX
  *
- * Returns an error is memory allocation fails
+ * Returns NULL if memory allocation fails
  */
 struct vhost_iotlb *vhost_iotlb_alloc(unsigned int limit, unsigned int flags)
 {
-- 
2.43.0


No virus found
		Checked by Hillstone Network AntiVirus

