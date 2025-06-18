Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE02D305528
	for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 17:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268499; cv=none; b=FA4cRXcicDFFGwTqNMmqOTiRyV/xKA6yNdYXFTO775Doltodj6G1NNyx5B08xvP/vFlGCGvImD4ZYcZqenFZ8LuWoNzxFTkayGYVlaapRQdC24ETXbeyf/8csA+4lfnfShysGSrTkM/OZldRaDc3CqZ4azTv1TL00pKwa/UavuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268499; c=relaxed/simple;
	bh=xmAX6FaG7PwzByxdVNWIboeTPGW5tjq2c62uEFet5m4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=sHDKxGlcmPHGypwNSCzLebo02yYhvJBsx0+GDPQ3wQ8DgAL2bh7klNwgOIi0wXE88gJiOPEFqzDgqtx6U5+VWcNOqlk5W7fdBQqPJOq4ff06keK401fq41Km3wxZuv4ghLdAva/X+aRP8XKJDOdMSz4pbl+dave+Rh1JR6GPPgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UWfD8hTU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UWfD8hTU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750268496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EpLhIwgxSmOTAUjcHZTQRVGXB1xFFa6Mgym/mVDU2pw=;
	b=UWfD8hTUsa0oM0FL6Hf4Y7TQHmJL54mykDcfurG0ecQ/jvfv5N3FS+PIpn8400yu4wYTIU
	j1Txo6wmxQ9MEQ4/b0VUtnW7GirM1ufxmIPRPUGzeqM42qdDp8iMgec7QSOblQ2QGygPHT
	WIyyQIZYal/GaktRmu0cUshAFG60HHE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-8sy2pylrNL6bF55OhxBF1A-1; Wed, 18 Jun 2025 13:41:34 -0400
X-MC-Unique: 8sy2pylrNL6bF55OhxBF1A-1
X-Mimecast-MFC-AGG-ID: 8sy2pylrNL6bF55OhxBF1A_1750268493
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a50816cc58so2470563f8f.3
        for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 10:41:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750268493; x=1750873293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EpLhIwgxSmOTAUjcHZTQRVGXB1xFFa6Mgym/mVDU2pw=;
        b=km86qY4V9KUds2PQiTCZz0geDiXrDBlcmAZVgmtApgn6GcvOtpQ3WPVQCsVMOF3jaG
         UOELAJebZDaJ0IBuHh2YoJJvQWpIr6hjN/3G90F1ggHVC2dXxRlKoSHaSY7Y6ij2k5WL
         uUJ9UhMIJbkmEwfHutM3IKub6CbQekzfYJUYUO6KRiChvDapUrKYvb7/UQgJyIBNOD91
         sszcPiX3VrSe9rfYBYk9KjP7nV1ig7hymo9/om0MB7VzJ/tVleC1kqvyYj27QGj6Zb1r
         42VD+h3I1MjJEbNRtAPJL4/y/InZqNQb0jxXjjnnSGyCHPJnkvcHtkdRHMcGLXPzOY5E
         3Gmw==
X-Forwarded-Encrypted: i=1; AJvYcCWLUV3u/It8YWB9M88B4uo07gqqrgBPclf38YDphbN082ARoM+7DpCfciHNeFr+TDYzZcuDxThWrFJY/sIFTw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxmF+lVyen5OmVBCAPyVHjuJzzHABXOyDGqBo3aeFlEbho9jj/f
	726O9vnKCqgomglVNvIOE1QlQ2yjcfjMoz4ZGEqfsZQ3VdWtk5bQiZxzN73JRgcZ328urpymrTL
	7NHbtF9XC7HzpN55nsyxIx6tCMbJYbUCKFlbAdUfmd3L5A+Kk9xJ3TG59u0GtRgqrkWNX
