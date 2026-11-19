Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795089768;
	b=VPWz8kKEnsANBIpwlgpKD8yStxMEr3Ye+5oXL9QUqD5196hlPch1eJrz3vDGs8AJvrPE
	 sgd2euIWyw4om2s/Y0vbWgTPbRD0dPx2J4D74CFjzwWg0ucS5nELqSCIOVj0LDRYU7cCn
	 Bd2GhMP1PmhfyGPrZZzjekYR2QmFlSBSD3nmrxf1CNcyIlVauZa5B++tJVTJSEYpwS3Dg
	 vDT6bVxQMArsOZCb8osMxifBSl1C2dCWt002hu88kvIUHHZzSdw7ndhHyhuGnwtduGA5W
	 +mXXgBq2aR4+bw/hS2jhjbVcfjD+2lpesBrKKDWSJj8f/gokWNEhv8yj00rRjqR79mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795089768;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mailer:X-Mutt-Fcc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition;
	bh=A4AW+1r5ioYbTqiBhF66CNLfZpJFNCdMJyMeafN4jyY=;
	b=o+EKhRw0XdnsuZjUZ9vaAz4V7/suXWEajBuDFipDXv5Uq6sO/wMfegMtK4xObCDMmr8x
	 GGJQLZ9oQdk7itimlBhhhLCHe2gG9QeUgtNqbKS1/F4+3OKUFMYmSG/DDl8DHaWBHv9qG
	 T1zYS919kqEuS+FoA7Dl4Z2zQ7Brz1RHtHjUjrN8cRPnoIfnRv5YqM4omCq5WKWWapt3m
	 u7/zTEk1DV/yvB8EhYcTC7vthnEnwkDF8Neb2JVDX6rFFHYHVImYACZrZHJt0fojRWjxZ
	 LQkwTCSQJwrxQ/7PrZcjYhhvFN20Zmo5OpX4pk80bINc0tDafImC4xg+uLxQbKjCw4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VmqqJkRu;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F61606A32A
	for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 12:02:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69F61606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VmqqJkRu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795089766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A4AW+1r5ioYbTqiBhF66CNLfZpJFNCdMJyMeafN4jyY=;
	b=VmqqJkRuxTHqire2Ob9n7Lu5JpU4t1+U809jf6AHulANQmi33wWvL5KVeddpZsNg0IO5wD
	3BAzO/F+0ZbNvQgBm8y0e4TqYdt7hW6AsqfusHAUolE8P2+PlePSkCo1LNcXHmVlUCj0uw
	cL5Mk/OHjK/7CxGt3y+uXaYpH5oimmw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-Bk8vgeLiMJGprRssyK8AlA-1; Thu, 19 Nov 2026 07:02:42 -0500
X-MC-Unique: Bk8vgeLiMJGprRssyK8AlA-1
X-Mimecast-MFC-AGG-ID: Bk8vgeLiMJGprRssyK8AlA_1795089762
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c50549f6cf1so145272866b.3
        for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 04:02:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795089762; x=1795694562;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A4AW+1r5ioYbTqiBhF66CNLfZpJFNCdMJyMeafN4jyY=;
        b=TfhxTIb4CjpcyYon9URtaU99GvR0UwQVJP9G6PaPiCLwaoTM6KpK+KWiaxtPCJb5LJ
         hhuZlp40Sxk8tRIp0rxQ6GiVOoTuKt6cTB5ClrWoa9dvqBQ4VbHiextiYNURr4xC77v/
         3CmTSi/nvfUhj1K1yp6kjB2WTk5gD9K6C9oxDJjI7pSAsZojz3xWWYFYGSyYi/O0rc1X
         NRs2F9GOzgsvVehwN6m/jWnzBdcb/sc1ep9UZT97uz9V/9W4XGKEOcIaJhrAQr2F9pRn
         ZoidbjeMCLWUP5RvStDVy5lElyU04lIKTBJYk6STWtQJOb1DpvKt5JM/bAC87HekwIlY
         suWg==
X-Forwarded-Encrypted: i=1; AL+hErG6afduaT0QvwpbAkaxzmK2RB/6vcYsrq43NjSiKWh0u2LfZ7v7cZsm736fpfVN9SZpgusUloliox2ADoOW+A==@lists.linux.dev
X-Gm-Message-State: APuU4Z9GmoMCH/jYSqL2OWBGTFE1Fz9ZsLOoLzXfwocRdkJ9sOknsj7A
	hsHXEbLHIhsBtjNSl8zVqPOvLDconCr1yrsnutxNpHTDt2ly5lCaTLtavsuM8KJKhbEbuZH1Ekd
	igWQA94erLl4hCHSm9xfTcphojMeCclkycUAeksrY1wI/EGPJihSalkWpnzmukyM1uIoa
