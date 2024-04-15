Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E523BBE1
	for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 08:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170497; cv=none; b=EKD/zlc4GVYY7CPAw43l2jvnyqEgjtOWwihaFnw3lZLU5V0hjxf6TPAalBXnxIYLGH/7UNtv22W0d4bh3+z51dueSufgMB5MzVo3q6LtGI2Mr/X1LMH5zXv9rxbrndqf2RuLfj3c6zGGhAHc/Zf1G+ylS8niYLn35wLvEKuitac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170497; c=relaxed/simple;
	bh=vZqUoc3gYd+I/LHSXlUpLfccZsnhlmnxJYwDUfMYSzk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NlZhZ6hcwXwQufmOYnTCbh5wMyzlar/Hl3rpHIBP+1m+D2ox5mV9+jTxbR4UKbfluvuOcczNNa60VlmYP6yqIC3QtlEkFeJ1X/UMR/qB7WNOPsOZ3Ygpuz1f08nzHexPLVJW0NsX4ymaUyuC7Z9OR08M4NlZHojB/TS5ozHLJwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=R46R/xO+; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="R46R/xO+"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a49261093cso1645963eaf.3
        for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 01:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713170494; x=1713775294; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gn/fmyyLOBGP9D7Ah7/te94Cqx4P0YQuEb1tR3Gfsk4=;
        b=R46R/xO+9+KgKPekoht6jklCtTwVMhZbeE6mKi4hPxPK2+TslQiMGLYAQDBhrW4IoJ
         TPzJxUBfsAsWpHeTukBt7yvXMk5f75ye0JUL/RwdZmPk1lfJ9fKqVoSDtOxZL+rnGGxQ
         GvGvlwleMS81APakLWzXnNeyULfm28+eXQxk0BWAqfaarcpsC5LJU92lNxNWE/cdl2XW
         8kXYoQjZuybKmh6zVLHI5uHxtkyAk5LQ1jHYzb1ZILwRVJSHl6ZsMqI4kT1n3OPXYDjY
         C9C3joUxOHhijEEBWyNGpdKln7zMG7qceI1mWhzq1EkD3+ZentL7t/Ih9McZ/WLGL0m/
         mmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713170494; x=1713775294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gn/fmyyLOBGP9D7Ah7/te94Cqx4P0YQuEb1tR3Gfsk4=;
        b=KBMvB7dAo5pllyE5859+1ooeQNBmRwiD9EKh0R6jdJx5BmUBzcuxTDN6zI3/IFRNts
         ryQvnTw7rKGEK9qIB9z7MkTeskieERdru2uawwQEIVchmpCQQIY6inb0ZJrNi7iThcSw
         VCkRDan1iqvXgW5h5P89de7tfPKZCixm0zNUo04uzQXQZMg2Mwf9RU7WedkNd9yUc+yC
         M/6C5gzLYvgCUNVHhjRGndyl92qyYwi8L9ibY5cx2wAUTvpSRpAOrYsydDOX27LOexOh
         fQNQC0PfyoBm/dHeYMND2Sb82ZJEVGcREAe63E9gekNgH1T8WIvjPtIE10Jj5JvX3ShV
         O8AA==
X-Forwarded-Encrypted: i=1; AJvYcCUXac65HjDfzlueGY0dIxGpJnGV8sQBCHe4s3OGBHg2tO9x8n1qMBvbZ2j3kOWD4WbXrusz8BytF88hMzf9D7ru8walYzZlz9wffbOGj6E=
X-Gm-Message-State: AOJu0Yx30rGOB5FkOp6Fo0KksIHjCFjek6kw0md3Hh+wNgf4q9sToA2F
	6oW2HSZyx5IfsUzHmmYYkeK8tKduFzpZarUWTpp893QiNnOmDJ8Lwkiw3LDtV8w=
X-Google-Smtp-Source: AGHT+IETdp6r2QsgZsbcC8cYUyAoKu02zRWiFTX/N1oYt3Eg7GPbdngrRxjNkXqYCiCkcAyLjTOyFg==
X-Received: by 2002:a05:6358:1396:b0:183:6427:10b6 with SMTP id n22-20020a056358139600b00183642710b6mr10637354rwi.19.1713170494297;
        Mon, 15 Apr 2024 01:41:34 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id k187-20020a636fc4000000b005d6a0b2efb3sm6575685pgc.21.2024.04.15.01.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 01:41:33 -0700 (PDT)
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
Subject: [RFC 2/3] virtio_balloon: introduce memory allocation stall counter
Date: Mon, 15 Apr 2024 16:41:12 +0800
Message-Id: <20240415084113.1203428-3-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415084113.1203428-1-pizhenwei@bytedance.com>
References: <20240415084113.1203428-1-pizhenwei@bytedance.com>
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
 drivers/virtio/virtio_balloon.c     | 19 ++++++++++++++++++-
 include/uapi/linux/virtio_balloon.h |  6 ++++--
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index fd8daa742734..4b9c9569f6e5 100644
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
@@ -355,6 +355,23 @@ static unsigned int update_balloon_stats(struct virtio_balloon *vb)
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_OOM_KILL,
 				events[OOM_KILL]);
 
+	/* sum all the stall event */
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
 	return idx;
 }
 
diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index cde5547e64a7..13d0c32ba27c 100644
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
-	VIRTIO_BALLOON_S_NAMES_prefix "oom-kill" \
+	VIRTIO_BALLOON_S_NAMES_prefix "oom-kill", \
+	VIRTIO_BALLOON_S_NAMES_prefix "alloc-stall" \
 }
 
 #define VIRTIO_BALLOON_S_NAMES VIRTIO_BALLOON_S_NAMES_WITH_PREFIX("")
-- 
2.34.1

