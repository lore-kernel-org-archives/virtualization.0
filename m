Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EA02E7621
	for <virtualization@lists.linux.dev>; Thu, 16 Jul 2026 03:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784170965; cv=none; b=jxFB8h4LaKwbKsWZPFJ/52eXBL22upbW6WxreYjgdvoGRlJ9m2CvO8Mj3pkPZlSgkWnvlwFJSabV1NIgXPfyVEpVJNQ9GvRRXkc5+5mgA6Iih8LmPkr9yBc56iqAXBA37T2xuFTrQJmPgPA6UiYj7LGDdyloV6CcUsSSal2lOmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784170965; c=relaxed/simple;
	bh=BmEQ1JjP3yY06yAm1q24o7DQiuX5kKIWSratjSc/NsI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J89SSV1AAahJ6ySIVGB/4ta3zK70rG/LH8i49vGllANsdnFPAAH8KOhP9eCy4TkQjshbSZONJ38TXIYrWs3HtvxCAuvhwMoEbW9tXdABPbRpUcbUl8W6Pp0j3mu7fxYz/jOCt57t35NDWT24HIUmr/flJb+0kPWHAYgALPIsnaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=g9cuT17m; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="g9cuT17m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=0t
	KiRx3pNUsOkbx59/0aLdgFv6oElr06UU1M1CtyXFY=; b=g9cuT17m4OuCXSuooW
	JMzdT3mRIj3bzPTnWzKdKatV5sqwHZ42jIy4mFAS4HSRUK886iXKu/NNNjN2k3vr
	vXWG1bvdt7cmtMAelECtgy2+7ZtBf8p125Ag8dwQwh6+jfi+FMX5u11A74Tsr0na
	CECDvAmWuqJFRWdpgTmr9lpqM=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD370XJSVhqov9lJg--.23S2;
	Thu, 16 Jul 2026 11:02:34 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	netdev@vger.kernel.org,
	kvm@vger.kernel.org,
	xiongweimin <xiongweimin@kylinos.cn>
Subject: [PATCH] vhost-vdpa: reject zero-size unmap
Date: Thu, 16 Jul 2026 11:02:38 +0800
Message-ID: <20260716030238.124368-1-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD370XJSVhqov9lJg--.23S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw4DWr43Cr43CF43uFy7GFg_yoWDJrXEg3
	95Crn7Jr1S9r4qyF1I9rW3A34avFZruFZ09asYg345XwnxXw4ay3y8Zrn3J3WfurWUAFn3
	Aw4vyr10qw1SqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnZNVDUUUUU==
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbCzgo1xGpYScphxAAA3h

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

