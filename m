Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E243C8C43
	for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 08:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784102966; cv=none; b=W9ou9OnsCaa14jEqpLye9wfkBJQxg6KStDSBHSw0r9oLC7PAl/YeULqDxnUeIc/a/HQ5+wTxKVIcngyEr4Uhq0kcchff1F/GY/5ftGOKATUY0efKNnPOEVnIn07NaGXAJERBdM0KXEaqYP2WJ1XFOClSKXOPm24tKYaSAnpzY6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784102966; c=relaxed/simple;
	bh=5tcPKwpIDjsWKs6MzlT9FnZF6+EyCK51e2bEgoE20HI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=EYv5GIReaHLX8PBIOvmOyj2c/ja4ckFPIqxHSH7tg8yW3ad3m0u4TP0ceAggmLXBNcM27LYS/g6we9cZoe3TuETXoNBGOGaoOa6yCcmYTsi7sKkf1KR5BmKubegXpdt8E6GpHsT8DFMz4LJ9IWxpGqtgOaONjCRd8E+t/42KCs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=H5okIFV7; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="H5okIFV7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Si
	IXtYrxZlh56/rCFMqeqwyfNP9xaxjnOp6azq+VESk=; b=H5okIFV7ptMUF1rq4F
	MRg5glr7KClInyOPMusO8Pc4X1lWbuA6B9b7MqFueaaAZzJu3Lu6zfwjV+57O7ZM
	Q4pVCG9K54GildMrXx+Pzuw2LwKLdTgTTzemnKiuT8+6gbFAZ86fBdNMR4iSNf3f
	EoRGpmVlw5UdQTlq8Qos+c2ZM=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgAH7u0vQFdqNnVMHQ--.33855S2;
	Wed, 15 Jul 2026 16:09:19 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: virtualization@lists.linux.dev
Subject: [PATCH 09/12] vhost-net: use sizeof(*featurep) instead of sizeof(u64)
Date: Wed, 15 Jul 2026 16:09:19 +0800
Message-ID: <20260715080919.21837-1-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgAH7u0vQFdqNnVMHQ--.33855S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFW7Gr4xtFy8XrW8Kr15urg_yoW8AF4Upa
	95K34UAFyUGr12yanFvr9xZ3W3J3ZxCa1UKr9293yrXF15ury5C3ZFkFy2qrZrJryUuryr
	JF1DtFy5C398Zr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5KsUUUUUU=
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbC7w+LG2pXQC-4UgAA3I

From: xiongweimin <xiongwm2026@163.com>

Use sizeof(*featurep) instead of sizeof(u64) for better type safety
and consistency with kernel coding style. While sizeof(u64) equals
sizeof(*featurep) on all supported platforms, using sizeof(*featurep)
makes the code more maintainable.

Signed-off-by: Weimin Xiong <xiongwm2026@163.com>
Co-authored-by: Cursor <cursoragent@cursor.com>
---
 drivers/vhost/net.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index c6854cba5..94028598f 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1777,14 +1777,14 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 			return -EFAULT;
 
 		/* Copy the net features, up to the user-provided buffer size */
-		argp += sizeof(u64);
+		argp += sizeof(*featurep);
 		copied = min(count, (u64)VIRTIO_FEATURES_U64S);
 		if (copy_to_user(argp, vhost_net_features,
-				 copied * sizeof(u64)))
+				 copied * sizeof(*featurep)))
 			return -EFAULT;
 
 		/* Zero the trailing space provided by user-space, if any */
-		if (clear_user(argp, size_mul(count - copied, sizeof(u64))))
+		if (clear_user(argp, size_mul(count - copied, sizeof(*featurep))))
 			return -EFAULT;
 		return 0;
 	case VHOST_SET_FEATURES_ARRAY:
@@ -1792,9 +1792,9 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 			return -EFAULT;
 
 		virtio_features_zero(all_features);
-		argp += sizeof(u64);
+		argp += sizeof(*featurep);
 		copied = min(count, (u64)VIRTIO_FEATURES_U64S);
-		if (copy_from_user(all_features, argp, copied * sizeof(u64)))
+		if (copy_from_user(all_features, argp, copied * sizeof(*featurep)))
 			return -EFAULT;
 
 		/*
-- 
2.43.0

