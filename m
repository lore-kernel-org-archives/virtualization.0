Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9125A33F8B5
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058850; cv=none; b=XqcbUu9mrH/of882IAlR/U2FhRpg0YZdjcPmG9cKb1mwjhxHETlX+rngndecgb5g7cBfaMPQpCQ7Ssp+3YJzMClW3h+C6IowNN0dLfDWc0CKaKey1DoRsylUNfmz5BporJkzctVhgXQwqnFsFVX1EMPph2Fnhwb4prcGGQcNQYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058850; c=relaxed/simple;
	bh=OUfDv1UVoayG4u3Qm8KhKCzfykxkZrQ4CprPvtCNsMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=lKYSosKfgtvmHtig7civZ7ZwSdqeIUbFhSrlVTaFqGyatbOQirb6b8GpBQEMEKejYrWxPucn/RsxLwpW3RPuB5pDp6Z6rfibFUfSBmJmKFqg6soDyPIjl0T8/yZu+4jrjZrnWbUHUAsR6zApclwttZEyKr912tbyXkihxAz/k9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V7RcHXIM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V7RcHXIM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761058846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=36pQ3u8jy0FN5dn5JcBHYlI7xvHgf6+mb8fY5UQyalU=;
	b=V7RcHXIMS+gv6XWZCVFVy6wpawjszdJ+lx8e7bkM7DDbvYKG+FiKUe3/itPKV2Y2qycFAw
	my7H426y/rYJoVTjxv0sk1sZK33mrG+2dKKFBcSBbYilm+8xk5SOseawNE3yieG3EWyHny
	b+NRCNiaSsj4BE8V4JVFTuGrknWHN1E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-027SnsHPPLKzSK5Yi7JgvA-1; Tue, 21 Oct 2025 11:00:44 -0400
X-MC-Unique: 027SnsHPPLKzSK5Yi7JgvA-1
X-Mimecast-MFC-AGG-ID: 027SnsHPPLKzSK5Yi7JgvA_1761058843
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-470fd5ba449so19275305e9.0
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 08:00:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761058843; x=1761663643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36pQ3u8jy0FN5dn5JcBHYlI7xvHgf6+mb8fY5UQyalU=;
        b=I57lrcnxwdFSS/WnS4joFaFObDq5lui3Ggwrf3oxUXRciZnF+cTo+3uqKcVHMn8yRk
         6UavLPAChwdAgZZKEZ2adGA5fmZfYbBWw5917uSd/leGGT8FqX9N15zzqeOYMzy5Hbre
         TWd3q+4o+KRL56APxy4k5J/D+5PXKd1PR35g1kNR5YAFRBQuAEHGrczxYW5O8lR9eXDH
         jTd6T0ruyiQtwv/EE0aweqw6Bi1AgyDsmkIdwiO/+qtcfhWNYEBQRcm4amHXscTdTVlY
         UF9r2ZSmfzD4KS7P7sjpi/vaHyZ5JnnimbF1qlWy0osozwV//3CxaJxlces/fkA6kUeE
         wpBg==
X-Forwarded-Encrypted: i=1; AJvYcCVYap4MVL2oAgc4ixT+f5NegkL5+4371cytjjb1VJ8g0CQpbIAmWRWcJQLDODKQ5Rc31tWV4S80MO+IEXNdsA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxTCcOEVjBKq9eAVTbyBk0ojWSWuj0lqTBxDmRkQNjwnyNFCYLf
	KjxAbcxR8VP7m0/h+7tIc9cPk3tcnkCHtWfK9GZEtw3RGCpij+npa1cEbIkLbSa0KrtyfFBArQq
	1NM3Aib4/8FlVxW6rrQxu7Dz0ZlREe1N1h3ZecQmlmLeAnUwFQc3ewQY++7LTcLz2XTLF
X-Gm-Gg: ASbGncsWBSWXdqGEX7EvO/ZgZTsE5xXHD+Tudys1epC/G++pYbMZqHufEku/KEYwTy9
	tlSnXlQOHvWEAlDIv+eGv0pRpqqQUzcCVDg4enex7BlkponOt9HC63eeIz02AceiFTs4vVdIbyC
	hAB4yz6+CsYFqEuKjb+frRH/khlWiXX8teAXwaLbOi5jJBAJNr2uq+l2WG3VwiF6KBbQQrlItYX
	EQnzcAynAYpK7ZF9uQAa+s+7zMPn57LQXeBqcCnkIXQ0QGcG4DS1nDyr6XSp/1zarxtM/CXews1
	DGXOo08cJVqgzmARUzY2I1LwCpM29TQ0zNTYSrM/JVC0mV3qrjVUVd0GmjfO7rH1b4BaSlqZUA5
	xc3wPqs1t2pg17yp0Yp8F7+yySkEhxSvnjkPYoqMkPRRxOSLnfrdASLD2HN/V
X-Received: by 2002:a05:6000:2312:b0:3e7:6424:1b47 with SMTP id ffacd0b85a97d-4285324c1ecmr15556f8f.6.1761058843377;
        Tue, 21 Oct 2025 08:00:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZSHalSV1qtXRSgl0VFWeqe9iy+sxBgka0ewlzc4+wG6jRvgfqUYrrl7qKB5xy+AtSOmms8A==
X-Received: by 2002:a05:6000:2312:b0:3e7:6424:1b47 with SMTP id ffacd0b85a97d-4285324c1ecmr15477f8f.6.1761058842857;
        Tue, 21 Oct 2025 08:00:42 -0700 (PDT)
Received: from localhost (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427ea5b3f5esm20480663f8f.20.2025.10.21.08.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 08:00:42 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 17/23] mm/balloon_compaction: remove "extern" from functions
Date: Tue, 21 Oct 2025 17:00:34 +0200
Message-ID: <20251021150040.498160-1-david@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021125929.377194-1-david@redhat.com>
References: <20251021125929.377194-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OrgyIU4mw6tocXxGntR8AbJrowm_01syZl1-5eKkl_E_1761058843
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Adding "extern" to functions is frowned-upon. Let's just get rid of it
for all functions here.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/balloon_compaction.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index eec8994056a44..7757e0e314fdb 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -59,14 +59,14 @@ struct balloon_dev_info {
 	bool adjust_managed_page_count;
 };
 
-extern struct page *balloon_page_alloc(void);
-extern void balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
-				 struct page *page);
-extern struct page *balloon_page_dequeue(struct balloon_dev_info *b_dev_info);
-extern size_t balloon_page_list_enqueue(struct balloon_dev_info *b_dev_info,
-				      struct list_head *pages);
-extern size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
-				     struct list_head *pages, size_t n_req_pages);
+struct page *balloon_page_alloc(void);
+void balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
+		struct page *page);
+struct page *balloon_page_dequeue(struct balloon_dev_info *b_dev_info);
+size_t balloon_page_list_enqueue(struct balloon_dev_info *b_dev_info,
+		struct list_head *pages);
+size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
+		struct list_head *pages, size_t n_req_pages);
 
 static inline void balloon_devinfo_init(struct balloon_dev_info *balloon)
 {
-- 
2.51.0

