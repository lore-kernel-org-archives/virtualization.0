Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E80A28D8F7
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 13:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288944; cv=none; b=mdgkmQlPpmvqxE9n8btrKKKbB7ErCwPkP4UIFTZW18pXhZ9ewNNUMW9iQqWrmSuK+k20Fk+4OBV+f4HnVphdHzqUNTWi+WnIpp9wKZwwDRK2Bhmvmr/+W8stJApckEDWD2tXfg+V8N6zvdYV053+q37DRDYHzvaYxNLWrMWxLaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288944; c=relaxed/simple;
	bh=WVagca6sn8mP5NDz3wa45UlfrVOPRD5IKy9vkw5Bh+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Ca3Z+VgKXpp6SZ2ohS5aIz8YETLQTYTen3XVxy6DXe591F4AwQDK6w1QOt9zPKZg48oKZr6KELuGf5xo0Vq0zvcYb9/j914SS9eR8oyVR6kyuEAoDwphVmlV8IEGOB/T3lvbLX3GaIBvO3z+MQuFcpvbzCSXeKOty8KIpsgaL0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fmgAH5JA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fmgAH5JA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751288941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sNIKdrm33pmadL5+MWfVmqXzrIDEGwSSahCLerJeLDg=;
	b=fmgAH5JAOhN8AzFhUFDXmOTl/fvkt1gWt/8wovpj9BMxpoLP+VMvuvPvBJz5aTE92dmlJm
	MKeVM2ztDR9Gn7ZkqxtH8eiDjo6lYM0O2MGyKUpEGOb+1Bty7p9SR8Q8CkaAG0NGtUAYxy
	Slhzk17lqckBhCAL+baKkp/wWeeqd8I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-wrPN3nRLP2GffDZvdv_04w-1; Mon, 30 Jun 2025 09:01:33 -0400
X-MC-Unique: wrPN3nRLP2GffDZvdv_04w-1
X-Mimecast-MFC-AGG-ID: wrPN3nRLP2GffDZvdv_04w_1751288492
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4537f56ab74so15327725e9.3
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 06:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288491; x=1751893291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sNIKdrm33pmadL5+MWfVmqXzrIDEGwSSahCLerJeLDg=;
        b=D1ClL8A5vADMwOtzzNsQQTmZc3a8qe398V95RUhywgpuicqOlGvWAc4Wk7h4V+lxLC
         es4Bck1E+WTImnPB2IPFLJJkB66bKi3X1lD6GhxxRN32T3Jcffqse6MfsCpAJwwBuMvY
         bXddrj47/w1XAFY7zup8fneNUEoUY3XZxkOSHR9ie+zUl+6xesSOjIvcHpZFSFtAPS9/
         JoJHAqvnDlXDKjT82qCZphE7YaOqztaKJioatj0mZQbuLyUaugKri56oV43oSSxuCX9n
         b6idGfYIcE5FjLeIr7cPmJXp5kFsPQu2l7rJ2zQqUyz5EYOeRvJ2t7iNs33iIyCyOXky
         m/Bw==
X-Forwarded-Encrypted: i=1; AJvYcCWo+C5QNjgWZXu9UjXeVEMykM9GlfE0ESDmY8FNu/I6cXO+pXbLQsR2KzY/MMI/C2tjDQCIUbhqK15wEHwQ1A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2X+e4crgZInoFQF00n0dlhgg2VsP4cbWieL1o5qUoQQZmUUMy
	XBAtRIihwyx6/AiVReV2FSHf6oaEDSNb12XkvnHk5kWh+0UGHNR4v+9tIsr0wuGI2jagBfYiFK4
	nR4g0VUB0dOEFqvSGG6jVvliXX0KonUM9oaXmokYMIgwTS/RcpW0Q3ZFYKFqED/VvQSq9
X-Gm-Gg: ASbGncuUwjM/6+SqvwQUX8XAaJMK7MdlY6xcyzFcvmwQYkarb2703ubh8kxf3mRd2ji
	zZU7qfHrV6rn0IbYZlHSnTEmlDK8QX+STcJZke3f7vWFLn2c/ADQnO1TeyPdqVcpn7tECxzjmXs
	tD9xjFwT6i69nGO1sNtz/ifTFttC8ebav/CU/Zb0mcoTD6+Ddd39F8F57hn+wmZfEBOD9YSo6jN
	Ol39ASfA0Hz2lCLzhimsL8E8oVvzU2w4YnxaYFRWtO2nzkvXEqzxbisTCmqGP4fDashLesbqZ5s
	tqCHe7uENol8+ZDB3JfJnXG67X1BhF9s5TTVp1YnKZ5ocNDIS6Bsm3DHmwMd2WROrTsW8zjya8F
	KX3ZNz1Y=
X-Received: by 2002:a05:600c:4fd1:b0:453:6f1:bdba with SMTP id 5b1f17b1804b1-4538ee60a60mr107461205e9.20.1751288490694;
        Mon, 30 Jun 2025 06:01:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvKPbKK01jDGKdO7HMFpJHGVfeP34xEfryqVjaTqeCy8FfNy/5uAgcgaE7N6g1euFItwJ1Ng==
X-Received: by 2002:a05:600c:4fd1:b0:453:6f1:bdba with SMTP id 5b1f17b1804b1-4538ee60a60mr107459575e9.20.1751288488983;
        Mon, 30 Jun 2025 06:01:28 -0700 (PDT)
Received: from localhost (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-453823ad01csm166146565e9.22.2025.06.30.06.01.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:01:28 -0700 (PDT)
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
Subject: [PATCH v1 25/29] mm: simplify folio_expected_ref_count()
Date: Mon, 30 Jun 2025 15:00:06 +0200
Message-ID: <20250630130011.330477-26-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: AtTdrvik9CrGUgwKN35feMoeTmhsfFKIHilNEPoouo8_1751288492
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Now that PAGE_MAPPING_MOVABLE is gone, we can simplify and rely on the
folio_test_anon() test only.

... but staring at the users, this function should never even have been
called on movable_ops pages. E.g.,
* __buffer_migrate_folio() does not make sense for them
* folio_migrate_mapping() does not make sense for them
* migrate_huge_page_move_mapping() does not make sense for them
* __migrate_folio() does not make sense for them
* ... and khugepaged should never stumble over them

Let's simply refuse typed pages (which includes slab) except hugetlb,
and WARN.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6a5447bd43fd8..f6ef4c4eb536b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2176,13 +2176,13 @@ static inline int folio_expected_ref_count(const struct folio *folio)
 	const int order = folio_order(folio);
 	int ref_count = 0;
 
-	if (WARN_ON_ONCE(folio_test_slab(folio)))
+	if (WARN_ON_ONCE(page_has_type(&folio->page) && !folio_test_hugetlb(folio)))
 		return 0;
 
 	if (folio_test_anon(folio)) {
 		/* One reference per page from the swapcache. */
 		ref_count += folio_test_swapcache(folio) << order;
-	} else if (!((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS)) {
+	} else {
 		/* One reference per page from the pagecache. */
 		ref_count += !!folio->mapping << order;
 		/* One reference from PG_private. */
-- 
2.49.0

