Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793349269;
	b=rKOIitNyOCdhQGuZ825dS31dLLpu2xhFDsI/ZcJGi0Dnb90OaSQaPqVhC7livlfyTC3M
	 +XWHFsRKKj/ly5IeVmrNapuuu5o9Sn0fRetNAWktcdnUfhbjmiFDK5gZDvwATGzTuaAQv
	 AcG5IWyHz+s8ZN2XTpoogxSSAXdniCjBXWqSeNzl3X1OIdsK0GFMJMCqto4rSsl8BYRh4
	 YKReuHJNXPHNBSRLlI5Ba/bXMEnP16MD1DVQ6Sp7YAKtBo98t4+9KWEIaMvpwR7Ku5eoH
	 nuzppXqRdNICBSk2NFF9Tw1t3pUi0OIes66qU1OWKefEDJQFDIBwRS5fxeq+isvIJVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793349269;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=k/Cb+9PJIrDQIPotGU391kdpQTlHe+ce4bWa99eeXrE=;
	b=AYxCIA+ccgcrIsPVll9ZGmtSZWqIPmuyjXZLpn2fY5PFZRdNFpQBUuRXMHYQ6EUJoPkx
	 3NCD/vm5jbKAp/kFHdMo2ZlBAhB7S9z46JOLIbNXjwenySwcRBiOYIg+vLcNICuVlLY1h
	 H2YjxXlG+/EInJSd/Ame/TyyOwpVYoPYFGbY6pfFkkZkQjuqRGde2/IgjXiOijnzAX/jX
	 roZ2cMf44xT6476YfC1KJxt5DFuHBM5zrt8wcZioiBK1q9Hhb5QHVnIjWrZc9zK2vmXD0
	 +tVdseB/k5jPRFPAC2PQVqS7djT3OGvDk04JSoo+boxFEV1EP5kykTdXNMsdHrhxZYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="i/358uwq";
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9C0606A31D
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 08:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC9C0606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=i/358uwq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=k/
	Cb+9PJIrDQIPotGU391kdpQTlHe+ce4bWa99eeXrE=; b=i/358uwq5lB2w8KcCt
	q5Sdp77z6yAtfUWMJgNhNTaZTddX8ZXRt3qLPhr1z6W+1BB8En0lJ5sfZFulFf87
	rLLopNVjAP1wk9iamAZHc7W9hckW9PgJn7zn6oAyafrAr9mF3jgI/7xg7fT5W6HT
	L7e6hoSSebvAxwwoiY59cB/7g=
Received: from neo-TianYi510Pro-15ICK.. (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgAXRXl+VuRqCoKSCg--.15983S4;
	Fri, 30 Oct 2026 16:34:11 +0800 (CST)
From: liuqiangneo@163.com
To: "Michael S . Tsirkin" <mst@redhat.com>,
	David Hildenbrand <david@kernel.org>
Cc: Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	Qiang Liu <liuqiang@kylinos.cn>
Subject: [PATCH v2 2/3] virtio_balloon: add tracepoint for host ack latency
Date: Fri, 30 Oct 2026 16:33:59 +0800
Message-ID: <20261030083400.66005-3-liuqiangneo@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030083400.66005-1-liuqiangneo@163.com>
References: <20261030083400.66005-1-liuqiangneo@163.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgAXRXl+VuRqCoKSCg--.15983S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFy5WFyfGw18KF4kCFy7trb_yoW5AFyxpF
	nxArnIk3yUXr42qFyfta1j9r15u397GryfJFWSgw1UCr43JFyDKr4DKF1qyFyrAr4vg3s3
	uFn2qFZ0kF1kZw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jfAwxUUUUU=
X-CM-SenderInfo: 5olx1xxdqj0vrr6rljoofrz/xtbC-AOJ6mrkVoOMrAAA3n

From: Qiang Liu <liuqiang@kylinos.cn>

Balloon inflate/deflate block in tell_host() for host buffer consumption.
Host-side stalls are easily mistaken for guest allocation issues.

Add virtio_balloon_host_ack to record tell_host() wait time,
virtqueue and PFN count, to split balloon latency between guest and host.

Signed-off-by: Qiang Liu <liuqiang@kylinos.cn>
---
 drivers/virtio/virtio_balloon.c       | 19 +++++++++++++++++--
 include/trace/events/virtio_balloon.h | 22 ++++++++++++++++++++++
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 2d0b16383661..c4fdc6815b41 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -19,6 +19,7 @@
 #include <linux/wait.h>
 #include <linux/mm.h>
 #include <linux/page_reporting.h>
+#include <linux/ktime.h>
 #define CREATE_TRACE_POINTS
 #include <trace/events/virtio_balloon.h>
 
@@ -197,8 +198,22 @@ static void tell_host(struct virtio_balloon *vb, struct virtqueue *vq)
 		return;
 	virtqueue_kick(vq);
 
-	/* When host has read buffer, this completes via balloon_ack */
-	wait_event(vb->acked, virtqueue_get_buf(vq, &len));
+	/*
+	 * When host has read buffer, this completes via balloon_ack.
+	 *
+	 * The latency is only measured when the tracepoint is enabled, so a
+	 * disabled tracepoint adds no clock reads on this (hot) path.
+	 */
+	if (trace_virtio_balloon_host_ack_enabled()) {
+		ktime_t start = ktime_get();
+
+		wait_event(vb->acked, virtqueue_get_buf(vq, &len));
+		trace_virtio_balloon_host_ack(vb->num_pfns,
+					      vq->name,
+					      ktime_to_ns(ktime_sub(ktime_get(), start)));
+	} else {
+		wait_event(vb->acked, virtqueue_get_buf(vq, &len));
+	}
 }
 
 static int virtballoon_free_page_report(struct page_reporting_dev_info *pr_dev_info,
diff --git a/include/trace/events/virtio_balloon.h b/include/trace/events/virtio_balloon.h
index f733fc360d8b..559deb997e88 100644
--- a/include/trace/events/virtio_balloon.h
+++ b/include/trace/events/virtio_balloon.h
@@ -81,6 +81,28 @@ TRACE_EVENT(virtio_balloon_deflate,
 		  __entry->requested, __entry->deflated, __entry->num_pages)
 );
 
+TRACE_EVENT(virtio_balloon_host_ack,
+
+	TP_PROTO(unsigned int num_pfns, const char *vq_name, s64 latency_ns),
+
+	TP_ARGS(num_pfns, vq_name, latency_ns),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, num_pfns)
+		__string(vq_name, vq_name)
+		__field(s64, latency_ns)
+	),
+
+	TP_fast_assign(
+		__entry->num_pfns = num_pfns;
+		__assign_str(vq_name);
+		__entry->latency_ns = latency_ns;
+	),
+
+	TP_printk("vq=%s num_pfns=%u latency=%lldns",
+		  __get_str(vq_name), __entry->num_pfns, __entry->latency_ns)
+);
+
 #endif /* _TRACE_VIRTIO_BALLOON_H */
 
 /* This part must be outside protection */
-- 
2.43.0


No virus found
		Checked by Hillstone Network AntiVirus

