Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A081C2737EB
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 13:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288453; cv=none; b=nvakzfEzJY9UNVzNpWlPTHuAam/iyJ+5GBfUjnkTCv9kf0kxogQL8krc8WpBtGLDP9eO22MQ1xWioWRS+hga80GGYQlcNQjUCimSH36K16mVlWMKZFuVisBu15Iyl4RP2oxXcBWWxkHlF9Q/4d2NQ2N3T1D+sDujFE23LM7Kgr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288453; c=relaxed/simple;
	bh=rcWuXS8i+J1+1NqCBG24FdrnWnU9/Zr9SBDXhHAAeFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=NC7ZCqQVNs2B80xWy77srPZC55xzHS2t8QLLPdgQKw/UHk5V6ZLulI05HOCQq3p/FvU0YuqjyMazxdJ9V4G8b+5wuy4iettfR/FkpVRNXnIrzzFldcqGUGR+9enMiWnPlgAYZPvbaoabLGw61YMsilIs/hCTh07LKivrN/rIGhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=br0uqhTb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="br0uqhTb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751288447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AOWsWuhFUlcALOXMJY1BPVzymTvYGz+UAPJ/r3JMpJ4=;
	b=br0uqhTbWVo/HZeqZJKHfQx0bP+xLNkTTQwvMW1O68oDFvfSjUezpYL/bX05AgvrPkP/Nb
	cYN48G91f8EdNQaK2IyTCowO8PoIzIyBQr5KRaGEe0cMxXj8M4NW989Dqx8COD+tSIktHX
	YUQGEP/QR0PehTcAh4xRkdxKeWNK9d0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-wmDXtGnnMva3yOEJdDAE1Q-1; Mon, 30 Jun 2025 09:00:44 -0400
X-MC-Unique: wmDXtGnnMva3yOEJdDAE1Q-1
X-Mimecast-MFC-AGG-ID: wmDXtGnnMva3yOEJdDAE1Q_1751288444
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4e9252ba0so1385288f8f.0
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 06:00:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288443; x=1751893243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AOWsWuhFUlcALOXMJY1BPVzymTvYGz+UAPJ/r3JMpJ4=;
        b=DGUtqWa/MFHnpuAFH8ceuUzJQ5bjyA56010V74Tay4nTBWerKY93qxFcWKUjWPc3Jv
         AS2WNHE5SHN/kbEIZO0AeVST1nLc583ww7LdbBYBcpNxEcD3Iv3Od8OV4ndB+D7lDNkD
         r9Qe5fL5rpKwnBoP7Pb6F2lnSphe3XhhVi5IBykxxlH8aM/f+jCl42GyUMTrdgWENAVx
         6dW9GSXTNBhvZpBr1bc8B2+u/QIov+x/LujfSqP8NLnquKEevt3QmYNZJmkxnWoDCXES
         h/tDQePhCTOCHZIhMacktK5/FHIherxMRDVCA5MK01dxsOHqjNHqyskYJHzazgRVB/Wb
         mVIw==
X-Forwarded-Encrypted: i=1; AJvYcCXdv8fuoauY6R1Lxiti0lymmvXxQh2bAF8OWT4gaoWpaF2v+2A6VbwsbNj8CTnl96RHeWflabfXAhK2xixJ2Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzuhASPEtJkXtA74hfJWLForcVfk3EKl5UENM7ih6WpUkGYnuj4
	3z+xHPAdoxh1frGWuCFSBO1SiWpwsI72sKHi9oomY4diagLomd1ZsOmLmTCUFOXMIJlzx9+31RR
	dHJk925+t2rYW7DR9T2Y6Xel3a48G1RpTaaFX6Kj7/uCCzisl5OPsl39mMoL8K8lGoeg1
X-Gm-Gg: ASbGnctgvvgPC5tHHRF7vz4r244N94YLGuoGO1X8s1sEPTaNR6ufgUN/MLQKlkr6iYf
	kWzMXm3zDBDVMdLdACQHFY9ncCcALqYqVFBvUMN/7jSYCQ8qq/7OlKcSLZUnnNlxz+RzErPuMGJ
	DNrMoi+z1y0zYXMyJgseAJpzQHG45fammfOIaWGTFyiYGATZkC/u/82xACItf1cssPVj1LS41FU
	z3XZXI2ptghW9hsHtiYwnbmvJOzoABkYhk2DsMfcCchB54E3OTgEODbIx3ILLDGT8uIjFVMdXUD
	0Xd+Q4CTT7TtsUaElTKhfiB8dYBkoqT6LfxTl9U12vOcuWOlbE75HiVH45m4oYFJoTBQZrXaE6D
	b43YP620=
X-Received: by 2002:a05:6000:2b03:b0:3a4:e6c6:b8bf with SMTP id ffacd0b85a97d-3a8ffeb382fmr7766129f8f.52.1751288443207;
        Mon, 30 Jun 2025 06:00:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGx8UWJltFtDizxyihu6cXjhn3Ci52lQuk8tR1EGhsL0o4Tf/9IaaIN7lF9qzEV9dDz+LNV9w==
X-Received: by 2002:a05:6000:2b03:b0:3a4:e6c6:b8bf with SMTP id ffacd0b85a97d-3a8ffeb382fmr7766023f8f.52.1751288442367;
        Mon, 30 Jun 2025 06:00:42 -0700 (PDT)
Received: from localhost (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4538a406489sm136745865e9.27.2025.06.30.06.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:00:41 -0700 (PDT)
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
Subject: [PATCH v1 10/29] mm/migrate: remove folio_test_movable() and folio_movable_ops()
Date: Mon, 30 Jun 2025 14:59:51 +0200
Message-ID: <20250630130011.330477-11-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: UPlm2-pgdxm02a68lCaYlqrB9AHPS16igMml412TzlU_1751288444
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Folios will have nothing to do with movable_ops page migration. These
functions are now unused, so let's remove them.

Reviewed-by: Zi Yan <ziy@nvidia.com>
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

