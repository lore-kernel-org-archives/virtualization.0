Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9B9224CE
	for <virtualization@lists.linux.dev>; Tue, 23 Apr 2024 03:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713843692; cv=none; b=lg1JfR5RbCwcZHRp4VcgRDVIpMdhMp0XD43kOOvaty5Qwl/VdAQxlvLt/cUDLcP1ET941lzcPeKhpIuv6HMfZGrjhYUbFs/016gLYnPsvdA9R7iGx4HqdpeiWtVhxVOPIQUWGqj79TO7SVm+M76u/jxrOajVC/bJvXv9yj5opyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713843692; c=relaxed/simple;
	bh=T2mh8rRfGjxk++iQjwyZbxgJDDwtHaHq4Lo1WcLQsh8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kgnpSk6upBUDAgQTzamB9n033ArX357MJ7rGiDQotRaZsr5hVRKxRo2qfmmO/cQ4nx6jPEPf/sX6ZKUBuiz6u/mfi7SadkMbWbgM2amgOWKVIcp6tUgXKIA1LUxAOhwf1lGC1Ay+jHpF+w6sq+bMQW8cPJZu21dN8w2+xLjvwVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Kz2JywRR; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Kz2JywRR"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ed2170d89fso4016067b3a.1
        for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 20:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713843690; x=1714448490; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0uuoQxJ0kINjaQgEP7wqVGQ+5rr3s87tkW4G+81Ziw=;
        b=Kz2JywRRL3CjSZbHf67536D3iCK1USWv8tCEEXcoNz7iBd4ISi9pMe2LdMHWhmiKV9
         ZuVH7xLZERIiq/sIDP0l42CaWI5Y4I3UDo0/CpqRRYOEBGLKQP6JADtQVNLQaHAt35EB
         iv+4DD2LY30c7lsFmZH3bi9/wAvnG/A6zRl7s4cTNDOArZSnoHRCi182PBf1bnPrMFmw
         wvqq994/Q/9ku96CMs3OLTnJ4u0wxVcSy6BECFSpno1tMijWrPoRrWI21HgXk1N2kjr7
         LUGB1cLPYab5TQLXGA/ltI8nZkW/Jns4uaD+mFLMgq+PkvyvJ/3SFQi/3YHaiSxVjP81
         D4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713843690; x=1714448490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0uuoQxJ0kINjaQgEP7wqVGQ+5rr3s87tkW4G+81Ziw=;
        b=oEeaRJS0WRQpNt08fDBeLI+Uj2nAaWN5Ki5NF+jkiPkihc6pJgPwic4ZcdZMUmtLXc
         W/J66zRudz1SL8jJvkzmE11I/PuLI/6gbr1b5P5izCY8L0ZG3EUn2zPN+ek2j8rqjtIr
         75+mvPZoIslsPuUDYOGpAAiiAZiDf+EfrIGqAc3GU410dVvnH5Cz8sQAP/f/54mj9+tD
         e47PeIRPdbMMbOc35XUPxgHtKvhjYATCBcAY8eX4LMZcD9O7SFWiyGmYiv+jRucWs0pP
         65hOsZyjlT+5WIeCgErLPahOBxru8+Ipq9it8KuYa8bxpFTKOf7tbXtEoNIw0C2d1gWb
         GnOw==
X-Forwarded-Encrypted: i=1; AJvYcCUPDpzaqt5FnNSjUA87TqvyiuTF3CGgSNIvGNEeY4M0V6ep/vxSoq47ND0HWSqpWxLJNKsvntBbP1R2bl9V8DyLiYMUdNKKHjq59DMsYx4=
X-Gm-Message-State: AOJu0YwXLXHvEw49TMYEi8B4GTvejvr/IvSVv3e8gl9w5ByUJSNPhLLq
	DaY36yyoObnXccbOlKlOv1AkpfXlvAq6zuRbM/Tnnmzq5HEb4t6PojvMxaRRo8c=
X-Google-Smtp-Source: AGHT+IH3OpN2sFYi3GvJfqyxhabzuW3WUwrv+oQUG4aXzn7ZEeGp3bOQixCyYcifZfO95/rYrfTxJA==
X-Received: by 2002:a05:6a20:841b:b0:1a9:54fe:b9b7 with SMTP id c27-20020a056a20841b00b001a954feb9b7mr2176395pzd.21.1713843690300;
        Mon, 22 Apr 2024 20:41:30 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id b16-20020a63d810000000b005e438fe702dsm8266980pgh.65.2024.04.22.20.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 20:41:30 -0700 (PDT)
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
Subject: [PATCH v3 4/4] virtio_balloon: introduce memory scan/reclaim info
Date: Tue, 23 Apr 2024 11:41:09 +0800
Message-Id: <20240423034109.1552866-5-pizhenwei@bytedance.com>
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

Expose memory scan/reclaim information to the host side via virtio
balloon device.

Now we have a metric to analyze the memory performance:

y: counter increases
n: counter does not changes
h: the rate of counter change is high
l: the rate of counter change is low

