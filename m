Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A372D2F9497
	for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 17:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268441; cv=none; b=pxMrSP51B02LftIbOUU5AuG9xY0MeZj5h7nODXSXNT4Vmxv8dHOgfr/QoVTZhXQ+u9ZyuYNQkl1eHOJO2Qk5lNmCZLe2xViJ1JdQ26ANn5upF+X5DA6nGRNkg2nyPsGq5v8eEIUvh0Z67qey8wRCsbLtk/XEMRTMzGG/nUvU1Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268441; c=relaxed/simple;
	bh=9PSofqRI4P1+E7gv4s7LsRbrQULLczAgLmwV7OUNB6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=a5ud440jeNJrTbMnkHsnizP6QAxe1a83J3JhKRdMWdsEv288zoX9Zw4Iiw+cjT9twoivE7R3cfNvn5Kj7KXnYsuaRDGpnSO1Dp7tyhVDYkHAeZ+5XJasuxY+L9sNptNt0qLst17vJw1cMBpzQGtR7xH6geTyyePLBS2mzvAJARY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VVyb9wFN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VVyb9wFN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750268435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=piFGbpStSQJy+mcXr4hbLewWyhEioJRgfJ7dmrDuxBM=;
	b=VVyb9wFND5FyCauso8iAM54xJh/hPxW1x3yygN/CuDhNf5wlW4dyn9nJzUP+6HMK0KeYTs
	Yq3fcfAz9MJIWsou6t68JmDDgGmKHy3NcmGFo4EOJjq2KCGsIo5PVX0UHx3eG+JjogZDXc
	dbupQXERQi37krOcS40y84W4PWU+WuU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-0-aTzI9aNAO6Z5i6En_J1g-1; Wed, 18 Jun 2025 13:40:34 -0400
X-MC-Unique: 0-aTzI9aNAO6Z5i6En_J1g-1
X-Mimecast-MFC-AGG-ID: 0-aTzI9aNAO6Z5i6En_J1g_1750268433
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-451dda846a0so56144455e9.2
        for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 10:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750268433; x=1750873233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=piFGbpStSQJy+mcXr4hbLewWyhEioJRgfJ7dmrDuxBM=;
        b=bqe8sSNXLSplJ7ssxpRynu0tmLwbFw9ZP7z3ANjqT2TQ2CIAOgNm/X2GoNDyoi5e6L
         jbrdr2FRtouqfywghEzoM7cgyYAaFe/MqauPdvPQmVbBXA7CHCDf+YOrNN9HXbgrHJzf
         bIa0HiVsVUNm4VG1ZlN36o6W3S+3EFWHA7KBrolf6t8RbFMloYGb1A+cO2VOT/BF1Pwk
         219epMwfXp489ZX+XxZ1jKn37srkKVXVvbTgZrrtRvYe+CeQOuorZ3k8Wi0AW6Kwb4Cm
         U9BShenLLorGj+ZoinyfF7g+7S9vMRv0sV5cY8XyLdo6cdY+EO58tw2z3HBjJ8fpLsJ2
         bRcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGiY+IMBTNc99v4m5zr7I18CcS2n86OprcwVU+ZOYkC22rGLNRqNIeZoAd81BxP/OvaJMLtFWYg9Gtpyjzdg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywkg0tjRsD7m7G7dSZZcmLaYCQ728xbJDiXGioGhotbe8cOmA1N
	DNa4tpswK+V7ynW+BJFPaNRcb+482YQieD3TSYroaaTVdmHeXXLMAFTG/g4HxjD4rwmSWvyRdYb
	h8NRJxrnA1R7q6wBnFurqH6UQj0yUhqqlmYrDG7CfyF6ty6RnsZS5YtzCpI+pDdSduzi2
X-Gm-Gg: ASbGncsYg8mzPQi3Z7auOezZNNUE8WaSX5PEhWD2+JRTrJda5JLTuN9XzxnXjDzTAq6
	sMuw6j3NZL31qogAkObW1uJuLU4GxdLAubdh161WdSMQveY2u+J8mXXogCxw+Q3W73h2GeIvr8f
	DCIBA6myK2Er8QjR1auRp0IagcSEBiPP6fewNQfdx36/9a+GRyzbaES4fYnHDGiTvKb6Rrwq6aZ
	Jg+BJW58UxRxg7oTOqyNgppB8dL9AaBjUJkyD3SzgGYfCECZ6w974I/O/Dmu+CO556Wm3+RGvGJ
	hMOrXU3jySEmdQVu4yXHRSwBrpI5AMc+jwLrHO4EjunBMTEXfN6PDE38K9G7zo4I25IJ/mVcg+i
	RFKZFKg==
X-Received: by 2002:a05:600c:8b26:b0:43d:878c:7c40 with SMTP id 5b1f17b1804b1-4533ca6635amr196393025e9.10.1750268433008;
        Wed, 18 Jun 2025 10:40:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPWAw9+UfLP1Ct5dqz9wzZx48CMnDwfNIf0E7YgKYn6BQsIliiNikQN1x74QYxh04+83mIbA==
X-Received: by 2002:a05:600c:8b26:b0:43d:878c:7c40 with SMTP id 5b1f17b1804b1-4533ca6635amr196392375e9.10.1750268432585;
        Wed, 18 Jun 2025 10:40:32 -0700 (PDT)
Received: from localhost (p200300d82f2d2400405203b5fff94ed0.dip0.t-ipconnect.de. [2003:d8:2f2d:2400:4052:3b5:fff9:4ed0])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4535e99d5bbsm3600465e9.36.2025.06.18.10.40.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 10:40:32 -0700 (PDT)
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
Subject: [PATCH RFC 06/29] mm/zsmalloc: make PageZsmalloc() sticky
Date: Wed, 18 Jun 2025 19:39:49 +0200
Message-ID: <20250618174014.1168640-7-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: WtbV-z9oCgy2hNxe2UsNSaDi7PUBUHIuDX_dmmwN8xY_1750268433
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Let the buddy handle clearing the type.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/zpdesc.h   | 5 -----
 mm/zsmalloc.c | 3 +--
 2 files changed, 1 insertion(+), 7 deletions(-)

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
index 7f1431f2be98f..f98747aed4330 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -880,7 +880,7 @@ static void reset_zpdesc(struct zpdesc *zpdesc)
 	ClearPagePrivate(page);
 	zpdesc->zspage = NULL;
 	zpdesc->next = NULL;
-	__ClearPageZsmalloc(page);
+	/* PageZsmalloc is sticky until the page is freed to the buddy. */
 }
 
 static int trylock_zspage(struct zspage *zspage)
@@ -1055,7 +1055,6 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 		if (!zpdesc) {
 			while (--i >= 0) {
 				zpdesc_dec_zone_page_state(zpdescs[i]);
-				__zpdesc_clear_zsmalloc(zpdescs[i]);
 				free_zpdesc(zpdescs[i]);
 			}
 			cache_free_zspage(pool, zspage);
-- 
2.49.0

