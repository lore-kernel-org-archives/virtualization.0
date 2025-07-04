Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62D12F4311
	for <virtualization@lists.linux.dev>; Fri,  4 Jul 2025 10:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751624748; cv=none; b=ey76cnt+Q0YGLlHql/o9T2A9oyp5LeDEdEpj523Vb0hFd3JAOY6v/L2XMnMJpIjYrs/POoIQxwVYmkFnJVpceJQYi7W9nrY/9JEOaICMJCWGNQ95EVjW8jcSx6+KL64dba1Eaf3X5sPp3Ujf8qbqDUxp0fQn2/PunFJnOqKnzV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751624748; c=relaxed/simple;
	bh=ALxPszCmVcU8TjBy7B2t3BqkreYKMgNug+n8yrbc+Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=GFFB7aYKIi8cxCPbdVi1DL61R/SfcdfhDnhwVNFVSx6n6vbdxbDj9/R7oKkLd6WcevTvSNncVxcOZtESyzEXxV2RDnjJ8M6xvbtSBE/0ob5uidwLpxQQLRrWwNv8xarb3t0Tn6EhfWFi1d7GZd8Q7KpFxTJUtN+dPpf6MVhKt04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dtqdj26+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dtqdj26+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751624745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+4vricv2e71NWYYMzs8BIQr/CRgQSzBMTqlFovEI9fk=;
	b=dtqdj26+ufS7idNqfvorOHhL+ZM3I6jYxqrPArt+qde5f9DzScOWiaz2Pg87QaE4eMBvrM
	jfI1jZjpnWxr+0aErXuGGaNp/n8akJFuhD0l+7m0fN0P2NnCVGuJrYCjJFMA7EnTxCxdfN
	kmqe06VsfKh3ywPjNiAmqtycafnU0rM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-BKs9vHiKNqaPODGvJIXsKQ-1; Fri, 04 Jul 2025 06:25:44 -0400
X-MC-Unique: BKs9vHiKNqaPODGvJIXsKQ-1
X-Mimecast-MFC-AGG-ID: BKs9vHiKNqaPODGvJIXsKQ_1751624744
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b39cb4ca2eso287729f8f.3
        for <virtualization@lists.linux.dev>; Fri, 04 Jul 2025 03:25:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751624744; x=1752229544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4vricv2e71NWYYMzs8BIQr/CRgQSzBMTqlFovEI9fk=;
        b=aVwYH+eiPma+tj2NXFziobDB9PgaycPJ+eYQQDknBRhGjflhclE4Q+hvSVwxfiVKr+
         F9PJ9Cyb5kw+p8/N2DHjyKCHwTQXWY2DYRXmgiW4U4/+b/eTTlyYCBUuYY//BIVFZmHU
         6V9F7KCPIhoGxNstGDYY+k4l4jRWzyv5t6GxE00R0bbF0rb7X57VKpEUZsysfjGXY5rF
         1UopGEjzmpLv8YkQBZnF6DJ9Y2kW1sVSCd4WPOaVPnY61sHJjDuWqCoY1PFpOgLV1URY
         jEbMre2VQfxsij+hqwfIU8S00iP8r3pglmYT5daNk88eEASAAIdHB8VPqwuuUDiSmSBc
         JCcA==
X-Forwarded-Encrypted: i=1; AJvYcCV65d1IWI8wnlO/7TdN4KtvcXg1xq3+V8ycN3ycvxLVCsQHF3pVGR9rninzM7soxDSKSrLjhEMXUPlgNB82YQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YznNpGUuiKH7fj0f0vDT3b1xenohWa3IQRpQAHg7VMOD+SmszpP
	sA7Nuw5QXEbsGVA0XFmfLg+FG7k0Yw/nrREz/wJHYxSjWImhewdWSBrWuE6/CSieiJvV1bPFyQp
	z3I9PrKzt9tky0fFh7VsNMHMF0ZLxg8Dsy8UI+oKg2m1Tqqo2itEi8yy7ENIU44EQADjE
X-Gm-Gg: ASbGnctcps5DszYJlcpzrdNqK8JtF24rf4maj0P2fIHkna2k1H3M7tRg/TvKYEypI9F
	nKkG6dLErFkGndEK/DZML47XHs7YZxUF48GD/VMXeMkd3vpgzpq2fq/5WLQuA+zOqvqJjuj+qDv
	+hqFT5aSmQynoKoMx0QwR0f8rUa2Qa1Y6qSU2jNfzX+Az/q3X8OAAiG3NRnRGNZowwGBqylXXo0
	2tQuFXtF2Bsbo6ymfIjmumxaoB2pNui2/bFbLOq+PR9ooPfJLRjfx36/9y9AAvonkJTPY7Rzen4
	lcRb4Zw/1I5im3ArTrrlgb2+Zxzz7Js5lYb6JUPE/wB9BJ1n47LhfhOIGN4cyqZYpu4EWvDy654
	I07ZSpw==
X-Received: by 2002:a05:6000:25e7:b0:3a5:2d42:aa17 with SMTP id ffacd0b85a97d-3b4964ded13mr1424166f8f.31.1751624743557;
        Fri, 04 Jul 2025 03:25:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFw2GicaPInsB28PjQGll7qbBWs9+u0wQOGd0rdAKVxiB08VA9zODFfDmMz6Eob0+nsp252Q==
X-Received: by 2002:a05:6000:25e7:b0:3a5:2d42:aa17 with SMTP id ffacd0b85a97d-3b4964ded13mr1424048f8f.31.1751624741867;
        Fri, 04 Jul 2025 03:25:41 -0700 (PDT)
Received: from localhost (p200300d82f2c5500098823f9faa07232.dip0.t-ipconnect.de. [2003:d8:2f2c:5500:988:23f9:faa0:7232])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b47225a2dcsm2114225f8f.71.2025.07.04.03.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 03:25:40 -0700 (PDT)
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
Subject: [PATCH v2 05/29] mm/balloon_compaction: make PageOffline sticky until the page is freed
Date: Fri,  4 Jul 2025 12:24:59 +0200
Message-ID: <20250704102524.326966-6-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: m0N8CSsSYczg8dOm3pg0OCTdoEoRc3k8uAftjMbDAow_1751624744
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Let the page freeing code handle clearing the page type. Being able to
identify balloon pages until actually freed is a requirement for
upcoming movable_ops migration changes.

Acked-by: Zi Yan <ziy@nvidia.com>
Acked-by: Harry Yoo <harry.yoo@oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/balloon_compaction.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index b9f19da37b089..bfc6e50bd004b 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -140,7 +140,7 @@ static inline void balloon_page_finalize(struct page *page)
 		__ClearPageMovable(page);
 		set_page_private(page, 0);
 	}
-	__ClearPageOffline(page);
+	/* PageOffline is sticky until the page is freed to the buddy. */
 }
 
 /*
-- 
2.49.0

