Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694CF2FCE38
	for <virtualization@lists.linux.dev>; Fri,  4 Jul 2025 10:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751624805; cv=none; b=i8sEyYFqgJKVXQM4+zlaD5CeqCAXzGigzQGxcdKEoJiv4C+Gck9G0wysIZyuTm1bbwJ16XCuu6zIMWs1qB1yStCChGm9tlcLianakSXWFNEsADeSMP+rLFFjb0DIlfLbEqT2GGhiH2a1QtVCpMoyI9kYoNbzgs9T+lXIl6R0ehA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751624805; c=relaxed/simple;
	bh=E7QNy7Hdv+Y8vIwxIlhZiDTu7KEk+npvDBgCx+4vSO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=bP3Cux1PW8sc88KmfLI0OpGyaF0kijgkF8yfd9VDFT+NqtAhk/EjIiaRznXGwvHs84U3grgPKPRTtZ0ioBDOTUiaGNHNsDRajuMPi3GJxUsA5Xdbu3h0YGkI7OsiFHYu1HBxgCMS4ARkd377UWsKtpbEiouDKY1zN0bp2Ffq8PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=StQkeTRE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="StQkeTRE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751624803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PJaNSOUY9l76maSUsyNVNOCD+/VPGSxzGfUbWAq4maw=;
	b=StQkeTRE3N4LEvla1d0EF/LCFIozRFvzVDmd8LBPrt6SXfOMLevRuRwFdWoXjTw04ergQE
	tglXSUiS3/O8Rv1fymZei3txDBsaYPvDSN2a0mu1+4HJmCfdMvAggzw/CTDxl3K31pIuZE
	Gu1lWbByDEkDxG+srwV6vzBW4J/WEds=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-hgPf85CIO1y0h5xgdyvMZg-1; Fri, 04 Jul 2025 06:26:41 -0400
X-MC-Unique: hgPf85CIO1y0h5xgdyvMZg-1
X-Mimecast-MFC-AGG-ID: hgPf85CIO1y0h5xgdyvMZg_1751624800
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-451ac1b43c4so4286405e9.0
        for <virtualization@lists.linux.dev>; Fri, 04 Jul 2025 03:26:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751624800; x=1752229600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJaNSOUY9l76maSUsyNVNOCD+/VPGSxzGfUbWAq4maw=;
        b=Ug1zI09CK+usmc9ObZv70B6ubMUW7KLMROgfYlyxAfGAm5Y6+00HaV0NpYKa1AV3XU
         fSRocbitXJmHTC47VHh7uOXOiM5GWRPoNQZkPVU9WRZh5Fr7o1Gc0hMqZJqSQPT5jJuD
         j4OI7qG6Ol9mv3pouStEXy8vS4xhwDqU+JmjNgcIiIe3opjf9JbrjBVoH9zKZIvsCccz
         uzaSPUp8IfWdL79dgWQslt8K74VxSCLRID9iEDne70C3JVu8I+pIkByHVr9AwqHIKP6C
         WDey2W7Tp//IOm8xGdPQMZvNzYYliinTyJjLUYUE+6+iO44mIY9aCOfxbwgYldktd8u9
         cy7w==
X-Forwarded-Encrypted: i=1; AJvYcCWXAoWzH4nw6EoSBCKLrQUJicrDnQsqjGagHUUkm2UijdWvhlvLyWIW79zGwCqufFjmDNPy3pAKsJeZroir5g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxQ26QZy/6B0y1hsNVoKob+AHHw2QPSH4ulyLYQUMAb33jcLbbF
	gcYNbQvpi7tdzLv5wOFsngn00tEOruviqoLP3f/GDh7/3DySbTznvNZ7Kp2livkOf5yQ0fjMs4m
	xUxzTRalYPtTM1Z6UtS/37LTV/7Y/EYRh2L9ZJXSQuPMpgCyVM9DDGf687+ikLmWA3o2g
X-Gm-Gg: ASbGnctbGMKs5XWpXCVA+FwsFd14ZKp57aemreNREWacr/gfkQ2BJqCCMfwobtcUPQv
	F7Vuc32lDy+Ye1IvuYBxK7SSt6cldajmvFFvhhT1auDiXpahkktQlv8aof1jPyvqQ1auaJGK1fG
	WxPrUugmxQj4dB6+Yu0ofpVAYhr7Qf2cRdM7hErYkHhTYOsA8ZS0IPv3rQhRai0A90EqOJXYqMZ
	Bvg3RvwetZCRy/MHAi8sWd/R01USv9/4kgEAiOBh/Gc2n/hqlV3FwHH1X3eJtxvqyTKmZF5DfaN
	WjZBs1bAtQr64lAE3R0Bf7oN9tbVTHUJKOlS/EJ2PONTvB1vj7dUGLX/kXHix5Jy+7wsIDOkOBn
	3KHWkRg==
X-Received: by 2002:a05:6000:24c1:b0:3a1:f564:cd9d with SMTP id ffacd0b85a97d-3b4964dbbcemr1548427f8f.36.1751624799775;
        Fri, 04 Jul 2025 03:26:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG//N9DaWJpqR05PkmLCvqepmh6sjEbIjzOMJ6H89vpgrAi3DitTSNnZ5FWKxlekTJwwx1oMQ==
X-Received: by 2002:a05:6000:24c1:b0:3a1:f564:cd9d with SMTP id ffacd0b85a97d-3b4964dbbcemr1548348f8f.36.1751624799228;
        Fri, 04 Jul 2025 03:26:39 -0700 (PDT)
Received: from localhost (p200300d82f2c5500098823f9faa07232.dip0.t-ipconnect.de. [2003:d8:2f2c:5500:988:23f9:faa0:7232])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-454b1628d6csm23008015e9.10.2025.07.04.03.26.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 03:26:38 -0700 (PDT)
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
Subject: [PATCH v2 25/29] mm: simplify folio_expected_ref_count()
Date: Fri,  4 Jul 2025 12:25:19 +0200
Message-ID: <20250704102524.326966-26-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: J1ygLTogYSPKpdnImtlxPnATeSq8iKLo1vUyZ0y2x9Q_1751624800
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
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ef40f68c1183d..805108d7bbc31 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2167,13 +2167,13 @@ static inline int folio_expected_ref_count(const struct folio *folio)
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

