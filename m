Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B532E20B04
	for <virtualization@lists.linux.dev>; Tue, 23 Apr 2024 03:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713843689; cv=none; b=sfkZT1EQbjTuKCGC8185mdtHL3ZFsy8UL0qfdrDys0/NFdyKN9Y4OZKULleHe5m4XuHXm305DGxV/8fdxLqO/bny6R9WahkmQO3NL9lZxltF8Wd3dgpX4fSM3IGmybZg6AC+WB9AXzSTuh544peNPc+pttpnAswukSG/jwhdnxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713843689; c=relaxed/simple;
	bh=+kh9BcjI07go1nGvUEVdhO4Ly9aJPFfeZnFM+8cusGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C7QM5w9nVqjmjAswLrlfJVCs+WhdUc0H9ZF2fhF47PVcORb1JiAbnQdXdmX8v8Eq/QzKVbZ8eeasnZKjF+6rhXnskoDKv0vNrf2VCCeCK/uhfkSjamz9pVJJgEtJGR3XQTwCLdgR7RZNqkNDlqLA/oNFsW7xOoe9NrZVASDpEsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fJtu8fD6; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fJtu8fD6"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5af2358c7e5so787792eaf.0
        for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 20:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713843687; x=1714448487; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5+no2YCmidvNin275LSwR8pI0Tp0FoxLTpLeIvaXuY=;
        b=fJtu8fD6fTNDDN9bHtTsBAfQ1PPBSAJuGFo8QittB5hbGcqIldXJ1Mimb//3pHb4tL
         4q4rRizHNeIxKB9Yoi06ruAUdrIzoPUSTBZRlKPuG3lfRUvwMDV5DbZt66T0Gllwc/sZ
         UNZ81c5bhNMCqvZw3Pe6cQqBZfMY4+ejVleWT+yrvUnFgq+tYas3i/tE6KuCKON3WPG6
         iL/mtyJm8UtZJxZ9CMrVr2HiS9QLnF2T1WgrW5JQMme7I/Qj1FVH1kX9xrsC9KtX8LR4
         2f2QIqFT6e+Zu9xKKtz42UNk+TeEqDe31bYmb+cvOkd8RyOdV9BkHRX7lpKqZ4M/iGzy
         JfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713843687; x=1714448487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5+no2YCmidvNin275LSwR8pI0Tp0FoxLTpLeIvaXuY=;
        b=Knhh5/n16tkzVfxGa3pQG5mGhGcTKNSK6XEF9/UD3C/nphXuUb4DMt11fzYAiJkp30
         BAeolDyWuY7xpudSeDGAq60PaVCL5jGSPwVhDGtXQ2eKOANfUinGuDZcvNv/RoFDl0RB
         q7ARGJcTNxe7Q7W3NScl+XC1Czr0wsA4Hp11dM0jnc1OS6BDAmFdq9+Sra6A4BVsWH41
         xhddxBLjPcPQLXnT+Yb5qWppRZQLKz1VvyHkJUo2sQqfDtcxyHovpybbfnVSC/PrzGUq
         bbI8MLz5DWIaGgbLy+k24hS/ugkbxUfgjSpPuZew3RFMPfi3k/H786WBuvzgQCeXIIIo
         79kA==
X-Forwarded-Encrypted: i=1; AJvYcCU3aUjUKgVNxw9osJ02frKiKEh3febAHgfihJfCfUIf6bbw6vruXEnxXEn9PGVMwNpdrdKXYiZhZK9Gb8y/9Tz/3Zen+GEnkoCSj5Ast+4=
X-Gm-Message-State: AOJu0YyLXJpoyZT49E2rnAI9XSyPLyHxrxGJK0U95RmxFbM+7iHEuXFf
	rvJIM+68VMRdnY7ycltk6M/xDNXEPEeL3bDgA0tMj/WzjEwqr4GD3VsZwqiB4ig=
X-Google-Smtp-Source: AGHT+IEk5ynVvllFpoDAECg8nh7BfbCqfpMIzwNakNzM2tHibdMZWatAJwp62coEKbLv8SpF4bdD4A==
X-Received: by 2002:a05:6871:7a11:b0:22a:7899:37c4 with SMTP id pc17-20020a0568717a1100b0022a789937c4mr14499731oac.20.1713843686932;
        Mon, 22 Apr 2024 20:41:26 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id b16-20020a63d810000000b005e438fe702dsm8266980pgh.65.2024.04.22.20.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 20:41:26 -0700 (PDT)
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
Subject: [PATCH v3 3/4] virtio_balloon: introduce memory allocation stall counter
Date: Tue, 23 Apr 2024 11:41:08 +0800
Message-Id: <20240423034109.1552866-4-pizhenwei@bytedance.com>
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

Memory allocation stall counter represents the performance/latency of
memory allocation, expose this counter to the host side by virtio
balloon device via out-of-bound way.

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/virtio/virtio_balloon.c     | 8 ++++++++
 include/uapi/linux/virtio_balloon.h | 6 ++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index f7a47eaa0936..e6229e548832 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -322,6 +322,8 @@ static inline unsigned int update_balloon_vm_stats(struct virtio_balloon *vb)
 {
 	unsigned long events[NR_VM_EVENT_ITEMS];
 	unsigned int idx = 0;
+	unsigned int zid;
+	unsigned long stall = 0;
 
 	all_vm_events(events);
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_SWAP_IN,
@@ -332,6 +334,12 @@ static inline unsigned int update_balloon_vm_stats(struct virtio_balloon *vb)
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

