Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058061C6A4
	for <virtualization@lists.linux.dev>; Tue, 23 Apr 2024 03:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713843682; cv=none; b=QW+MxIfoxGLDTru0F71zf4GBTJ5JyeIIE0E8brzAjxG6oYynYRMgoXmEH6kX658ZIASNY69NT58/fUFT8WK//GNDCPp2sP7DeK57ZTAl9awoOzzHwdOdT6yOBz/djg1qiiddAzbNBfuvKUn5MENxK86ZG+eZS7pmCWNpeqvExOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713843682; c=relaxed/simple;
	bh=iSysrDVuYXg0UMc79wYI1kULCvYs69ZhGh9/V1D5h+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AUz+4ZReggx4D+NfOGc8mhlI5oFQtZKbGpc0fhEZ5yFC5sIMf9c/zeCRGzHr9JRSCsrgcRKIKnKo6Wk4DLULRWmdke4zTkPsi4YgxSUXBWvXuZNaT+zL3Do9DZ7E5QR+KRPtlFp35vQICuy3eXfkAXRr3Xl3zKhoPir0kj6xh8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YbCUH07J; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YbCUH07J"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6ea2436de79so2770154a34.1
        for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 20:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713843680; x=1714448480; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KkBGMpzb7Zyfmx1ZstJgk5Op8ktl/5dFs5p8PlYlyX8=;
        b=YbCUH07JtIb8oY1t0jEgiE6A/qybjoAYJqX4zeTgJJATaNXIvUwdVD/uMVVjNKvfqx
         nkIW3XYP8r667rimZSvhSPNGFe/WLeRvwmCi15RlMigJ3kItOKE1M7JOz47E5ze5OaqO
         HKY7uFIYkXs7eECjojnL/w6ttKZGQa8bNVlEn81a6KEHvzVNqEJJWB+eIE20WePoHZ67
         z1fpv1eIjvEaDSa+U5Kxi+MxYVWY9NJL5tdPWbK91KTxruVcT4rJ+c8jXlQlEKb2AyH0
         UDe2jTPDwLhXtkCkTeMenecNeGGGj5gxgE/n9uIMrXpUFvKa+ecjc6YLTJ87sAkvCrRZ
         RHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713843680; x=1714448480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KkBGMpzb7Zyfmx1ZstJgk5Op8ktl/5dFs5p8PlYlyX8=;
        b=G8pmsOhBn5BXY8gl8i6xcnWmQv/CRbebnbIUqPnXCQFMCmSsKy34k4UcjHya/HssNE
         CwbHVu+VgnRqvxsh2mywwiml5/J0+RliBwpYBbRoBtyawbgHVFvyzN6i5GDF+lFRafbK
         inB0qVqw+Q/eVhm46l8LJuOeMwJgv4Br/xwPNFae1rukLLU4xl4weRfjra7j4kYPkfmA
         OmBYS3ivs7brG8PvPjRhvnuDjfp/rfK7jxykqc720XGcngCCkjZImaLPO5XPOaQB1jXP
         esLpjnfp03hXUsRxnTLgbE86V+ksHm7Nw3MJK7Tbujbhhzr+3rngKA4xV6Z9yTroF0q3
         NmRA==
X-Forwarded-Encrypted: i=1; AJvYcCXDqLByHaM8nvzUY+2eQkiDzOAvISgQXpJV40tRAucN9TrkPVbAdSBbcJw1E7F1L76BULYIXoaY9806rFbNovNDuUF6O7zUTQJs/O81wXg=
X-Gm-Message-State: AOJu0YwW/4jpX9YSaemmWM93oXNyLd5DQd97GkIFAKcS/JoQxCOmzYuy
	AHN56J22xP7r0pPXn/l233wSKdRT1o0uU/peqobAQwvYEd0790OAdcLfcUEb47Y=
X-Google-Smtp-Source: AGHT+IFPWbPsOAgDjqPCg7khKs3ioBh3D8C//sMkXvFal/sejW6ukQN3/LZM7rjAVP3UsOTPrF/iBA==
X-Received: by 2002:a05:6830:4392:b0:6ed:686:b43 with SMTP id s18-20020a056830439200b006ed06860b43mr9633062otv.17.1713843680244;
        Mon, 22 Apr 2024 20:41:20 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id b16-20020a63d810000000b005e438fe702dsm8266980pgh.65.2024.04.22.20.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 20:41:19 -0700 (PDT)
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
Subject: [PATCH v3 1/4] virtio_balloon: separate vm events into a function
Date: Tue, 23 Apr 2024 11:41:06 +0800
Message-Id: <20240423034109.1552866-2-pizhenwei@bytedance.com>
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

All the VM events related statistics have dependence on
'CONFIG_VM_EVENT_COUNTERS', separate these events into a function to
make code clean. Then we can remove 'CONFIG_VM_EVENT_COUNTERS' from
'update_balloon_stats'.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/virtio/virtio_balloon.c | 43 ++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 1f5b3dd31fcf..1710e3098ecd 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -316,34 +316,49 @@ static inline void update_stat(struct virtio_balloon *vb, int idx,
 
 #define pages_to_bytes(x) ((u64)(x) << PAGE_SHIFT)
 
-static unsigned int update_balloon_stats(struct virtio_balloon *vb)
+#ifdef CONFIG_VM_EVENT_COUNTERS
+/* Return the number of entries filled by vm events */
+static inline unsigned int update_balloon_vm_stats(struct virtio_balloon *vb)
 {
 	unsigned long events[NR_VM_EVENT_ITEMS];
-	struct sysinfo i;
 	unsigned int idx = 0;
-	long available;
-	unsigned long caches;
 
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
+	return idx;
+}
+#else /* CONFIG_VM_EVENT_COUNTERS */
+static inline unsigned int update_balloon_vm_stats(struct virtio_balloon *vb)
+{
+	return 0;
+}
+#endif /* CONFIG_VM_EVENT_COUNTERS */
+
+static unsigned int update_balloon_stats(struct virtio_balloon *vb)
+{
+	struct sysinfo i;
+	unsigned int idx;
+	long available;
+	unsigned long caches;
+
+	idx = update_balloon_vm_stats(vb);
+
+	si_meminfo(&i);
+	available = si_mem_available();
+	caches = global_node_page_state(NR_FILE_PAGES);
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MEMFREE,
 				pages_to_bytes(i.freeram));
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MEMTOT,
-- 
2.34.1

