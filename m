Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2E9293B7F
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 13:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288492; cv=none; b=kWzQ9iJ2jjtOKjHtXKAOpa4RsTa2Ma6sNbNrETrJ7ZQXEyTNv/IAuhSqUxab1533q/hRHYamWMdixWm9jTBI0NST1o333ObSJIhfVYK4FOoK9agvxt+dERfo2jjh/in7jiK9kXu7D5Ns81rQF4CuIkpidSxQxXMTVcY4ri5O2HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288492; c=relaxed/simple;
	bh=dmz2lbFNKy/5bI6qe76v2+ePPpX7/2WN9a22IrkHZ0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=EgCI7ZaSIADaAzUdTHhwKTICxBFYt2MEXwmTdSZ+F7Sw8uxfsIyOoCrLiLJ/QA/7gQcqZXF7lTiWIOQ4To8b8tQfqbLvItJNDCFP21kbnPoD0qkZACTrFwFow+2yfot75Ht2R+mVnmPR9RojoQVl58H1aJRSbz7caZU5002xH8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KG+fKVZE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KG+fKVZE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751288489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1QasDl39udqF142inQM/Baaw9xGb/E/13xzKchOHRQc=;
	b=KG+fKVZEpMf5rvayl477QXc7Xu0eWMTzK9n9XYf9zme2iHEMxmRliBIliRW26nM4eNElBn
	37jzZMyvOgIZtfZ16J1qtwxYtQ4jb949EHQEzPqjyAFbkE2RazJMPSD6xsyFzYztGEYhgl
	utvu5Ud4PVpkD5K0HmglahdgQNP5qCg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-NO1aIrHtOf-HYgFzSHmPIw-1; Mon, 30 Jun 2025 09:01:27 -0400
X-MC-Unique: NO1aIrHtOf-HYgFzSHmPIw-1
X-Mimecast-MFC-AGG-ID: NO1aIrHtOf-HYgFzSHmPIw_1751288483
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-451ac1b43c4so21887855e9.0
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 06:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288483; x=1751893283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1QasDl39udqF142inQM/Baaw9xGb/E/13xzKchOHRQc=;
        b=joMj75tTmSr8RZTSYD/iuK2wCNdzBaln4vPd4kbs7qFx8U7Y+TlGoSoztuEiIKSq0c
         G2sW8PlGU1P+/nc23RrwYGdX5GRaIn8611MQKcsELv02/02knCFZ9WwvwcdaLyVt9iii
         CZG+oQXfdwkPIL+xyVhW8o8ESZRw5l5krvuch7xXjNazXv60y7DN2o3bKVbguC4hplwW
         +mRfhaD9MNesesuhZqOGA0DkFK1TGudoNmbgQrczcUWHkRRM6YrxjA2V8K5/Fp1za/fQ
         3ozKnFurqSjJCQSzytSrAp4zWvC5Yc6Tgb2z7rlNsO6ICDK+T/srAu7fPxREDWBZP4fP
         qM8A==
X-Forwarded-Encrypted: i=1; AJvYcCXG8QVny/XavGBYNhwdXQ9pMbsjtubHZoTpLFoSVFDG73cMZndPB9zB5eIUSYV49QJx3m6zVPm/j0j5SoOliQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzcYd7e239rWDVUwEGLiNu8gvm3YhzeZ8AW2ZUwAUjxWUo0FNAO
	yMwVzT4MIQN2YMQsAXydjS5x4q6SvSOxhSe1s5vLuM7ekhBGApoXD/7/rXi7EcMd0Mj1XAWov4W
	fu7XBhUwi8CBOOb4hBKeDeBSQIziZ6v7fCQgU9ijFa7C4cbJDT6krYG9l6u8nLEVTSHw+
X-Gm-Gg: ASbGncs/L72SS+lL/nxD40RDOW4NLQ/rAiYkNnK+jgpJhJwv5qtqq/UJDLWCsMInVef
	s0ZSUTdRrhl8j6sL0vf+2ppayTmteY2rKtE8RuOopTRQy5fidEwHe/N4H5EuI4rdbMRW2W0xdKb
	GtNt+xUgg6BabWckM+29ITR9EZcdAxbRfoVBJQ5C+ObsYxnu/bkZLuaEMp319zJVe8Tqkc1C3zd
	+WPSY3xVihau6dlpE7yfx/cHyhxZw+sXuxIibxmCAypVVmYXXXRk75mYesGEW0jhihgcZuwErb7
	E3MfpuHKLprA7UNbLizuLbgMXhvPZtVP+1HEfaxfbyyuTcAB71au7iFt7s8ozPyPaK/heLcOiEr
	RS8hfwIk=
X-Received: by 2002:a05:600c:8b6f:b0:43c:fe15:41dd with SMTP id 5b1f17b1804b1-4538f9b3107mr110835435e9.6.1751288481887;
        Mon, 30 Jun 2025 06:01:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBR/gPcUn8RUWOgibmcJHz2SRyFZ4ktYe9xvVAqHy7XBBioQHhn6lWeSN3C2mJi+xEdsRK1w==
X-Received: by 2002:a05:600c:8b6f:b0:43c:fe15:41dd with SMTP id 5b1f17b1804b1-4538f9b3107mr110833985e9.6.1751288480607;
        Mon, 30 Jun 2025 06:01:20 -0700 (PDT)
Received: from localhost (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-453823ad0fesm169286405e9.25.2025.06.30.06.01.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:01:20 -0700 (PDT)
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
Subject: [PATCH v1 23/29] mm/page-alloc: remove PageMappingFlags()
Date: Mon, 30 Jun 2025 15:00:04 +0200
Message-ID: <20250630130011.330477-24-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: peettqIvJXS3NKyFXMmnMCqG_4rWYVJmc-_zxG8j1dw_1751288483
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

We can now simply check for PageAnon() and remove PageMappingFlags().

... and while at it, use the folio instead and operate on
folio->mapping.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/page-flags.h | 5 -----
 mm/page_alloc.c            | 7 +++----
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index abed972e902e1..f539bd5e14200 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -723,11 +723,6 @@ static __always_inline bool folio_mapping_flags(const struct folio *folio)
 	return ((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS) != 0;
 }
 
-static __always_inline bool PageMappingFlags(const struct page *page)
-{
-	return ((unsigned long)page->mapping & PAGE_MAPPING_FLAGS) != 0;
-}
-
 static __always_inline bool folio_test_anon(const struct folio *folio)
 {
 	return ((unsigned long)folio->mapping & PAGE_MAPPING_ANON) != 0;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a134b9fa9520e..a0ebcc5f54bb2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1375,10 +1375,9 @@ __always_inline bool free_pages_prepare(struct page *page,
 			(page + i)->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
 		}
 	}
-	if (PageMappingFlags(page)) {
-		if (PageAnon(page))
-			mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
-		page->mapping = NULL;
+	if (folio_test_anon(folio)) {
+		mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
+		folio->mapping = NULL;
 	}
 	if (unlikely(page_has_type(page)))
 		page->page_type = UINT_MAX;
-- 
2.49.0

