Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC9A757E7
	for <virtualization@lists.linux.dev>; Thu, 18 Apr 2024 06:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713421578; cv=none; b=Y9E8pZeuIAXp1ou577nAr+lo6uPiYb+mhqcShjoeqxvmB6zOfHOfMLd+JmCdl2ALnBSU+4LAnp5t7rp7RpT6W5WiZuArEHAXzwrH2YVuG3QXEH2RXT3PVUA+MOjVKWV67e6oeJvj1eVlCBNH0ea3JausLeaDnPogYPdRiNeovZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713421578; c=relaxed/simple;
	bh=Xzbgih7B8aIf9LhXB1XHaCkjr0jHp8G/PviFgcyTSdE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bBL73AeDOyH03FprMnXXePwCWxj7F9WVv7AKb1Xsl3cLsbZdjcL4hKFwXtdPm6VGqHQrXY4fkRpCIaA3xS2kcqy+SVlsSi2QGf+9RqYwX3//0rF+3O0/Aw6xAYMq1TKSkuLtZDl1hZ48y3BUYpYHALvRLoupAVqe3pwLtd/Mid0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bfDeW3B+; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bfDeW3B+"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6eff2be3b33so570447b3a.2
        for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 23:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713421576; x=1714026376; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLD61XepBARAsgwAEEryGhLKo22WgyhNR7D0Io1kaZU=;
        b=bfDeW3B+uhJLnrTX5T/iYYjD0GrLCaq31FTLcnW3SL7iVxFSNbz/8OCzljP++hD6BN
         nJeTpKavQZ3aGCwM6KtVBmXBGAKG71OSG9sNt+ICUIdhl7CqrIbQPrlGOFGl3SFOxHXu
         73ZAP6pbhOIdBC8TVUaSgd30RM6Lk0d71Au1gyUMOioFKpFa5gFf9Bx8SwTu+o2Jf/NW
         PUX3KUL6/SsKIzTddV/JCPCG5vsgASMO88oppBJNspHDBK24+F+orsXMjtT9BWIYK3bq
         aaeAEQZtNFmw3foZ+wFX9FSgePA++OIJaUq3l5iD7Ed/9jVRzwqD2lbfIL1TTxmhQn2G
         mThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713421576; x=1714026376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLD61XepBARAsgwAEEryGhLKo22WgyhNR7D0Io1kaZU=;
        b=HWeKYeyE9jUO9Q1UA8P+bx5ez9ARMVJrTINAww7VmDI7Hxsex294bW96whJNwV3pFr
         yAAvupbAbykSG7eeDrg+iXiUN3TMj2XIlhdKH9HVB8VHa04j+vPddjECjqMfa2JkRQh2
         YDGwE+fjZvWwfU0ZZjfacpokUBkiTkRtMgFsY9hTadZpGl6fRpWw4JW4ynHfiIsW1WwQ
         Oi2aG4S463SWXlYIDyB9fjNZhXFDhSC7CCJJeReIe/m3cAoWwQGi124UZu93WRwIh8av
         1+YRgaVcjRgvU0HchjdlzlR39Qk3GbZZnBwUljyGJ9F+uq1eTHRMO8OqCWhMg5FCEtzT
         ACCA==
X-Forwarded-Encrypted: i=1; AJvYcCVs3NgnsUYiaY0ahWCeNYniGwgfFEDsHkgbnyMjGVf3rtClH77Nv3LF/tjbOYQNunW/oEJ4LXZwpCIXgoJHuqkhDx/T7CxJvis3M5+JRLQ=
X-Gm-Message-State: AOJu0YyTdDiurP9f54EQzfCqpWFCYr4+/YoKuhJjgGyy+5D/u/1C/Cb/
	g13+TbhB3AMUz/UyMNoqDKlo7khJaJuJmWCZNOSMyL1rGitqDwpLCt6WoYcNSyc=
