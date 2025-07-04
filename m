Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA512EA48C
	for <virtualization@lists.linux.dev>; Fri,  4 Jul 2025 10:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751624812; cv=none; b=m/RcdlTHzaOipNt1U4UT9IiaLJ9QHPpnDof5XldECLrA7OVArsinQNeNNtBjUmuhIGM5hxLxiloEnG/a0DG78IEbQEezXDz/W+CHjsBu2AU3yKnHRErZBYosrO03A5YVAA8zOi78+DGumE47gyGXegSBfvmjoaw9eG6V2m5A8vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751624812; c=relaxed/simple;
	bh=8rQqgJp11Lk6antrmn+yK+r+00c98BCFbnlbAAQikq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=IolWVLQZSWZidZG5i5pCZiu2gwi0SL6hQh/HqWzUpLMVODjxhFa9J2UXHS0Dno0GnrQc7qPzhBgTuq3B8A3okv/9wEJ4D/NY+QypnXLlZrwlh/SjMcCeRhzDXWtZiQ+J2yqAJBkDJsXTgTMfwpg2+Dvh5Iw5XkGydxkMClEVNFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MrU0fNXV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MrU0fNXV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751624809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=egdaFmDJBU0TtndNYiZ6nPcRML2Mxu7RUt3KjMyWE24=;
	b=MrU0fNXVTRDCzOwSdC+Q0trjy64o82BzGfIrf+ZH2ehEhpcOMph+avSd0pVsRbKpHNOlrh
	VCV3Kxw7AEC2CYBVTRPQnNTuOIp2YiGzRlJUcSVOotilJergPvYQa6MNh7BDM23j9tLZlu
	tk06wigR5fNZHajqgn8S0vg03L3NK2Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374--W37QWRvMRqa7In4ax-8Rg-1; Fri, 04 Jul 2025 06:26:46 -0400
X-MC-Unique: -W37QWRvMRqa7In4ax-8Rg-1
X-Mimecast-MFC-AGG-ID: -W37QWRvMRqa7In4ax-8Rg_1751624805
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a5058f9ef4so328609f8f.2
        for <virtualization@lists.linux.dev>; Fri, 04 Jul 2025 03:26:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751624805; x=1752229605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=egdaFmDJBU0TtndNYiZ6nPcRML2Mxu7RUt3KjMyWE24=;
        b=XevM1gbFV6RQpP/XLjPyqgipjvmnCX2q3Ioak+Tt/55T5eJu1YXfKA+6S0stNBQxCn
         Y8QFBae4Vv6G+NXuhMwJ7mxWIPEviTJymI3dHnEprR2jZE8UPa+gSjl2ynOO3mvg5Kj8
         ZwcfDthoBfaAv08wZNWyXiZgz17dnnxKHc1vVtpvyeTwkUgR8nxJunr5+h+jPJqJLr54
         HTsmYJ26vGgJ6M1yHSYQg/IH+8Wrr+FwjKj3nqr3LwhIaaYFkildbYTJooqDo+XkZnGB
         h7z++o6ieEwTQqMG3O/uTkJGDgs1OPgTyzqfA3pnfnipW7Loo63kl5rhmSkcqR3qSRyZ
         cKzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJIPmMvKZX1ET410+jBb1bYYHDAzxUX4qm4WWq9L79J8R0xHhKUbQ5TpwMQGH7x8aKEwTVw5770SS4oTTnsQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9QEJltK7sGkqOgIeGrtKNmdL+ChchhsmzIMQnkp0j6F/CS2gC
	hcHa1U9mfRbezjlcRthj/15sr3Ekp0qCKZja2NDUTUZkQb+3jgvcl6rIBjowd6iU0KjfFszmxzg
	9ilMqefp2h7p4/ZzcfKbmuoDf3v6SY1q2hyB8dazQ/ojBKvhHNd10SEA4OPoMmvB8FvNF
