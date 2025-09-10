Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BA93115A0
	for <virtualization@lists.linux.dev>; Wed, 10 Sep 2025 09:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757495874; cv=none; b=VYSCNv0/nOgV1diEwicbPTbR0ctDkoiHr9ePsu7JKfnSbONgA4+fn/9vjx2aFiPfKJSzmQoiVsyEbj1W4Jvm9kPHnkx1kusXY1Mm30cC8lt5X9i8OMH+pojCTA35EswhR9mwjgdfP9fJyS+TOalKFYyLvT1R/V4nRaxoywW07RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757495874; c=relaxed/simple;
	bh=RLLm9pnVH37H7xjf5OXNxYNi/k874wPLIP1MoO6qGR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XpBLGck/sZsa8HAcyqaiGwEswcS6FO3dK48bIX4OuzRk+fj7z5VSr2RzSt8OM7O8Xq8EqEI7D+R1+ckZqoMSUy1A9owPVatlFXzILxvh3PSUzsfzL2oRFlyfYdqh/foNGMgD2v4KDceANMb/WJrYTuNEiIjw3/ii31BmrvltU54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee768c1423b9e5-bfa9f;
	Wed, 10 Sep 2025 17:17:47 +0800 (CST)
X-RM-TRANSID:2ee768c1423b9e5-bfa9f
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from Z04181454368174 (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee468c14238228-95f8e;
	Wed, 10 Sep 2025 17:17:47 +0800 (CST)
X-RM-TRANSID:2ee468c14238228-95f8e
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: mst@redhat.com
Cc: jasowang@redhat.com,
	eperezma@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] vhost: vringh: Modify the return value check
Date: Wed, 10 Sep 2025 17:17:38 +0800
Message-ID: <20250910091739.2999-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

The return value of copy_from_iter and copy_to_iter can't be negative,
check whether the copied lengths are equal.

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
 drivers/vhost/vringh.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 9f27c3f6091b..0c8a17cbb22e 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -1115,6 +1115,7 @@ static inline int copy_from_iotlb(const struct vringh *vrh, void *dst,
 		struct iov_iter iter;
 		u64 translated;
 		int ret;
+		size_t size;
 
 		ret = iotlb_translate(vrh, (u64)(uintptr_t)src,
 				      len - total_translated, &translated,
@@ -1132,9 +1133,9 @@ static inline int copy_from_iotlb(const struct vringh *vrh, void *dst,
 				      translated);
 		}
 
-		ret = copy_from_iter(dst, translated, &iter);
-		if (ret < 0)
-			return ret;
+		size = copy_from_iter(dst, translated, &iter);
+		if (size != translated)
+			return -EFAULT;
 
 		src += translated;
 		dst += translated;
-- 
2.33.0



