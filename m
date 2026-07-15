Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91303315D3E
	for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 08:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784102970; cv=none; b=qzdSK3MLXH+UiNAtbHnqYY5YNgYV9s1Z7fblK/XiVCu7Px5BHtFlJg2wllzXe8aOmArlJmzw4V9B1m+nDDQr9ossZeZtogLqueifl7ONU8chDqCFU3C5SjI8PoTLVrrDMfhW9cM0U93l2s0GQz8B5I1cwp7bTnP1JxB24+L3lEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784102970; c=relaxed/simple;
	bh=ogenjDnRp5+Vy9PSNDUAc+uNfh38h+QuETbfnxBGslA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=oM60Bwni8RT1+6An8Y0Z+aozruBGeW3ZZ2CDex2YvyX26ZdhGhuj1WysBST6mKkeTmSWoQlgwxKdLCboY5tDs+vuEmQ/XL2SmwMtcynvFzWCLnrNg+mzgGdHsa/ZC9+QxR/cwD0cyNlnu5YZHS2/eh84ECvPwP35rlShehfUfgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VuSpbQ2r; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VuSpbQ2r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=QM
	11klm/SPRjlQ2RpQeSm/bWZw3zfFDIXCw5x4omtcI=; b=VuSpbQ2rhQnDHV7GVw
	yG08/lrLyrH7UCM64WwEPlKDA8mDZNG34t5efwHPlshW2goAWyVLn7hvEs/4925H
	ENJO262yv5NRO3w4+4o/hujuQSgrt2rtxBBL6X/PWFo+OD3q9eMorj6dTBlTRC3w
	JlNXzN+Ry94hBAJUYeQm5n1Tg=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD334MtQFdqhImAJg--.46829S2;
	Wed, 15 Jul 2026 16:09:17 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: virtualization@lists.linux.dev
Subject: [PATCH 05/12] vhost-vdpa: add comment for VHOST_SET_LOG_BASE not supported
Date: Wed, 15 Jul 2026 16:09:17 +0800
Message-ID: <20260715080917.21785-1-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD334MtQFdqhImAJg--.46829S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrWDur18Zw4fXrWfGFyUKFg_yoWfKFc_ur
	4rWr1xXF93GF40vw12kw13C347ta97Ww4Sva9Y9rW3Ar17Xw1I9a4vyr9Yq347ZFW7AFWU
	ZrZ5JrW2gr1IvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU829aPUUUUU==
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbCzg2LG2pXQC13VwAA3j

From: xiongweimin <xiongwm2026@163.com>

Add a comment explaining why VHOST_SET_LOG_BASE and VHOST_SET_LOG_FD
ioctls are not supported in vhost-vdpa. The vDPA devices use their own
logging mechanism through the vdpa bus instead.

Signed-off-by: Weimin Xiong <xiongwm2026@163.com>
Co-authored-by: Cursor <cursoragent@cursor.com>
---
 drivers/vhost/vdpa.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index a18ed439e..6ddd5f0f9 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -848,6 +848,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 		if (copy_to_user(argp, &v->vdpa->nas, sizeof(v->vdpa->nas)))
 			r = -EFAULT;
 		break;
+	/* vDPA devices use their own logging mechanism through the bus
+	 * and don't support the traditional vhost-user log ioctls.
+	 */
 	case VHOST_SET_LOG_BASE:
 	case VHOST_SET_LOG_FD:
 		r = -ENOIOCTLCMD;
-- 
2.43.0

