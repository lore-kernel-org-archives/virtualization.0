Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027042FD89E
	for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 17:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268471; cv=none; b=tlA8k99i1+vM90f5EyV+ySnCkdvVDzSXAJJt2paXCXqLfr4t9tvfDuG/pzajvVAtqfc1Si/BPB2MyC8617X6whPbvYMYmjVuBsEsWPbpfIPtO7GyLxHZSBeLBqdpnldLO1H+Hfu+bvZ+DD4ttiOnGTsPjBUo9X2pN7dJQHwTR8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268471; c=relaxed/simple;
	bh=0evh8/P+NmJQ1hFz8tzRv5gkRTQcHLHrxi5Nv+XvqCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=g/XPstc4pE7GjJNTuWuAPzc5dtwljR/pcJHz3GRwcCRBlGxqJuTh6lCfdK1HS7Y3oRz4fsNf4gguel2LH6fB5ED6oQYAQd8GNx6QwpXZcUfwGvN5z4ndQQVTVQq/O/oVAPO9FoavxTknzIzBgwUkdVuQAZGsOnbnHhq3iQ/BgNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=II9hbIov; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="II9hbIov"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750268466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iZh2vT8OhFDnKR2hfytPb7VOtq98Q1N4tcWXpFSfOT0=;
	b=II9hbIovoQq76o2JZs4OxlufQTnHQCPLYzRGuClBabMq5fEGNyus/z0Fpu9BToT+Q/ZHPS
	HuqijzyFiVo71x20X270P/2sFj5gEKBmNwGa/T/mrjuzO+8Ll8xObCZlnq7vTcIljjxPhE
	sLHF9UMhGzKJkt/LVe49zxR40WZ77eU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-KP1GH8jYPASxE7RPmZO55g-1; Wed, 18 Jun 2025 13:41:05 -0400
X-MC-Unique: KP1GH8jYPASxE7RPmZO55g-1
X-Mimecast-MFC-AGG-ID: KP1GH8jYPASxE7RPmZO55g_1750268463
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a5780e8137so531013f8f.1
        for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 10:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750268463; x=1750873263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iZh2vT8OhFDnKR2hfytPb7VOtq98Q1N4tcWXpFSfOT0=;
        b=rRyWWqgD/fFq7WvTQW2IVxjjmdxZaIMhbh/FWYZbgWs6KcUAmAqhpfSdY5u2mYto7c
         BErU7ItHeqpa5H6EqFrM8YNyX1qU3dB405T1y3kQmzZWSs7EGuczGw6B4B1cgI3JdRBc
         wZaCQDrFIn3+8wrrRyc428haxpFVPsQItVOp1hDlo3Mu83GAW/EHHuBNsOoMe5AJBnfY
         Ezvc8XUn4C/W/WAjx0VD1MWngIcnGEaYPa+fqcRTmt/qDIZLyVRp0UVNeGAsCeIEhGen
         /xwwa1f+czULI4EuBpd/2nOlQmrwC8wzeyVC6IaUYJzhD+rQsyWiRwA8Y8HcCkih7ezu
         jBOg==
X-Forwarded-Encrypted: i=1; AJvYcCVnjP47yfj4f15/of7AXyxQ5ykEZZ0pNxsiDdKLSAATnpbyetW7FPhQjpfOrMpf3yBcvWyDRqNBcstm5aIi9g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwmwLYUOhgsfFmUTolBzhiLnJrj/2ECCUbPZ8xY/FgiiIAsEd0c
	2tl79pmRizOuSj/r1W0OK9MXPLXRVWvsJWhAdKUU0p4s/bEbGdlCHwoKgkkk7o/sPgboOtsOkFA
	GYX5cDRfCl+wdoT1Xwhq/FGxPaGiu1a/aMEe7aR5uJvGTPQQ5yjfKOejl2zAhXpKy2+16
X-Gm-Gg: ASbGncuhx9wX/0MLYUEU+MuDR1loSVBZjmP23vh7iwIKp3+TUOHhmUWUL+H3PYDzVEG
	iQcFlu6j2h16zPOUk42y0gf/Nq3PJMlYJwwcZFuttIrJo7QvRnCJgQkFNWtofvZ6Na2is6Wku7R
	a9r53Momv4wTvbCMZ54/Ybv2OZGNo69RVIB6QDta/eFkWU3HDBb8U67fkeHCZ/QbwJ0Prg7fnC9
	dAl6leUNA1V4d6o7SEQdjSTPMWgiXfTizSa8ayfXZRqxZLszQOcsYa6KUNP2cDDuITrh8hp1MEM
	cdXLSLXQLo5tgBN30hqd0UXzHGKD+Cj2U7wKmQao+WXNHcDa7Hdg8L6r18ixHaUK7FW6WGqPQ5l
	mUpw3BQ==
X-Received: by 2002:a05:6000:2a04:b0:3a4:e1f5:41f4 with SMTP id ffacd0b85a97d-3a6c971ce8dmr252805f8f.17.1750268462965;
        Wed, 18 Jun 2025 10:41:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIfeWEl0T3CJLW2Q374pwGp0+w6+6OG/MMLaU0GvL+YMoweLR1hXiYpIsPjINzwYBpzh5jeg==
X-Received: by 2002:a05:6000:2a04:b0:3a4:e1f5:41f4 with SMTP id ffacd0b85a97d-3a6c971ce8dmr252776f8f.17.1750268462550;
        Wed, 18 Jun 2025 10:41:02 -0700 (PDT)
Received: from localhost (p200300d82f2d2400405203b5fff94ed0.dip0.t-ipconnect.de. [2003:d8:2f2d:2400:4052:3b5:fff9:4ed0])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-453596df276sm20306265e9.0.2025.06.18.10.41.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 10:41:02 -0700 (PDT)
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
Subject: [PATCH RFC 17/29] mm/page_isolation: drop __folio_test_movable() check for large folios
Date: Wed, 18 Jun 2025 19:40:00 +0200
Message-ID: <20250618174014.1168640-18-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: J28aqFKeu3GRdLzAYS-ev2jguBWI52KAW1c9XM4lMm4_1750268463
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Currently, we only support migration of individual non-folio pages, so
we can not run into that.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_isolation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index b97b965b3ed01..f72b6cd38b958 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -92,7 +92,7 @@ static struct page *has_unmovable_pages(unsigned long start_pfn, unsigned long e
 				h = size_to_hstate(folio_size(folio));
 				if (h && !hugepage_migration_supported(h))
 					return page;
-			} else if (!folio_test_lru(folio) && !__folio_test_movable(folio)) {
+			} else if (!folio_test_lru(folio)) {
 				return page;
 			}
 
-- 
2.49.0

