Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50B22FCE05
	for <virtualization@lists.linux.dev>; Fri,  4 Jul 2025 10:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751624796; cv=none; b=U7JxkFHafZFJ4408doEFgFG7SfjydY//y4hAUo9Ek4CWUdoeDwqHpXaonWMAyoZS0xqXFalJXFKnwmbXEFeB7bnrZQG8Xrr4edWNpbWy6j2DFNNl7esvjwqsmVn7hwURCMqLmNGVKiugAeKphg9Aw6Dm2iWtLV75aPRCsRis0s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751624796; c=relaxed/simple;
	bh=pHyy8UC6aDtzrad/rUQe1SyqR3fae/2pllZmxoCrbEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=EZmq7E8PSYZdGCanzygJhH1Bi1Ljd1ATp/ZCG+WE+Oe+QQnDzqbvgzue9n2eipMjh2FKYC5YPk5aQRZ++gSCMmGpGmQfMhZZJtd6Xs03MnyL/Lds0iXGjj79IQpggoWmMCaOyrwQ2WcDVPumtXfpiugluPgIKuk6LU0mzVYpVl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HFvToW0M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HFvToW0M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751624793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pi83bTeEFwDlpM8pJuM4mqXwpOj3VH8gXnt6oQN+QH8=;
	b=HFvToW0MPVq/TI2AaVNDGTUiJ0gjBu8TcAk4BNMGoayamYKsuw9vdofxpggkv5JhZPGUmD
	pL4gGMuCBzKARWDd9pAEt872aPAkub2JU0/mv4wz4ZXO+dkp8igOBeRdYh2BAyrNe+m3hd
	xFPRuI0RKz+cH+Z0gQ2F0euVXmWI1rs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-xaSJmap_Oh6bDb4L9zxBKw-1; Fri, 04 Jul 2025 06:26:32 -0400
X-MC-Unique: xaSJmap_Oh6bDb4L9zxBKw-1
X-Mimecast-MFC-AGG-ID: xaSJmap_Oh6bDb4L9zxBKw_1751624792
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4fac7fa27so329000f8f.0
        for <virtualization@lists.linux.dev>; Fri, 04 Jul 2025 03:26:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751624791; x=1752229591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pi83bTeEFwDlpM8pJuM4mqXwpOj3VH8gXnt6oQN+QH8=;
        b=dpq6VU/gv6r+cdHXFHg10QQIpKewFs7XYeWuAU1GhPqZEbS+UB9uH7pysfQhh10qkX
         YksIp40MG5r7sMTGZztVERw3ZOjkACEuD7nMW84QLRpG/1D5nLrVNWFQnaM9pT9B76nd
         5EGmuq0TmHBap+cNAGt/Wzto4WZxPjvy6dd0h/S2pGhO1L5h9gmasa9H6rlAgVzUMeRJ
         I0r+Yrsgfu268xgtI0yYeYTd48S4lCksdfRMtVzmXmlw+lm5rlS0WSlxaRznevWiJJ5c
         xIlCPRE/IvDA2yhE2KA9KcLdEbGdpI9VgzbQnqvzKR+l1n6xEch9J/Qv0wRF8wwfvU8w
         ESxg==
X-Forwarded-Encrypted: i=1; AJvYcCVyR+MPZfDqb//KNfgPKKM97P4s4wzHrWI9gqh40HJgo7SbBTc+IGGI+7bQNAONrpfoL77G03do7YWqDG8OLQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yya4R5l4srGt/5QXbGXBs7QVTRLqoW3oOaxIoM5M+PW75Uwd7Sg
	Pc0pfasdm5/NFhlX2WnPdpRSzHKGe3xCE7MK9faCYJDwcu+Y5wci1ixqOTAsS4DLJT3eYoI1doB
	oGtZsc3WIiRB/emVvIuoe+6lD3BryNdQ4/LkdZApRWC7Rsg2TT2ZUbda9dmNwXQV02cNN
