Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ADA1D5CD1
	for <virtualization@lists.linux.dev>; Fri, 17 Jul 2026 01:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784251778; cv=none; b=M3SQpOIgSqD2IT5oFB+VrptMqfXzHAXGCHFKxbBcKo0faKSYnPxhAqMxc+6HzF1TVn0qup7aYjPRyoKikAf7MXl+7vwdPEQ2a8e9gaYbB5JapaTIjW0rI0wEw5IOIHwJfVuBeuQspJfcDK6cQXBOMppF+9FcyjAGD7ZS7NjsgcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784251778; c=relaxed/simple;
	bh=kNYnFNkLbQa/pQFvP1FGbkRzVW+D9Z3TT/5y5SOxm1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UKlL00Ui4aiYorq1QVIwphez9sQ39BKup+6ZruK4VJrzoD6X5fcyyVug+gkUUzCOIIIpZ3km4jf5F0dpDH9i2QFrwlXtT9xBZLRUZHK15x8+G31+tZkH/VjVdlboeYLdFugPpinE7CDm2i1b7DzW/oC+J30hZrpRQhZ5WFftS8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YOOHpSCm; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YOOHpSCm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=en2/ELT4QrudvVT3KU2Nd0vth4idJXg1D6VcuR3iyXA=;
	b=YOOHpSCm/lsA70Ww11e0UECgSb32HSy9S0pjKmd7mG7CUVBWaFHAGNcDKCqQSu
	oLk4/L1nl8VqeE/1jdmdbrf52EjY+R2DCLFQ8qfWjGPw1dFqon/xe6QHcTfhdvCP
	SRJZIyjVhCA3YghrXxtHePQ7cfU+IRMmMD55J+q9rti2E=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wAnhexwhVlq2yZ6Jw--.30876S2;
	Fri, 17 Jul 2026 09:29:22 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: xiongwm2026@163.com
Cc: virtualization@lists.linux.dev,
	mst@redhat.com,
	jasowangio@gmail.com,
	netdev@vger.kernel.org,
	kvm@vger.kernel.org,
	xiongweimin@kylinos.cn,
	Eugenio Perez Martin <eperezma@redhat.com>
Subject: [PATCH v2] vhost: reject zero-size IOTLB INVALIDATE
Date: Fri, 17 Jul 2026 09:29:21 +0800
Message-ID: <20260716030236.124322-1-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716030236.124322-1-xiongwm2026@163.com>
References: <20260716030236.124322-1-xiongwm2026@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnhexwhVlq2yZ6Jw--.30876S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr4kGw1kZw1xWw18Cry7Awb_yoWkXwcE9a
	1rJ3s7XFs5Jr1Dta1kAa15Z3sayFsF9FyUu3W0yw1aqr4qqw15Za9Yvrn8AwnxZasFva43
	AwsFvr1UtFyS9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRiUGYPUUUUU==
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbC7xJu-WpZhXJJ+QAA3a
Message-ID: <20260717012921.oyTkqBgRqNTWiMgAtjVgcCUBT2oIiZ3D44ekHl_MujM@z>

From: xiongweimin <xiongweimin@kylinos.cn>

Reject VHOST_IOTLB_INVALIDATE messages with size == 0 to prevent
iova + size - 1 from underflowing to U64_MAX, which would
incorrectly delete the entire IOTLB.

Changes in v2:
- Move the check to vhost_chr_write_iter where similar check for
  VHOST_IOTLB_UPDATE already exists (suggested by Eugenio Perez Martin)
- Add Acked-by from Eugenio Perez Martin

Suggested-by: Eugenio Perez Martin <eperezma@redhat.com>
Acked-by: Eugenio Perez Martin <eperezma@redhat.com>
Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
---
 drivers/vhost/vhost.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 3c080c454..327e1108c 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1716,7 +1716,8 @@ ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
 		goto done;
 	}
 
-	if (msg.type == VHOST_IOTLB_UPDATE && msg.size == 0) {
+	if ((msg.type == VHOST_IOTLB_UPDATE ||
+	     msg.type == VHOST_IOTLB_INVALIDATE) && !msg.size) {
 		ret = -EINVAL;
 		goto done;
 	}
--
2.39.3

