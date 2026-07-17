Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3F8246784
	for <virtualization@lists.linux.dev>; Fri, 17 Jul 2026 02:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784254395; cv=none; b=lcA21bWguAQDx2f++7KcakOd8iyY5FXwMFsStZXG4j9mSydOZO6IV50FJwgkDvPB/bUfdyClToVv0sbfhytzyIgxnyiEWroj0ad221HQnvY+NFeCSqBi65lfNnVeo7JteXNBsyo6/ksO3GrRdnAnrX8Qx7ds3B+6OiWw3yJ/tV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784254395; c=relaxed/simple;
	bh=T5Gh/RzLI5ItsHpkIRSaFUE259p+06RVDMAR1wSK1mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hH7WT7nx+d3LyVyzYV4Uwa4gJ7+pp00OoJaB+8A0gV0kq7XTYji44V69gtpXfqyI4enMSgD1aU186JQOhZbA41S64duGdrElcXqIFlUH5Dj3R6gvnEHth+WWUmmQG5YPHK0BtFNOERfaIRwf92065hrGzs6P+y8sEet15eBl1D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Yt4CLx84; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Yt4CLx84"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=w/
	VEqc6IOpy65exxrKAozFQawljjck8mYtmYSkA/CgM=; b=Yt4CLx84OX5aQ5v4+T
	tfyn9xn26W2dv6VGwxU80xy4gN197ReNrBqAGwfpCbruMAq3nHdk39Z0mZNVFnEq
	JJsluklREzOgvU0Find3qDPfAP5Inlv0FQYphrNzx97sgFPW9z5EdwkOJYJTq8Qg
	oouzpSDnnO+kZ/AD9bIvrBuOY=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgDH8Wawj1lqVSFNGg--.62837S2;
	Fri, 17 Jul 2026 10:13:05 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	mst@redhat.com,
	jasowangio@gmail.com,
	netdev@vger.kernel.org,
	kvm@vger.kernel.org,
	xiongweimin@kylinos.cn
Subject: 
Date: Fri, 17 Jul 2026 10:13:05 +0800
Message-ID: <20260717021305.327441-1-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJaqyWeNJwVNUihL8MAEH+-a5OsoaDGsgaPnP0BqQd6YH4ZhYg@mail.gmail.com>
References: <CAJaqyWeNJwVNUihL8MAEH+-a5OsoaDGsgaPnP0BqQd6YH4ZhYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgDH8Wawj1lqVSFNGg--.62837S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr1Uury3Ww15WF1rGr17Jrb_yoW8Wryxpr
	Z5ury2kr97WryrtanFk3y5A3Z8Z392yrWUWFyFqw45ZF18tryv9rZ8Ca4j9F97JFyYkF12
	va1xKw1DZasrWFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07b1q2NUUUUU=
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbC7xEBkGpZj7FufwAA3z

From: xiongweimin <xiongweimin@kylinos.cn>

Hi Eugenio,

Thanks for your review!

You are right. My original patch has an issue with the `break` statement,
which skips the `v->in_batch = false` assignment when `set_map` fails.
The correct approach is to simply capture the return value without
breaking:

```c
case VHOST_IOTLB_BATCH_END:
    if (v->in_batch && ops->set_map)
        r = ops->set_map(vdpa, asid, iotlb);
    v->in_batch = false;
    break;
```

This way:
1. The return value of `set_map` is propagated to the caller
2. `v->in_batch` is always reset, regardless of success or failure

Updated patch attached below.

---

Subject: [PATCH] vhost-vdpa: propagate set_map error to caller

The return value of ops->set_map() is currently ignored when handling
VHOST_IOTLB_BATCH_END. If the backend fails to program the IOTLB,
the VMM incorrectly believes the operation succeeded and may continue
with stale or incorrect mappings.

Propagate the error from ops->set_map() to the caller.

Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
---
 drivers/vhost/vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index bb96b1aa5..b52d8d94e 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -1298,7 +1298,7 @@ static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev, u32 asid,
 		break;
 	case VHOST_IOTLB_BATCH_END:
 		if (v->in_batch && ops->set_map)
-			ops->set_map(vdpa, asid, iotlb);
+			r = ops->set_map(vdpa, asid, iotlb);
 		v->in_batch = false;
 		break;
 	default:
--
2.39.3

