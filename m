Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B682F5494
	for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 17:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268439; cv=none; b=T47J6kf4/ErwnlUyuovk3QZT+8vmAvIiCMVvLFEw3Df7CKV4jn8pXfX9MmvyJquQEyuX9jdtgEtyugrNK79t3Z9hJRRqDG++EJcWvpWZNUKWbtF617eO7l2g84vO5AA6OKokmV6CuiYHn/HsYaV6HWF0kCvXyjnbqrdItvNfoAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268439; c=relaxed/simple;
	bh=qK/hSpqxPHXWhlFplYYMa5g7zmr2Q/EzGHQmEAB7ZSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=AGUAlViqPh+KaaySkQIJgLEA6xhe84VDHs7LXdi99e5bmA9t2xLGBzx6ajfNpTzWhrh2hqkG83K+ZQfsD/f5F1OYCMk+CouStoQCeFbN9PlkTV1leSP/HI2upOn/Cntjr3usvz4tEEb57J4IYE0MvY3VY3YaIeJ0WyD0tC7AxLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zr/JJfoD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zr/JJfoD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750268433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fkYbA0acVo3UX9Us91PPuYxLoMCXI95NEZ07wm0hikY=;
	b=Zr/JJfoD1OBAhj8YxglxfjiSZoOwl++rKOA43HZAKxqDtdEUPhJ+wln0wBc64jQAsCWOAE
	ne4GYXB5u91/lfyIfi083ZFk8vCsnbW4TBhNNem2akFWdw9yIE98OY8cGxjO2iDoRI0+oA
	gzPkQsRUyl4FUn3WkABahVccyTTNmAc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-PQBikiheOl2rASFOPrz49w-1; Wed, 18 Jun 2025 13:40:31 -0400
X-MC-Unique: PQBikiheOl2rASFOPrz49w-1
X-Mimecast-MFC-AGG-ID: PQBikiheOl2rASFOPrz49w_1750268430
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f55ea44dso2915771f8f.1
        for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 10:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750268430; x=1750873230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fkYbA0acVo3UX9Us91PPuYxLoMCXI95NEZ07wm0hikY=;
        b=neF5DO+VZTr4ch1Tz3/CwQoMCLyGgX2sgV2SnzZFaEoyxFvZQBQouZMFjAXONUiE7m
         R18HVHotPQk6NwrPHWLynGSOGS3MB2Xlw8n+rMoiE9FaoFTQ4s4K3B5r0mSC5l1HJcG0
         I83NJciUQRHr278HZzpfyQql2ZkDfKRz9Gmu+WmHL/0WNJ8qmbS+O8S5RSOIWH4TEpEz
         2XOmwOjoghh/fUEV9iFjarap0T6zoQPcCvPmLw2VYu4nRABVPIj/mRMLyzTvD1Tl1spC
         i+MJMpUKt7eAzMGUYvUaW8SHPPJspaMB/vLGqTzN41R9Jb5NqoNuUf2jy2OsyJThCFU3
         aW3w==
X-Forwarded-Encrypted: i=1; AJvYcCVq4+CyeAN7zuTqJ44kw9zk7fsbYgzyQgH8/o+0BSf6Q5ZVHAepsnZn2n9wx7tZKAhZtb2ObRSPOoGXfqPJSQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx2ahjT/5LxcumYg27PIdA3nM4ysmp7cMjAPFsjc41Dot2khkjT
	8+FCHweVy4V3HZGSBX/8k+d98cXfirxXm0E/8awCnBC/BPwtlgsydNQ33vlTaVcs51xSGCMvwXz
	AsgOIu/s0/TD3ZSHdioe0K5wxCFzHAk+si0XTQ6BUMmVDn6ClEmnqkabXQIPzc2FZHxnl
X-Gm-Gg: ASbGncv5Ey0O90MAYzs8z0SXLgYYQdbDv9uMrolXNDyms4WUBesw5DKRPGYCWpYKY2B
	wwzu+HW8MlqNQ4PanAQtAf9EJLgOzRjufCcMS7kQ05EHNUEilbBHTTQJCLs+5nRgB7agloSCTAv
	GN6mAM/UHChD2IpTudMKRw+Fim0AKJn5icPnQG5Hmc3Z1XCT2BViL7z9LM/6xD2F+fyyb3mBaL/
	OXFioG+9lGq2XFn7IeH9ca4YgvUb3Y5CIVAhsCZWLnwNKl9Nrc0Qb3FJdOVWy/0uydIiVpdAEUB
	wAyMeZMwk1JFOu2+cGCXNDd1hd6HmtBjcnnRXTWzd+HSKw5m5pJJ/b/hTUca68qnW2wjet6tI+C
	t11Vj1w==
X-Received: by 2002:a05:6000:71c:b0:3a4:dc93:1e87 with SMTP id ffacd0b85a97d-3a572367972mr13745202f8f.1.1750268430444;
        Wed, 18 Jun 2025 10:40:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzzxL/ng01qs/lSRwaNlZPiY9y2+iVmfz3gXJp3VGo7LunL2znQ2yg0q95yDx7nL6kngLoWg==
X-Received: by 2002:a05:6000:71c:b0:3a4:dc93:1e87 with SMTP id ffacd0b85a97d-3a572367972mr13745179f8f.1.1750268430076;
        Wed, 18 Jun 2025 10:40:30 -0700 (PDT)
Received: from localhost (p200300d82f2d2400405203b5fff94ed0.dip0.t-ipconnect.de. [2003:d8:2f2d:2400:4052:3b5:fff9:4ed0])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a568b62ba7sm17864640f8f.91.2025.06.18.10.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 10:40:29 -0700 (PDT)
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
Subject: [PATCH RFC 05/29] mm/balloon_compaction: make PageOffline sticky
Date: Wed, 18 Jun 2025 19:39:48 +0200
Message-ID: <20250618174014.1168640-6-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: TT61iXki3UIs_o1NwWI4kED34rVicNgpab0rE0T5lhU_1750268430
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Let the buddy handle clearing the type.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/balloon_compaction.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index b9f19da37b089..bfc6e50bd004b 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -140,7 +140,7 @@ static inline void balloon_page_finalize(struct page *page)
 		__ClearPageMovable(page);
 		set_page_private(page, 0);
 	}
-	__ClearPageOffline(page);
+	/* PageOffline is sticky until the page is freed to the buddy. */
 }
 
 /*
-- 
2.49.0

