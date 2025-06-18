Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E7730380D
	for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 17:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268485; cv=none; b=QIMGalJnqmw+LWpLgduS0SEEzsPPAQc/D6z3NvN0NYhMjzzLeqxV7P9POg0qwoOPM0FBVnTk9Dl5+16Tx/YcYwrsfs3HytHB+yf/MrTXZz7vNpaiQ9A8ET6dEHqUh69L/1oyQFopVn5gIubyGPnBkTGGm4Kv+0sOHdidFU6w04o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268485; c=relaxed/simple;
	bh=mR4wKIFzNAz9lCxg/2MhGizqJd2oyhLD6gTXEVIJK5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=ccA4yg8Z+cQuNz/OaSg/ErX1BotpMveqRRcnnyAPJtopAbuqmZUMgufbAoPu/yNcGa0xkhyKkxNbFHZKtX/qkxIELBMOw/H2i1tirBNRxkVjvaGQwt2FM5qiCt/bKWsX1bqPaBo3amCDYOl1bx29oPWpDIBJc9soKvsFVgab9RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RGgoRlBv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RGgoRlBv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750268482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OFGM8ws286HsZ+G2nyb5/sPhilYYDV0QN54X+S74Jfc=;
	b=RGgoRlBvMfb8arUK2BvY6h0eS8PbkDeh3eO5qoLXOWcsk7KcpHNZbl35vHOlVHXD/++8y2
	Jq7J1Qrhz4k8HUne7GKcTg079Pb0TCqCq0FK2bZ7oIqfqli7PRosX6VYonskm897JAVSx4
	kM7Zp95LdcXDGC4Uj159vDDi1DdDSMs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-ItVBdLcVOCSWQRaXzkZwKg-1; Wed, 18 Jun 2025 13:41:21 -0400
X-MC-Unique: ItVBdLcVOCSWQRaXzkZwKg-1
X-Mimecast-MFC-AGG-ID: ItVBdLcVOCSWQRaXzkZwKg_1750268480
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4f858bc5eso4324956f8f.0
        for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 10:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750268480; x=1750873280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OFGM8ws286HsZ+G2nyb5/sPhilYYDV0QN54X+S74Jfc=;
        b=hdUw98DRdPV60YitS9Hvr9g1UR9umoYABr6DH7IqihJMVoGmW0Imtw1juqjgBcPRdP
         btlh4o8opbxTEyFYeHt8iBo6Uidy7f0d7BeIjfVMdYx/Lbx1zQq6G+1/5hu9oA5DxZgq
         lAn2qUBKFWlMVyfoHFj93DVdNHGvht3RlZugjE7U0AkohHZJYToPo+aViv9Yc7NfQNq4
         +gQpDdQ/PQ1TmQzq2lVZhotmY/IXVOIEzc3wO2eBOvJk8/867rV+cjgYxrwfY7P2Er2A
         oxgsu0cTfWMLh6koMGFAUnFfcU/t9zY8TFmhuEPw88jgvnU9RK5O810Gr3EVL0jnvIsL
         HPIg==
X-Forwarded-Encrypted: i=1; AJvYcCVUR7f5W4sdIHC8ONed5KSwy9lf/jmyzMg0g/bIyAiOnA20GpXv8UDO7QC7siranFSrGcw4A2BF/lbEhecj3w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyiV7z944hXN8AzLSkdFtL8f5oTLCtm1qyiFtZtT5SpkWsm3Dm0
	43HPi0UNo4EPiaMQnTUvaPAdLuHHoqCAjymrlQ0g8h15pkQGjIePEc2kjQx20DnrREDfZaG3RF0
	IVi29sajLXc+CnNAPVQCnk+bsh+UB8k/3nY0qDTaGxAIXPzkkRwDEWOEomSAvk0mN33mv
X-Gm-Gg: ASbGncviz9+hgfK2GCkLnUWWFotzTK4BL8tdTKL5arIoKLww/DUeH8pxU9jT7AU76by
	agsZO7KoOs7+in5iIikuD9Hj8rI43ZGilBBA77MKZ72ZW8M4efsX/TAlo6pTrQwOFEM4X+1k+Rq
	NrtCJXx3raWha+58xvI0dfjj7Tg6V2X6PZyGOBkbdX6YRyAHdf71z7vCQvwi8De5aNLiZtc2B3B
	aQLMoADu8/GgyUo3m9GxWLCgwJVG7DieYQs5c+mKNHKYYRSlbO7G1mm2S1l47UGMmeIZREzDrzj
	U+nMiGgrPttA7CnUipVywx+GQ7fcCcHMSPljIpe6KjJuIgomSuMMRXrVW9Idh43tnnfbHeJ7Q0g
	2vCk3BA==
X-Received: by 2002:a05:6000:2f88:b0:3a4:f8e9:cef2 with SMTP id ffacd0b85a97d-3a572e6be35mr15379304f8f.36.1750268479817;
        Wed, 18 Jun 2025 10:41:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGgOLn/JzQiVrSw8561br8iJzDS6W98mGXalaJQyvnuLaRLghELBqFwLLjepyMMgs/X1CCpA==
X-Received: by 2002:a05:6000:2f88:b0:3a4:f8e9:cef2 with SMTP id ffacd0b85a97d-3a572e6be35mr15379264f8f.36.1750268479340;
        Wed, 18 Jun 2025 10:41:19 -0700 (PDT)
Received: from localhost (p200300d82f2d2400405203b5fff94ed0.dip0.t-ipconnect.de. [2003:d8:2f2d:2400:4052:3b5:fff9:4ed0])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a568b62ba7sm17866251f8f.91.2025.06.18.10.41.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 10:41:18 -0700 (PDT)
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
Subject: [PATCH RFC 23/29] mm/page-alloc: remove PageMappingFlags()
Date: Wed, 18 Jun 2025 19:40:06 +0200
Message-ID: <20250618174014.1168640-24-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250618174014.1168640-1-david@redhat.com>
References: <20250618174014.1168640-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KVkNxcAqK3NJKRRQv6iH6R8Ul5SgVMCoKUGAcKKjgVA_1750268480
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

We can now simply check for PageAnon() and remove PageMappingFlags().

... and while at it, use the folio instead and operate on
folio->mapping.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/page-flags.h | 5 -----
 mm/page_alloc.c            | 7 +++----
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index abed972e902e1..f539bd5e14200 100644
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
index a134b9fa9520e..a0ebcc5f54bb2 100644
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
 		page->page_type = UINT_MAX;
-- 
2.49.0

