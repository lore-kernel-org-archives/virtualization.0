Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1A93C9880
	for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 08:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784102966; cv=none; b=mF++dv6Lxd+fITiIXICqjAASMHMMKPnz90X9gq3sEd08IVvlvZ2U/2P8DJf6hiRo4VjE77IzQ49ox6jOmGHFNW5tsgvqWo/V96Q8Xbb6o3jHNDZl4lk92Ny1QR6PR956M2BETiuTjxOGS7ldA7i43GyR+ADotvMnWtYK8g5HVOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784102966; c=relaxed/simple;
	bh=1nxuU6l2o74A1ZSfEs1oTmiZT9TaGY8vqmz6PDROZ4k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=YX5xgH3eBdYrr+dkJFFf7t49l/EYYb0aAHHQHksVrQCRUSerqA5PU06mDjvZPhO+rjqHAQrNINKnTOB+dWSAfHU+vhR4TS8CXAX5cBW5LEMvJn7pvb0+IYz2VezQCMOI0n8hpaVRxLqv0HbyDub0ir6MamzO99RF8SG2gxJhrPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ED4tSoRs; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ED4tSoRs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Uw
	FCuF7L87P2uUP9nfGcVQZP8OscnWNKire1ScvVO4c=; b=ED4tSoRs2lrx7WvNgA
	tRD+PryXQYML1ZrfEozip84gTdfQA94PHlSLyzenyX3Ad8TDyUJHGgzuukNOtTeC
	yU1SQhGZ0MeDl72QldLTIUbem4mzFnFCzM6g0Y8bQ7yAkCvt86DUkwFSxO88UkJ9
	uKu28jzNZBAieKrmVGpzGDcaI=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wBnNVssQFdqJ3rVJw--.45029S2;
	Wed, 15 Jul 2026 16:09:16 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: virtualization@lists.linux.dev
Subject: [PATCH 04/12] vhost-vdpa: improve ASID not found error message and return code
Date: Wed, 15 Jul 2026 16:09:16 +0800
Message-ID: <20260715080916.21770-1-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnNVssQFdqJ3rVJw--.45029S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrWDXr1kGryUKryxtF45GFg_yoWfuFb_uw
	48ur1DAw4ftF4DtF92kF13Aa4ktr4kuan5uasYgrW3Zry7tw1rta4kZrn5J3WxZFW7AryD
	Ary7Ar10vw1IvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0-18PUUUUU==
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbC8A2LG2pXQC0E0QAA3o

From: xiongweimin <xiongwm2026@163.com>

Improve the error message when IOTLB is not found for an ASID to clarify
that the ASID may not be allocated. Also change the return code from
-EINVAL to -ENOENT to better indicate a missing resource.

Signed-off-by: Weimin Xiong <xiongwm2026@163.com>
Co-authored-by: Cursor <cursoragent@cursor.com>
---
 drivers/vhost/vdpa.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index ac55275fa..a18ed439e 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -1275,8 +1275,10 @@ static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev, u32 asid,
 				 v->batch_asid, asid);
 		}
 		if (!iotlb)
-			dev_err(&v->dev, "no iotlb for asid %d\n", asid);
-		r = -EINVAL;
+			dev_err(&v->dev,
+				"IOTLB not found for ASID %d: ASID may not be allocated\n",
+				asid);
+		r = -ENOENT;
 		goto unlock;
 	}
 
-- 
2.43.0

