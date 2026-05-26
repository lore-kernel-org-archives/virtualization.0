Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E35234F27B
	for <virtualization@lists.linux.dev>; Tue, 26 May 2026 08:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779782633; cv=none; b=naRxXZNVnMstMjEE18Mz5yTjJF/pxffveQwmUEEc5PI79RxhUn/1qBgf7E4v4f3nkJOKT5lcYDrLP9/qK3AQeTzt7m3YJ0Knt/LYSiDQAbtSbkotDfj0aZgM8bqbNJccm1Q7qXwr6AwPDVOCxZwc/m30rTE+zfBwJX5S5pu05cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779782633; c=relaxed/simple;
	bh=45KEKPvIipfpxvasf0IAIn3DmtzkftZ2hberpVknMjE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CZgc0nAy/ZRTLGAOIrThCrquSzzNQ++0PWOjfuCwJ1TCuzHXeBn4cntkuRLBMN9NEtn82oF1p/8IUoHtuEfXe5tjuKTUh3kNxlee5JQXIP/+skLRqZuN8sO7gMvZ3K+HRugYzvA/LmpZpBU+tsgvPVSj5BFfFplDbzTBbjhcwp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IhwxUNh3; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IhwxUNh3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=9B
	rc5GiPYOxWptKHRclEmQdD+ryXnNMxYPoyH4Q3BgA=; b=IhwxUNh3CRcZ2tdxwR
	4/orR6AaXzDrJNtlXSiATLbMq+LyMXS4HVbHU/kCsG9P/tBr8jLiUlA+dYb8J1c0
	RAe0jl+GL0RWvIo7qy36yPw2BZvG3FCsIfpeybGj9fexDnWU4784nT71ebErqKig
	bqxP55v4gXY/YhYJILr5A42TY=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDnL5PbUxVqovnmEg--.27103S2;
	Tue, 26 May 2026 16:03:43 +0800 (CST)
From: "rom.wang" <r4o5m6e8o@163.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yufeng Wang <wangyufeng@kylinos.cn>
Subject: [PATCH] vhost/net: fix clear_user start address in VHOST_GET_FEATURES_ARRAY
Date: Tue, 26 May 2026 16:03:36 +0800
Message-Id: <20260526080336.61296-1-r4o5m6e8o@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDnL5PbUxVqovnmEg--.27103S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKry8tF43WrWkXrW7Wr48Zwb_yoWkXFX_u3
	9rXryxuryxGrnI9wsxXa4SyrWayFW8urs7WFn29ryxA343u3Z7Cana9FnxJa1UW3y8CF9r
	A3s8Jr92g3Z2qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8nXo7UUUUU==
X-CM-SenderInfo: 3uurkzkwhy0qqrwthudrp/xtbCzh-rYWoVU9+0-QAA3h

From: Yufeng Wang <wangyufeng@kylinos.cn>

The clear_user() call in VHOST_GET_FEATURES_ARRAY incorrectly starts
at argp, which is the beginning of the features array, overwriting the
data just written by copy_to_user(). It should start after the copied
elements at argp + copied * sizeof(u64) to only zero the trailing
unused space.

Fixes: 333c515d1896 ("vhost-net: allow configuring extended features")
Signed-off-by: Yufeng Wang <wangyufeng@kylinos.cn>
---
 drivers/vhost/net.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index db341c922673..70c578acf840 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1777,7 +1777,8 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 			return -EFAULT;
 
 		/* Zero the trailing space provided by user-space, if any */
-		if (clear_user(argp, size_mul(count - copied, sizeof(u64))))
+		if (clear_user(argp + copied * sizeof(u64),
+			       size_mul(count - copied, sizeof(u64))))
 			return -EFAULT;
 		return 0;
 	case VHOST_SET_FEATURES_ARRAY:
-- 
2.34.1

