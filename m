Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AA62FDC5E
	for <virtualization@lists.linux.dev>; Thu, 16 Jul 2026 03:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784170854; cv=none; b=jt9yPWBEoMIPezpCgHeoLOwYgirKlgQ5IzSVo5w22hq31IAl51Q9Qwl0Nz/fQegVih7jobpcEwN2dnW/sIBcvxJDJsd0UVxjviaVVzJiAorbwyXAx83HqkCE0UCILmU+18ou1/ciBmZVvjxOmmUgoYu6MvpVg/i/KQMVSMsNagM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784170854; c=relaxed/simple;
	bh=xf2QTRoFsupnatxYF7X5Z/KWv/0K5cSRiyp6AD9+/wM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vCpJq4ffMXqRDkMEdn0CSlwEmd9PIvEPP6cLhZ2OvCOTgBHQkI7sPJMDcOyLOS3AQEBqOnHkgTThChKEmVsh9uqNBFQxaMuXFbrtOCIlA2Copk0x8rspcpI8cdOnFeMr25wD1QOiC3IZUdVbIPS+UvKCzqpcTtiPwF+C/epzDXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qDBKoiNz; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qDBKoiNz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=PA
	wu+cA7ZMkmgEIUhOWxUit2qByCZAw9d2FC+6+Sy+Y=; b=qDBKoiNzkj4TtCjX12
	J3qXu6XNyJN3lXyvAbxhLRXr8R0gm9STEV52E6CJSsxv5iUbnpVCbLMsuBGjgPNr
	dyxSFjeObH4lLco4I+zPReNhyMwZXUF1/V8zv2310SZuXpB+UzlCQnmMu7P4kh8x
	K7MUPimSFB4yyr47H1WyVU0OE=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDHmNxeSVhqH1PMHQ--.49499S2;
	Thu, 16 Jul 2026 11:00:47 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	netdev@vger.kernel.org,
	xiongweimin <xiongweimin@kylinos.cn>
Subject: [PATCH] vhost-vdpa: propagate set_map error to caller
Date: Thu, 16 Jul 2026 11:00:51 +0800
Message-ID: <20260716030051.123889-1-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgDHmNxeSVhqH1PMHQ--.49499S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr45Wr4xKr1kZr4rKFW5Awb_yoWDZrg_Ww
	4fWrn7JF4rWr4q9Fn2grW3A3ya9FsFgr48Zas8KFy3Zr4DXwsaq3yvvrn7Aa13urW7AFnx
	Ar4ktr1Sy3WS9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUeQ6pJUUUUU==
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbCzR8aqWpYSV9BhwAA3D

From: xiongweimin <xiongweimin@kylinos.cn>

The return value of ops->set_map() is currently ignored when handling
VHOST_IOTLB_BATCH_END. If the backend fails to program the IOTLB,
the VMM incorrectly believes the operation succeeded and may continue
with stale or incorrect mappings.

Save and propagate the error from ops->set_map() in BATCH_END.

Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
---
 drivers/vhost/vdpa.c | 6 +++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index bb96b1aa5..ffbb10a92 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -1297,8 +1297,10 @@ static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev, u32 asid,
 		v->in_batch = true;
 		break;
 	case VHOST_IOTLB_BATCH_END:
-		if (v->in_batch && ops->set_map)
-			ops->set_map(vdpa, asid, iotlb);
+		if (v->in_batch && ops->set_map) {
+			r = ops->set_map(vdpa, asid, iotlb);
+			break;
+		}
 		v->in_batch = false;
 		break;
 	default:
--
2.39.3

