Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153842C027F
	for <virtualization@lists.linux.dev>; Thu, 27 Nov 2025 03:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764213884; cv=none; b=rR/eUmm90X5jeSA6ppDJy7M0ag/RYSaNoN/+ME/k+afnpcisO0NtdGf6ysvrWTatSFzFE960F0NbswjLdpHJBr5KVyh9WnTebInHDkNedZvK5gqFlqV/5UJNBYXQgID3legeGFgg5UWAZmU7Pd64j/U37RbsZw9joZOhSpIEjig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764213884; c=relaxed/simple;
	bh=429romhQ3ndFQlLjH1JBjo6rPP4/v/e6MuQLUPhnfvk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nsxSg+LYX9gB3XxT31MdljnrGirCxnSuoharw474mr/0aOmT5QKqAzAZwdtlzBVUdZL3NCR6OznlTe8g8x1ykSl1NxNYhFEqYUl6mqKxU/r+npYh7RALalq9F42/Qjlnb0mxaMHhAstOUwYJce9RkUvG2XAUo14O+qdkIJ5Lj34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QODFgq50; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QODFgq50"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=q31v+xf7MuoN0rWelUId0ieqnNp6bEYZEnceXBG+cao=;
	b=QODFgq50BJq+qCvm3DTJaAASx4NKguxNHOaWVvXZC4cCr9jq59fuDxCtbMF62z
	FosggER51IRWs2TK+mfPdgd/XyYS8mkFMfI4JnSNvRhIVnjxOlL3j9NdV9y4nNgz
	2oSKUyy4VQOlOPzz66UMGMBFy9CZwUBTdURcFWK9reGzU=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCX4NVfxCdptnYQFg--.3639S9;
	Thu, 27 Nov 2025 11:24:29 +0800 (CST)
From: Longjun Tang <lange_tang@163.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com
Cc: lange_tang@163.com,
	tanglongjun@kylinos.cn,
	virtualization@lists.linux.dev
Subject: [PATCH v1 7/7] tools/virtio/virtnet_mon: add README file for virtnet_moin
Date: Thu, 27 Nov 2025 11:24:07 +0800
Message-Id: <20251127032407.33475-8-lange_tang@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251127032407.33475-1-lange_tang@163.com>
References: <20251127032407.33475-1-lange_tang@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgCX4NVfxCdptnYQFg--.3639S9
X-Coremail-Antispam: 1Uf129KBjvJXoWxGry7ZrWxAr15uFy8Xw1xGrg_yoW5XryUpr
	Z8WrySgrWkXrW2qa4fJr15ur1Fkws5J3W7tr92q347Cr45J3WkXFW7tFy5CF43Cr17A34I
	q3WDuas0ganrZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piKLvNUUUUU=
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbBdgATLmknu4n8mAAAsT

From: Tang Longjun <tanglongjun@kylinos.cn>

introduces the building and running methods of virtnet_mon, and also
explains the key implementation points.

Signed-off-by: Tang Longjun <tanglongjun@kylinos.cn>
---
 tools/virtio/virtnet_mon/README | 35 +++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 tools/virtio/virtnet_mon/README

diff --git a/tools/virtio/virtnet_mon/README b/tools/virtio/virtnet_mon/README
new file mode 100644
index 000000000000..a1f6a5ebd219
--- /dev/null
+++ b/tools/virtio/virtnet_mon/README
@@ -0,0 +1,35 @@
+virtnet_mon is used to monitor the data packets of the virtio_net driver and the related parameters of virtqueue, useful for tracking its status and troubleshooting faults.
+
+Build and Execution
+===============
+）Build and Execution
+$ make
+2）Load virtnet_mon
+$ insmod virtnet_mon.ko
+3）Obtain log
+$ tail -f /dev/virtnet_mon | tee -a log
+
+
+Example
+=======
+76748.877337321 cpu=5 dir=TX event_type=SKB_XMIT_DONE_PRE_EVENT vq=0xffff0000c43e0800 queue=output.2 num_free=255 num=256 avail_flags=0 avail_idx=17411 avail_flags_shadow=0 avail_idx_shadow=17411 used_flags=0 used_idx=17411 last_used_idx=17410 broken=0
+76749.357149745 cpu=4 dir=RX event_type=GRO_RECEIVE_SKB_PRE_EVENT vq=0xffff0000c43e0d00 queue=input.2 num_free=4 num=256 avail_flags=0 avail_idx=57294 avail_flags_shadow=1 avail_idx_shadow=57294 used_flags=1 used_idx=57042 last_used_idx=57042 broken=0
+76749.750030740 cpu=4 dir=TX event_type=START_XMIT_PRE_EVENT skb=0xffff0000d354f700 proto=Unknown seq=0 vq=0xffff0000c43e0800 queue=output.2 num_free=256 num=256 avail_flags=0 avail_idx=17411 avail_flags_shadow=0 avail_idx_shadow=17411 used_flags=0 used_idx=17411 last_used_idx=17411 broken=0
+
+
+Implementation Key Points of virtnet_mon
+================================
+1）Create a misc type driver for transferring log information between user space and kernel space.
+2）Introduce kfifo buffers to support more frequent log output or file writing.
+3）Use kprobe to trace the functional interfaces of virtio_net to obtain the relevant parameters of skb and virtqueue.
+
+
+Next Steps
+========
+1）Add real-time monitor of skb and virtqueue parameters to promptly report faults, such as:
+    a) virtqueue.broken
+    b) virtqueue.num_free
+    c) vring used.idx
+    d) ...
+2）Support dynamic control to enable/disable functions through echo xxx > /dev/virtnet_mon.
+3）More comprehensive monitoring information virtnet_mon_pkt_info.
-- 
2.43.0

