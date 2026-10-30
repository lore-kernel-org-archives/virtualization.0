Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793349271;
	b=ye5Jm86wV5nlgyzAF5y8dC0d1zuBVAN8EF+8ov27ePhF/tj99ne8+k+y9fjghkLDrTI4
	 YXgTrkaCkThaOG6DD0dRefs5C0D+bMDiYttJa1Ddfbs+CNJJ6z32eOuLUBy1bc7GHI+pk
	 cXijeWrSBXhu2+ohbfEBcoVTl2KCFQgz/bXx48ky1ax2O36Z6escNmd9qsygJ+H2SlZGD
	 GMzFnf5+LKSsYsHZbfxWDhSJX2yYn7YrnjfPQ+ZNCiFOvykrEbnP/9u/x6T/X2QMZvMuf
	 FQKJAoO8JblSdO0s3uxziTPa5At9ovP0Sr8EgSWWBTiqJXs3+ab2zFZKk+Zj5BfuQyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793349271;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=I72n+CWhLWrUERT5jZ5V7O55jD6fzXYXW00CTfYGjS4=;
	b=k9QrlLw5VsKVCm64vP51ymBM3CPCICluV5iNqXEqzQoOAUkThTEbpDUcEUjYNi9zjEex
	 hEBfLIJuZILSfAZal1lq+LCjQAalSl9kPVnXy9GWBSjP6RAOAw6OSxIndrZtTSads5yIw
	 pS8m7zWMRdZTzFPuwvzEa7G0gPEbEEnPOpppvKruxOlG6rMQb7Z3soh2Q46tjIWUyXBli
	 iLEMTFFJWAOGXk/CHrKoXyf7Qb5GKdWgp9T8T1fggOh1onsFN0ydKKsG2Z0+CaJOYbxHN
	 SzAHHPJxI2GT0DRdK5yKdcNdUHpYGVGzQ7v8nVkANCj024wicXA0OAxjPjTe6SJdkqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=GWQZCO3K;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E86606A320
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 08:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90E86606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=GWQZCO3K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=I7
	2n+CWhLWrUERT5jZ5V7O55jD6fzXYXW00CTfYGjS4=; b=GWQZCO3KL7T/cQiFBD
	y+vf17/v6PO27FhjeNQjKyBxTy9+OeikBghu7vo4R6irOguDrYFk7N4O29en60x0
	nNUcnW1nYwnb3iDs878uhKfxR6iPN4iMyaD1d3MvMBGk5WncaJCyon3gzw5coagK
	F38x0a/Z851VeW6xDVW0e0V1A=
Received: from neo-TianYi510Pro-15ICK.. (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgAXRXl+VuRqCoKSCg--.15983S5;
	Fri, 30 Oct 2026 16:34:12 +0800 (CST)
From: liuqiangneo@163.com
To: "Michael S . Tsirkin" <mst@redhat.com>,
	David Hildenbrand <david@kernel.org>
Cc: Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	Qiang Liu <liuqiang@kylinos.cn>
Subject: [PATCH v2 3/3] virtio_balloon: add tracepoints for free page hinting and migration
Date: Fri, 30 Oct 2026 16:34:00 +0800
Message-ID: <20261030083400.66005-4-liuqiangneo@163.com>
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
X-CM-TRANSID:PCgvCgAXRXl+VuRqCoKSCg--.15983S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFyrZFyxJw43Kr1kZF4fZrb_yoWrGFWrpa
	n7Arn5G3y8Xr47KFWfArW8uw15Z3s7CFWfJFW2g34UCF43JF9Fg3WDtr1DZrW3Ar18trn3
	ZF1IgFWUCF1kuaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jlGQfUUUUU=
X-CM-SenderInfo: 5olx1xxdqj0vrr6rljoofrz/xtbC3wSK62rkVoTPlgAA3-

From: Qiang Liu <liuqiang@kylinos.cn>

Free page hint requests cannot be traced, and migration only
provides summary stats. Lock contention causing migration abort
cannot be distinguished, making these two flows hard to debug.

Add tracepoints to record host hint commands, leftover hint blocks
and balloon_lock -EAGAIN migration failures.

Signed-off-by: Qiang Liu <liuqiang@kylinos.cn>
---
 drivers/virtio/virtio_balloon.c       | 11 +++++-
 include/trace/events/virtio_balloon.h | 48 +++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index c4fdc6815b41..26c9c118ad96 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -817,6 +817,10 @@ static void virtio_balloon_report_free_page(struct virtio_balloon *vb)
 	err = send_cmd_id_stop(vb);
 	if (unlikely(err))
 		dev_err(dev, "Failed to send a stop id, err = %d\n", err);
+
+	trace_virtio_balloon_free_page_hint(
+		virtio32_to_cpu(vb->vdev, vb->cmd_id_active),
+		READ_ONCE(vb->num_free_page_blocks));
 }
 
 static void report_free_page_func(struct work_struct *work)
