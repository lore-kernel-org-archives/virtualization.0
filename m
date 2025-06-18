Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5F1302CC0
	for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 17:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268482; cv=none; b=hYmYuCvQA5HN/UPf+UwoTNGQSu9FtbDVid1HPFQ9ei49EUPrVkkQqREDy/hqXH+TAuBxtxAahpAYQz5Pa4nDPCB0H3nkdiGslofk7iD56wyagN1MWcsSN2wghx6ybiTHRd8Ek0yiqdf+yNos8VK2CWkRJKY4a0UD4vdScMId4XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268482; c=relaxed/simple;
	bh=7MqWYtvNLDCeRHTl94GzHGrw7bPzHhaA6ax/7SHlO8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=USZD8unXeN9JIlr6/WNmmqVRhqCBwVPP4onVEgXnxxrIS/GuynYzjDbAWZRkb77yg9L7SCjvsX6+dtFRgboQmIwb/yV5u5VApSYUCauDn9oKW0Sax4tGfX34pUVIZQfRIBZc0PPhCZuGDXCZ85qM+ontLhhGqDOBiPJxwAY34xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eF5O9bf9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eF5O9bf9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750268479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HKAYn5W/PSf7oEyDpSl452LRf2zvea6hrq0MdbpucUo=;
	b=eF5O9bf97oMdEz6oad2soFM587eQVLjsrSTw0hc0TxWKIW8f6Qte7OnP1YMP45RpS+hxQs
	nEdKLKpT6Z7tFuEIRBlEwWABr2GaM3B5LXdbDD5c7dvrzYZIEReHWzQzVc9pA0OB5TW++J
	ImWG7NKHvo8AFom1JsbST+Sxxb9BVKE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-RD-ivrBHNqmsyCBkvhNwmg-1; Wed, 18 Jun 2025 13:41:18 -0400
X-MC-Unique: RD-ivrBHNqmsyCBkvhNwmg-1
X-Mimecast-MFC-AGG-ID: RD-ivrBHNqmsyCBkvhNwmg_1750268477
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-450d64026baso49047075e9.1
        for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 10:41:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750268477; x=1750873277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HKAYn5W/PSf7oEyDpSl452LRf2zvea6hrq0MdbpucUo=;
        b=TBZF0U1YWpUUHvgqItfcyt6uB1RBtCKCt2k4WvuCq2YDUC6hpdbOMdi+CKf6/eJJHH
         Xlq3Az/2wE/XVpx4MkXSObZgPx+IEnXirhy6aciOafiN827qiO+oOC86DtKfC6lPb5h6
         E9rbekKCx08BBK0BlnrcnYd9E1gChXgUupKwZUe8ULQBgqIy2F7z0TGWu02V/3MGx4sq
         plvNsmDGd7+8/8c6sKX+nEmk0rlXoSy0rgyfN4mPKcraq6BLCWP0gSpichgfP1ULpeXq
         MpIElbpRl2h4uKTWvQ4iO/k8nFMj9koOBpvHfyC1ZC2Ow23rNvJSS7cdwWdZ6tLdRmd8
         wZ4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjFy2m3dTEiOwEyokgsvLqUoXqEU5bMrXGxJWiNVz34slX3TOx6HGjGuXjOT690W41hmvsc79zKz5IUehEAQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzaR9vLTS+rl0xLTBk/6l+hL1/lgegHR9ys0MtA6IIY/GFmxkHw
	lAv7164dYkIJm9sJlcMlNpOn5Pl6eSRluvkeHv3H9VkBcdl745259xt2umw2tQLL5UEcaGr//o8
	yiV9iiDSV8Mg6Dw1wzokzgWvGfMf3KSc+NNYl2HCZ2Bh1AI6HI5lG7f8+BeISPyiPG0V6
X-Gm-Gg: ASbGncvpG4MdiGimEdgQR1uQ6r3Cv8FYV06QXpdlvXNJX3ADAGDSfWyPHHGzGY9Ule2
	JJpKXffcNGu/3sc/rReU8Zzem211Vl9nv8ObJzVJ/JCtURHFQ1yH4vBRNcmlTDTecPNEXieehpQ
	6lWyRru1eA39Z4PjH4nieNajpatNEWB2GoOCM6oRe1heyDiDUfVbYZRz+iLWwvucrcIitSq8HDk
	d7+1MpoUfPWxE8A8fQPbWPrREEKxp1NLT89JZHLtzxZT8F1J8Tc7Gzgm5WXOz3O19ni/n5nnK6Z
	iwxNMurbjwN71RWjhbSOwkpEdCYPvE8/e8/yVlgobbGUrttyla7g6tkHQ/ZmmaxhX4HXjQp9/ib
	QP7W8hg==
X-Received: by 2002:a05:600c:1c14:b0:43c:fceb:91a with SMTP id 5b1f17b1804b1-453430ececamr157094685e9.11.1750268477174;
        Wed, 18 Jun 2025 10:41:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENrfq9JZf2w4nH2VRe3EOokVKel4Rw1khN0dggc1dWhdYjdSzsol44AwGmQNvJE5b04zR6vw==
X-Received: by 2002:a05:600c:1c14:b0:43c:fceb:91a with SMTP id 5b1f17b1804b1-453430ececamr157093925e9.11.1750268476711;
        Wed, 18 Jun 2025 10:41:16 -0700 (PDT)
Received: from localhost (p200300d82f2d2400405203b5fff94ed0.dip0.t-ipconnect.de. [2003:d8:2f2d:2400:4052:3b5:fff9:4ed0])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a568b087a9sm17793395f8f.55.2025.06.18.10.41.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 10:41:16 -0700 (PDT)
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
Subject: [PATCH RFC 22/29] mm/page-flags: rename PAGE_MAPPING_MOVABLE to PAGE_MAPPING_ANON_KSM
Date: Wed, 18 Jun 2025 19:40:05 +0200
Message-ID: <20250618174014.1168640-23-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250618174014.1168640-1-david@redhat.com>
References: <20250618174014.1168640-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: A-xbDJNmhQmVO0Dum_aCLHpeRAxjVjVhfYIEFmALLz4_1750268477
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

KSM is the only remaining user, let's rename the flag. While at it,
adjust to remaining page -> folio in the doc.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/page-flags.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index aa48b05536bca..abed972e902e1 100644
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

