Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF788292B36
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 13:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288488; cv=none; b=la5nJalTYEDY1/+69TTmV8FJtNK2dxLISsoY7E4tHgT2B1jNEXpxYyRRa4lh6BY3LSqHeZemKjvHmr1Q2erOk1S1saxnOWQ+9Tg2L20tUTITW3TaYxtkwcTTVWxMDIgOshVJUkQlTzvGQ7PqeyPnlLPDWH8I1ZRgv5EzIrsgEkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288488; c=relaxed/simple;
	bh=bX2O32zo3eRkpyjOPjcPSMjPx5jynwq3pH5hPVFisUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=pcmC/0KkB1U2dkET3C+LBFoXEdnjhdP0Mdy0bXnE8vi2ibcdgILdfmjWwhZzoPT55q3cEuSt7y8RhcYNiomm0GNqRvKBjgZf+FuXR9RCnnmAq+Bpg5JL35uKtVPMkIdf8rLkHWu6phUweuOrui4GLiWpvQGCPM5ttBsIgJFv/Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iyHF7tDP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iyHF7tDP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751288486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lqdlPSrzqUfx0/Anfl8VFepfeUNo5Gqwl7mCFswBHro=;
	b=iyHF7tDPnTrYUFaFBAcSNFlkdpEiBCIsKg2ZzHFUjUD9S4S3M76lf9tpcqynf/8SQJ8dHv
	JFkar2TRtLfPVTuc9diucAVAq0elGhAjcrAoogCmaMEmYGros0BaVB7Ao9IHjigVHaBAWU
	EugniWIDSpJPbdT51DjWzk2kS17kkgg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-pCfaCX87PSOp9FWf6yh5Tw-1; Mon, 30 Jun 2025 09:01:22 -0400
X-MC-Unique: pCfaCX87PSOp9FWf6yh5Tw-1
X-Mimecast-MFC-AGG-ID: pCfaCX87PSOp9FWf6yh5Tw_1751288481
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-453691d0a1dso11776695e9.0
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 06:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288481; x=1751893281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lqdlPSrzqUfx0/Anfl8VFepfeUNo5Gqwl7mCFswBHro=;
        b=ou8sYD1Xps7ewqAN4MpD26oET0pcSDP7HURWl1z/ALOlVGOKSkkwP5mzygdphEjkfP
         vcdFRLu6o2qAgVwexDybaqWhdxCavuOwUTpphxGB0optPbA/BIYzaAkg6qNhLElyshi/
         7B+SWMEZSt4CFrr80QLFVUKOhT0/8ilnkK2mk6zc5Wj8TpZ3zxwYdq3kBwKIKAKLVTHL
         Yy3FsRCFN3cE453XvX/G9lus+v2/0ECR4zbyvpvN5inms3/u7MMB6QEX88taGUDxNYMr
         92SdsEvP/adENUrsSQKcDG9JqFiwyCKXqMTZtAqPzYgZh5Lp9a7m1sjo34FQv57p1JUs
         zv5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUp1XfY2b44C+0dFfjWVoPpLQSjCpC9nyUqZweF3LQea6itqQmCFJ5+wZOwm5V8RnugfyQoXgCtjgQSNHAJaw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz3r4Pmd8ZUvvBtZcZU5tzLjrKsLTWAAkwKN6pCMyIANzoaYogO
	WQRJ2cqW82178Ko8A7MuJig15KCfuR+ra/3IAVxa04/KVnisIP50C3ZUvWaDH/fHKngaKxi4SiD
	AwRnqce2Hqqvks3sHhkM3LvoqamFvSI0rXZQemPRztSXAb8IJpNHMC73NTLc3Vw2ScetD
