Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8322F546B
	for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 17:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268433; cv=none; b=SRsallKatkBAos1xhWgo/wA+SlUluObkj869/IOFE/tNwUAWGZ6pWGx2nxVkEplgyzE1FfcK4gcalbBMh+Z45WyRhjFCEcdVBJok6jFF6iHyCuKJeoT9PGbLfIY81w8E4mQeWAaNb+vYuNlKzT1g9TvYYHCgkofPQLfKKlqqIdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268433; c=relaxed/simple;
	bh=LfUaIY7XKmkW22E2CA7zcjn2zCtCLb3wGZMadkbbvUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=cYRBpfVwcnyUsEMjZ9NVAv83ogDtxmPjMWhoTYoZvUPrykX5lCb3Cyim/+Pv5pw72oB9zUVjZcqZH3Lny6jNp4E+v2/Ib4K0uSQaN8mpEtGfxgFV3Mu9Sqg644MICPWU/uSUSu2Owbllr/0rUMVK8M0CgvROVl/NJZ4HULMrbxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A7zeA9na; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A7zeA9na"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750268422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ztkVXhL49uhBZn35+Dz91j/1BkEFGTeWr88qG2zBn1I=;
	b=A7zeA9nayFIPuyR+a2hQ0HDl/NMWD30aGpXQ5P49dghledM57aJrJR548gXJ8GBH/OVDxs
	uslNK1mqJNaRvGgA2CB6AO9Trz6BLlinoYglJSrLwmoizClZ3s+bgvyvA5JJq/S0c8F+Qm
	jGDruWHxEHivVIF94kcOuyu7+Ee2HEk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-uuBqEVPyNeWPOaw9gM7N5w-1; Wed, 18 Jun 2025 13:40:21 -0400
X-MC-Unique: uuBqEVPyNeWPOaw9gM7N5w-1
X-Mimecast-MFC-AGG-ID: uuBqEVPyNeWPOaw9gM7N5w_1750268420
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a56b3dee17so508810f8f.0
        for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 10:40:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750268420; x=1750873220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ztkVXhL49uhBZn35+Dz91j/1BkEFGTeWr88qG2zBn1I=;
        b=A2poC+vY/0Y/erLglodQrt7kYjuzzssfqJ+c1sFAx5LoC1MjuHj0gt6vWV/rQFA14G
         TRgE+1MiOWI3kZOaUH1+VnFYnVNxzs0bgg14IIdTGfOhGI6ixIyFLAjHtRiMnIbycOqe
         jhSx6IasJNCPGQIqUKDmQKfedN1M9SA6gJji9T4LrLdcQW+yx9FrYC5Dm3J9cr3GBDwS
         gec2GXwQ9dAKLzbXVwECsG7c9IqyXY1rqjZhZWPwLoV1iwh4er4J/dtQ/7tu2rCNY/tB
         RUuWjVRAqI+3ZRUX4VdW8p6+uNa9K+KKgfi+NGu+GKT3wOZRJtxKr0NA5kLBRMSh+Vav
         /O6A==
X-Forwarded-Encrypted: i=1; AJvYcCUKBYJVLik1Hj/k1cqKhA+mG60yb4IQRnQnUirHRPxI0b3rdFmnZe1BJLNU4H9nFSiCB1CHDdwZXO2Kbl07Xw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZgkFUZeFuq4bof9DqEXxC+1hpRkvwHhugnBx0IZKJEz3Wm1Bz
	yM3llNtHA6N1byV+I4PAB8eYi6mHPBv/L0tV1VEhS3nsT+MkMhVhC5W3vBD6YvPssOHNsfZWZAx
	1/iC585shpovBd/herlBd7iPBfcgIJvQH1L17qYuypEjeQnxLb5IHtaKg/c9TP6UpIh7U
X-Gm-Gg: ASbGncsD/kb/9oKcxV21BELWV0J/pMLtEBHaQVJ9/ngGCnPdh/Jh9XaCTGBHJbrqfrS
	1WPjaw5vnFymA9n4beLfvjG0J+yb4+dBbShN3fBeLJTIOQVieA/GaOdkf5zB8NOUDFn6aPhzBkA
	WI2Ff0Ss5DsftrJKFn2+uRoIXXWC0Q/IfEXWMwRXgbWOe6uO8+b4kcMBo3Vltg8diOkTp875Gct
	ZHoIMZkZR72Q3+37nms+pzAy7aqvxWuJv99Cs1HLn12k7j6LyBTq/Q/AJktH3bpBUkyLRL8mLnL
	YG4Dw3UN6amRCcIxzmScNFhz8tbf8r8Fo/t9ovHyeRlIpYXe0QYvPxKwAEvvCcuM0sveyaskE/z
	ulGj6cw==
X-Received: by 2002:a05:6000:22c1:b0:3a4:f7dd:6fad with SMTP id ffacd0b85a97d-3a6c96bde70mr478044f8f.14.1750268420148;
        Wed, 18 Jun 2025 10:40:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdKc/sogX7P8eUPuNrS35oj8SOpb+inlndXsECh3VUw/sMAlaRsKTNBWIAReSnT0M7eOt7jg==
X-Received: by 2002:a05:6000:22c1:b0:3a4:f7dd:6fad with SMTP id ffacd0b85a97d-3a6c96bde70mr477976f8f.14.1750268419626;
        Wed, 18 Jun 2025 10:40:19 -0700 (PDT)
Received: from localhost (p200300d82f2d2400405203b5fff94ed0.dip0.t-ipconnect.de. [2003:d8:2f2d:2400:4052:3b5:fff9:4ed0])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a568b0898fsm17901600f8f.54.2025.06.18.10.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 10:40:19 -0700 (PDT)
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
Subject: [PATCH RFC 01/29] mm/balloon_compaction: we cannot have isolated pages in the balloon list
Date: Wed, 18 Jun 2025 19:39:44 +0200
Message-ID: <20250618174014.1168640-2-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: -0X_-BVsCJ7pz3fWxo1WoNQ783iajPrxjBXVdkdOn_E_1750268420
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The core will set PG_isolated only after mops->isolate_page() was
called. In case of the balloon, that is where we will remove it from
the balloon list. So we cannot have isolated pages in the balloon list.

Let's drop this unnecessary check.

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

