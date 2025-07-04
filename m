Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FAB2FD5B3
	for <virtualization@lists.linux.dev>; Fri,  4 Jul 2025 10:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751624809; cv=none; b=W8tuhsva4SisZATqpsVYDClbQJXonuF816XudLU9yeI7bPfsBmSEYT+PJ9ZoKspD8XCTzVPxbX6xIqEVKXErKVLsLsRdKSIH2D/m6nHW6+DkVRsU2Ya/JOc7LaATK5vpDoHnICJarf+1KBHKneMhrv6ZL4rs05QUaupz9igYO9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751624809; c=relaxed/simple;
	bh=s9je96qO6r5yAAE/tRQstaImZtvw0D0SBMiOehTSPeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=M/s4PHLMGV8xsR+p6cHALmnDLTPRxdxYHb2a7v2lsqrL07Lf9a3MiWKOgaVxCxNMyaQEFm/vtzcm4NZKv+pRE2JoF0B9WcfQaNUjAzeuuXt/pvGTV/DKmjL8fM7oYK5BEfclsGle7CTRuxrNkI3aSMjsT/ZgtywUP0gvhR9VpJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R3zk7eUX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R3zk7eUX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751624803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fs/e8+Swpq2YGTbmX8ig9Uwxi9FIgSmYum8BwX+79CI=;
	b=R3zk7eUX1iHuY0NA5WYAActHOO1UuhvwdErNYwEP2V0pSbMR5JfLNpQpdI/SvXx13J+5PS
	sIjc8VIWL1+2hW7+k0SiR0FD6DVtHP2OpUcoC1C2STknVIxe8Bxd1vP5rCGiQbho9pr66L
	5Qvk9BCaVO/alEl1vA4o5BusktmV9VU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-ishZAZX1OcGKHrI8wK31hw-1; Fri, 04 Jul 2025 06:26:38 -0400
X-MC-Unique: ishZAZX1OcGKHrI8wK31hw-1
X-Mimecast-MFC-AGG-ID: ishZAZX1OcGKHrI8wK31hw_1751624794
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f858bc5eso538301f8f.0
        for <virtualization@lists.linux.dev>; Fri, 04 Jul 2025 03:26:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751624794; x=1752229594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fs/e8+Swpq2YGTbmX8ig9Uwxi9FIgSmYum8BwX+79CI=;
        b=qX+b3BVECXf7DtyWVhzAmMdvKbC7/q3GPLyOCxkQy/e99DkdV+uPPPupN5j92e94P0
         72ymLKNgwWmehrc/sDoY6v5bVHGkPzq/DHSntXJaPigFxzPTsVLRu3g2M6WiCWob33pa
         KD8DIgaE2GKzYoPDZPm3a/7j1ZKanV70ggd8CpX461MLlRMYI8zQPW8gLPPMUvjeaAJI
         VZbQrIVPoqJoHnxI0CzHmaCIljPk8BCBQLUCUxOlG7pQL8WxAd0oqTe9CyRXhPfyIV3g
         95GXkRdTG4QNYjtBgqONC9WlnIqkyPZLIeXt/xxeR4yKQdHrg4nkCgEdr+0faZSzD4HZ
         NLZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHf57kP05O+riplTHRvtGTIYKYCCJZ4jmyQSYrlN2YFo0FuQaJPqYqCkT4XLhFeTpri0/+nVgevfIqxe7nEQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyN7Fy6mffEYYYU+OCRh7iNY1ry8aRCUsxt5rUJgRiJOWd47Ku7
	6LfBvdHIZzP+H+yMwXiPmF2/5GYfk3QZmaqXFlCvizXXTtC5072gRnjX8LomYVpmspZ5DXi+8eX
	IBebDSHSAYD3wp+9dL88I0C+uCbUk/YKSNCfvgI3dNKHCuYwkRYsa+FwYoLeLwTLotmrw
X-Gm-Gg: ASbGncturHoUb8c19B/Ctjam4AtT0MvHLkWCGfB8xvLjMPKS3tM40Y1GXDwu97uNvlv
	Tf85SMjha4gfEJmWX3b5ea96Bp0lh1CioXwJpkhp+qYZWy+FUqPZSjasdTUA78kejWVSZuXjMZL
	RHuVmlZkA7qrMvmhtzPy5ICed3SHNm1G0Pv02ws4MT9QVdF6lw7mEX+00U55+9RjUX/lj1joXBs
	kKuGxShD+RtdhutLJN/wbKXcrW9TIfVUbYXGxJxIC3UUN/pU6B96W5O9rYAtl2En94yqonbOMAq
	ip3DBmZOuwxrLGwTmQEasMz+ziE1A4W07WwLYSpxEdJJfPSOh/6VBzdSYdoG0EuxjY5PriSt3tO
	4PPIFsw==
X-Received: by 2002:a05:6000:24c9:b0:3a4:e667:922e with SMTP id ffacd0b85a97d-3b49700c540mr1015612f8f.4.1751624794004;
        Fri, 04 Jul 2025 03:26:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFv4//fTRSt2GT11U1TkRjsS9jXLC3kcU+xe7g60I+SsSxP4GVJGQoWX7WuUGQypypw/2H7pw==
X-Received: by 2002:a05:6000:24c9:b0:3a4:e667:922e with SMTP id ffacd0b85a97d-3b49700c540mr1015567f8f.4.1751624793449;
        Fri, 04 Jul 2025 03:26:33 -0700 (PDT)
Received: from localhost (p200300d82f2c5500098823f9faa07232.dip0.t-ipconnect.de. [2003:d8:2f2c:5500:988:23f9:faa0:7232])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b47285c6c9sm2093397f8f.89.2025.07.04.03.26.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 03:26:32 -0700 (PDT)
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
Subject: [PATCH v2 23/29] mm/page-alloc: remove PageMappingFlags()
Date: Fri,  4 Jul 2025 12:25:17 +0200
Message-ID: <20250704102524.326966-24-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704102524.326966-1-david@redhat.com>
References: <20250704102524.326966-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yuTD0O_uBl4Ndn1A-Ez3-0kkdGCzHvNa75n9f_U8_Og_1751624794
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

As PageMappingFlags() now only indicates anon (incl. KSM) folios, we can
now simply check for PageAnon() and remove PageMappingFlags().

... and while at it, use the folio instead and operate on
folio->mapping.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/page-flags.h | 5 -----
 mm/page_alloc.c            | 7 +++----
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 094c8605a879e..fc159fa945351 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -723,11 +723,6 @@ static __always_inline bool folio_mapping_flags(const struct folio *folio)
 	return ((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS) != 0;
 }
 
-static __always_inline bool PageMappingFlags(const struct page *page)
-{
-	return ((unsigned long)page->mapping & PAGE_MAPPING_FLAGS) != 0;
-}
-
 static __always_inline bool folio_test_anon(const struct folio *folio)
 {
 	return ((unsigned long)folio->mapping & PAGE_MAPPING_ANON) != 0;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4aefeb2ae927f..78ddf1d43c6c1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1375,10 +1375,9 @@ __always_inline bool free_pages_prepare(struct page *page,
 			(page + i)->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
 		}
 	}
-	if (PageMappingFlags(page)) {
-		if (PageAnon(page))
-			mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
-		page->mapping = NULL;
+	if (folio_test_anon(folio)) {
+		mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
+		folio->mapping = NULL;
 	}
 	if (unlikely(page_has_type(page)))
 		/* Reset the page_type (which overlays _mapcount) */
-- 
2.49.0