@@ -869,8 +873,11 @@ static int virtballoon_migratepage(struct balloon_dev_info *vb_dev_info,
 	 * recursion in the case it ends up triggering memory compaction
 	 * while it is attempting to inflate the ballon.
 	 */
-	if (!mutex_trylock(&vb->balloon_lock))
+	if (!mutex_trylock(&vb->balloon_lock)) {
+		trace_virtio_balloon_migrate(page_to_pfn(page),
+					     page_to_pfn(newpage), -EAGAIN);
 		return -EAGAIN;
+	}
 
 	/* balloon's page migration 1st step  -- inflate "newpage" */
 	vb->num_pfns = VIRTIO_BALLOON_PAGES_PER_PAGE;
@@ -883,6 +890,8 @@ static int virtballoon_migratepage(struct balloon_dev_info *vb_dev_info,
 	tell_host(vb, vb->deflate_vq);
 
 	mutex_unlock(&vb->balloon_lock);
+
+	trace_virtio_balloon_migrate(page_to_pfn(page), page_to_pfn(newpage), 0);
 	return 0;
 }
 #endif /* CONFIG_BALLOON_MIGRATION */
diff --git a/include/trace/events/virtio_balloon.h b/include/trace/events/virtio_balloon.h
index 559deb997e88..38e74a53bcd5 100644
--- a/include/trace/events/virtio_balloon.h
+++ b/include/trace/events/virtio_balloon.h
@@ -103,6 +103,54 @@ TRACE_EVENT(virtio_balloon_host_ack,
 		  __get_str(vq_name), __entry->num_pfns, __entry->latency_ns)
 );
 
+TRACE_EVENT(virtio_balloon_free_page_hint,
+
+	/*
+	 * unreclaimed_blocks: hint blocks given to the host but not yet
+	 * reclaimed via CMD_ID_DONE; accumulated across reporting rounds.
+	 */
+	TP_PROTO(u32 cmd_id, unsigned long unreclaimed_blocks),
+
+	TP_ARGS(cmd_id, unreclaimed_blocks),
+
+	TP_STRUCT__entry(
+		__field(u32, cmd_id)
+		__field(unsigned long, unreclaimed_blocks)
+	),
+
+	TP_fast_assign(
+		__entry->cmd_id = cmd_id;
+		__entry->unreclaimed_blocks = unreclaimed_blocks;
+	),
+
+	TP_printk("cmd_id=%u unreclaimed_blocks=%lu",
+		  __entry->cmd_id, __entry->unreclaimed_blocks)
+);
+
+#ifdef CONFIG_BALLOON_MIGRATION
+TRACE_EVENT(virtio_balloon_migrate,
+
+	TP_PROTO(unsigned long old_pfn, unsigned long new_pfn, long ret),
+
+	TP_ARGS(old_pfn, new_pfn, ret),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, old_pfn)
+		__field(unsigned long, new_pfn)
+		__field(long, ret)
+	),
+
+	TP_fast_assign(
+		__entry->old_pfn = old_pfn;
+		__entry->new_pfn = new_pfn;
+		__entry->ret = ret;
+	),
+
+	TP_printk("old_pfn=0x%lx new_pfn=0x%lx ret=%ld",
+		  __entry->old_pfn, __entry->new_pfn, __entry->ret)
+);
+#endif /* CONFIG_BALLOON_MIGRATION */
+
 #endif /* _TRACE_VIRTIO_BALLOON_H */
 
 /* This part must be outside protection */
-- 
2.43.0


No virus found
		Checked by Hillstone Network AntiVirus

