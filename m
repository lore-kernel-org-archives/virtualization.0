Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957DF2EE96F
	for <virtualization@lists.linux.dev>; Fri,  4 Jul 2025 10:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751624736; cv=none; b=dpWJjtfUjN2i4+gRV2/wFXZAupcdqAZx4R8QO4XjWL2MEzSEzZXGfmASwy/97udhfUuewD6jODpuG/wUKm/DzKfaM5stkUc9PjNMWWeivd62KU9kfMkRN7EpUw+iT8nbqt9+AohJa57eOmLC/cZJJnv9EoNJ4WRO/WRiWsmjxoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751624736; c=relaxed/simple;
	bh=N0i0mDmhVdZqrTyFYSoYTge/lbt5vfjL3ApU/H749m0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=BpoOYlRrls3eA4OiasbM6KmYf8KtiEOpf9pvTNnOgEDtWAE11tX181zstI25Fm93AE2KnXxStZH4KwZZTIcLV+vMyqtKhmNZqyLzAWPCqdRGbeLbTYMBCbCBM8jBdwThzOKdotga54u4gqRkAHHre4pnVViSioiQTMP4OUn60Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W9I2AH1D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W9I2AH1D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751624733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cQQqBmPuJGjYXvvpwjiHFMj2XowEg2vBjzCyliDZdkg=;
	b=W9I2AH1DmB69P6aO0V2ax0pD7KRClieubPkd3LPGB7ydNlcGx4txZcytkUxp2HS4plq8dz
	/YwWbis6BCmBPWLxKuAX1j1XgrIYbCwt49ILbTwosjKSe/6cW6BQk8KqvZipOXA/8KZot4
	X8FBizAn8lck00bvTtyJDexkefRxixw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-Y61qA1b8PTS3QjvBMT5qXw-1; Fri, 04 Jul 2025 06:25:32 -0400
X-MC-Unique: Y61qA1b8PTS3QjvBMT5qXw-1
X-Mimecast-MFC-AGG-ID: Y61qA1b8PTS3QjvBMT5qXw_1751624731
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45311704d22so4285085e9.2
        for <virtualization@lists.linux.dev>; Fri, 04 Jul 2025 03:25:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751624731; x=1752229531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cQQqBmPuJGjYXvvpwjiHFMj2XowEg2vBjzCyliDZdkg=;
        b=XhiJESCGB3b2YDG4qmuVPnyiyazpUYvZnjM1kZayAUz7kbD9LOdhKN0+OkhbXPhsHT
         /dCLjiDmWI6+RufXmumvBeUBu6DiJjHcBLjvdZ8dF+8Zn4DFpR3kVY19R3wz5gD8L27A
         yMekQvi1S0SBuuDb6pJIr+CAO/5EgK5CLobOSaAB8kcBy8OHVWyXZNNtJolXgIs5D+1G
         oLSljAiJpJ0/fcyDfB2BAbw2qm0tWYh2a5ja+AaBshMJ8J9Ol28PHDr+O+UwOA7RBpJt
         b9LFIm2wiyBuPuNM6cQ5p/X6ETLSInDp1ssj5Eh3kabTLeW5/ktigZADR0fXHnv2cbCm
         2Yqg==
X-Forwarded-Encrypted: i=1; AJvYcCX0a8QOZJJT3vuLl618olatIbFyhRXNNTc4D7/ooNKnJWfQEeHdLhh8s2vhX+9eSDBbGTR5lCI8ulLqegP0VA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyN4oMyrfPPw9kRYf3zTZpAr5ZSyDX/0nspRt65/T1FxPo3Q7hL
	3qbJhzxXErNPCqDQQ7QxHFUAe9oSA4Irotw2HUGQVJ1dZBW3sckzVfywadjN0455amm6fNQD2wx
	nc+rRUB8a4hVmTutdY3wwFqslQBKnoN4aX7uJz/lwOPFFbtK8LirvG7jChi0CFdiZseia
X-Gm-Gg: ASbGncs4WyTZIKCqtrkAsHn324k0PHASpvZZXc4MNRlmKBWjOfiM7drgfMB/IV1A6rJ
	yR3FZCQto+qSVggOnLEeoiDdJDuxEWTKB9jD+qqV1m3Bn7DXXu9LRDlfWVq3ZVXNjDt5sI9c11A
	LfyHTO1sq4iHSkjx8nWgchnykctxFPycvBXOJsi9CWjyz4cCc1bD+bVGKMSSCr1aK6YHZdcKBlD
	LiPf1uG8Q36V3HU3QuRyFmaSxQJ2ukX65KnhbmFnBfTm5QkylkrlVsBuUnD/pDTO4wVEla0zRe8
	ksVES3abD/r4Qb9f1B17JDuXwVhIs67DYf4XjiCEUkrs2Tt82AGwxoT+etLufpGKSryaueThVLp
	jgzQLkg==
X-Received: by 2002:a05:600c:1c19:b0:43c:f8fc:f697 with SMTP id 5b1f17b1804b1-454b4e74ba9mr16507715e9.9.1751624730964;
        Fri, 04 Jul 2025 03:25:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2JCKcFSESlucn/AkzEEQU5f9yWEwz5OrnoWVnvSvIPUgrXnOXbfSZDcsxaTgozbAMtqKAdQ==
X-Received: by 2002:a05:600c:1c19:b0:43c:f8fc:f697 with SMTP id 5b1f17b1804b1-454b4e74ba9mr16507075e9.9.1751624730349;
        Fri, 04 Jul 2025 03:25:30 -0700 (PDT)
Received: from localhost (p200300d82f2c5500098823f9faa07232.dip0.t-ipconnect.de. [2003:d8:2f2c:5500:988:23f9:faa0:7232])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-454a9989fcesm51185055e9.16.2025.07.04.03.25.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 03:25:29 -0700 (PDT)
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
Subject: [PATCH v2 01/29] mm/balloon_compaction: we cannot have isolated pages in the balloon list
Date: Fri,  4 Jul 2025 12:24:55 +0200
Message-ID: <20250704102524.326966-2-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: czKo6xohMt5dm8CVQ6jMfBL05jZ_W7NGTuWDTL9unLA_1751624731
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The core will set PG_isolated only after mops->isolate_page() was
called. In case of the balloon, that is where we will remove it from
the balloon list. So we cannot have isolated pages in the balloon list.

Let's drop this unnecessary check.

Acked-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/balloon_compaction.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index d3e00731e2628..fcb60233aa35d 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -94,12 +94,6 @@ size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
 		if (!trylock_page(page))
 			continue;
 
-		if (IS_ENABLED(CONFIG_BALLOON_COMPACTION) &&
-		    PageIsolated(page)) {
-			/* raced with isolation */
-			unlock_page(page);
-			continue;
-		}
 		balloon_page_delete(page);
 		__count_vm_event(BALLOON_DEFLATE);
 		list_add(&page->lru, pages);
-- 
2.49.0

