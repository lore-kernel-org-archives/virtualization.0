Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5813B51C46
	for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 07:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713771797; cv=none; b=FJmAM3UsJbbGv27jvfdQ4eDRNCBFakAX4o/qAkFlPm2o7PsKC8Bf2WyoYJMTgFLGk9e7veWjbYB5yKbxqtUCWNQLm/F0gvsIICuy1jV4+7vg4EYlhNN+mgT/gt7Li9uqCvrCV+YhrWejqO/Z2zfLmjpXKHCBNNdRdn/Md+QnXb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713771797; c=relaxed/simple;
	bh=B7vOTsSVYsGFUvhOXvJRAjHPNDIwccqInso5hXY7xSM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tVkTzVHBumubVuybBGh1y61aF1DLQvrQWBFiPG+mP02YTh5tg4IB4sJC/WgKnPPFHKWxZUCVB03W4iKqvgQzIdE8K3Tdkp4pdReCANrzDyFE7vKlf6IzmaGy6CJ89pzVFoP1tNH6IRQH8ABqVhUJSHW0mcgXV2pxdAxZQC5I7bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Ss9/LyKv; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Ss9/LyKv"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e2b1cd446fso33394525ad.3
        for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 00:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713771795; x=1714376595; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBFXolLQYa78XCdQIXx8hSsPDNH1h31ohatbB+q7SSA=;
        b=Ss9/LyKv6WVXzm821DSPNmL1gQEEmG0W2fIMHEB+ZmpE0tHhzGiFKxdFij3Nja4jU4
         SrCZPYCHr7xDFJMX1cJnCVebl3BRiFH1hL7ls6IZoF31RaTPqoIiY8vAbRlfM+VIlRPO
         6d8S3dYNL+uJk0WYKq4vcd0wkcynbZd4pf+7HnqX1mpWuNbCN/20qQspCReyIoUuLi4B
         Hw/Na9/dyb9JoxKjzvGeYvL7rZ0+cSw4fiWmNOtOc8CVB/lENqqL5nSNPSXMA0R3qjV1
         i2GDW6XSQJHAZggBIxxhz3S0IwUrstc/5zavUBfw8D+lO/2VZ9E9NMd/0d9HCdcea3Er
         4HBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713771795; x=1714376595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bBFXolLQYa78XCdQIXx8hSsPDNH1h31ohatbB+q7SSA=;
        b=KXkN8k2hbIn2X/6hHesJ5HvBy9XI7vnqc5++kdjdj32IuWJ1yFqFiY0/3Owgp9Imsm
         faIgoNtT8XuyZQQffyu1/llHMGWsmikEfJ8e0XnX/uV9yNKT7n219k6H0yLeVcN3JvMk
         6yHxzCmQC1QEwOT7F5sNg+71P+nV18DbuPcDKNrTgvpDQsgh6ZZf3wnvPEDqeQw7HgLi
         UwcBnz5j0WHrVBjY7bhIuOcTnFx/zo+IMYLs20TuShiqP7E42Awerw8uMGuVhO9awkGh
         bDvjdoCt9ZmBaoVQQce6bM6soV47Nhyogwm+TOwGK0iRe0ddKkxYavvZiOO5BMS5+TmP
         4O3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWn98MbzGaltNGcJ/l1JU/JfZyhobM3Fz4Pq7FAG4sf0yRNpQ3D8viMmGk77EjleJ8fReHBt8i6JlEznA+IHehBiTTCCYEddbv/meH10QE=
X-Gm-Message-State: AOJu0Yw0iTP7FwfAgr2WPDkisYfCQD8s8IgnsQ2rYUKIxYo0tS6A02Nq
	ZPIB0Hg+dRMCkIyq9yrDlw3EV5ML3fw3q7D/ZYm8BGA0XbW5bguG1NAlbnFrZr0=
X-Google-Smtp-Source: AGHT+IEvHT3XYAnqbJeBRBtYXwHjzJuRWUr3q0IHkM4UWpx7JR4+gVdQqRx7dbo9nSIw0pAVB8jXbw==
X-Received: by 2002:a17:902:784f:b0:1e4:d548:818f with SMTP id e15-20020a170902784f00b001e4d548818fmr9126943pln.58.1713771795591;
        Mon, 22 Apr 2024 00:43:15 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902784b00b001e0bae4490fsm7595634pln.154.2024.04.22.00.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 00:43:15 -0700 (PDT)
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
Subject: [PATCH v2 4/4] virtio_balloon: introduce memory scan/reclaim info
Date: Mon, 22 Apr 2024 15:42:54 +0800
Message-Id: <20240422074254.1440457-5-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240422074254.1440457-1-pizhenwei@bytedance.com>
References: <20240422074254.1440457-1-pizhenwei@bytedance.com>
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
index ab039e83bc6f..e45146fde164 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -341,6 +341,15 @@ static inline unsigned int update_balloon_vm_stats(struct virtio_balloon *vb,
 
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

