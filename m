Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70E95029A
	for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 07:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713771794; cv=none; b=Dq/FOM1hY6zV7qK/Oadxd52G27uwqDXC0MyMk4vyk/7kwNCFO6RfgF3mGrCEoKTejHJNZ4aX/8i0MZnneCh6jHvHDiITmlHjSHG7IEo0MviXo5F56HC4Q9j2Bq0vsVY6JUsQ4+sxDpys33uhhVvP/24cEqlaR/cNgSRIxWrx0FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713771794; c=relaxed/simple;
	bh=Tifl00pi8az9qD8WZxeEmmg/browFVnK/hcBZYXoc2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uMPuZmtHFfULP5xXzQJCG/A0A6bPdqtPCRty6oIH6wyFr3nSf3BCm/9cvjX+pkOpPgDXEjVMf1tHbSm8xqMQN0IKGto0Q5FFQilYT5IDmjagvpf9i4xv+ldcM+8wjZPcIxUzkbMT7Iz7yKtaULXHg82uaesQcxEwIIXkqfIlOmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZZej+e6M; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZZej+e6M"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e3c3aa8938so27537985ad.1
        for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 00:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713771792; x=1714376592; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrl4akKhVgEJxLJYwq5+gLRsb/mo5Xi0vTQ5EYuojH0=;
        b=ZZej+e6MARTgDXsYIGvOpM6+cEP2yzmPAlw2QztZRgQA/mvUet7gEEx82P3FgtNwYQ
         rCmfUiQj+o9+wKyM5uPFDAYdQ+gLyO3fze92OIl9gv9m69r2KVIRbohwS8STXBLxPn+y
         WlVGaoAgNHyM/kIBGj9HzC0yhEDC+FCV/SMV2N/MwhH5Kd00FrimgmiBzpEIzYua9Igd
         L8YiwPko2heUkzshL2yANrIyiVLHAi1+O03Gf+DRhFicm/XXB+96jz1mZHCbwuTHMIYZ
         H8xL9Zf94JEXdPeM3t+ZtFi4hfvsoTzQY+M3q3STdRxxUgxOtGDwhsv4TIr7aD1jnWa6
         MzTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713771792; x=1714376592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zrl4akKhVgEJxLJYwq5+gLRsb/mo5Xi0vTQ5EYuojH0=;
        b=P/oYEhFIgT/dQ0sH0jxP/H2bUgLBDmNdOv1DYaB5shr/ymi5sZgr0PfUS0qTjR27uE
         QuABWZ6RnteOo6JeGbP9leR1nF8U4nWJWQSvQ0V32yFgeIx2Y+wBvg9WCDIizNmh1rHK
         xlox4nvjgN/Tv7NfKxjGTrnsLGlmPacrPzaOodhwY+i8dtUeRuDuRrG0jDzhnW4cDy9n
         40spHDZ7ktm0uFkrI6FIYNOpTiQsMTzZg2Ot1GqajeLihmRK8XVSh2xrj9VUnFSUVvXI
         7gv4zubvoO23GhOAj4sBaguFPhVmyM9C5PrSt39kmidDAbWPgqsU649G56ySw/Na5y9s
         CVMA==
X-Forwarded-Encrypted: i=1; AJvYcCXL0Po3yWZk/qPUfAP6x4fMgKYr1ADv1ZFqOnW6J6/nbOO4+duw10WeXCVJoy5WGiKqrf1p+jAlbLDEOL+hp+tda+FNFuFfV64ahPrCIDg=
X-Gm-Message-State: AOJu0YxEaXF8dgkdmCR4Oz5kSHNG+I4KEa8AUOUEAasEFXArndTpjZRF
	AjIW7c58JX7vRwdqWmKX1UE8YZhVjHOAPwW82qekRrG2J51EtsifMKrVJWURs10=
X-Google-Smtp-Source: AGHT+IEc9oEJpvxbLzrOG8tkIAbOFSv29i67Gv0xrVCixugzuwunQk9IqJOdyb3sAb6X7Uc5rZD22A==
X-Received: by 2002:a17:902:db07:b0:1e4:bd90:f1d4 with SMTP id m7-20020a170902db0700b001e4bd90f1d4mr11064583plx.40.1713771792141;
        Mon, 22 Apr 2024 00:43:12 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902784b00b001e0bae4490fsm7595634pln.154.2024.04.22.00.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 00:43:11 -0700 (PDT)
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
Subject: [PATCH v2 3/4] virtio_balloon: introduce memory allocation stall counter
Date: Mon, 22 Apr 2024 15:42:53 +0800
Message-Id: <20240422074254.1440457-4-pizhenwei@bytedance.com>
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

Memory allocation stall counter represents the performance/latency of
memory allocation, expose this counter to the host side by virtio
balloon device via out-of-bound way.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/virtio/virtio_balloon.c     | 8 ++++++++
 include/uapi/linux/virtio_balloon.h | 6 ++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 87a1d6fa77fb..ab039e83bc6f 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -323,6 +323,8 @@ static inline unsigned int update_balloon_vm_stats(struct virtio_balloon *vb,
 #ifdef CONFIG_VM_EVENT_COUNTERS
 	unsigned long events[NR_VM_EVENT_ITEMS];
 	unsigned int idx = start;
+	unsigned int zid;
+	unsigned long stall = 0;
 
 	all_vm_events(events);
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_SWAP_IN,
@@ -333,6 +335,12 @@ static inline unsigned int update_balloon_vm_stats(struct virtio_balloon *vb,
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MINFLT, events[PGFAULT]);
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_OOM_KILL, events[OOM_KILL]);
 
+	/* sum all the stall events */
+	for (zid = 0; zid < MAX_NR_ZONES; zid++)
+		stall += events[ALLOCSTALL_NORMAL - ZONE_NORMAL + zid];
+
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