X-Gm-Gg: ASbGncsvTbBEWs23x4aaBSr1oHuVRBa5S02AMyf7jk1vz0O8+BAqP8iZ+C6bNoMpE+G
	zlh5BtZBV0Z9+3ssxqqBDNsgfCnvJnmBSq1B02XCkUMuX0J+7dFE6CZEGwfAl+YjrwNbAOIBk3b
	RT4qoSHk3oaygPO4pQB0F+7lkgMoPsWD/OqhLpgDpVQUTspWSamEwIwpsKBBpNs8UxAohJbRhzu
	FnUpOgwIfxZHPAKcxJAbNusWRT0YhtFYEi5Bgv4a9mSeeo6WjmYQJfGn4MEDxqaiQLlyod646Wd
	xT6Qer+9ick/gYlHbGHXzt4jD0gG9AmcSRAF7d+VStIKue+xrtE7R9oYERCq+eQTUK4VnxUNpDm
	gB2rUkA==
X-Received: by 2002:a05:6000:708:b0:3a5:5278:e635 with SMTP id ffacd0b85a97d-3a572367577mr14018450f8f.3.1750268493467;
        Wed, 18 Jun 2025 10:41:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIdYJ4byKGNqSckw7stdQWmP9a+mk+8zzlUOQQiezgX3FefY2T8iN/DegCcyfhV4fwKQhI6A==
X-Received: by 2002:a05:6000:708:b0:3a5:5278:e635 with SMTP id ffacd0b85a97d-3a572367577mr14018429f8f.3.1750268493058;
        Wed, 18 Jun 2025 10:41:33 -0700 (PDT)
Received: from localhost (p200300d82f2d2400405203b5fff94ed0.dip0.t-ipconnect.de. [2003:d8:2f2d:2400:4052:3b5:fff9:4ed0])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a568b5bfefsm17100889f8f.88.2025.06.18.10.41.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 10:41:32 -0700 (PDT)
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
Subject: [PATCH RFC 28/29] mm/balloon_compaction: "movable_ops" doc updates
Date: Wed, 18 Jun 2025 19:40:11 +0200
Message-ID: <20250618174014.1168640-29-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: CQsMH4CaIIQwP0VoLNJKrxE1qWh6wpquYrZ173vMtF4_1750268493
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Let's bring the docs up-to-date. Setting PG_movable_ops + page->private
very likely still requires to be performed under documented locks:
it's complicated.

We will rework this in the future, as we will try avoiding using the
page lock.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/balloon_compaction.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index b222b0737c466..2fecfead91d26 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -4,12 +4,13 @@
  *
  * Common interface definitions for making balloon pages movable by compaction.
  *
- * Balloon page migration makes use of the general non-lru movable page
+ * Balloon page migration makes use of the general "movable_ops page migration"
  * feature.
  *
  * page->private is used to reference the responsible balloon device.
- * page->mapping is used in context of non-lru page migration to reference
- * the address space operations for page isolation/migration/compaction.
+ * That these pages have movable_ops, and which movable_ops apply,
+ * is derived from the page type (PageOffline()) combined with the
+ * PG_movable_ops flag (PageMovableOps()).
  *
  * As the page isolation scanning step a compaction thread does is a lockless
  * procedure (from a page standpoint), it might bring some racy situations while
@@ -17,12 +18,10 @@
  * and safely perform balloon's page compaction and migration we must, always,
  * ensure following these simple rules:
  *
- *   i. when updating a balloon's page ->mapping element, strictly do it under
- *      the following lock order, independently of the far superior
- *      locking scheme (lru_lock, balloon_lock):
+ *   i. Setting the PG_movable_ops flag and page->private with the following
+ *	lock order
  *	    +-page_lock(page);
  *	      +--spin_lock_irq(&b_dev_info->pages_lock);
- *	            ... page->mapping updates here ...
  *
  *  ii. isolation or dequeueing procedure must remove the page from balloon
  *      device page list under b_dev_info->pages_lock.
-- 
2.49.0

