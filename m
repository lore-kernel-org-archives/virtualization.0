Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCC730F95F
	for <virtualization@lists.linux.dev>; Thu, 16 Jul 2026 03:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784170841; cv=none; b=HHSGgrBrnmmFsKYJfh7H0D6806XF+TnGZblqGG9Ug4sIGTjrqlxnCHm3fu4NEki4OVE0RV3CjZVHhLeLjIak5Y9OpGYZiF3Ul/l3dqXpmJp7Ji5dv3uEDRde2DQNr80SluMq9AplOE7nhXqbV0c6ECrLZTmTLW8RWtlYdLjDIK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784170841; c=relaxed/simple;
	bh=BmEQ1JjP3yY06yAm1q24o7DQiuX5kKIWSratjSc/NsI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KXyyvO69HawrhnYG2WVB3T41hHwvmEsxuaSvrLhNDuDcI1/QMN7dAb3Yr28gKwowlEdVaHtOkfamcXGjzC2+vSXZNWDIBONqnpTaKV5o+l/suUIrVfMGFcm+KVt/WUJeGd45J9uwVsRq88XJ39St7m4pyfhv48Sh1CVy5FgRrKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=anvlaqql; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="anvlaqql"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=0t
	KiRx3pNUsOkbx59/0aLdgFv6oElr06UU1M1CtyXFY=; b=anvlaqqlh/n9UPvRC0
	rfqJDarDpEaZo+xRFS+fyKW5D0x1MuNF4QelcnQdwZmxBCMJhWKzIZfQMpcnkg25
	qV5XyYkA75KwKB044t5X+QkDrdSOUS5CZjqr5RfffYe3135xpWzZPCLwIBWXbcnO
	uo8VwaO/HSLk6KEPxKXdb0TnA=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDX_xRQSVhqKQDjHw--.39238S2;
	Thu, 16 Jul 2026 11:00:32 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	netdev@vger.kernel.org,
	xiongweimin <xiongweimin@kylinos.cn>
Subject: [PATCH] vhost-vdpa: reject zero-size unmap
Date: Thu, 16 Jul 2026 11:00:36 +0800
Message-ID: <20260716030036.123784-1-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDX_xRQSVhqKQDjHw--.39238S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw4DWr43Cr43CF43uFy7GFg_yoWDJrXEg3
	95Crn7Jr1S9r4qyF1I9rW3A34avFZruFZ09asYg345XwnxXw4ay3y8Zrn3J3WfurWUAFn3
	Aw4vyr10qw1SqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnz6wtUUUUU==
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbCzRAXpmpYSVA-CQAA3x

From: xiongweimin <xiongweimin@kylinos.cn>

Reject unmap requests with size == 0 to prevent iova + size - 1
from underflowing to U64_MAX, which would incorrectly unmap the
entire IOTLB range.

This fix also covers the error rollback path in vhost_vdpa_va_map:
when the first VMA lookup fails, map_iova equals iova, resulting
in a zero-size unmap that would otherwise clear the whole IOTLB.

Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
---
 drivers/vhost/vdpa.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index bb96b1aa5..f49bf1cfb 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -1035,6 +1035,9 @@ static void vhost_vdpa_unmap(struct vhost_vdpa *v,
 	const struct vdpa_config_ops *ops = vdpa->config;
 	u32 asid = iotlb_to_asid(iotlb);
 
+	if (!size)
+		return;
+
 	vhost_vdpa_iotlb_unmap(v, iotlb, iova, iova + size - 1, asid);
 
 	if (ops->set_map) {
--
2.39.3