X-Gm-Gg: ASbGncv1YO3kxF14U0y4w1BzY/jJKJtFBfk0+mj91I8RoNzuP8a67//M29+BKVcLuMZ
	yAkIC2aoWxk5imAF3YeEzJyaJ2kJjPHfmcmIm54BHTq7Mc+3Df0gheptrtIRE+EQHY5gH0Fn48F
	Dz0dgp1sLt+JgyfvzwABE6kWMdLq3C/IWEXdoHrDJ8G2QsLf4DTk+K6wzAo3PCga5nSmsHMA9uc
	sg0/gM/Suak6uoTguZ+2Z85nGlaROREMY9c3K3J8rJ4Iz107z94mt3TQqWMyf1OJLFNckDUFRuR
	2ukQKOIs6xDmJ8ocJnWnTW/OHzwrV33kkPQ5N3vlTIO7HHHrcNIHRT2NgAg7v/bWj6k7C5Rbdsv
	yPQ1FaQ==
X-Received: by 2002:a05:6000:420f:b0:3a5:25e0:ab53 with SMTP id ffacd0b85a97d-3b497038f53mr1271107f8f.32.1751624791470;
        Fri, 04 Jul 2025 03:26:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrTbC9DKT0t3aMKhVtx8nltW/QfximYUsOEu1FNJGdEflOepjIkffBp71QlqU0uLEDVp5xtw==
X-Received: by 2002:a05:6000:420f:b0:3a5:25e0:ab53 with SMTP id ffacd0b85a97d-3b497038f53mr1271044f8f.32.1751624790899;
        Fri, 04 Jul 2025 03:26:30 -0700 (PDT)
Received: from localhost (p200300d82f2c5500098823f9faa07232.dip0.t-ipconnect.de. [2003:d8:2f2c:5500:988:23f9:faa0:7232])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b471b97732sm2167298f8f.59.2025.07.04.03.26.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 03:26:30 -0700 (PDT)
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
Subject: [PATCH v2 22/29] mm/page-flags: rename PAGE_MAPPING_MOVABLE to PAGE_MAPPING_ANON_KSM
Date: Fri,  4 Jul 2025 12:25:16 +0200
Message-ID: <20250704102524.326966-23-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: Rf3Tuv4L1Uu3IjH4ncpVIW6UxGnb76-9f-5OZSSVtC0_1751624792
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

KSM is the only remaining user, let's rename the flag. While at it,
adjust to remaining page -> folio in the doc.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/page-flags.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 8b0e5c7371e67..094c8605a879e 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -697,10 +697,10 @@ PAGEFLAG_FALSE(VmemmapSelfHosted, vmemmap_self_hosted)
  * folio->mapping points to its anon_vma, not to a struct address_space;
  * with the PAGE_MAPPING_ANON bit set to distinguish it.  See rmap.h.
  *
- * On an anonymous page in a VM_MERGEABLE area, if CONFIG_KSM is enabled,
- * the PAGE_MAPPING_MOVABLE bit may be set along with the PAGE_MAPPING_ANON
+ * On an anonymous folio in a VM_MERGEABLE area, if CONFIG_KSM is enabled,
+ * the PAGE_MAPPING_ANON_KSM bit may be set along with the PAGE_MAPPING_ANON
  * bit; and then folio->mapping points, not to an anon_vma, but to a private
- * structure which KSM associates with that merged page.  See ksm.h.
+ * structure which KSM associates with that merged folio.  See ksm.h.
  *
  * Please note that, confusingly, "folio_mapping" refers to the inode
  * address_space which maps the folio from disk; whereas "folio_mapped"
@@ -714,9 +714,9 @@ PAGEFLAG_FALSE(VmemmapSelfHosted, vmemmap_self_hosted)
  * See mm/slab.h.
  */
 #define PAGE_MAPPING_ANON	0x1
-#define PAGE_MAPPING_MOVABLE	0x2
-#define PAGE_MAPPING_KSM	(PAGE_MAPPING_ANON | PAGE_MAPPING_MOVABLE)
-#define PAGE_MAPPING_FLAGS	(PAGE_MAPPING_ANON | PAGE_MAPPING_MOVABLE)
+#define PAGE_MAPPING_ANON_KSM	0x2
+#define PAGE_MAPPING_KSM	(PAGE_MAPPING_ANON | PAGE_MAPPING_ANON_KSM)
+#define PAGE_MAPPING_FLAGS	(PAGE_MAPPING_ANON | PAGE_MAPPING_ANON_KSM)
 
 static __always_inline bool folio_mapping_flags(const struct folio *folio)
 {
-- 
2.49.0

