Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793329138;
	b=Jn5+D1iQ17f7CQsfT1v7kW+TicAoQUgwfKAnyHwcrf2jvnPMU/HepuNgyeOcCRSOZfAd
	 CTutyGXgiA/QAfsPDe8oDKskuZ2ki9MVFxuO+HZ1iJy0k7j0f2r+Vtxq4ns8lUxvmguJX
	 uoNMF2mJxswMxUhjSw3PVFAyHSLG1yMHyq/e0GwlE5nOgVADZkiuegrBraL9kREQgj4S7
	 N9TANhn+/jbwqIwJ7J/6ej65Fip1yFPIsbnRqlA0bpAMrty4Mtf1koVP8U37I8BIvLE74
	 KWAnr4a6ooz8To/ANEt4Y6ktv/pZLeacBMZuXfuc94axW6ZkknBTaIvOCtX6IhPPE2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793329138;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=k/Cb+9PJIrDQIPotGU391kdpQTlHe+ce4bWa99eeXrE=;
	b=tOb+h9VB4+g2EH4cpwyq3uhD6KmAFzri6ZJC1+Fmxuf2O7hwlIt+88a3YIQzcYB4qLhY
	 cKzzF50yuauMBrZuxJqh0eVlETr9cvJIAD712AErwlKxSuGquRy5BTWUVNfB3Z2iplu0D
	 9PYipBN9MPfo1KyqzBr8De/R4GOg4GE47uo6vguyPkCF5UJ2Nh9cDAlVjAnniB/4SgG0e
	 UwOpf6bDX9KQHtcfvcxnKxlAKa0dsvrHMw0i21tE5bbJAJH5dTlnZAbGyzFYvG1BRVzFw
	 GXg289e6k0QXc0jic3TGedaqEyDDpuls6IRI4H02P/8iBOuJoX5lEi7ls7jrNQVoKAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=XccjRenk;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951AE606A31A
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 02:58:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 951AE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=XccjRenk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=k/
	Cb+9PJIrDQIPotGU391kdpQTlHe+ce4bWa99eeXrE=; b=XccjRenk5yuZ0Xaqvn
	+DcQWWoHIWQJHUdZ6tn4dTwSN3U5JPjkkz7+MymaHI0bQU8/O+mcYKGx/VQPkLwg
	1EvUhYR/R2Zqtk/mLBbD2fTJhXjlA329fsP57usR9o3p3TIyYn+Ze8qp4M9WdZyd
	xV3C2vxsQhA8tJcYDwZhVRuqM=
Received: from neo-TianYi510Pro-15ICK.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgCnZfjfB+RqfTvxCg--.40090S4;
	Fri, 30 Oct 2026 10:58:46 +0800 (CST)
From: liuqiangneo@163.com
To: "Michael S . Tsirkin" <mst@redhat.com>,
	David Hildenbrand <david@kernel.org>
Cc: Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	Qiang Liu <liuqiang@kylinos.cn>
Subject: [PATCH 2/3] virtio_balloon: add tracepoint for host ack latency
Date: Fri, 30 Oct 2026 10:58:33 +0800
Message-ID: <20261030025834.19160-3-liuqiangneo@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030025834.19160-1-liuqiangneo@163.com>
References: <20261030025834.19160-1-liuqiangneo@163.com>
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
X-CM-TRANSID:PSgvCgCnZfjfB+RqfTvxCg--.40090S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFy5WFyfGw18KF4kCFy7trb_yoW5AFyxpF
	nxArnIk3yUXr42qFyfta1j9r15u397GryfJFWSgw1UCr43JFyDKr4DKF1qyFyrAr4vg3s3
	uFn2qFZ0kF1kZw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jfAwxUUUUU=
X-CM-SenderInfo: 5olx1xxdqj0vrr6rljoofrz/xtbC3wbOMGrkB+brpQAA3G

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

