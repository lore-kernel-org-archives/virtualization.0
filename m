Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAD12FC001
	for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 17:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268497; cv=none; b=oV7Dc0kDsvNNali1NvMU0K4yFdZ70X6X8Im1WNzphT6QvPmWCTeSW0RebhAtBiYqDo/yA3GefHGd8SnNdnXdQ/iaQGdns7s3fTMfWS1qVjIKJ7esw3RMSesyLZ7c0UvWgB3dDXaXNtnMH2RbkL2XdBdTXfEifehhd0Jh28Tkwes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268497; c=relaxed/simple;
	bh=qANw5s/Bw3QCvq7BlzvxZffSRQGWJpFueQvB/Dfqsvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=jqD5vqXwnP2xejBEw4FB+aUwEnnh4T35mhbPd90SLmO3W0DvO+7vuW9ADlnTF/fAJBIW58IdUJM/X2Al+Le3Wn/YDJUPOPDRULq6FPDMx5WlX02jNYN06Or3pFu85tYyZorv/Bw8pT4bNSgs95dgnFskcKpUGMlU00fe2XHeIxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=blULzw/Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="blULzw/Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750268493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OmfdwaP0f5XUY3WcVBI8N3swmSiQtYBlwUFmuX0ZYxw=;
	b=blULzw/YuzhtMaq/MzAOwHI00YuPbBMeXOUAO/2a0f/5vp8pl1Q6TleaTPJ9/clGwv+R7Q
	pFqwGFPrA+jlzbpDao+tFbtH/xg7RQKiZvwxNIi1knbbAdCCiWmd4WXyfm6ww56aWJiEqd
	SmGzMHmXebCRT3R8Dhaf6dG6oC9Lkeg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-oQts-OVxOBCyIb5ThtpVvw-1; Wed, 18 Jun 2025 13:41:32 -0400
X-MC-Unique: oQts-OVxOBCyIb5ThtpVvw-1
X-Mimecast-MFC-AGG-ID: oQts-OVxOBCyIb5ThtpVvw_1750268491
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4f7f1b932so4391475f8f.2
        for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 10:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750268491; x=1750873291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OmfdwaP0f5XUY3WcVBI8N3swmSiQtYBlwUFmuX0ZYxw=;
        b=VG4WJBLG+tsfwNlyAA4OAmvrA94mF66/mcrxATV1zhSGvVTHlF+k+VfQLGXIjQMYAH
         PsOdjHyP5nlCB4ZjJPvLkahb9slsDuwRMMCLNlFglHNLPpP6yE6B0xxcLvh9GOKHaHwd
         KG3f5So0uIE5QWnRtQC7AawzMgYPVO3IdvEnGspOkNv2H2gATNU/X4/dFsXNwYfaAn0H
         fSMjRPUK8+jR7z1scb7EJdjlb5I16L+ocbXOjaORgaryUByDaGghWSRJPHGElp1gul0e
         aVByRJr8uYOQw3N9pZnfPZMiVt6nsTa4EtY123JpMMVWKk0b30G5jFj3L4fOec3vG8lr
         zs/g==
X-Forwarded-Encrypted: i=1; AJvYcCWHqnfRjcABVUj75Hn9zsXKfUY/0Nl7ZkfTT8w0jZMUKDitM0fVP5sWaYpxfDfVfzjR1lDrgf7dcGIpP1cc4w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx9VfPIp+oijJLE5HmIMJBrML+7S43sYjApX0SpDOvoegB7/Sip
	0hQEfY2coBqrgPQtqWR1Drps55XocPVdsJG64Eu+CeLvNFg0Sj3HtEDfyOtl+dIyv+LaoVpSUAP
	yQ8Y3T7zfigZUNLuVxbnRF9DHbChMjHDjR4RVTsxikeSNDYv0+xPQ4Jc050Fsb+bihgAC
