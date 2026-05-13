Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F3B4D90DD
	for <virtualization@lists.linux.dev>; Wed, 13 May 2026 16:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778691020; cv=none; b=Sb5e9HAobxnVcbDDtP+mjn2L2nh2pUkj0kyjiVS0Qi6Z4mh2yQAfIVmL1LIsn3oLEdsPspviL5pX28z0pOWQLHhmcPFUXpnPUfXX1mXGLh8SdHgiVv/d8YT3KXVQBzCe9UE9TrDYfr2IbTDph2PvwvorGTju3m754feTH6RaXGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778691020; c=relaxed/simple;
	bh=ubWLVrkqIfMjNhK3RiA5i6R8ocZ29s4Mn+vxxSfA+gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nop0jUDre9lphJgqQ6uN5qYe+oEb0w51ORglQtey7ns6NQBE2EI3tvViQ1R4npQsF0l8X34dU+65iyqY4gPmHJ0v2BZsUpbHG94FK1qcSJBcKwx0gvwErW3m20E6E2GDM6Acgb1oS9L9ksXVNTaN8maN2pGJ08OeyTj1Gn9A0vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=pqMpIXjp; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="pqMpIXjp"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-90fc979d84cso67207185a.1
        for <virtualization@lists.linux.dev>; Wed, 13 May 2026 09:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1778691012; x=1779295812; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLcL6E1qyfzlUGSv6Nk/PekuP6kW11aRlu3ns23KnZ4=;
        b=pqMpIXjpSUwQ89EolGX7+9G5Ouom6UtOPplsfxR/B686EXxjMmzNXE6N658W7X5EaZ
         g4ULqzHRDeV2awAfiszruPZeXgrWyNBlUOnmXYsU9O+cBmd4eJlwZuiHnDB/mWNKHuyA
         AZscOHXfLAfHJqO0IfI9A/dl9ze21a99vz5MSGQbRp6VZIEu06JCA78bXvzbXEKdYhYz
         xYMnDtukSFb3/o/EGSIFIBVJhiaFcwRFldt7xFUJlJXT2I7OBugaWkFVmnX2hVYc/iNA
         fLJc/yVAjrPWYDA7eSwiyA42ppAxu2G0s+0NQfLjE316bpSmjlNhAktEmritf4FLmcBK
         jPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778691012; x=1779295812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aLcL6E1qyfzlUGSv6Nk/PekuP6kW11aRlu3ns23KnZ4=;
        b=W+yApOPSn2S3NZyYSoXuA2w6cNX9BjA8TtHoSSczhgV6TFx6agoDEl4BmZVemZ1QUa
         YYWYptpUmpm8/mW25pA4M4oT7b//XjTVxBG7Ng22NCthTf2yzYwpHp4R2DeuNymIa0tU
         A5osdee35fkYqDQqleVwY2dndBoNX8roc6w6zDzaa0hw/Uq+9++NvbAAdhI5MK8laekG
         VZ8/aMOvmeMdKv2wZ1lW9bYVE6Rc2yP0vtOm3okRdoUOA25Y1jXks6OGIGhXa6Uj7Lev
         DKMANBd4wYpmj2i8gg4GfFKUh2ZidoLXnzUuP5FjApDTbRpO8xffQsrYYL6PF216q5rx
         qOrw==
X-Gm-Message-State: AOJu0YwePnziOvj6WY1ixo1zqX4wzw7QWAoqqljvgpwnyaNFzJpbYSge
	xmzuNTfzJodn3ZAJnJsulmJqJXXf3aQuQMkmc62GTRNzqYL2xD20jzm8DUe1d3LiUQmIN08TO1i
	lcBP5
X-Gm-Gg: Acq92OFWeVx+khCbaTwTuN7q7RKv9HgFgl1uBtE5V1ufzyBXwPJ1gKXBjXQ1Qnfx/Xn
	RLETk2hNudqyy75pvKbW7u/8evp2lhVDrB4iADlBMG13lVPCUahUzR/aQL/isAl2PF1yI2iUVZ0
	+7573bO+gWPn/Ce1n+tThEApoNfFSPy6JR6OPC2QpVYtRBD1tRW8cuRiCgEn0MMrpV6uyon6tQp
	yyC+cryg24aPHFauuJPEHs22O1JNOFh7XDieyMesllgIlxhJFpj12smBf5ZT9i+L8SjzxXkt5Zh
	CuX8TdqLq/gAGMd+DoR0o0rg9ED9Bo4UD6Jt6SD/OqoN2KYiwnPxRxomOMGvkVPLc1GkLHjPRLl
	2+Dwal0TEOAxOA9h0uq6cYaaq/UkVy1LqcLFqtb90JfPjxYCW8cxCOrBexgNJ8k6Drt5rjYkaGT
	SHb0oxpxd/t6ybQ8Z9KQwWbxdsziun75LSu3zY6fkfiiFzrD3Q9VFQ1A/iVjjtm0JUt2h8dmpcm
	AU99bBIye/HT+i26g==