X-Gm-Gg: ASbGncuZcyz8ctQAIBHr6vlBvokq2ZYa5D+l2Ge0ftYWFfHMZchnF1kKThqFJIbvl7I
	EYGrIv5Iq873j76vC2SafEZjjky/VnAHduhAaZqJZPALJQ52VBJGr5BhNumBRL20OT5DOTHmTEy
	Q0QfYIk5x5Waa8tw7UMH2nYUDhAnuUMIjXGpMmwpOO+G72rGuEcBXrvxStmXHQShvjFBblUHWFd
	KRxR/fxHb8DfIV9mA0iW+b8KaNojhzYBWKy4OKZTYqBYE/Tjw4V8pcf27Yy2T/7V1A1iEP7xoeg
	PK91RkeHu/RmOWpzmfpaX1M6Dx78fVxY+FiCh0zd5OkFSip+m6Ao7t+Oce47EbOnlaEQYdsnPoV
	ftjxVFQ==
X-Received: by 2002:a05:6000:41eb:b0:3b3:a6c2:1a10 with SMTP id ffacd0b85a97d-3b4964eb8c5mr1818971f8f.12.1751624805274;
        Fri, 04 Jul 2025 03:26:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEReO138rar0bBMYwWljLx+rr/cG2x6KKHBHNt6saeQjtIgYNeV27GRLz6HCnNXsrL9yURvTg==
X-Received: by 2002:a05:6000:41eb:b0:3b3:a6c2:1a10 with SMTP id ffacd0b85a97d-3b4964eb8c5mr1818905f8f.12.1751624804727;
        Fri, 04 Jul 2025 03:26:44 -0700 (PDT)
Received: from localhost (p200300d82f2c5500098823f9faa07232.dip0.t-ipconnect.de. [2003:d8:2f2c:5500:988:23f9:faa0:7232])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b47285c90esm2152102f8f.91.2025.07.04.03.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 03:26:44 -0700 (PDT)
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
Subject: [PATCH v2 27/29] docs/mm: convert from "Non-LRU page migration" to "movable_ops page migration"
Date: Fri,  4 Jul 2025 12:25:21 +0200
Message-ID: <20250704102524.326966-28-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: EtqXOCAy6q5Sti-xff5ZRXq7NnNAxMxYb9tZLwU6x9w_1751624805
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Let's bring the docs up-to-date.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 Documentation/mm/page_migration.rst | 39 ++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/Documentation/mm/page_migration.rst b/Documentation/mm/page_migration.rst
index 519b35a4caf5b..34602b254aa63 100644
--- a/Documentation/mm/page_migration.rst
+++ b/Documentation/mm/page_migration.rst
@@ -146,18 +146,33 @@ Steps:
 18. The new page is moved to the LRU and can be scanned by the swapper,
     etc. again.
 
-Non-LRU page migration
-======================
-
-Although migration originally aimed for reducing the latency of memory
-accesses for NUMA, compaction also uses migration to create high-order
-pages.  For compaction purposes, it is also useful to be able to move
-non-LRU pages, such as zsmalloc and virtio-balloon pages.
-
-If a driver wants to make its pages movable, it should define a struct
-movable_operations.  It then needs to call __SetPageMovable() on each
-page that it may be able to move.  This uses the ``page->mapping`` field,
-so this field is not available for the driver to use for other purposes.
+movable_ops page migration
+==========================
+
+Selected typed, non-folio pages (e.g., pages inflated in a memory balloon,
+zsmalloc pages) can be migrated using the movable_ops migration framework.
+
+The "struct movable_operations" provide callbacks specific to a page type
+for isolating, migrating and un-isolating (putback) these pages.
+
+Once a page is indicated as having movable_ops, that condition must not
+change until the page was freed back to the buddy. This includes not
+changing/clearing the page type and not changing/clearing the
+PG_movable_ops page flag.
+
+Arbitrary drivers cannot currently make use of this framework, as it
+requires:
+
+(a) a page type
+(b) indicating them as possibly having movable_ops in page_has_movable_ops()
+    based on the page type
+(c) returning the movable_ops from page_movable_ops() based on the page
+    type
+(d) not reusing the PG_movable_ops and PG_movable_ops_isolated page flags
+    for other purposes
+
+For example, balloon drivers can make use of this framework through the
+balloon-compaction infrastructure residing in the core kernel.
 
 Monitoring Migration
 =====================
-- 
2.49.0

