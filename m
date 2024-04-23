Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625541D69E
	for <virtualization@lists.linux.dev>; Tue, 23 Apr 2024 03:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713843685; cv=none; b=JRTsHRVtU5qp9KpxojC1Y/3RPfCY8+YRHMJT/fEHNULX7iZRW8LH46m/GOAA4YU/AIhJls9CfpSxzJP+dFZ7rI5C4gXLrLDwYMXn3f2uvudqUe3Xpdf74xqRA1OZBk4r5o97j5vCMWtavMGyE5MmZVUlzUVqbB1h0UA4Ezeg7v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713843685; c=relaxed/simple;
	bh=og/1Bh1HmmM5su2/my/Vew9YvJYFlLIPs0D6nqUUBV4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RQ0WPqO2dfACu/KxNBps0PHojBr+ZjT2YbcMaIhi/jgfnpE9lMGIk2u9QUIpV4IRsIlFwXfrBiubC4Qb5GJP1ste2kICA+uM5hGZ1nBJ+wbZOXkbNdm6xNKEXc+KH+6H9woqjzZYKDJTP0SmgUCnteG+4gsKwfCnxu+wc38x/MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bTD2w/ll; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bTD2w/ll"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-36c16ed12bdso3421755ab.2
        for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 20:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713843683; x=1714448483; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zk8sHHlFZ5yMas0e7wt0QxJKNRueI84ut/8EKgUk1gU=;
        b=bTD2w/llz+XHR6yltWYVXiqAnV6WIhjQnEoxLDOdV9dTwN55IRsR6fiM1SAmW3xYIp
         AzFhPVl0yHqCs9FijwKIgrtJZp4dQg9qtk7MtPoXGXOtPPjcm5UzFYMyKZxDyyXY0WU5
         xXrGdxJRaZ07kS4eSAYeBOH6+IICWVAFQIrI6D7hQunWIrJUfzZ5x5OG2n27c5x63eFP
         BYNUzDiln2/ScDmKnvPWUnhF+LwSdYIvBVzP2saPZpu4QBitP65pQk2gWsK1dScbaWJv
         Y3tMU57A4oSYszSXiG6wOQ0cdTH6ezTaC0GwQJDqR1L3QKdNmORxpXnjq08VWAX4ynU3
         7jpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713843683; x=1714448483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zk8sHHlFZ5yMas0e7wt0QxJKNRueI84ut/8EKgUk1gU=;
        b=jq7CLQIfCROQ1JeCj9oPbwFYLsyiNoebs9tPXqzfYKkhk2/fHXfZmljy1MP3vUdEXE
         sGpzSPlZDZ8WtwEWVrBEuHXQ9y1T6haVVB6PJ58i8N03Q7wT3R0/FfB6jPQ4LGshkzzC
         OUE6vHzMfMGqkXEu9W1a2MWEDxNXhzEmeaCRwQ9GSHXbl2z753V1majmGbQMLVaQbC23
         6z1OmZMIaAOjLCGiLY9tuawmY7HTHzfjqfc0/AwGCOOHB+2Yoj+NXLyRDKmHPByUcKui
         bj+EHZAazw0lAmWzUUIGINBkQwp3hJnDTfRg2H9t1w5zEI+/r6qaH5xlOtTKYBvy+ZSy
         u5yg==
X-Forwarded-Encrypted: i=1; AJvYcCV7T9cQBBn0csWnKta/05ab7Ve5GQ6Ddj55UK2BFQSpLbemIyXCJcxh1aX7p6AORkqGDRfRacPlXeK6wGcyDm1y7lxXtOOQR5vWDNcUsxw=
X-Gm-Message-State: AOJu0Yx4UEekVporzcX8sbQB3KjBZf5O58GeG2XdpvL0Mdhrg3TBj+cL
	1Ei51SqYSxisRR+vQB0a9FP+EwsTyYgHnKeFzZcZT/hlbRRocsczQnEFfVg232uwuj+syykH9Vs
	t
X-Google-Smtp-Source: AGHT+IGK5wXI7LkTDRk5nDef0rXFGK962Vq/MSDSyQakfWBHz0PVFwhhTJdfJ5JmoY+i8cpaYiedhg==
X-Received: by 2002:a92:c267:0:b0:36a:fe86:5fcc with SMTP id h7-20020a92c267000000b0036afe865fccmr16168240ild.0.1713843683557;
        Mon, 22 Apr 2024 20:41:23 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id b16-20020a63d810000000b005e438fe702dsm8266980pgh.65.2024.04.22.20.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 20:41:23 -0700 (PDT)
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
Subject: [PATCH v3 2/4] virtio_balloon: introduce oom-kill invocations
Date: Tue, 23 Apr 2024 11:41:07 +0800
Message-Id: <20240423034109.1552866-3-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423034109.1552866-1-pizhenwei@bytedance.com>
References: <20240423034109.1552866-1-pizhenwei@bytedance.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the guest OS runs under critical memory pressure, the guest
starts to kill processes. A guest monitor agent may scan 'oom_kill'
from /proc/vmstat, and reports the OOM KILL event. However, the agent
may be killed and we will loss this critical event(and the later
events).

For now we can also grep for magic words in guest kernel log from host
side. Rather than this unstable way, virtio balloon reports OOM-KILL
invocations instead.

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/virtio/virtio_balloon.c     | 1 +
 include/uapi/linux/virtio_balloon.h | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 1710e3098ecd..f7a47eaa0936 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -330,6 +330,7 @@ static inline unsigned int update_balloon_vm_stats(struct virtio_balloon *vb)
 		    pages_to_bytes(events[PSWPOUT]));
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MAJFLT, events[PGMAJFAULT]);
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MINFLT, events[PGFAULT]);
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_OOM_KILL, events[OOM_KILL]);
 
 #ifdef CONFIG_HUGETLB_PAGE
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_HTLB_PGALLOC,
diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index ddaa45e723c4..b17bbe033697 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -71,7 +71,8 @@ struct virtio_balloon_config {
 #define VIRTIO_BALLOON_S_CACHES   7   /* Disk caches */
 #define VIRTIO_BALLOON_S_HTLB_PGALLOC  8  /* Hugetlb page allocations */
 #define VIRTIO_BALLOON_S_HTLB_PGFAIL   9  /* Hugetlb page allocation failures */
-#define VIRTIO_BALLOON_S_NR       10
+#define VIRTIO_BALLOON_S_OOM_KILL      10 /* OOM killer invocations */
+#define VIRTIO_BALLOON_S_NR       11
 
 #define VIRTIO_BALLOON_S_NAMES_WITH_PREFIX(VIRTIO_BALLOON_S_NAMES_prefix) { \
 	VIRTIO_BALLOON_S_NAMES_prefix "swap-in", \
@@ -83,7 +84,8 @@ struct virtio_balloon_config {
 	VIRTIO_BALLOON_S_NAMES_prefix "available-memory", \
 	VIRTIO_BALLOON_S_NAMES_prefix "disk-caches", \
 	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-allocations", \
-	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-failures" \
+	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-failures", \
+	VIRTIO_BALLOON_S_NAMES_prefix "oom-kills" \
 }
 
 #define VIRTIO_BALLOON_S_NAMES VIRTIO_BALLOON_S_NAMES_WITH_PREFIX("")
-- 
2.34.1