X-Received: by 2002:ac8:7f0a:0:b0:50f:ae60:25ab with SMTP id d75a77b69052e-5162fe3d0d4mr54299461cf.12.1778691011304;
        Wed, 13 May 2026 09:50:11 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e677e63sm152498891cf.12.2026.05.13.09.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 09:50:10 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: virtualization@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	mst@redhat.com,
	david@kernel.org,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	hannes@cmpxchg.org,
	surenb@google.com,
	peterz@infradead.org,
	mingo@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com
Subject: [RFC PATCH 1/2] virtio-balloon: extend stats with memory composition and pressure data
Date: Wed, 13 May 2026 12:50:05 -0400
Message-ID: <20260513165006.2790857-2-gourry@gourry.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513165006.2790857-1-gourry@gourry.net>
References: <20260513165006.2790857-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When doing proactive ballooning to reduce the size of a guest, some
additional vmstat information is useful in deciding how much pressure
to exert on the VM and when the VM starts experiencing undesirable
behavior (memory and io pressure).

Add 11 new statistics tags to the existing balloon stats virtqueue
for improved balloon sizing decisions. Old hosts ignore unknown tags,
so no feature negotiation is required.

New memory composition stats (bytes):
  S_DIRTY:         dirty pages awaiting writeback
  S_WRITEBACK:     pages under active writeback
  S_ANON:          anonymous pages (for balloon ceiling calculation)
  S_INACTIVE_FILE: inactive file LRU (safely reclaimable subset of cache)
  S_SLAB_RECLAIM:  reclaimable slab memory

New workingset stats (counts):
  S_WS_REFAULT_A:  anon workingset refaults
  S_WS_REFAULT_F:  file workingset refaults

New PSI stats (microseconds, cumulative):
  S_PSI_MEM_SOME:  memory pressure (some stalled)
  S_PSI_MEM_FULL:  memory pressure (all stalled)
  S_PSI_IO_SOME:   IO pressure (some stalled)
  S_PSI_IO_FULL:   IO pressure (all stalled)

Export psi_system for module builds (CONFIG_VIRTIO_BALLOON=m with
CONFIG_PSI=y).

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/virtio/virtio_balloon.c     | 33 +++++++++++++++++++++++++++++
 include/uapi/linux/virtio_balloon.h | 26 +++++++++++++++++++++--
 kernel/sched/psi.c                  |  1 +
 3 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index f6c2dff33f8a..8fa33aec4ce7 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -18,6 +18,8 @@
 #include <linux/wait.h>
 #include <linux/mm.h>
 #include <linux/page_reporting.h>
+#include <linux/vmstat.h>
+#include <linux/psi.h>
 
 /*
  * Balloon device works in 4K page units.  So each page is pointed to by
@@ -414,6 +416,37 @@ static unsigned int update_balloon_stats(struct virtio_balloon *vb)
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_CACHES,
 				pages_to_bytes(caches));
 
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_DIRTY,
+		    pages_to_bytes(global_node_page_state(NR_FILE_DIRTY)));
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_WRITEBACK,
+		    pages_to_bytes(global_node_page_state(NR_WRITEBACK)));
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_ANON,
+		    pages_to_bytes(global_node_page_state(NR_ANON_MAPPED)));
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_INACTIVE_FILE,
+		    pages_to_bytes(global_node_page_state(NR_INACTIVE_FILE)));
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_SLAB_RECLAIM,
+		    pages_to_bytes(
+			global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B)));
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_WS_REFAULT_A,
+		    global_node_page_state(WORKINGSET_REFAULT_ANON));
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_WS_REFAULT_F,
+		    global_node_page_state(WORKINGSET_REFAULT_FILE));
+
+#ifdef CONFIG_PSI
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_PSI_MEM_SOME,
+		    div_u64(psi_system.total[PSI_AVGS][PSI_MEM_SOME],
+			    NSEC_PER_USEC));
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_PSI_MEM_FULL,
+		    div_u64(psi_system.total[PSI_AVGS][PSI_MEM_FULL],
+			    NSEC_PER_USEC));
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_PSI_IO_SOME,
+		    div_u64(psi_system.total[PSI_AVGS][PSI_IO_SOME],
+			    NSEC_PER_USEC));
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_PSI_IO_FULL,
+		    div_u64(psi_system.total[PSI_AVGS][PSI_IO_FULL],
+			    NSEC_PER_USEC));
+#endif
+
 	return idx;
 }
 
diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index ee35a372805d..37ec8a8466c4 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -77,7 +77,18 @@ struct virtio_balloon_config {
 #define VIRTIO_BALLOON_S_DIRECT_SCAN   13 /* Amount of memory scanned directly */
 #define VIRTIO_BALLOON_S_ASYNC_RECLAIM 14 /* Amount of memory reclaimed asynchronously */
 #define VIRTIO_BALLOON_S_DIRECT_RECLAIM 15 /* Amount of memory reclaimed directly */
