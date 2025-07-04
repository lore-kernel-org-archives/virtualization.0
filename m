Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748CB2F3C23
	for <virtualization@lists.linux.dev>; Fri,  4 Jul 2025 10:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751624746; cv=none; b=oXZxqSTygTRZ6abY7fUmqaXXlbLl4RMyR9H9L0Wq4eF39JGKxjKsJDRlYgK7dOdNv8M65hq7TmLhiW1lwvQ0hmV5E4wCNyi9m02TtgXeRqXCwlrKbEsiz8kU3qaeCK2Yhq0shg6BcYelZpdb6ogE9wGFLv9ZazvoJ178AK/ekYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751624746; c=relaxed/simple;
	bh=AM3xYskqV1GdLk2CfAavrgvRU1Z8ivBgX0T2p7YhDTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=mde/8yloMw9c3Ki60OgaVfZf98AzkI5KkzstH7qUa7vG0AtgGXJcYZvT78odYXsCIE+Jyleh/A1Kz/WAWTDPMJzcZ6hMynQxe9GpMtSpm+oriIE9K6HvjNg3iCeZ0hBzCzW1pAYUPTASQ3lOhQLQWP8GiHfueyC/i13KYQxgLj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S6VMGOsP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S6VMGOsP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751624743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CYTSovr6D54lprWegV/WfQaWtrhfAm9Hhj9zhgiC0NY=;
	b=S6VMGOsPJWFQehm0Q8c6doAct9gJTTZMrUI7zNPgp9L25DZUgSwFB3M6lS6NZqr+9BZ2u4
	pwAe7DLX6GxERvpQrNlyORZL+XRbia+eTm+4ldEfRtWBAIwk9I0h3QJc2TuTY+vPA5a6uZ
	wFM5uivPqbZthxTJR3yAVPRMdepNuI8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-iM6Tjz8FPkqJQ4ZLKCohmw-1; Fri, 04 Jul 2025 06:25:40 -0400
X-MC-Unique: iM6Tjz8FPkqJQ4ZLKCohmw-1
X-Mimecast-MFC-AGG-ID: iM6Tjz8FPkqJQ4ZLKCohmw_1751624739
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4530ec2c87cso6375865e9.0
        for <virtualization@lists.linux.dev>; Fri, 04 Jul 2025 03:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751624739; x=1752229539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYTSovr6D54lprWegV/WfQaWtrhfAm9Hhj9zhgiC0NY=;
        b=XXiunngBwURbEL3RVmvag2/tGtsv2XDmCS4/W9TCyi7+agm03NM5daSCLjT7kHFeYP
         udeK7q5KNNdcnG72xoJawdEWAGlUxaaIkD28YIe6zTn2frsZhVhB0dKEAKIPu3SJt0z0
         RdmaWi8mC8uPaJ9HJYqBTJoFXCwOx9GapY11xD/oPo6ccWLZpBuZpXT9csdaU4JAk1QQ
         L6U054yT+XqK94Nx+q87loHPa2+9REaWN4EivDTo1blBJkubVFSZ9Y+Zt/gfTSq97q6y
         C/755BL/hS1lwhNIVM7XTmYL31Ulu8BXIyc5z3onGZxfXq5r2Vsb+1UKUoOV6q6cXarF
         ge9A==
X-Forwarded-Encrypted: i=1; AJvYcCX1PjBPWZeH+loKWqnOEttgdezvsEN1Hj7bjC6vNIsgdYcFmWNuqhs2/6s717zDbfAO5BCbkmgLw9Remgxuug==@lists.linux.dev
X-Gm-Message-State: AOJu0YxOjiiRvcp+kd4wAnXStxCDMhm14gLeqSaLl6PEbySU9OpDcveH
	n1Rk1dP0mKISzq4FfXqzy4qlRAWUxmzICE4VzqQ2qVMJMc3EFGA4ZRn8yrbDhxiedyVRe6ClPyU
	M+NLo/q3lW1INwSbutdFyBAvKFwLh+ZC+//qtCVnTFTk5PHlwQ4bwiHbNUbFg5FIUhG82
X-Gm-Gg: ASbGnct46/RaYd/BQDxwXWLaRd60XJZ/1vFirGpNKQfkPf5pMT7pYPWWbZ3BFTjIPWX
	RSN6w4EHSNUfm9OuM7loxsEgW3hxeodRfjMR9AK3SZ20gzy1CGcISr0FfJjD58efMCYVCVPyO0V
	9eqfB1CkJC8NW1hqh4CakhJthfWOYyK83Zp1Oji2jZhOd3ackM+c/8BxBb3SF5UtPjroJwCP7Ed
	OUtdQwwLSylxmxzCFoXc8aJO/rGTwPvpkY2nVQJfGdX9pmySlXA/w0Ivw5Os4cnQ3tKdGfJclsd
	DMsVAjDNZ8qAWuStsGyCgBNnQZYoRlW9f9W5oAL3hbXCJPbO2v01Q5gC1ANTNDdJbwR9wssMbZE
	QXpSuVA==
X-Received: by 2002:a05:600c:3e1a:b0:450:d01f:de6f with SMTP id 5b1f17b1804b1-454b30aff3dmr25066105e9.15.1751624739223;
        Fri, 04 Jul 2025 03:25:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEabPcFPa9J30O6qNf8/Kx6cfnBeZR0NWqXc94Uy+RT4akZprmrg4imDnBXRg/gEanMTx6ZJQ==
X-Received: by 2002:a05:600c:3e1a:b0:450:d01f:de6f with SMTP id 5b1f17b1804b1-454b30aff3dmr25065735e9.15.1751624738758;
        Fri, 04 Jul 2025 03:25:38 -0700 (PDT)
Received: from localhost (p200300d82f2c5500098823f9faa07232.dip0.t-ipconnect.de. [2003:d8:2f2c:5500:988:23f9:faa0:7232])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b47285d3c6sm2121167f8f.95.2025.07.04.03.25.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 03:25:38 -0700 (PDT)
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
Subject: [PATCH v2 04/29] mm/page_alloc: let page freeing clear any set page type
Date: Fri,  4 Jul 2025 12:24:58 +0200
Message-ID: <20250704102524.326966-5-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: OVDR-sc6R9S1ALNOSxE2lhbXoLUoROi2PnqNlFnzBVs_1751624739
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
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_alloc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 858bc17653af9..b825f224af01f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1380,6 +1380,10 @@ __always_inline bool free_pages_prepare(struct page *page,
 			mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
 		page->mapping = NULL;
 	}
+	if (unlikely(page_has_type(page)))
+		/* Reset the page_type (which overlays _mapcount) */
+		page->page_type = UINT_MAX;
+
 	if (is_check_pages_enabled()) {
 		if (free_page_is_bad(page))
 			bad++;
-- 
2.49.0