X-Google-Smtp-Source: AGHT+IExq7y1kqyqGXewPq6tqKPgeINzrgW8X9DzhXoz5Wq5smACLbcQzHv5/LkcKr/osJEn2qOGzg==
X-Received: by 2002:a05:6a20:9717:b0:1a9:dcd9:9756 with SMTP id hr23-20020a056a20971700b001a9dcd99756mr2120694pzc.16.1713421576513;
        Wed, 17 Apr 2024 23:26:16 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id s21-20020a632155000000b005cd8044c6fesm666392pgm.23.2024.04.17.23.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 23:26:16 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	virtualization@lists.linux.dev
Cc: mst@redhat.com,
	david@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	akpm@linux-foundation.org,
	zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 2/3] virtio_balloon: introduce memory allocation stall counter
Date: Thu, 18 Apr 2024 14:26:01 +0800
Message-Id: <20240418062602.1291391-3-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418062602.1291391-1-pizhenwei@bytedance.com>
References: <20240418062602.1291391-1-pizhenwei@bytedance.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Memory allocation stall counter represents the performance/latency of
memory allocation, expose this counter to the host side by virtio
balloon device via out-of-bound way.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/virtio/virtio_balloon.c     | 20 +++++++++++++++++++-
 include/uapi/linux/virtio_balloon.h |  6 ++++--
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index fd19934a847f..e88e6573afa5 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -321,7 +321,7 @@ static unsigned int update_balloon_stats(struct virtio_balloon *vb)
 	unsigned long events[NR_VM_EVENT_ITEMS];
 	struct sysinfo i;
 	unsigned int idx = 0;
-	long available;
+	long available, stall = 0;
 	unsigned long caches;
 
 	all_vm_events(events);
@@ -338,6 +338,24 @@ static unsigned int update_balloon_stats(struct virtio_balloon *vb)
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MAJFLT, events[PGMAJFAULT]);
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MINFLT, events[PGFAULT]);
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_OOM_KILL, events[OOM_KILL]);
+
+	/* sum all the stall events */
+#ifdef CONFIG_ZONE_DMA
+	stall += events[ALLOCSTALL_DMA];
+#endif
+#ifdef CONFIG_ZONE_DMA32
+	stall += events[ALLOCSTALL_DMA32];
+#endif
+#ifdef CONFIG_HIGHMEM
+	stall += events[ALLOCSTALL_HIGH];
+#endif
+#ifdef CONFIG_ZONE_DEVICE
+	stall += events[ALLOCSTALL_DEVICE];
+#endif
+	stall += events[ALLOCSTALL_NORMAL];
+	stall += events[ALLOCSTALL_MOVABLE];
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_ALLOC_STALL, stall);
+
 #ifdef CONFIG_HUGETLB_PAGE
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_HTLB_PGALLOC,
 		    events[HTLB_BUDDY_PGALLOC]);
diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index b17bbe033697..487b893a160e 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -72,7 +72,8 @@ struct virtio_balloon_config {
 #define VIRTIO_BALLOON_S_HTLB_PGALLOC  8  /* Hugetlb page allocations */
 #define VIRTIO_BALLOON_S_HTLB_PGFAIL   9  /* Hugetlb page allocation failures */
 #define VIRTIO_BALLOON_S_OOM_KILL      10 /* OOM killer invocations */
-#define VIRTIO_BALLOON_S_NR       11
+#define VIRTIO_BALLOON_S_ALLOC_STALL   11 /* Stall count of memory allocatoin */
+#define VIRTIO_BALLOON_S_NR       12
 
 #define VIRTIO_BALLOON_S_NAMES_WITH_PREFIX(VIRTIO_BALLOON_S_NAMES_prefix) { \
 	VIRTIO_BALLOON_S_NAMES_prefix "swap-in", \
@@ -85,7 +86,8 @@ struct virtio_balloon_config {
 	VIRTIO_BALLOON_S_NAMES_prefix "disk-caches", \
 	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-allocations", \
 	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-failures", \
-	VIRTIO_BALLOON_S_NAMES_prefix "oom-kills" \
+	VIRTIO_BALLOON_S_NAMES_prefix "oom-kills", \
+	VIRTIO_BALLOON_S_NAMES_prefix "alloc-stalls" \
 }
 
 #define VIRTIO_BALLOON_S_NAMES VIRTIO_BALLOON_S_NAMES_WITH_PREFIX("")
-- 
2.34.1

