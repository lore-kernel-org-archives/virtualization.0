Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA78E2931C6
	for <virtualization@lists.linux.dev>; Fri, 17 Jul 2026 02:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784254175; cv=none; b=N8fS4kq+j9+2zr8o0ee0oIkMplf2P+K76ibQhdqEgABhBPeoeQeqap7UTVTGbpV8PD+3oDLiEqVYYUjBLsfUcWZQl5c/aqaDJxIEDRZQrnOLxqbmesYGKKn8RfnoRJCIHiXmk+3wfMDj1R3TI2zTqSMYKXrLWfoy1uPCHUvJTzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784254175; c=relaxed/simple;
	bh=B1sqVEA9lXXFx/cEol3hN6KR4Q9XWf6XClRbYR2I0Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fdiooDLWlTiyKD115ZW/hLRFdhY39Ytlw9IwNSxVu/6yOKP8PGg+NwG6i3qpWEuzvvrT7G15lpJyVTtifyFoeaH0aNwMxEQPdKa+GlBr/OXTqO7SJWIN8W1koA5hKzrgJH3xhmI9C8OHq1b9e4kV9nnj/mV4mYzaHzMsNfdLOlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TKS/6b81; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TKS/6b81"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=V3
	iDNBEN1Om6vZBlylAfFMAtlEWc+eavFhwE2b4Q9Zk=; b=TKS/6b81T7tyhkgmHw
	Q7OUIuuOrJ+lHiE9MEDy/CYfNktixHhPXTDdt10m7Qblq9eEfvzfRdw//Ua5CzQd
	2tsBlzHhnnLrLBKc9CWYLm22Fa93EfydbAcGMOko3TKvQ+/fSkpLm47Z8IsLwfPA
	L/dQgXDlPGJJc0nZviH2La9rg=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wCn8VTLjllqLyU2Iw--.184S2;
	Fri, 17 Jul 2026 10:09:17 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: virtualization@lists.linux.dev
Cc: xiongweimin <xiongweimin@kylinos.cn>
Subject: [PATCH] vhost-vdpa: propagate set_map error to caller
Date: Fri, 17 Jul 2026 10:09:16 +0800
Message-ID: <20260717020916.326833-1-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCn8VTLjllqLyU2Iw--.184S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr45Wr4xKr1kZr4rKFW5Awb_yoWfKrc_Ww
	4fXrn7JF4Fgr4q93Z29rWay34a9anrWF48Za98try3Xr4UXws3W3y0vrn3A3ZxZrZrAFna
	yr4ktr1Sy3WrujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnnqXJUUUUU==
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbC8A3HV2pZjs1ctgAA33

From: xiongweimin <xiongweimin@kylinos.cn>

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