X-Gm-Gg: AYBFou1+Bz2hhnehiVLOEdciXaX9CkA41Bv9epe6N0yDgtw90GOpdRnZqYIl8SVJYAM
	0OfbEH9hmetidGWccN1gNiFwQ++dZgbSEPOIhxTee1YxlcGSDhlTxqLHDuVV/ArmaREm6HazwZ2
	7odB+ljdjN2C6Zk9N6Uk+ANk1Z1jhQiTfdiUQwKr05y1rWV8+KMG+k8iyHJ5lLW6Ld/4/tEb6sb
	A6tBOwJEu9MeVQSCHeyM4SqMKeUCNG+6d1BjkKK4pl17h0q8uO55jRJauzLJUslk5HhQRqiZUmQ
	F+Xv5IR/m0f/3KgpNvh0t4/0Evhg0ARrB9XT4kISef4V2/4/U+AC/Oi8vIjZrnTlwoWNiuKyjMJ
	CqgQVzJ58c7FCPhncfHWBl89nkUo8PwgltuYw2P9BxA8=
X-Received: by 2002:a17:907:6d1f:b0:c46:8b87:c1f4 with SMTP id a640c23a62f3a-c510e2d4ee1mr524867666b.20.1795089761431;
        Thu, 19 Nov 2026 04:02:41 -0800 (PST)
X-Received: by 2002:a17:907:6d1f:b0:c46:8b87:c1f4 with SMTP id a640c23a62f3a-c510e2d4ee1mr524859666b.20.1795089760723;
        Thu, 19 Nov 2026 04:02:40 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1520:4400:d78d:7b2d:2f5d:e08f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a655f9f4a7sm10439162f8f.34.2026.11.19.04.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 04:02:39 -0800 (PST)
Date: Thu, 19 Nov 2026 07:02:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>, Dev Jain <dev.jain@arm.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Gregory Price <gourry@gourry.net>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Lance Yang <lance.yang@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Miaohe Lin <linmiaohe@huawei.com>, Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org, virtualization@lists.linux.dev,
	"Liam R. Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Brendan Jackman <brendan.jackman@linux.dev>
Subject: [PATCH v11 2/7] mm: page_reporting: support host-zeroed reported
 pages
Message-ID: <2ec112cbdde76a60ab235a0df7734a23387f1c86.1795089715.git.mst@redhat.com>
References: <cover.1795089715.git.mst@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <cover.1795089715.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lkN88m8QKskIQXlc0XQtBiLgykkjFy563tz_WGatk_Q_1795089762
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add a host_zeroes_pages flag to page_reporting_dev_info, allowing
page reporting devices to declare that their host zeros reported pages
on reclaim.

On successful reporting by such a device that guarantees zero contents, set
PG_zeroed.

Note, that hosts zero the pages for guests, safely, even on
architectures with aliasing data caches, and even without knowing the
guest user virtual addresses.

Specifically, ARM64 data caches behave as PIPT; KVM handles cache maintenance
around stage-2 mappings and invalidates the whole I-cache when it aliases.
On aliasing MIPS, host unmapping flushes the whole D-cache, and slow GUP
flushes the host aliases of replacement backing pages before KVM maps
them.

Any host that can't handle this, will simply not set the flag in its
page reporting device.

No driver sets host_zeroes_pages yet.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: LLM
---
 include/linux/page_reporting.h | 8 ++++++++
 mm/page_reporting.c            | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/page_reporting.h b/include/linux/page_reporting.h
index 272b1274efdc1..49adfc5d45804 100644
--- a/include/linux/page_reporting.h
+++ b/include/linux/page_reporting.h
@@ -13,6 +13,14 @@ struct page_reporting_dev_info {
 	int (*report)(struct page_reporting_dev_info *prdev,
 		      struct scatterlist *sg, unsigned int nents);
 
+	/*
+	 * If true, the host zeros reported pages on reclaim.
+	 * This includes any architecture-required cache flushing or
+	 * invalidation, especially on architectures with aliasing data
+	 * caches, so guest accesses observe the zeroed contents.
+	 */
+	bool host_zeroes_pages;
+
 	/* work struct for processing reports */
 	struct delayed_work work;
 
diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index de587be178010..841dcd64777d1 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -127,6 +127,9 @@ page_reporting_drain(struct page_reporting_dev_info *prdev,
 		int mt = get_pageblock_migratetype(page);
 		unsigned int order = get_order(sg->length);
 
+		if (reported && prdev->host_zeroes_pages)
+			__SetPageZeroed(page);
+
 		__putback_isolated_page(page, order, mt);
 
 		/* If the pages were not reported due to error skip flagging */
-- 
MST

