Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFE52F2378
	for <virtualization@lists.linux.dev>; Fri,  4 Jul 2025 10:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751624750; cv=none; b=X9HvEHyWPkq6s5hJ/9ym82eM9ifpOE6nSfsZcFRuGPmzgRvNyrnmFlm5dSs16j0Xe/TbJ+kFUk3fD6npimQpMyFdiK2pzBpFr38BCEws1WqSG56CmvNvAZwelueCxlSBvWoHiwnKXYzlZlW2lDYftZY7mD9Rs/zzkYfy1KD+ggM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751624750; c=relaxed/simple;
	bh=Whhu182ZcZuvW8AFFhlkxBAnfsoxAKiodOBFvbw9Jf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=oOAxccui5piqEXcjZJ1BT7NptNMoVjEdpZcRUb8tCAdO/hn4/gMtM3jZFH1Jm7hgORrKPoTND9upPGxXwg2SgvLcZzdUZkgQkp8rWVx7jpVeIJ3Iuh0jPjAWeGjtYMsxcecmGUJ4kA5Ro2u8+Wfy1oUtZoLBV6c9NoS+j4LwZ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ImGIfB9q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ImGIfB9q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751624747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ONGts7/hBJv/SI9LHH6S4PEHXTtUzsYSWsi4Xmz5Gpg=;
	b=ImGIfB9qQtNHlsYyTKX6eCgUVdEHLg2T7WtH3H1hXH6E1aJXpotT/6WlKTDZpM55uJubu+
	YoKVIpG6l/qJgrpxSE7XJ/iyF91u0vp3pxTORN1w7rCcGuU1P1e3f9NjQZmrXV4JGqzwEJ
	Vl84VLHNv/QI6Zkp6S+ej6Sd5YCzYtc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-XFaG9DHZMZO3KkA_7OkTSA-1; Fri, 04 Jul 2025 06:25:46 -0400
X-MC-Unique: XFaG9DHZMZO3KkA_7OkTSA-1
X-Mimecast-MFC-AGG-ID: XFaG9DHZMZO3KkA_7OkTSA_1751624745
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b20f50da27so952463f8f.0
        for <virtualization@lists.linux.dev>; Fri, 04 Jul 2025 03:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751624745; x=1752229545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ONGts7/hBJv/SI9LHH6S4PEHXTtUzsYSWsi4Xmz5Gpg=;
        b=ZWpPvjCsj7+DbekkiZ9M41IueS1+4dPpbeBpMecazNmMkvn4eudH74U5euaAkkCFKO
         FNrU9BgefpIZMnrC/glfbeID+UwuLCS8GnqFXAqEl6a9/Z7LzmDTT7TQg7s3PbBHQ/vp
         Ij/grdp+y45dKS87Y4G2HFhtiiaaraLpwQXqrRiGvOsydQ2kzvgzsZorhXl0iRjWnJM7
         k3qZLyvG4phBUKkPFXa8FPrPfOLs39tiIpa9t0TRVTMjZZJmeQtCIjVpYvsMdVJat0jQ
         sHCt8l7YForMJnAwos1tNuRIp/OWkHaVU97B59Hgdhni9i21tDPUSdKsljRZNxnZpjwf
         EYWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVcNoeumeg+PcycBGx8FhAVfz5nRotiBH+Wq7qJJApUFbS21T/6lBG6NYEYhq+m8AdDLb8bKJ9PHirzXJQDQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy8iNY6hTY4cW33+2k3TGwW002EZ0u7D5709AOPRYIbwKz6H7B8
	3l2KAiS+gJIhhjGWLftI6C+ky2sq56W5G//Uwm8Y6AZXEMVJaPpkd0CkW3I6pQo1MSWclsG7WP+
	9Y6eKviBe4m4EndYjtrcYY8beEpG1BzcNFOAgZMz+uDHuFZFGSnYPE4ndJSrbmfxDkZHd
