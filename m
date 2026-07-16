Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9744D2FFDCB
	for <virtualization@lists.linux.dev>; Thu, 16 Jul 2026 03:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784170834; cv=none; b=q1K6EgIq0BTBG2X59kAQ8QEz1kPsx6yDy6Hv6rOOkYh6kZl0SOG1+ef93F1dFjtc25wvdgQsSXwvdSxfQIDLcZD4pmDEfUHNYVRNvruDseIeWxh5Zaz/SpkqlWyvkWg//0y9QJ6nqkleHVyk89h9Z8BleQOKbVL1j23PMjVn9Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784170834; c=relaxed/simple;
	bh=DFZRlVoWzPVMZ2jvsLr8WRYOGQcz7fh8eTIjkDXEqfw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hs+FifsB5NHdkB080tptkDEHoh6ytbgHumL2l+W/pKJqo18eY22TKKiygBejPLUj8q+C4/h+I0tnQwsbRJsZ8ezEy67l4YRpcUQJqpzwzn1AO9tmCRqK4x38pmU6fNKYSstIoqPTm+o9DdxzOUsc0nTstbqcOTNoaWxg62uR2qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=miOIr2be; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="miOIr2be"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=NV
	gqlwNf7WiTSJJImnUuHurU6cSUXveORdu3yb81gdo=; b=miOIr2beZ4k0s09Dv0
	Sq2QNlYFibiim2oCabxhZlGu2aUQXfZrid1dB6NSr15LukS9zPKUIJhC0CAwd6l2
	YlvVPX9AwfmEOr42H9ndgobOFBzf4+mpN/ACwDniiCcDgPS7G7LsC25ZeTlf6Hqq
	LRDo5tKWLiTFHakx0X8+y+ek4=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wAXJMhGSVhqrEs8KA--.24557S2;
	Thu, 16 Jul 2026 11:00:22 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	netdev@vger.kernel.org,
	xiongweimin <xiongweimin@kylinos.cn>
Subject: [PATCH] vhost: reject zero-size IOTLB INVALIDATE
Date: Thu, 16 Jul 2026 11:00:26 +0800
Message-ID: <20260716030026.123733-1-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXJMhGSVhqrEs8KA--.24557S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr4kGw1kZw1xWw18Cry7Awb_yoW3trb_ua
	yfXr1xJFn3tr1qq3Z2yFy5Ar9IyrsrWr4DXasYy343Zr17Jw15u3y8Zrn8A3Z5Ww4jqF9x
	Aws0kw10vF1SqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnzuWJUUUUU==
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbC8AYUo2pYSUa-1gAA3V

From: xiongweimin <xiongweimin@kylinos.cn>

Reject VHOST_IOTLB_INVALIDATE messages with size == 0 to prevent
iova + size - 1 from underflowing to U64_MAX, which would
incorrectly delete the entire IOTLB.

Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
---
 drivers/vhost/vhost.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 3c080c454e374cabd7321416ed92c5f7d3135254..xxxxxxxxxx 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1656,6 +1656,10 @@ static int vhost_process_iotlb_msg(struct vhost_dev *dev, u32 asid,
 		if (!dev->iotlb) {
 			ret = -EFAULT;
 			break;
+		}
+		if (!msg->size) {
+			ret = -EINVAL;
+			break;
 		}
 		vhost_vq_meta_reset(dev);
 		vhost_iotlb_del_range(dev->iotlb, msg->iova,
--
2.39.3

