Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD85239E7E
	for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 08:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784102969; cv=none; b=bldu+GnFosC93S+gPnZ3k+QPhZCirFMwbfqP2UdzxkgMQXQ4taVEBNEUr1hh0VEG5/4wTWP5d9O6C+PbMZf5E5xyGqd/S65XrTveJtWqfuAqbIQU2+2ArRj+TzvnXLsOteu6PozEtFlJ30yhsqCu34FnD3YdUaBgE9hC5QjdqLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784102969; c=relaxed/simple;
	bh=zee27NGY3TT1wsVBcKgm4HwgLjz+f+0YmDuZ3oat71M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hJ8ghyt69tZYJgoHt7fwPXXQXiSeXevocuzonEuEQXIdvMvya4GO9ZSkPsnG+VZ2f0UvMdCiGbVRFljVhRl+GLiPJaOdSC4teUXUic29YQFwcaY2HsMHGd/VUobGQPFQ+QYkJzm1cH/arDh8e59vFSJ8MfBCiieMPSA8KY4LFWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=I1a7O7Bg; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="I1a7O7Bg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=vR
	MktCvaA5Pp8uAYVqovWcGywav3OvjIKt+KjuLK6pc=; b=I1a7O7BglIQkY7uBf+
	9Y8BVBekY5BHTd/R6S+kVN2J9igfWSYtXcdevU80RtAVSLpx+nQteLqFMjMncOX+
	p+tQBUzc3BbLHqXePs8jdSwU2eCALvlKLSiP50jDXDpW9gkg1gYv0wMlP3fz2i1x
	OZrifGio23c7hDb2pepRQ4kjY=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCnps0uQFdqTXvVJw--.19978S2;
	Wed, 15 Jul 2026 16:09:19 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: virtualization@lists.linux.dev
Subject: [PATCH 08/12] vhost-scsi: improve CDB size validation and remove TODO comment
Date: Wed, 15 Jul 2026 16:09:18 +0800
Message-ID: <20260715080918.21824-1-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnps0uQFdqTXvVJw--.19978S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7urW7XF48Kr15KFyUXF1UZFb_yoW8Xw48pr
	W3Wa1UCryxAFy7K39xJFy3ZFy3uan7AFyUKFy2ga45AF98Kr1Dt3W3Ka4YgayUXrZrGFZ0
	qF1qvFy3J3WUCw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jamhrUUUUU=
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbC7w+LG2pXQC-4TAAA3W

From: xiongweimin <xiongwm2026@163.com>

Improve the CDB size validation by adding a zero-length check for
additional safety. Also remove the misleading TODO comment since
scsi_command_size() already correctly handles both fixed and
variable-length CDBs.

Signed-off-by: Weimin Xiong <xiongwm2026@163.com>
Co-authored-by: Cursor <cursoragent@cursor.com>
---
 drivers/vhost/scsi.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 219d9d881..2fbc328c9 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1432,12 +1432,15 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
 			lun = vhost_buf_to_lun(v_req.lun);
 		}
 		/*
-		 * Check that the received CDB size does not exceeded our
-		 * hardcoded max for vhost-scsi, then get a pre-allocated
-		 * cmd descriptor for the new virtio-scsi tag.
-		 *
-		 * TODO what if cdb was too small for varlen cdb header?
+		 * Check that the received CDB size is valid and does not
+		 * exceed our hardcoded max for vhost-scsi, then get a
+		 * pre-allocated cmd descriptor for the new virtio-scsi tag.
+		 * scsi_command_size() handles both fixed and variable-length CDBs.
 		 */
+		if (unlikely(scsi_command_size(cdb) == 0)) {
+			vq_err(vq, "Received SCSI CDB with zero length\n");
+			goto err;
+		}
 		if (unlikely(scsi_command_size(cdb) > VHOST_SCSI_MAX_CDB_SIZE)) {
 			vq_err(vq, "Received SCSI CDB with command_size: %d that"
 				" exceeds SCSI_MAX_VARLEN_CDB_SIZE: %d\n",
-- 
2.43.0

