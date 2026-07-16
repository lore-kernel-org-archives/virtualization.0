Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B87279907
	for <virtualization@lists.linux.dev>; Thu, 16 Jul 2026 03:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784170966; cv=none; b=uv788knaV0rZm19PhTbTVGJJ9loAIUaU2x0IMI4en/690bB3gbXLhdOyCk6NlCwWl7vw+SjAg6iZ3Y7e6AEF8ndf8Vnu+0GZLFQvoFvYQrj0NHzPCCft2HuOuq8fXHvHmAUpKTyyKyyDGxT+TkK133w8EYjTFJpLCUSHjaccuBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784170966; c=relaxed/simple;
	bh=xf2QTRoFsupnatxYF7X5Z/KWv/0K5cSRiyp6AD9+/wM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gpLDnBmoqG0RH1cHzg35Wjyemc88Qx/5go0iiQLEgBqZCLA0VkzUMPQyk9U4SPUBPRmUYUT2N+L6PmdcnWtrHA760/Dew1n8b+PTQ2/8ECEbET5wJNeWlOQy4h0il+CzI2GZDrSxCRpiPXjolWzg0BKOnDln/ZOmYNS+IdEKNzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HsdMNx7k; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HsdMNx7k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=PA
	wu+cA7ZMkmgEIUhOWxUit2qByCZAw9d2FC+6+Sy+Y=; b=HsdMNx7ko4htk1zms8
	smFkRc7cv/xLtl6UHaEVMpxC59gAOOkpaKEJXyBM5PbR3Pa7Q8bF9ZSPqplg0p3Q
	+iDgGXglRwksz0iABJ9oBxOgfgoJfltAQ9cbehNY08veJxiAgsb5QwA2/ZHoVTAh
	aXOoKtU5d9FhvP3xJop4yl0ig=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgAn_SPOSVhqtI_MHQ--.48504S2;
	Thu, 16 Jul 2026 11:02:38 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	netdev@vger.kernel.org,
	kvm@vger.kernel.org,
	xiongweimin <xiongweimin@kylinos.cn>
Subject: [PATCH] vhost-vdpa: propagate set_map error to caller
Date: Thu, 16 Jul 2026 11:02:42 +0800
Message-ID: <20260716030242.124455-1-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgAn_SPOSVhqtI_MHQ--.48504S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr45Wr4xKr1kZr4rKFW5Awb_yoWDZrg_Ww
	4fWrn7JF4rWr4q9Fn2grW3A3ya9FsFgr48Zas8KFy3Zr4DXwsaq3yvvrn7Aa13urW7AFnx
	Ar4ktr1Sy3WS9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUeRWlDUUUUU==
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbC7w42xWpYSc7JhgAA3o

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