OOM: VIRTIO_BALLOON_S_OOM_KILL
STALL: VIRTIO_BALLOON_S_ALLOC_STALL
ASCAN: VIRTIO_BALLOON_S_SCAN_ASYNC
DSCAN: VIRTIO_BALLOON_S_SCAN_DIRECT
ARCLM: VIRTIO_BALLOON_S_RECLAIM_ASYNC
DRCLM: VIRTIO_BALLOON_S_RECLAIM_DIRECT

- OOM[y], STALL[*], ASCAN[*], DSCAN[*], ARCLM[*], DRCLM[*]:
  the guest runs under really critial memory pressure

- OOM[n], STALL[h], ASCAN[*], DSCAN[l], ARCLM[*], DRCLM[l]:
  the memory allocation stalls due to cgroup, not the global memory
  pressure.

- OOM[n], STALL[h], ASCAN[*], DSCAN[h], ARCLM[*], DRCLM[h]:
  the memory allocation stalls due to global memory pressure. The
  performance gets hurt a lot. A high ratio between DRCLM/DSCAN shows
  quite effective memory reclaiming.

- OOM[n], STALL[h], ASCAN[*], DSCAN[h], ARCLM[*], DRCLM[l]:
  the memory allocation stalls due to global memory pressure.
  the ratio between DRCLM/DSCAN gets low, the guest OS is thrashing
  heavily, the serious case leads poor performance and difficult
  trouble shooting. Ex, sshd may block on memory allocation when
  accepting new connections, a user can't login a VM by ssh command.

- OOM[n], STALL[n], ASCAN[h], DSCAN[n], ARCLM[l], DRCLM[n]:
  the low ratio between ARCLM/ASCAN shows that the guest tries to
  reclaim more memory, but it can't. Once more memory is required in
  future, it will struggle to reclaim memory.

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/virtio/virtio_balloon.c     |  9 +++++++++
 include/uapi/linux/virtio_balloon.h | 12 ++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index e6229e548832..225662358221 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -340,6 +340,15 @@ static inline unsigned int update_balloon_vm_stats(struct virtio_balloon *vb)
 
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_ALLOC_STALL, stall);
 
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_ASYNC_SCAN,
+		    pages_to_bytes(events[PGSCAN_KSWAPD]));
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_DIRECT_SCAN,
+		    pages_to_bytes(events[PGSCAN_DIRECT]));
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_ASYNC_RECLAIM,
+		    pages_to_bytes(events[PGSTEAL_KSWAPD]));
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_DIRECT_RECLAIM,
+		    pages_to_bytes(events[PGSTEAL_DIRECT]));
+
 #ifdef CONFIG_HUGETLB_PAGE
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_HTLB_PGALLOC,
 		    events[HTLB_BUDDY_PGALLOC]);
diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index 487b893a160e..ee35a372805d 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -73,7 +73,11 @@ struct virtio_balloon_config {
 #define VIRTIO_BALLOON_S_HTLB_PGFAIL   9  /* Hugetlb page allocation failures */
 #define VIRTIO_BALLOON_S_OOM_KILL      10 /* OOM killer invocations */
 #define VIRTIO_BALLOON_S_ALLOC_STALL   11 /* Stall count of memory allocatoin */
-#define VIRTIO_BALLOON_S_NR       12
+#define VIRTIO_BALLOON_S_ASYNC_SCAN    12 /* Amount of memory scanned asynchronously */
+#define VIRTIO_BALLOON_S_DIRECT_SCAN   13 /* Amount of memory scanned directly */
+#define VIRTIO_BALLOON_S_ASYNC_RECLAIM 14 /* Amount of memory reclaimed asynchronously */
+#define VIRTIO_BALLOON_S_DIRECT_RECLAIM 15 /* Amount of memory reclaimed directly */
+#define VIRTIO_BALLOON_S_NR       16
 
 #define VIRTIO_BALLOON_S_NAMES_WITH_PREFIX(VIRTIO_BALLOON_S_NAMES_prefix) { \
 	VIRTIO_BALLOON_S_NAMES_prefix "swap-in", \
@@ -87,7 +91,11 @@ struct virtio_balloon_config {
 	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-allocations", \
 	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-failures", \
 	VIRTIO_BALLOON_S_NAMES_prefix "oom-kills", \
-	VIRTIO_BALLOON_S_NAMES_prefix "alloc-stalls" \
+	VIRTIO_BALLOON_S_NAMES_prefix "alloc-stalls", \
+	VIRTIO_BALLOON_S_NAMES_prefix "async-scans", \
+	VIRTIO_BALLOON_S_NAMES_prefix "direct-scans", \
+	VIRTIO_BALLOON_S_NAMES_prefix "async-reclaims", \
+	VIRTIO_BALLOON_S_NAMES_prefix "direct-reclaims" \
 }
 
 #define VIRTIO_BALLOON_S_NAMES VIRTIO_BALLOON_S_NAMES_WITH_PREFIX("")
-- 
2.34.1

