Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256313C585B
	for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 08:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784102981; cv=none; b=sNyFnzXQ/kIB/2flDhnB2Za0JSAhBfTjllsapPiDlB6JYX8kyCCyevO4bIP46PMIGxs+V9+/heXj3tY5y+ZrgZdEfIjA2O/TZq6LmGBfxiE4GJaqcCC8Hrw4Q02f/5HQfRBq0FDmPm00JAr8Min0tDBj1bBzFQqPC93JeAutz4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784102981; c=relaxed/simple;
	bh=RH0GwAMtHZhQNfX9tlADgXr/qey1zqq6aQtWGJvVdT4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=CxcER/hTWTvGRX8TKV3h9RzaqFt/bPSt9SD2J9kPMb/97wI7g3yUUjW6eivTYbkSP3TuCRdAJFmtwiIQ76rXXOX34C1OH/eifn/0px0FHRANV+Api7fusCx+P19BBvL6Y4V2TU9BU77zroRpWJKuCT8sKV8ESd7zYuSpc9GiKBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dRH4z5+A; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dRH4z5+A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=JS
	EpgsxvYTDtOy8M9DjJDiAUMCwukq6gNA06ZZxiHGY=; b=dRH4z5+Af6BOPLy2RO
	Xn7NeDw7N3wT4TFdU49i7iNQ7BRTugrbw6xJWLtCV45nr4+jnKPS5NXnY9lXcZxr
	FszSpjlHN0bq3ux5brcA62yrhNVGzRnVi1MNJOFWiRHKaCilV4UjteJDgC/1qQdL
	xddO/T55ZcfYMTZ41Ijrruhhk=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDnV9A8QFdqC4k2Iw--.38125S2;
	Wed, 15 Jul 2026 16:09:32 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: virtualization@lists.linux.dev
Subject: [PATCH 12/12] vhost-vdpa: add explicit cast for void* to u64__user*
Date: Wed, 15 Jul 2026 16:09:32 +0800
Message-ID: <20260715080932.21937-1-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnV9A8QFdqC4k2Iw--.38125S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF1UZF15Gw1DuFy8Xr43Jrb_yoWfCwbEvF
	18Jr17XF18KrZFvr1xuF13Za4Yvan8Wrs5Z3ZY9ry3Zr12v3WS9a4vy3srXw1xZrWrGFy7
	ArZxXrnFvw1SkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0dWrJUUUUU==
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbCzRyPH2pXQDyxFAAA3l

From: xiongweimin <xiongwm2026@163.com>

Add explicit cast from void __user* to u64 __user* for maximum
compatibility with static analysis tools. While the implicit conversion
is valid C, explicit casts improve sparse checking compatibility.

Signed-off-by: Weimin Xiong <xiongwm2026@163.com>
Co-authored-by: Cursor <cursoragent@cursor.com>
---
 drivers/vhost/vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 6ddd5f0f9..bb96b1aa5 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -779,7 +779,7 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 	struct vhost_vdpa *v = filep->private_data;
 	struct vhost_dev *d = &v->vdev;
 	void __user *argp = (void __user *)arg;
-	u64 __user *featurep = argp;
+	u64 __user *featurep = (u64 __user *)argp;
 	u64 features;
 	long r = 0;
 
-- 
2.43.0