X-Gm-Gg: ASbGncsjbEL6F/F+aD+LcxnejknhG2z/n0fMT0Sh7cfr5gS1cICZf9NbvHefAjtvQSe
	W/dU+rKeWQANl+mbT8TAIhmgnARHU63IKXS0zjlxdqYChATHiX0TKHtM1dcKl/Ei4VhjdDPNdbr
	+B4BJMT7nTOHoZ+2cvRudU4lUQBZWw0M26VxdxE/uSswLRz30v9VJfrSAgLR4+TpxzMy5zgwn5k
	qNSom+Hy7PWOaJKtlgPHnTdZ7ubuRsynT/cg8VmY8TOTOqNgvQTM80hkiNK6BybHjNxZ7jwNfMs
	U+qFjdyyjhpJSkfjfDVuk0M84dMk6xAv06xSN9y/7O+ly8w+UnQn6ogrVFyLhQlG/hl/vIaPZcD
	OLR6eUA==
X-Received: by 2002:a5d:5846:0:b0:3a5:7991:fd3 with SMTP id ffacd0b85a97d-3b495b94916mr2217847f8f.11.1751624745011;
        Fri, 04 Jul 2025 03:25:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECnxpY/j05u6/I6xCq4leYolGKDWTZ8k8uJQRmE44kdkts1pPfCbxB96EsSkR3GWRBi0mgpw==
X-Received: by 2002:a5d:5846:0:b0:3a5:7991:fd3 with SMTP id ffacd0b85a97d-3b495b94916mr2217787f8f.11.1751624744465;
        Fri, 04 Jul 2025 03:25:44 -0700 (PDT)
Received: from localhost (p200300d82f2c5500098823f9faa07232.dip0.t-ipconnect.de. [2003:d8:2f2c:5500:988:23f9:faa0:7232])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b47030ba14sm2117357f8f.6.2025.07.04.03.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 03:25:44 -0700 (PDT)
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
Subject: [PATCH v2 06/29] mm/zsmalloc: make PageZsmalloc() sticky until the page is freed
Date: Fri,  4 Jul 2025 12:25:00 +0200
Message-ID: <20250704102524.326966-7-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: fwpNlKDyI5-t-ufWVVyBQJ3TLLLotpM33ytx_g3aQz4_1751624745
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Let the page freeing code handle clearing the page type. Being able to
identify balloon pages until actually freed is a requirement for
upcoming movable_ops migration changes.

Acked-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Harry Yoo <harry.yoo@oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/zpdesc.h   | 5 -----
 mm/zsmalloc.c | 4 ++--
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index 5cb7e3de43952..5763f36039736 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -163,11 +163,6 @@ static inline void __zpdesc_set_zsmalloc(struct zpdesc *zpdesc)
 	__SetPageZsmalloc(zpdesc_page(zpdesc));
 }
 
-static inline void __zpdesc_clear_zsmalloc(struct zpdesc *zpdesc)
-{
-	__ClearPageZsmalloc(zpdesc_page(zpdesc));
-}
-
 static inline struct zone *zpdesc_zone(struct zpdesc *zpdesc)
 {
 	return page_zone(zpdesc_page(zpdesc));
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 7f1431f2be98f..626f09fb27138 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -244,6 +244,7 @@ static inline void free_zpdesc(struct zpdesc *zpdesc)
 {
 	struct page *page = zpdesc_page(zpdesc);
 
+	/* PageZsmalloc is sticky until the page is freed to the buddy. */
 	__free_page(page);
 }
 
@@ -880,7 +881,7 @@ static void reset_zpdesc(struct zpdesc *zpdesc)
 	ClearPagePrivate(page);
 	zpdesc->zspage = NULL;
 	zpdesc->next = NULL;
-	__ClearPageZsmalloc(page);
+	/* PageZsmalloc is sticky until the page is freed to the buddy. */
 }
 
 static int trylock_zspage(struct zspage *zspage)
@@ -1055,7 +1056,6 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 		if (!zpdesc) {
 			while (--i >= 0) {
 				zpdesc_dec_zone_page_state(zpdescs[i]);
-				__zpdesc_clear_zsmalloc(zpdescs[i]);
 				free_zpdesc(zpdescs[i]);
 			}
 			cache_free_zspage(pool, zspage);
-- 
2.49.0

