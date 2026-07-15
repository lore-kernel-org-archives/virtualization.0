Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F67315D3E
	for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 08:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784102956; cv=none; b=KchC/qyzi07oRQlf8LJfQOfk6IPkKFdUVCbLbp7Ky/R0TEKuXr285VwCA1yIy9Ku+5UKH1dYo7WH9FNyhU6fEMEDwk8AuEJ84q84XfEY3kjdP16NXNQSOUJ7pGyGGKT3THZhUZzhHoCE43UCbtNVK1qEA6YHh0saoWUghQtXs0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784102956; c=relaxed/simple;
	bh=FVoY6obbuyYaLvbjWCT0rnrHWtfVzIjCGXWvEN1+Zio=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qdn+FIe4IsIrjDi0eKa6Ip/6zqp+APaAVVA/x1t3yvqbJ6qbTHniK+HM75zKWLG/LcyxaOqozy5DvdkxooXMFbfqnRxhZKMKfR3rv78k71gcht1nXK9Ga4+aCaZx2UGt0PwaXwdkMLjICK67f+yPGYvFfcNYfmp319icJYi7x3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mSRjmoSG; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mSRjmoSG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=74
	SJteIRECAZ3kP1j5HqdjYbmyuP9X2vOTTgdq2aUeU=; b=mSRjmoSGCA60WoNicR
	NZMKwDqR2KvWMLZ00itAY5joerNxYYi24eWBGmCnKDxoZsoiKXAyaL5EDB6e467+
	mMCBox+kgXwhvJ9rohGGjUQ6DqYWwN4ZimXxEoOiTK7UbWazLgYdpSaJCHfmZLZQ
	ZtfBqGsUqSMRr68e4Oi2D0vtc=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBHZF8iQFdq4eGoJg--.36433S2;
	Wed, 15 Jul 2026 16:09:06 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: virtualization@lists.linux.dev
Subject: [PATCH 01/12] vhost-scsi: improve BIDI operation comments
Date: Wed, 15 Jul 2026 16:09:06 +0800
Message-ID: <20260715080906.21689-1-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHZF8iQFdq4eGoJg--.36433S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrKrWDCw4DZw1fCw1rKF43Awb_yoW8JrWkpF
	WFgw18tr4akF18K3ZFgayYva1Sga1kGry7KFW7Wa4rKFyYyryjq3ZxKF4Yqr97JryxC3Wj
	vFWqqr13Cr1UCaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j8EfOUUUUU=
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbC8AKIGGpXQCID0gAA3s

From: xiongweimin <xiongwm2026@163.com>

Replace FIXME comments with clearer Note comments documenting
that BIDI (bidirectional) operations are not yet supported.

Signed-off-by: Weimin Xiong <xiongwm2026@163.com>
Co-authored-by: Cursor <cursoragent@cursor.com>
---
 drivers/vhost/scsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 9a1253b9d..81e905c4c 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1047,7 +1047,7 @@ static void vhost_scsi_target_queue_cmd(struct vhost_scsi_nexus *nexus,
 	struct se_cmd *se_cmd = &cmd->tvc_se_cmd;
 	struct scatterlist *sg_ptr, *sg_prot_ptr = NULL;
 
-	/* FIXME: BIDI operation */
+	/* Note: BIDI (bidirectional) operations are not yet supported */
 	if (cmd->tvc_sgl_count) {
 		sg_ptr = cmd->table.sgl;
 
@@ -1168,7 +1168,7 @@ vhost_scsi_get_desc(struct vhost_scsi *vs, struct vhost_virtqueue *vq,
 
 	/*
 	 * Get the size of request and response buffers.
-	 * FIXME: Not correct for BIDI operation
+	 * Note: Size calculation is not correct for BIDI operations.
 	 */
 	vc->out_size = iov_length(vq->iov, vc->out);
 	vc->in_size = iov_length(&vq->iov[vc->out], vc->in);
-- 
2.43.0

