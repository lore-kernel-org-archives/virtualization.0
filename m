Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AFF315D3E
	for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 08:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784102967; cv=none; b=o7MhKkX5w7eAMyCn0STTxmpFvyZFLaBUOBpKo654k4RUhGJZb4Fj37bZznJG5adhhdOBej9IQmv1we0xwX33SvalrGFUkdffjYDbhdDU+gLr8b/5xCujX7Y/Q6CMs4uViLyIj+hCkwa0pPalCwATSw7RJi5tMLHdm67SeTuGwo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784102967; c=relaxed/simple;
	bh=SJFmFkfhsltfgrz2J9eDAQcLIP4a8wUqpNXfcN9yNqA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=P186zyaqgc4N/0j75qv9ZW3jSwwfFoKkmoVmydNIiq7rh+Q8qz7HTE4QeBCWzjejCsn0VqzfeVO9UVqwj9k52jpWobfEwsrMurElcwDd/QcC+YficyQ+oR6qb24wxV7EPRfKon51ZjUHOPiYpdilL0JX9nqeqpn687FrvTYGp9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LvW9LIQV; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LvW9LIQV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Hk
	c4BqTzkBkrdhNJBK7oj/vlJFH0BXOJ/8VY4yK1mkI=; b=LvW9LIQVCcI/YX0kT8
	27U5kGlwM9TmHRTPxD8DrM7+/zTbC9FXk8NyBggNpDH7Lp79iCNyPqMOwux+cIgN
	mZgWNxjwHLrNUyDFElUwesyYBizrSBzSnDXTL+tlahsRwPp6Ot3dptaoyH8OqQwj
	duoyDLOTqCcd41dhm75aj3u5U=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wCHjxkrQFdqkOeoJg--.39348S2;
	Wed, 15 Jul 2026 16:09:16 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: virtualization@lists.linux.dev
Subject: [PATCH 02/12] vhost-scsi: remove dead commented code in vhost_scsi_make_tport
Date: Wed, 15 Jul 2026 16:09:15 +0800
Message-ID: <20260715080915.21742-1-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHjxkrQFdqkOeoJg--.39348S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrWfKw1kurW7Cr4fWr4kZwb_yoW3KrX_u3
	yFqr1DXFn3Cr4vvw4kAFy3A34Fkw48Xr1kuasYyrZxZr9rXrn0ka4kAF95Ar47Zry8GF9r
	CFs8AFyUZw4IyjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0-db5UUUUU==
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbCzQyLG2pXQCyvmwAA30

From: xiongweimin <xiongwm2026@163.com>

Remove dead commented-out code that was left behind during previous
refactoring. The code checked for invalid WWN parsing but is no longer
used.

Signed-off-by: Weimin Xiong <xiongwm2026@163.com>
Co-authored-by: Cursor <cursoragent@cursor.com>
---
 drivers/vhost/scsi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 81e905c4c..77e47f246 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -2841,9 +2841,6 @@ vhost_scsi_make_tport(struct target_fabric_configfs *tf,
 	u64 wwpn = 0;
 	int off = 0;
 
-	/* if (vhost_scsi_parse_wwn(name, &wwpn, 1) < 0)
-		return ERR_PTR(-EINVAL); */
-
 	tport = kzalloc_obj(*tport);
 	if (!tport) {
 		pr_err("Unable to allocate struct vhost_scsi_tport");
-- 
2.43.0

