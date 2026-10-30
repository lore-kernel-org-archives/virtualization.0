Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793329157;
	b=yiXmSEB+nerYTYNMC7ImRi7bbqVc+D/IVYnlzvG4aXmlnklnI9lXbpuTNuHiqwen0SUY
	 WaqMAv2AHgtopUtfRuNpBLW7N1qVEOWg8PGlfG2Vf9bgnDaVHvogDCmLA2xCaRhVUK3gx
	 qaLjfiU1GbfN8s87LrFtmcTZ4SHizj7orJQwYBkwQ85+BfICB2vKyrihOkainkRsztYQO
	 HmBf7A9sL87lhBOw0Ikzc+/Hjfup7knaNNMJ2irxWEwFrfVfZI+tGskrU6BWGUP6iGw6i
	 P41nfpe0RGPwmyyQ1yAuEr1YCtkBeNCjFWf/3RnVUPRVai96B6Tfex7BGhHTLBo4RVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793329157;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=M1YFIP1momfayTo5BQCGcGIZ358SmM7AYY10VJeYGMA=;
	b=dFTwalTEENFLXCigUPVOFg/f2oeAYqb3DlDtk/HQ3BTdnzVN6iMlaEIKD9H2RC55MnY2
	 n7z3TPm3l/SuIqRY5GNN3VNTFlJDOyuS3leeoTHTPLTTa3wTUjvqMz9IJreyY8swvQfgo
	 WJoQ27jDXr8avccTEt10kG7XF0q7kreK2zDxCLLms3JO4iVBlACQbeypPt/RC/u+qoG+5
	 7FrxZv4JIc/VIe3Xia5tDcWDd8pc33uWJXKeSXoJOwlRxPYDIm8WJqHRVUfQ8RdSW8ZBs
	 ea1axO+c9IPWo/zoKVZAN3XCqi3S91NRZUjCz9JnpWOZTsN6UXJKuiEbyHBYpTdK9uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=dAgBQoIt;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABA7606A31A
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 02:59:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EABA7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=dAgBQoIt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=M1
	YFIP1momfayTo5BQCGcGIZ358SmM7AYY10VJeYGMA=; b=dAgBQoItthieozI9GK
	PAVrjylRYwpWFebCszC8FG8eOhGJlURUQA0zr8mc85YC8a7dQYae5M/zQuKr8r9y
	nTwnGTbXEcicnuPhN2YliMCICDjYwoRawTh03YXuvsR3lew36k2O0uDGofp95LI6
	kHLOrInIlWeOw+65/yjn53xbs=
Received: from neo-TianYi510Pro-15ICK.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgCnZfjfB+RqfTvxCg--.40090S3;
	Fri, 30 Oct 2026 10:58:45 +0800 (CST)
From: liuqiangneo@163.com
To: "Michael S . Tsirkin" <mst@redhat.com>,
	David Hildenbrand <david@kernel.org>
Cc: Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	Qiang Liu <liuqiang@kylinos.cn>
Subject: [PATCH 1/3] virtio_balloon: add tracepoints for inflate and deflate operations
Date: Fri, 30 Oct 2026 10:58:32 +0800
Message-ID: <20261030025834.19160-2-liuqiangneo@163.com>
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
X-CM-TRANSID:PSgvCgCnZfjfB+RqfTvxCg--.40090S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3GFyUWF1rGw1xKFWxCFWfZrb_yoW7Ar4UpF
	s7Arn0kw47XrW7Ka4fCF4rWrsxZwn7CFWxtFyaga4UCF43JFZrKr1DtrWDJF4UAry0grnI
	ga9xXF1DCan0vaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jTKZJUUUUU=
X-CM-SenderInfo: 5olx1xxdqj0vrr6rljoofrz/xtbC4AXOMGrkB+U8VgAA3d

From: Qiang Liu <liuqiang@kylinos.cn>

When the guest responds unexpectedly to balloon resize requests,
the actual applied delta cannot be observed from the guest side.

Add a "virtio_balloon" trace system with three tracepoints:
config_change (target / resulting size / delta), and
inflate and deflate (requested / applied page units / resulting size).

Signed-off-by: Qiang Liu <liuqiang@kylinos.cn>
---
 MAINTAINERS                           |  1 +
 drivers/virtio/virtio_balloon.c       | 13 ++++
 include/trace/events/virtio_balloon.h | 87 +++++++++++++++++++++++++++
 3 files changed, 101 insertions(+)
 create mode 100644 include/trace/events/virtio_balloon.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e4ca41cdd872..0ef6f34471de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29590,6 +29590,7 @@ M:	David Hildenbrand <david@kernel.org>
 L:	virtualization@lists.linux.dev
 S:	Maintained
 F:	drivers/virtio/virtio_balloon.c
