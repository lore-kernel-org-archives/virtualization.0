Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0A93C3C0F
	for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 08:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784102966; cv=none; b=RUGEE/ZVRbAV5+SFvMWO86JsTVapzdostJYqWG11zrg4qII2QaLNSzJG8osJ0IgMLS57M3vdUhPlKgr9IPfqYigtjZAML6dzdfObQTNhyxvQFxuZvf8NqzrkmDVSQKQkw2ldcX4kuV0pVS2micrn+e33Gkshy4jewCKga5RBWYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784102966; c=relaxed/simple;
	bh=MIiKzqKnaBpE5qBSKe1Sp9+yqgZeYloQCkx8RO6M5gg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Wu7t2LdXcAPir9RaCRiw+HdpH5jvCOXHiM5BLA85x7/7hulQCYk8GZinqRI8wKgVSeMHpglUORyEYYmI7AxY6baz1SolWP36og7rZWlfJH0w0OKBGgi9+kePYyFjZ0On7ZP6FHYYt3g8g3lLKbWpvCleo+HQRctfget3vHSWRmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GWlZp+1W; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GWlZp+1W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Og
	LfJ43VXise+FRLt2zX9oiRrIgB0t374cGxA606Skg=; b=GWlZp+1WiDbKY5hBtb
	Tj1I0NtlPofxll+j26foDbYmZa5+fUmmjlcufQtwA5pWzs8DstTDaCPY2uPXzCyY
	C3OLO0oOQS577wubi6Mnk+zND9Vr17x9L/ROsrpvNJ/wW1rjTbX7hF1cPdjNZAE2
	oJs4vWDL/Bb6eZU2DCYE942Bw=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDXltUuQFdq+eioJg--.5422S2;
	Wed, 15 Jul 2026 16:09:18 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: virtualization@lists.linux.dev
Subject: [PATCH 07/12] vhost-scsi: improve TMF log allocation error handling comment
Date: Wed, 15 Jul 2026 16:09:18 +0800
Message-ID: <20260715080918.21811-1-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXltUuQFdq+eioJg--.5422S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrWDZw4DAw4kJF45Ary8Grg_yoWDXFg_W3
	yfKr18XF92yr48t3WFyFy3ArWS9r4DXr1UuFsYvFZ3Zr9rZr15K3WvkFn5Xw15Xr4Sy3Z5
	Ars5Xry5Ar1IvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0aXdUUUUUU==
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbCzg6LG2pXQC53egAA3O

From: xiongweimin <xiongwm2026@163.com>

Add a clarifying comment to explain the error handling flow when TMF
log allocation fails. The tmf structure is freed via vhost_scsi_release_tmf_res()
and then safely falls through to send_reject since it doesn't access tmf
after release.

Signed-off-by: Weimin Xiong <xiongwm2026@163.com>
Co-authored-by: Cursor <cursoragent@cursor.com>
---
 drivers/vhost/scsi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 77e47f246..219d9d881 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1620,6 +1620,9 @@ vhost_scsi_handle_tmf(struct vhost_scsi *vs, struct vhost_scsi_tpg *tpg,
 			tmf->tmf_log_num = log_num;
 		} else {
 			pr_err("vhost_scsi tmf log allocation error\n");
+			/* Free tmf and send reject response. The send_reject
+			 * label does not access tmf after this release.
+			 */
 			vhost_scsi_release_tmf_res(tmf);
 			goto send_reject;
 		}
-- 
2.43.0

