Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BF84D9E8
	for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 07:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713771787; cv=none; b=Q+C/AT6iFHrgfO3e3habs015hR00DOsr7mlI51QY6YR2PrEakwvLRepCfwfsxiNYmK8V5v882AgUnGPdZU0MZj0sdPxgrA2YTtLb8DIm7ApC0X4BIaJp/wCfNDai4INDL7DEk4voSAaVhn8DFB+vcaPH4e93zQvjF7FRKHaFrVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713771787; c=relaxed/simple;
	bh=3Oj9v8fKAeuQ0Snq0CF75spBnzuIUdmlULeL8Toft80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V2suDIW5AHphOgDja/UHI5XNq3+BvXExG4YS5tP2XpYmSXlxsHcEUJSbZk2CRWJ5Y5tdTL1FZv/9j32rklQZqtvgJoMuQFWkoRgOT+AN2eK5dDx3sXLkYZ9od/OVzG0RqoITmhd4AicuTeJGZflA3nIOEuGc97X0TpPgNu0Q+Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gwOkH6le; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gwOkH6le"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e9451d8b71so11141775ad.0
        for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 00:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713771785; x=1714376585; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8v4Ayhiua6xBQPRLdZqElV8SuuukGuSIp7AWQ+b83kM=;
        b=gwOkH6leY2Q4507u3wl8h40oXlrxkt2OCmZujessqXz/Srr4uyjKWAddboMUUK8HBM
         sXkm4VLOYd5EM6xzshLGifCNNnA1c/2P8/ZSpevX8prMJfGo3UcoFcx65p2ukQIC0dDI
         o2kHawCI7Xc7ZQ78vwCyf9wODa3BT7odxmCxD4ZYtfnGKa0WXzrMuIlV6wCw+LL53zm4
         J50ZdaBXc+pwlCYwIizL7tMcJFss12yETxab7yqPqR2hYvUFqbxm8cs3V9OmDCI24cnF
         Oq8Y/tn2BKGa9i0S8X2XB8K4ToUqWDjrJGsuZ4aEzmNK+ywF8nCIZ/+pguPeEykZoXuF
         2dQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713771785; x=1714376585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8v4Ayhiua6xBQPRLdZqElV8SuuukGuSIp7AWQ+b83kM=;
        b=VeVHWZknkPddISDasoenTbtVYwJO7jKTR2kVk7W5ftaC6w8pJBTY5rpbDMwsicnj/q
         rUTVIgTh6excfq0DSsXtSKmxOQEqzB76mighellptghRNTHKHMMpb2jQkhO3l9MQz3EQ
         jNdlwCERPMW6yEYWNM1CMz1SV1d9TduNXD/yxQue/OUAaDnbd1ndyWovB0grDmlCCjKo
         RMYrftwHdiaTSgaHTmginLHB4bHQhqt6GxTdueYkmOnufDEgSTlDmcEXzcGe+tO6qzL/
         GbU0h+mTydK9WluW1L0ku3i9EUIG+bu9RPgK7AmrlwxdniqdFxS2nlsVuSUDzP9BVK2b
         kxfw==
X-Forwarded-Encrypted: i=1; AJvYcCXk5hp1gKL34/WRDVWlx0PCJbACA6oDJQv/jcwvj1qW6QWWaz0Wuv2KIDCtRJ6YQafStbsAlWAVlnnadE8Y9n1z+U7khtCZd4WpcBHfbQ8=
X-Gm-Message-State: AOJu0Yz4oYeCg7MWJ1TBlAlXgr4EbF1t0tCCWzSmcJA2DPle1r0gNao5
	GHufvrWLVY58UTMsNh0JDgq9Plr8hw/xlAS3Z8LhFMJ/C1tl01fpFbx8QYCHE7s=