+F:	include/trace/events/virtio_balloon.h
 F:	include/uapi/linux/virtio_balloon.h
 
 VIRTIO BLOCK AND SCSI DRIVERS
diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index ab3e3d887e00..2d0b16383661 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -19,6 +19,8 @@
 #include <linux/wait.h>
 #include <linux/mm.h>
 #include <linux/page_reporting.h>
+#define CREATE_TRACE_POINTS
+#include <trace/events/virtio_balloon.h>
 
 /*
  * Balloon device works in 4K page units.  So each page is pointed to by
@@ -285,6 +287,8 @@ static unsigned int fill_balloon(struct virtio_balloon *vb, size_t num)
 	/* Did we get any? */
 	if (vb->num_pfns != 0)
 		tell_host(vb, vb->inflate_vq);
+
+	trace_virtio_balloon_inflate(num, num_allocated_pages, vb->num_pages);
 	mutex_unlock(&vb->balloon_lock);
 
 	return num_allocated_pages;
@@ -333,6 +337,8 @@ static unsigned int leak_balloon(struct virtio_balloon *vb, size_t num)
 	if (vb->num_pfns != 0)
 		tell_host(vb, vb->deflate_vq);
 	release_pages_balloon(vb, &pages);
+
+	trace_virtio_balloon_deflate(num, num_freed_pages, vb->num_pages);
 	mutex_unlock(&vb->balloon_lock);
 	return num_freed_pages;
 }
@@ -567,11 +573,18 @@ static void update_balloon_size_func(struct work_struct *work)
 	diff = towards_target(vb);
 
 	if (diff) {
+		unsigned long target = vb->num_pages + diff;
+		unsigned long before = vb->num_pages;
+
 		if (diff > 0)
 			diff -= fill_balloon(vb, diff);
 		else
 			diff += leak_balloon(vb, -diff);
 		update_balloon_size(vb);
+
+		trace_virtio_balloon_config_change(target, vb->num_pages,
+						   (long)vb->num_pages -
+						   (long)before);
 	}
 
 	if (diff)
diff --git a/include/trace/events/virtio_balloon.h b/include/trace/events/virtio_balloon.h
new file mode 100644
index 000000000000..f733fc360d8b
--- /dev/null
+++ b/include/trace/events/virtio_balloon.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM virtio_balloon
+
+#if !defined(_TRACE_VIRTIO_BALLOON_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_VIRTIO_BALLOON_H
+
+#include <linux/tracepoint.h>
+
+/*
+ * All page counts reported by these events are in balloon page units, i.e.
+ * the 4K units the virtio balloon device operates on.  Divide by
+ * VIRTIO_BALLOON_PAGES_PER_PAGE to obtain the number of guest pages.
+ */
+
+TRACE_EVENT(virtio_balloon_config_change,
+
+	TP_PROTO(unsigned long target, unsigned long num_pages, long delta),
+
+	TP_ARGS(target, num_pages, delta),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, target)
+		__field(unsigned long, num_pages)
+		__field(long, delta)
+	),
+
+	TP_fast_assign(
+		__entry->target = target;
+		__entry->num_pages = num_pages;
+		__entry->delta = delta;
+	),
+
+	TP_printk("target=%lu num_pages=%lu delta=%ld",
+		  __entry->target, __entry->num_pages, __entry->delta)
+);
+
+TRACE_EVENT(virtio_balloon_inflate,
+
+	TP_PROTO(unsigned long requested, unsigned long inflated,
+		 unsigned long num_pages),
+
+	TP_ARGS(requested, inflated, num_pages),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, requested)
+		__field(unsigned long, inflated)
+		__field(unsigned long, num_pages)
+	),
+
+	TP_fast_assign(
+		__entry->requested = requested;
+		__entry->inflated = inflated;
+		__entry->num_pages = num_pages;
+	),
+
+	TP_printk("requested=%lu inflated=%lu num_pages=%lu",
+		  __entry->requested, __entry->inflated, __entry->num_pages)
+);
+
+TRACE_EVENT(virtio_balloon_deflate,
+
+	TP_PROTO(unsigned long requested, unsigned long deflated,
+		 unsigned long num_pages),
+
+	TP_ARGS(requested, deflated, num_pages),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, requested)
+		__field(unsigned long, deflated)
+		__field(unsigned long, num_pages)
+	),
+
+	TP_fast_assign(
+		__entry->requested = requested;
+		__entry->deflated = deflated;
+		__entry->num_pages = num_pages;
+	),
+
+	TP_printk("requested=%lu deflated=%lu num_pages=%lu",
+		  __entry->requested, __entry->deflated, __entry->num_pages)
+);
+
+#endif /* _TRACE_VIRTIO_BALLOON_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.43.0


No virus found
		Checked by Hillstone Network AntiVirus

