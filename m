Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB9B36A34D
	for <virtualization@lists.linux.dev>; Tue, 14 Jul 2026 02:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783997125; cv=none; b=Fy3TYPKHh/IJhCyxsB3HwhC7ExT0mRvQ/DtZSO00UqBhO4El3g0TbDbptG8IRMJmkG7iodljKD+EGdkuEwiNSwONRR9vPkRRYw6fJeqmpZFl5qD5BThTBXHza12qDUVwlk3WMz0qQ3Vab91IDXyIASd+QKcd2OswVwf/hHIZGOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783997125; c=relaxed/simple;
	bh=t7ES9qvxfdBYy5phQUgrVGtLfHCgai1UoAbq/ZmVB9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qVbzNiPPY2q57E6IPHGKWFVBtGjhWF0Hs1OYSxr7jI2q01PppPh1rEsGHrt4Kk9PNMSInwzfM2OwQKRLcmb8KdWA7aHXa00Mpr9dMxC9XrxbBwzV2AqQj7CLfrL85UGxMjg9DXm6Jx5mhimlH3adKYlrNq+jtfXEAB+Kc2iLMT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UdJJrdM7; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UdJJrdM7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=QF
	58zN1CnZhTbFRDggSAyuR9d9wYPZc3P6t5CBASEhc=; b=UdJJrdM7eBZjAH9MpC
	ppLdjq1cDlJr8d7qSHanVesLnATAlAcmbf8REpx6A7E4SQvCfU7w91OUcp6xKejk
	xq99Royz4/TJzx5VQpUsgvpMNL2uJNFnXaGmk21a+CgYhwdBapNElwktu8sCyfKj
	70PdBo/Bapfsp9qM1/H8YHEIQ=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgDnr5O5olVq0LimGA--.23819S2;
	Tue, 14 Jul 2026 10:45:13 +0800 (CST)
From: weimin xiong <15927021679@163.com>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowangio@gmail.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	xiongweimin <xiongweimin@kylinos.cn>
Subject: [PATCH] virtio: fix article before virtio in dma-buf comment
Date: Tue, 14 Jul 2026 10:45:13 +0800
Message-ID: <20260714024513.188571-1-15927021679@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgDnr5O5olVq0LimGA--.23819S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKry8tFyDKw47JrWrXw4fKrg_yoWfXFX_uF
	1UXryIgw1DX3Wj9rZ5Zw4F9r9I9a48JFs5Wrn8tryfAw13Jr1UAryIqF47G3ZrZrs8KFsx
	XrWrAr98Zw1fGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8vPfPUUUUU==
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC9BrGT2pVorrSbAAA3+

From: xiongweimin <xiongweimin@kylinos.cn>

Use "a virtio" rather than "an virtio".

Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
---
 drivers/virtio/virtio_dma_buf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_dma_buf.c b/drivers/virtio/virtio_dma_buf.c
index 95c10632f..901282d82 100644
--- a/drivers/virtio/virtio_dma_buf.c
+++ b/drivers/virtio/virtio_dma_buf.c
@@ -14,7 +14,7 @@
  *	struct embedded in a virtio_dma_buf_ops.
  *
  * This wraps dma_buf_export() to allow virtio drivers to create a dma-buf
- * for an virtio exported object that can be queried by other virtio drivers
+ * for a virtio exported object that can be queried by other virtio drivers
  * for the object's UUID.
  */
 struct dma_buf *virtio_dma_buf_export
-- 
2.43.0


No virus found
		Checked by Hillstone Network AntiVirus