X-Gm-Gg: ASbGnctCToRhhrm2Aa8utD8LyN1ceHIAYWbdoILwDbu2Xm7gpY0XBfeJHBuHrOxHRCR
	VuQW5dtH/MZnQeOq97zuuyj1VIrkuLOuJfr9pWDUJRRFYEocT8rz1pr3neI77WzTgbw+j52w4oH
	qLDL1y2oBTSt30GIrq/39vBz+avOx/3CILXDEZfjZQ/KRy92X5YIbjfpVWjR379E7Pl2FnHTRq2
	KRxuS6s78f3m3hb/cZzyroTjd9/Pg1/3k8n+O9ATj5Qc+Kj1NiTf0fmihaLfSYbBASgUpBT6dix
	tTc4jcZzjWeWUt262GSs59sp/2s57f1drhAfW4SFj83fvI6AAky/GbQnc7baKs3dlktl+EBm1+k
	JbJ8tlgw=
X-Received: by 2002:a05:600c:190b:b0:440:6a1a:d89f with SMTP id 5b1f17b1804b1-4538ee4fd6cmr142842765e9.4.1751288479085;
        Mon, 30 Jun 2025 06:01:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIe1HafHWQMdBGxTE/8gmXCwDECQtvb4nkW8MYtHAgLmX5UxDUSKKTFebF7rirr8hhXGCxDA==
X-Received: by 2002:a05:600c:190b:b0:440:6a1a:d89f with SMTP id 5b1f17b1804b1-4538ee4fd6cmr142840675e9.4.1751288477814;
        Mon, 30 Jun 2025 06:01:17 -0700 (PDT)
Received: from localhost (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a892e528a9sm10541491f8f.60.2025.06.30.06.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:01:17 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: [PATCH v1 22/29] mm/page-flags: rename PAGE_MAPPING_MOVABLE to PAGE_MAPPING_ANON_KSM
Date: Mon, 30 Jun 2025 15:00:03 +0200
Message-ID: <20250630130011.330477-23-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630130011.330477-1-david@redhat.com>
References: <20250630130011.330477-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xwYBpgbD4HQ1fuTCskzmI4Adb28xS4ABm7Jem3AkbiQ_1751288481
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

KSM is the only remaining user, let's rename the flag. While at it,
adjust to remaining page -> folio in the doc.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/page-flags.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index aa48b05536bca..abed972e902e1 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -697,10 +697,10 @@ PAGEFLAG_FALSE(VmemmapSelfHosted, vmemmap_self_hosted)
  * folio->mapping points to its anon_vma, not to a struct address_space;
  * with the PAGE_MAPPING_ANON bit set to distinguish it.  See rmap.h.
  *
- * On an anonymous page in a VM_MERGEABLE area, if CONFIG_KSM is enabled,
- * the PAGE_MAPPING_MOVABLE bit may be set along with the PAGE_MAPPING_ANON
+ * On an anonymous folio in a VM_MERGEABLE area, if CONFIG_KSM is enabled,
+ * the PAGE_MAPPING_ANON_KSM bit may be set along with the PAGE_MAPPING_ANON
  * bit; and then folio->mapping points, not to an anon_vma, but to a private
- * structure which KSM associates with that merged page.  See ksm.h.
+ * structure which KSM associates with that merged folio.  See ksm.h.
  *
  * Please note that, confusingly, "folio_mapping" refers to the inode
  * address_space which maps the folio from disk; whereas "folio_mapped"
@@ -714,9 +714,9 @@ PAGEFLAG_FALSE(VmemmapSelfHosted, vmemmap_self_hosted)
  * See mm/slab.h.
  */
 #define PAGE_MAPPING_ANON	0x1
-#define PAGE_MAPPING_MOVABLE	0x2
-#define PAGE_MAPPING_KSM	(PAGE_MAPPING_ANON | PAGE_MAPPING_MOVABLE)
-#define PAGE_MAPPING_FLAGS	(PAGE_MAPPING_ANON | PAGE_MAPPING_MOVABLE)
+#define PAGE_MAPPING_ANON_KSM	0x2
+#define PAGE_MAPPING_KSM	(PAGE_MAPPING_ANON | PAGE_MAPPING_ANON_KSM)
+#define PAGE_MAPPING_FLAGS	(PAGE_MAPPING_ANON | PAGE_MAPPING_ANON_KSM)
 
 static __always_inline bool folio_mapping_flags(const struct folio *folio)
 {
-- 
2.49.0

