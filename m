Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9073538389
	for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 08:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170500; cv=none; b=YYnBt7DF/YuTYpsyDsSZFrjiD2PlwHkDAQ4346NR76oWXuzJQkfEcz9ZS5IgPV6+NYlPIO0SdvwWs4P/dkr9D/iV2FgAV9v3od3JNBlAt24iS6SmKJ3Dhlu0tcDX1n3Ec1GCEN642rD3YwcyIBD9TKWydYXX3v3sjL/1CaJP0Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170500; c=relaxed/simple;
	bh=NFrR2exu6d6NexTbth3nKYMeBa96W+PF0xe/+85rGTE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r4C/HOkGXgGaSBA/YF2h6HXF6m7U4PbUmDmoGo1OYywsB398SAxB8nKIOTjOwNDCGqABmeZ2DpmvgsLsiDr1r/uZ0AhTTlP7ZsiMvvGU58NmJpDGH+Ow9FHqQMYxtH8Xa/JFpzfyrs+qtPiQ6CfxksO6Vto8oJUH1lyh9JQDU64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DFLHiHop; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DFLHiHop"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6eb658ca1ceso1905642a34.2
        for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 01:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713170497; x=1713775297; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVSyUCsRBJHReEwHJLY9AUjYGa31t9M8IXFXE6DP2gA=;
        b=DFLHiHopZ4HibdCNyoGSoTa4BeWZCso+2FImpkfvuI8m4QWaTpsY/zJgctLsjaBxEi
         ywFL8XBEM3YmDB9MYsVPngl/4OXcWFEzmlk86zfQIcANtMHGuWKzNee/5/5GSLN7wP19
         C50nlzSFZfsAFksIx2wdM8lyix8S3KEyuNCmv1h9bST/1CpPO+2RVOoVd8xVNK+a7cYE
         J6Ux/2InOXFK9ofVZHyw+HDXVOnLPqX+nHWq2CG12imPXLWj2vQUInMPI26CCngnYMBQ
         E8YbcVmRi35GnxA6PeiOw+mZccIZsUtJg3vFbxoaelFw1EZHnfCo2wPmMbnVFUeFk5iJ
         auYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713170497; x=1713775297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jVSyUCsRBJHReEwHJLY9AUjYGa31t9M8IXFXE6DP2gA=;
        b=SG5tCvPm0Pr/hIhkbwHvd/q3pbyKjK7YWRen68PF2SggDpptlGjDJQKkgKadO3Yiwe
         psUw8tNrN9TB0W4u+wG56MAGbfG/d0KqVTdPMZUcq31uHlrmB/R/J/HW7z9pQrxpleg6
         ipOQD17JI4y/Yqjmot5VmJ7r1hT8pIDti0rsCIUV1/cL78kHIyq4mRptIGO+YUOTyu4K
         gTq6kx2y+yvdNp7GEVTBhl5nG5oOzv0zD6r2lA34s+S4mztLJECboVkKUtfDxJM7iseV
         5JnHM3P9atgv3vCresMRR+MlA3LxOCPLrSbzPpGJ4p7D4xwpZu7E6uijvS3wwE1Y/mux
         onKw==
X-Forwarded-Encrypted: i=1; AJvYcCWmf/bmpE2+dEYoBbqfH/7ZJ1nyZHksZizkElVPVlHTlK69onCaUubbpQ1qbGZ8pPgNXhEJPQ8NqRR5Llt+FJ8+i0DuiXrac4aRKp5O13c=
X-Gm-Message-State: AOJu0Yz/TihpuOJklziWPeWv61yUwnDPfaqwB/WGaZof2/CddSja5Ykk
	+0bjnlpHDVJg7XTrdQdKEtCJcHVJ7TUbFsmvxz27atNznHYUwjJ3JCZPf588suQ=
