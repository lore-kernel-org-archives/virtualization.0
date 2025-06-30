Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BB628B7C6
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 13:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288434; cv=none; b=Wq4ySqxI55X/au0n0YZ5Ue78pavMsTFFe6i43AlGlsRog6NFP1RNlcnp5I5XuDBf1Cv8rHdFVspoMz/ohvxYZw6iwEPKpBlBLhBYexvIxAz51wrHmlQwuEuPBcfKdwXKW1cMWnwajDcJqZjFPATQ1zo6aIm2MJW86Sk/VhriStE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288434; c=relaxed/simple;
	bh=4MxWzYVQT6MaRWyD8DaQIwXKPr34x2kzXAmctRW17zM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=p6G2KuTQDLK8kLjhmBFzzTK5VherS04kwWQp2LblEz9K/p6Q8lw0IjV+b6WBWoWsbSkC6kdhlVb8CGDibgMaNWL+/olouVatm8D0V7+VG/WeFnTuhNBNoriPcQ+iTJPBPCvshx87F3U4Kbn3zZlS2rD/H1vU6agrzYeH2/fsfc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IccAVx8H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IccAVx8H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751288431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zonaY4DxD0y8MNMLsQ+Z7vSDV1xV1t770zE0DCe01j4=;
	b=IccAVx8Hvd7lPQAssut5bBH1P6N9RTbX9YXmF0zfqgkrtCieY0UzCa4pzU+9T/mBsen9Jq
	u0UHKd4WXiy1iJFxYXG/AMd0BwyyydtUxISu5GWApTSTqHYoLL0jtej4zCWxXwobjbX+uP
	AkanK8lbc5DnjpojqpLNNCWA4ggTCog=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-F_Grli1aOgOwwnRC8K_WZQ-1; Mon, 30 Jun 2025 09:00:30 -0400
X-MC-Unique: F_Grli1aOgOwwnRC8K_WZQ-1
X-Mimecast-MFC-AGG-ID: F_Grli1aOgOwwnRC8K_WZQ_1751288429
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45311704d1fso12780475e9.1
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 06:00:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288429; x=1751893229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zonaY4DxD0y8MNMLsQ+Z7vSDV1xV1t770zE0DCe01j4=;
        b=RL/aQKsk/esgcPx6Pk0Bjb+nLwimr8BmI0Qn/sKO5IUx5oIDtvLNzS5y/8HOMe+/yT
         eQYGHEx2vevcZeCbKw5AaNZdGVPaLskVC+K2vx1hca2tpA6DrapoiVyZkMVSr1ass7BY
         MRJfOHCza98SmfhJPIAN0fRagploIfLq3+bXsdkVMmZ9Xn6zMdYA5mSLfHrjJT5Eq9G2
         T3N6QiNA0g95hrndHSIOtwqp/IHkGkl15cdFEtsQeG6oTHjpY0CUxJcd6zL1/qwxc00d
         +JA63743ptrS1LAG3odRjbKgxcuLCGCKEHWlJK/7Z3LqMabrVmD0b45tyK3TfRjPsQo7
         wiHw==
X-Forwarded-Encrypted: i=1; AJvYcCVsN7LTQ6uG40BsJtWbxfJ14+MeQZ1DexOEQoQCLUYG4r8xlp6/r7QQNcziHwZP2NSntyDMpVbdChofF+HIMQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxWgNWCXaOY9KGIG+P/V9ZTCgcOe4VUUQsurSW/WGwdKjK7mo44
	0gcTUHWHdXK10RgD97hZ+WYfJXHyZonlZVjDygvSCJjIZg5lSLa0TsYoNM2oGvCEsivUaXRtS9z
	FeOzg0imBXGI5Llhw3REhF5dVj1ADLd1gX8TVD8NlAGMGl7NKYWwKjEeAeUn8vwzBGvM1
X-Gm-Gg: ASbGnctF93QjRQ63fOdcc60WXHh0otnKTOhDhfDfaWvpyFsHCgyuiiwvsaA5iuex+DE
	Us231kgJno5pSodGGUdsLdJoKqUDCHhdXDvac7lRyITdiBs3Yt5dUxDpiccfimBPrDGLoyB03ZU
	p2X7KS4a2X5oBZk63CY8zHgfrYvXvXLtVtAQAR7fqRRjHexU5qKmYdBsuWBGfga12arQIzoXf6x
	iwm0GAJGUvCbcmSYCGghCVLl8A+pgxdMXuLxYI8qM6kmxO9W9zAzFd+mRAj4ObYAORIRF5mo8eM
	Dk/T27T64TwaX3eUEG45sRMjvqWA+QAVO69j+KwukEJglNCxQNLnQ1SPX82PoKH0O6nnL5iPiHz
	e23GFGts=
X-Received: by 2002:a05:600c:3b8e:b0:43c:f513:9591 with SMTP id 5b1f17b1804b1-453913c5a63mr120766715e9.14.1751288428785;
        Mon, 30 Jun 2025 06:00:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQsOsTnGBejCVgyOLl0Qh2EVLJQ4G+kbMgNeqpJuJaGM9Kh9Xe41tPUK3+55dbuJ7ci0FJ3Q==
X-Received: by 2002:a05:600c:3b8e:b0:43c:f513:9591 with SMTP id 5b1f17b1804b1-453913c5a63mr120766035e9.14.1751288428255;
        Mon, 30 Jun 2025 06:00:28 -0700 (PDT)
Received: from localhost (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-453823ad0fesm169262535e9.25.2025.06.30.06.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:00:27 -0700 (PDT)
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
Subject: [PATCH v1 05/29] mm/balloon_compaction: make PageOffline sticky until the page is freed
Date: Mon, 30 Jun 2025 14:59:46 +0200
Message-ID: <20250630130011.330477-6-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: GoYaqweT3zzcgeK9LY6mePj3I7ePPukJzAVkRIxJDkE_1751288429
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Let the page freeing code handle clearing the page type.

Acked-by: Zi Yan <ziy@nvidia.com>
Acked-by: Harry Yoo <harry.yoo@oracle.com>
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