X-Gm-Gg: ASbGnctZ0Ma2fEDFMr2p6ViYCfM45zu28unopXzba2UeBFCYBTbS+lO08DZQWkUUgHN
	i8Tw5VpfPLziuQ6GBvw4mred2imgVx8/hIGaf3nOtNRw2BCwstFLgx2HvDYQyBQNKqbOYcOVcNY
	EC0Epryi4+9nObzwCx9T4v/FAIBPGOutKldy475LTOLG45wtf4wy5jOK7Bomnqs31eAjAsHGaHj
	FB7lqljHwAQZbygPipjIjdgqZTSJdqxCb6uNCiGtjehRoYXr3Gx3OCRU+HRSS7/xcr6q9lpF5sD
	JFOX4OUlHjKWAn/9WHQqQ1/E0mQgje4rgXLszA1PcFlQ0Ad3ietkKISdBb5eCocNy5bjEKHali5
	8o+swng==
X-Received: by 2002:a05:6000:178b:b0:3a5:21c8:af31 with SMTP id ffacd0b85a97d-3a5723721bdmr15240242f8f.16.1750268490830;
        Wed, 18 Jun 2025 10:41:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAZhpZh4slqbXf6Y+7KOO1SPenqI87LsZpqVnArN4AUioCPUgU259IOTbkkNjhv6BPhqHLFQ==
X-Received: by 2002:a05:6000:178b:b0:3a5:21c8:af31 with SMTP id ffacd0b85a97d-3a5723721bdmr15240182f8f.16.1750268490320;
        Wed, 18 Jun 2025 10:41:30 -0700 (PDT)
Received: from localhost (p200300d82f2d2400405203b5fff94ed0.dip0.t-ipconnect.de. [2003:d8:2f2d:2400:4052:3b5:fff9:4ed0])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a568b2f80asm17518051f8f.78.2025.06.18.10.41.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 10:41:29 -0700 (PDT)
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
Subject: [PATCH RFC 27/29] docs/mm: convert from "Non-LRU page migration" to "movable_ops page migration"
Date: Wed, 18 Jun 2025 19:40:10 +0200
Message-ID: <20250618174014.1168640-28-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: nw9Qlt4xZ44uVTDFrIPXd9P7u9dYxWLRzbJmCh3fDhc_1750268491
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Let's bring the docs up-to-date.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 Documentation/mm/page_migration.rst | 39 ++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/Documentation/mm/page_migration.rst b/Documentation/mm/page_migration.rst
index 519b35a4caf5b..a448e95e0a98e 100644
--- a/Documentation/mm/page_migration.rst
+++ b/Documentation/mm/page_migration.rst
@@ -146,18 +146,33 @@ Steps:
 18. The new page is moved to the LRU and can be scanned by the swapper,
     etc. again.
 
-Non-LRU page migration
-======================
-
-Although migration originally aimed for reducing the latency of memory
-accesses for NUMA, compaction also uses migration to create high-order
-pages.  For compaction purposes, it is also useful to be able to move
-non-LRU pages, such as zsmalloc and virtio-balloon pages.
-
-If a driver wants to make its pages movable, it should define a struct
-movable_operations.  It then needs to call __SetPageMovable() on each
-page that it may be able to move.  This uses the ``page->mapping`` field,
-so this field is not available for the driver to use for other purposes.
+movable_ops page migration
+==========================
+
+Selected typed, non-folio pages (e.g., pages inflated in a memory balloon,
+zsmalloc pages) can be migrated using the movable_ops migration framework.
+
+The "struct movable_operations" provide callbacks specific to a page type
+for isolating, migrating and un-isolating (putback) these pages.
+
+Once a page is indicated as having movable_ops, that condition must not
+change until the page was freed back to the buddy. This includes not
+changing/clearing the page type and not changing/clearing the
+PG_movable_ops page flag.
+
+Arbitrary drivers cannot currently make use of this framework, as it
+requires:
+
+(a) a page type
+(b) indicating them as possibly having movable_ops in page_has_movable_ops()
+    based on the page type
+(c) returning the movable_ops from page_has_movable_ops() based on the page
+    type
+(d) not reusing the PG_movable_ops and PG_movable_ops_isolated page flags
+    for other purposes
+
+For example, balloon drivers can make use of this framework through the
+balloon-compaction framework residing in the core kernel.
 
 Monitoring Migration
 =====================
-- 
2.49.0