X-Google-Smtp-Source: AGHT+IFLEEPCt9VyzH/L1QCrMmvcBH5qldAmYAh+iqUObe92I/ilLOhZ5GsT6F60/+szU0KPLSFuSA==
X-Received: by 2002:a05:6870:9113:b0:22f:7513:f20a with SMTP id o19-20020a056870911300b0022f7513f20amr11633580oae.55.1713170497684;
        Mon, 15 Apr 2024 01:41:37 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id k187-20020a636fc4000000b005d6a0b2efb3sm6575685pgc.21.2024.04.15.01.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 01:41:37 -0700 (PDT)
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
Subject: [RFC 3/3] virtio_balloon: introduce memory scan/reclaim info
Date: Mon, 15 Apr 2024 16:41:13 +0800
Message-Id: <20240415084113.1203428-4-pizhenwei@bytedance.com>
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

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/virtio/virtio_balloon.c     |  9 +++++++++
 include/uapi/linux/virtio_balloon.h | 12 ++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 4b9c9569f6e5..7b86514e99d4 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -372,6 +372,15 @@ static unsigned int update_balloon_stats(struct virtio_balloon *vb)
 	stall += events[ALLOCSTALL_MOVABLE];
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_ALLOC_STALL, stall);
 
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_SCAN_ASYNC,
+				pages_to_bytes(events[PGSCAN_KSWAPD]));
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_SCAN_DIRECT,
+				pages_to_bytes(events[PGSCAN_DIRECT]));
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_RECLAIM_ASYNC,
+				pages_to_bytes(events[PGSTEAL_KSWAPD]));
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_RECLAIM_DIRECT,
+				pages_to_bytes(events[PGSTEAL_DIRECT]));
+
 	return idx;
 }
 
diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index 13d0c32ba27c..0875a9cccb01 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -73,7 +73,11 @@ struct virtio_balloon_config {
 #define VIRTIO_BALLOON_S_HTLB_PGFAIL   9  /* Hugetlb page allocation failures */
 #define VIRTIO_BALLOON_S_OOM_KILL      10 /* OOM killer invocations */
 #define VIRTIO_BALLOON_S_ALLOC_STALL   11 /* Stall count of memory allocatoin */
-#define VIRTIO_BALLOON_S_NR       12
+#define VIRTIO_BALLOON_S_SCAN_ASYNC    12 /* Amount of memory scanned asynchronously */
+#define VIRTIO_BALLOON_S_SCAN_DIRECT   13 /* Amount of memory scanned directly */
+#define VIRTIO_BALLOON_S_RECLAIM_ASYNC 14 /* Amount of memory reclaimed asynchronously */
+#define VIRTIO_BALLOON_S_RECLAIM_DIRECT 15 /* Amount of memory reclaimed directly */
+#define VIRTIO_BALLOON_S_NR       16
 
 #define VIRTIO_BALLOON_S_NAMES_WITH_PREFIX(VIRTIO_BALLOON_S_NAMES_prefix) { \
 	VIRTIO_BALLOON_S_NAMES_prefix "swap-in", \
@@ -87,7 +91,11 @@ struct virtio_balloon_config {
 	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-allocations", \
 	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-failures", \
 	VIRTIO_BALLOON_S_NAMES_prefix "oom-kill", \
-	VIRTIO_BALLOON_S_NAMES_prefix "alloc-stall" \
+	VIRTIO_BALLOON_S_NAMES_prefix "alloc-stall", \
+	VIRTIO_BALLOON_S_NAMES_prefix "scan-async", \
+	VIRTIO_BALLOON_S_NAMES_prefix "scan-direct", \
+	VIRTIO_BALLOON_S_NAMES_prefix "reclaim-async", \
+	VIRTIO_BALLOON_S_NAMES_prefix "reclaim-direct" \
 }
 
 #define VIRTIO_BALLOON_S_NAMES VIRTIO_BALLOON_S_NAMES_WITH_PREFIX("")
-- 
2.34.1

