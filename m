Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901A52F5339
	for <virtualization@lists.linux.dev>; Fri,  4 Jul 2025 10:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751624762; cv=none; b=Ckk0I4LklczwPtHsf0Tr/jVxznzDc0VcI1vUJNMvOnvjJAmkWKU7ooxFgIJhZhcaQRGTYZCqHEBkal0HLNUaiXa90qjeKA9yC3rOh3JOqcYbbH/ro/xGJ24AXS//9qsMdDB0U+4WLWH/yZY8WQgY9+FBi0+rPZ8/dsnUk00nWoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751624762; c=relaxed/simple;
	bh=Wr+Kn1AL8lzxIZAskivxC/G+Yen/YkPljMI4x8om+J8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Hl51MSw5e0QgUBpSHZaxJlaJbOMdGDjNX+YXj2Pt2Y+J93nIkJ/riNmlSLEqAVDmTivB5hNg/CtTtuIg82jyiBnFQ7tkQUP1CkWBMzPSIhddxoK/tHwmmdR0lkfCzCLJ6cYaLiUu/LLWue41upCMVNlDrQiIAzuDfADzAeF2FzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AuSySbeb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AuSySbeb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751624759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YZJ0pN+qk8np2TVjDZumvdXYQEUJdQ541mKybIkqdFY=;
	b=AuSySbeb2ar592H3z30N2n4I3gUDyJ6f73qrrLT6jGWxJ4nzF4Mxw/62ia1aWxf21x95MY
	XR7axZFsq9ydASU+JtGkTzfL6tsbArOnE/uets2p2xgE6RFZsW89mL2wM8kYe6JrfN8Sw1
	XqhURKaVXkB1mLDSXB7Q9zRydGe8HLk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-4NarY0TENzSvX1YTh8JPPw-1; Fri, 04 Jul 2025 06:25:58 -0400
X-MC-Unique: 4NarY0TENzSvX1YTh8JPPw-1
X-Mimecast-MFC-AGG-ID: 4NarY0TENzSvX1YTh8JPPw_1751624758
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4eb6fcd88so475424f8f.1
        for <virtualization@lists.linux.dev>; Fri, 04 Jul 2025 03:25:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751624757; x=1752229557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZJ0pN+qk8np2TVjDZumvdXYQEUJdQ541mKybIkqdFY=;
        b=AAhK5jf/oN/niwrhHcGl5+GOms0vAMtYIfAZTdv5kH3CBNuOXZAjDY1evgWxOiWxp4
         SIOrV4x6JbfZHEtVT5XGgJuFmmcvDMFeX55rVPn5LirTC1cVjdvVE/uPvAdm4vDonEf7
         gNGUvsXHQabIRMs7zz8oPnuLv9Nail+rxerCQ9c1YrrbrPGu06VJQ4eTSBvi+WQsCbVo
         +xLM7D8BSlS2aSC8E5qEQ7MaBmxKcYy9gcxd9g9JOrfx5VCOZnso5G/DijDcc8jasQTi
         zbDJomF+t/Escpb5S8ERcxwmuGUW0LRwdapq8f1Nb/7RQjKQaBwzF4dr9iyzS5SjXuZN
         7MTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXR0c8e4cEbzSRspUdvj8F9u7HPg2sATQWXnEuhSUxlcEHMVTWlovp7DirxCUq+t4lwp3HIfH5ECUNSqtiiXA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzOUm5UCfqzm+TbDw0hGtZwEy+07gY8GC2Ffty1GmWm2MXH+ZAf
	QQM6tj1kImCKUZ4VSXHbF7Sr5njh1fgkNYOyR2p9Seov6wTE0nTIKZinC0BpKllCJ9YIloFvlg+
	oRaOt62KiOMIEDnGxEIFudiaAjCvFf7kSsTJ+p20e5A8tR7qeZS49MgZwf18YcGHFTaXT
X-Gm-Gg: ASbGncshcIBOEQeRvh6jsG/ydKTJNhkjiS5UsoFrdd7rypQWQQowDFZ0/8yJUMJHgwX
	Eas2o6KQfq2+xixVOLI8Q4JWNKqJSIFgWC9UntP1VyqpdIa5yWQ5jR+HZ7zlu/JGc3FO/Q8CAty
	IXR7AhrPi7TI+1/ftyPEsIjSRkJHkBmrm7HOYUcpdYzqZ3njtDqy/1sF93aiIXqVad5adGF9+Ve
	2vaHbyMuOZ7QEobogPDUC80x5dOHzcFtXU5+HaMrCyCBgou6emDIJ8ZJZykaoCilX17V5V0C9nq
	Yt4XCrN2fn2UV7buAMvwpOP19lrSHMaD94/HFPjlOCvrfwv8IDer4LapVnI9etqEnVBnJMt+0uv
	WXyOnhw==
X-Received: by 2002:a05:6000:40e0:b0:3a5:26fd:d450 with SMTP id ffacd0b85a97d-3b49702e8bbmr1183999f8f.47.1751624757517;
        Fri, 04 Jul 2025 03:25:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjTF6Bi5YHLD4LeEN00n0rlH4Rvb7Qu4SkJgVJFS3bHVyzx6sYZQQ7vAELvz5hrZ++LyEv3g==
X-Received: by 2002:a05:6000:40e0:b0:3a5:26fd:d450 with SMTP id ffacd0b85a97d-3b49702e8bbmr1183969f8f.47.1751624757061;
        Fri, 04 Jul 2025 03:25:57 -0700 (PDT)
Received: from localhost (p200300d82f2c5500098823f9faa07232.dip0.t-ipconnect.de. [2003:d8:2f2c:5500:988:23f9:faa0:7232])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b4708d0fdfsm2172535f8f.32.2025.07.04.03.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 03:25:56 -0700 (PDT)
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
Subject: [PATCH v2 10/29] mm/migrate: remove folio_test_movable() and folio_movable_ops()
Date: Fri,  4 Jul 2025 12:25:04 +0200
Message-ID: <20250704102524.326966-11-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: VJtd8jXsHfc6xhsBJl1zgUBwcf6z8InUGZo9tXP0zXg_1751624758
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Folios will have nothing to do with movable_ops page migration. These
functions are now unused, so let's remove them.

Note that __folio_test_movable() and friends will be removed separately
next, after more rework.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/migrate.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index c0ec7422837bd..c99a00d4ca27d 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -118,20 +118,6 @@ static inline void __ClearPageMovable(struct page *page)
 }
 #endif
 
-static inline bool folio_test_movable(struct folio *folio)
-{
-	return PageMovable(&folio->page);
-}
-
-static inline
-const struct movable_operations *folio_movable_ops(struct folio *folio)
-{
-	VM_BUG_ON(!__folio_test_movable(folio));
-
-	return (const struct movable_operations *)
-		((unsigned long)folio->mapping - PAGE_MAPPING_MOVABLE);
-}
-
 static inline
 const struct movable_operations *page_movable_ops(struct page *page)
 {
-- 
2.49.0

