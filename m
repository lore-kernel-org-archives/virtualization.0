Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCDA3C5DC3
	for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 08:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784102973; cv=none; b=It9WQBF8WKst9NvLpYSF+cA/0vMYgmwly3RCXdPb2E1budvd8HZEODLrrz0m8Bmw4aOOeLWwVtHqv2ktx6BQ/2NYV0nChiYdv8o9/Q/5c3JB+ddxI+3SU5KQKpNBxpPXC0hO8CvirkuP2eYbvQrZhwO3hIeazR8Z8PlYqIpyrU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784102973; c=relaxed/simple;
	bh=Bqln4el3CCkzGf9pn8gkJBAtMLyu8AT87/hpPLfguG8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Z/BgYSaEIlQ7z4i9tth9GLSYGGnPAfapft9V0KxUVLKViey2QuBv+jqjTc0Yod65CdebkOq2a8aQMGaoiexaxAbZJYIQuRvhqt03JdIrFctn/hohvqZpsHkEnq6a49iH5YAFXcknaVgUS4cuwITzAiAHwmKDe7PBXnB+C+83w7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eAr2+Miw; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eAr2+Miw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=9b
	AipCzXha7O4F0PrvgiBGGi+rrSH/c+xikRFKplm2w=; b=eAr2+Miw3baGQORB5L
	msd8BsgKkzUzG48rMxyqMto2ujk7BQHh/2+tnJBDLI+Y8vFiM+CJu93iexi/Lqfn
	ArWaPDXk/lFCmB2hYG5NNS2cBbeGynsbWy9n1nslBYcsQKW7pzEFI4mz8Ut4hp5n
	AM4El+PLCbT51qv8h9dsAWwYw=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD397AtQFdqpOioJg--.2717S2;
	Wed, 15 Jul 2026 16:09:18 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: virtualization@lists.linux.dev
Subject: [PATCH 06/12] vhost: rename confusing 'min' variable in log_write_hva
Date: Wed, 15 Jul 2026 16:09:17 +0800
Message-ID: <20260715080917.21798-1-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD397AtQFdqpOioJg--.2717S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw47Aw4rWr1DGFyxAr48tFb_yoW8XFW3pa
	yfKry3tr1Fka1Utay7AF1YvF1fCws2k3sxWF9Iga4rZ3WUAr1qkFy8KFyjv34kAFyfWFW3
	JFW8tFyay3WDua7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j8-B_UUUUU=
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbC7w6LG2pXQC74NwAA3t

From: xiongweimin <xiongwm2026@163.com>

Rename variable 'min' to 'logged_len' for clarity. The original expression
'min(l, min)' where 'min' is both a macro and a variable was confusing.
Also fix the misleading comment about GPAs - this function works with HVAs
and UMEM mappings.

Signed-off-by: Weimin Xiong <xiongwm2026@163.com>
Co-authored-by: Cursor <cursoragent@cursor.com>
---
 drivers/vhost/vhost.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 4c525b3e1..3c080c454 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2461,14 +2461,14 @@ static int log_write_hva(struct vhost_virtqueue *vq, u64 hva, u64 len)
 {
 	struct vhost_iotlb *umem = vq->umem;
 	struct vhost_iotlb_map *u;
-	u64 start, end, l, min;
+	u64 start, end, l, logged_len;
 	int r;
 	bool hit = false;
 
 	while (len) {
-		min = len;
-		/* More than one GPAs can be mapped into a single HVA. So
-		 * iterate all possible umems here to be safe.
+		logged_len = len;
+		/* Multiple UMEM mappings may cover this HVA range.
+		 * Iterate all mappings to ensure we log all dirty pages.
 		 */
 		list_for_each_entry(u, &umem->list, link) {
 			if (u->addr > hva - 1 + len ||
@@ -2483,14 +2483,14 @@ static int log_write_hva(struct vhost_virtqueue *vq, u64 hva, u64 len)
 			if (r < 0)
 				return r;
 			hit = true;
-			min = min(l, min);
+			logged_len = min(l, logged_len);
 		}
 
 		if (!hit)
 			return -EFAULT;
 
-		len -= min;
-		hva += min;
+		len -= logged_len;
+		hva += logged_len;
 	}
 
 	return 0;
-- 
2.43.0