-#define VIRTIO_BALLOON_S_NR       16
+#define VIRTIO_BALLOON_S_DIRTY	       16 /* Dirty pages (bytes) */
+#define VIRTIO_BALLOON_S_WRITEBACK     17 /* Pages under writeback (bytes) */
+#define VIRTIO_BALLOON_S_ANON	       18 /* Anonymous pages (bytes) */
+#define VIRTIO_BALLOON_S_INACTIVE_FILE 19 /* Inactive file LRU pages (bytes) */
+#define VIRTIO_BALLOON_S_SLAB_RECLAIM  20 /* Reclaimable slab (bytes) */
+#define VIRTIO_BALLOON_S_WS_REFAULT_A  21 /* Workingset refaults anon (count) */
+#define VIRTIO_BALLOON_S_WS_REFAULT_F  22 /* Workingset refaults file (count) */
+#define VIRTIO_BALLOON_S_PSI_MEM_SOME  23 /* PSI memory some total (us) */
+#define VIRTIO_BALLOON_S_PSI_MEM_FULL  24 /* PSI memory full total (us) */
+#define VIRTIO_BALLOON_S_PSI_IO_SOME   25 /* PSI IO some total (us) */
+#define VIRTIO_BALLOON_S_PSI_IO_FULL   26 /* PSI IO full total (us) */
+#define VIRTIO_BALLOON_S_NR	       27
 
 #define VIRTIO_BALLOON_S_NAMES_WITH_PREFIX(VIRTIO_BALLOON_S_NAMES_prefix) { \
 	VIRTIO_BALLOON_S_NAMES_prefix "swap-in", \
@@ -95,7 +106,18 @@ struct virtio_balloon_config {
 	VIRTIO_BALLOON_S_NAMES_prefix "async-scans", \
 	VIRTIO_BALLOON_S_NAMES_prefix "direct-scans", \
 	VIRTIO_BALLOON_S_NAMES_prefix "async-reclaims", \
-	VIRTIO_BALLOON_S_NAMES_prefix "direct-reclaims" \
+	VIRTIO_BALLOON_S_NAMES_prefix "direct-reclaims", \
+	VIRTIO_BALLOON_S_NAMES_prefix "dirty", \
+	VIRTIO_BALLOON_S_NAMES_prefix "writeback", \
+	VIRTIO_BALLOON_S_NAMES_prefix "anon-pages", \
+	VIRTIO_BALLOON_S_NAMES_prefix "inactive-file", \
+	VIRTIO_BALLOON_S_NAMES_prefix "slab-reclaimable", \
+	VIRTIO_BALLOON_S_NAMES_prefix "ws-refault-anon", \
+	VIRTIO_BALLOON_S_NAMES_prefix "ws-refault-file", \
+	VIRTIO_BALLOON_S_NAMES_prefix "psi-mem-some-us", \
+	VIRTIO_BALLOON_S_NAMES_prefix "psi-mem-full-us", \
+	VIRTIO_BALLOON_S_NAMES_prefix "psi-io-some-us", \
+	VIRTIO_BALLOON_S_NAMES_prefix "psi-io-full-us" \
 }
 
 #define VIRTIO_BALLOON_S_NAMES VIRTIO_BALLOON_S_NAMES_WITH_PREFIX("")
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index d9c9d9480a45..8ab3aa1c4ef5 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -175,6 +175,7 @@ static DEFINE_PER_CPU(struct psi_group_cpu, system_group_pcpu);
 struct psi_group psi_system = {
 	.pcpu = &system_group_pcpu,
 };
+EXPORT_SYMBOL_GPL(psi_system);
 
 static DEFINE_PER_CPU(seqcount_t, psi_seq) = SEQCNT_ZERO(psi_seq);
 
-- 
2.54.0

