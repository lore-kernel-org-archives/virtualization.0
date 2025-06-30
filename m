Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EDB2857F8
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 13:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288432; cv=none; b=b4vg95+lI+Xv212cil1Ndlc+xwjVIme0UmezEe6cy2zRQAFsePnEgc1PMK+UUGwOoE1xGz+CgU+euGRIt39nUBYFESHg2bxzOnhKQvCT0TbJjL51Br5cvyxXINMNYgnQFjG78uQc5kz02E7XNjrZsqxqYchilyzDKbtkzHHclk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288432; c=relaxed/simple;
	bh=S3zLBPDhBdMrO+ksqFydENk2LB8FvPckKtc18Wgtb7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=lA/wuMlxAVJh/BUhYyp1GikZJKMX3+eJIIlpw2q7sLBbip1ce+jzkue6GMdcUsPjzP/PrfITylMVXlUK9aYmHn9v7Q0H5L+TsfTeZ0WBeZzBp54wY7cH5myWFLeP3HF8uJcizEgtSaDv1qBrdElIbv0BqzNSRddQmKZ78HWGdPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CrbGMhMh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CrbGMhMh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751288429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p0pHDGHZALCRdBpqrQ9hLtuju8zJ3QwGWTV045A4FRg=;
	b=CrbGMhMhA3tZl8XwuxJZ2+aYNnwPvrS2hO7w1XKzz6rq79Wb484fPwCg6IuylLE2LwNpYs
	RyBT/JyR6MZqBGcXekoBWb5RDUZQ+EcPT72FZlOQTmscUoEymaGN46Pzkyaz0IrjLtl0ON
	jfq8g6QWbQNPT2vhNPUqvM3omxWG7BM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-MdVORHFFO0-FSXpYJK56HQ-1; Mon, 30 Jun 2025 09:00:27 -0400
X-MC-Unique: MdVORHFFO0-FSXpYJK56HQ-1
X-Mimecast-MFC-AGG-ID: MdVORHFFO0-FSXpYJK56HQ_1751288426
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4539b44e7b1so9206125e9.1
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 06:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288426; x=1751893226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p0pHDGHZALCRdBpqrQ9hLtuju8zJ3QwGWTV045A4FRg=;
        b=EcEA+KJTAfWUjlzB8EHzOrLR812fyK/8GYFQoJ9y+x/CeObhbj3tEboBhmCUCr9QSW
         gHwjw2LcWpQ/15BGvJwOzKcKKMA8W/y8fqAgkJqLqPY1i+j/hHeU3mmcyY41+I5fWDOv
         64LuNKcbQ7tPRxKvEtNVU8yjxQppWfabUEFXXiJw9ZTTbHdqxt6yyzhOLsIPkqsZVCJE
         7r9jCVGh8YEtuPuyyREK1N0GaXD1xXxSaEw8R/y3UmCGt0bmz8GY3a2rftutN21Vntjw
         bnkS6qyMivpFh0Ej5ZP/aZnSQAPPUNS5errZl/Z9pjtJeKl+T7cRIviVpwnDDXhjwPj6
         ij+A==
X-Forwarded-Encrypted: i=1; AJvYcCWNzt2KAunAEo+AZm5jSuEfrRQmYOxpdzbf9I/+GDTZyB0InOGn43whgzd9dynY5VawuR7UgA8xzjWzT2J00g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyxpka7PbAWfKzUr6GI7ivWCgwH3iOhPyOlPoFjzfGXJ0xR1M0O
	8+qdPhHtXxUO/dSft+XH0CFzaFXBudJ37Yt47crXsD/eLGSOUnDVmdY5LN8gtdfflexcPxXwbVg
	c39ksJ6wNypho5ar1f5Ap+tLCkVQA6LVAV6hpn3oa6XfL4Atewd9PlVAdJXLveqs3Wu1G
X-Gm-Gg: ASbGncsy06uvu3Y5dN5qWfji7K/Hf/F6WBYb/Nh3lcnCchk7v0oPJsQST0AuPvXpdcU
	QLGL+kC3kFWcymDFjFDGU/CDWC5ukb0rXZvuxlWXZkF6DUMQQXWz7SHsuW5b6GalAHtgN9pRNWs
	kaSUfDcUjCAOWUU9aA7Lu7INsQrNnLKqD2d9n2q7guSmtHM65YYg4371wWhLIKKiCnd1ERs62St
	qpcXFe9b/xyaWKk4tGIoiqAoeauJleRL5V1vVwbpttE+2wgvk+s/0kGYI5Q2RtaiJ+wSI0PLaxA
	TdaJjwlFpo7fkeFd0wCiRYzqRYhDxulhijGZm4IAOxeXLPtXNQQ4EmdJMKyPnYsSwmfCLpj6lMI
	TCqi5V80=
X-Received: by 2002:a5d:64e1:0:b0:3a6:d579:ec21 with SMTP id ffacd0b85a97d-3a8f577fd35mr10177740f8f.12.1751288426247;
        Mon, 30 Jun 2025 06:00:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwLhkxvJD2R8UoqRuajbGlVqpEQolWc/VBvsc1ZeiLSR5gPzKHixn/vDhyoe1JVlLg6TEErg==
X-Received: by 2002:a5d:64e1:0:b0:3a6:d579:ec21 with SMTP id ffacd0b85a97d-3a8f577fd35mr10177695f8f.12.1751288425713;
        Mon, 30 Jun 2025 06:00:25 -0700 (PDT)
Received: from localhost (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a88c7e76e1sm10574554f8f.16.2025.06.30.06.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:00:25 -0700 (PDT)
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
Subject: [PATCH v1 04/29] mm/page_alloc: let page freeing clear any set page type
Date: Mon, 30 Jun 2025 14:59:45 +0200
Message-ID: <20250630130011.330477-5-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: _bxxcoyAJtFk7gen8cmFLp0iz6lSVwaD4ifLUg9Iv0Q_1751288426
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Currently, any user of page types must clear that type before freeing
a page back to the buddy, otherwise we'll run into mapcount related
sanity checks (because the page type currently overlays the page
mapcount).

Let's allow for not clearing the page type by page type users by letting
the buddy handle it instead.

We'll focus on having a page type set on the first page of a larger
allocation only.

With this change, we can reliably identify typed folios even though
they might be in the process of getting freed, which will come in handy
in migration code (at least in the transition phase).

In the future we might want to warn on some page types. Instead of
having an "allow list", let's rather wait until we know about once that
should go on such a "disallow list".

Reviewed-by: Zi Yan <ziy@nvidia.com>
Acked-by: Harry Yoo <harry.yoo@oracle.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_alloc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 858bc17653af9..44e56d31cfeb1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1380,6 +1380,9 @@ __always_inline bool free_pages_prepare(struct page *page,
 			mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
 		page->mapping = NULL;
 	}
+	if (unlikely(page_has_type(page)))
+		page->page_type = UINT_MAX;
+
 	if (is_check_pages_enabled()) {
 		if (free_page_is_bad(page))
 			bad++;
-- 
2.49.0