X-Google-Smtp-Source: AGHT+IH5FapWr2NsqZRBiIrj5e5+IahI/4Uza3UkvKorGF9IdyGMaix/CVDPSu/65IlIfj7nO5mHKw==
X-Received: by 2002:a17:902:c40c:b0:1e4:2b90:7282 with SMTP id k12-20020a170902c40c00b001e42b907282mr13198963plk.14.1713771785215;
        Mon, 22 Apr 2024 00:43:05 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902784b00b001e0bae4490fsm7595634pln.154.2024.04.22.00.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 00:43:04 -0700 (PDT)
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
Subject: [PATCH v2 1/4] virtio_balloon: separate vm events into a function
Date: Mon, 22 Apr 2024 15:42:51 +0800
Message-Id: <20240422074254.1440457-2-pizhenwei@bytedance.com>
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

All the VM events related statistics have dependence on
'CONFIG_VM_EVENT_COUNTERS', once any stack variable is required by any
VM events in future, we would have codes like:
 #ifdef CONFIG_VM_EVENT_COUNTERS
      unsigned long foo;
 #endif
      ...
 #ifdef CONFIG_VM_EVENT_COUNTERS
      foo = events[XXX] + events[YYY];
      update_stat(vb, idx++, VIRTIO_BALLOON_S_XXX, foo);
 #endif

Separate vm events into a single function, also remove
'CONFIG_VM_EVENT_COUNTERS' from 'update_balloon_stats'.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/virtio/virtio_balloon.c | 44 ++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 1f5b3dd31fcf..59fe157e5722 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -316,34 +316,48 @@ static inline void update_stat(struct virtio_balloon *vb, int idx,
 
 #define pages_to_bytes(x) ((u64)(x) << PAGE_SHIFT)
 
-static unsigned int update_balloon_stats(struct virtio_balloon *vb)
+/* Return the number of entries filled by vm events */
+static inline unsigned int update_balloon_vm_stats(struct virtio_balloon *vb,
+						   unsigned int start)
 {
+#ifdef CONFIG_VM_EVENT_COUNTERS
 	unsigned long events[NR_VM_EVENT_ITEMS];
-	struct sysinfo i;
-	unsigned int idx = 0;
-	long available;
-	unsigned long caches;
+	unsigned int idx = start;
 
 	all_vm_events(events);
-	si_meminfo(&i);
-
-	available = si_mem_available();
-	caches = global_node_page_state(NR_FILE_PAGES);
-
-#ifdef CONFIG_VM_EVENT_COUNTERS
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_SWAP_IN,
-				pages_to_bytes(events[PSWPIN]));
+		    pages_to_bytes(events[PSWPIN]));
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_SWAP_OUT,
-				pages_to_bytes(events[PSWPOUT]));
+		    pages_to_bytes(events[PSWPOUT]));
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MAJFLT, events[PGMAJFAULT]);
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MINFLT, events[PGFAULT]);
+
 #ifdef CONFIG_HUGETLB_PAGE
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_HTLB_PGALLOC,
 		    events[HTLB_BUDDY_PGALLOC]);
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_HTLB_PGFAIL,
 		    events[HTLB_BUDDY_PGALLOC_FAIL]);
-#endif
-#endif
+#endif /* CONFIG_HUGETLB_PAGE */
+
+	return idx - start;
+#else /* CONFIG_VM_EVENT_COUNTERS */
+
+	return 0;
+#endif /* CONFIG_VM_EVENT_COUNTERS */
+}
+
+static unsigned int update_balloon_stats(struct virtio_balloon *vb)
+{
+	struct sysinfo i;
+	unsigned int idx = 0;
+	long available;
+	unsigned long caches;
+
+	idx += update_balloon_vm_stats(vb, idx);
+
+	si_meminfo(&i);
+	available = si_mem_available();
+	caches = global_node_page_state(NR_FILE_PAGES);
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MEMFREE,
 				pages_to_bytes(i.freeram));
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MEMTOT,
-- 
2.34.1

