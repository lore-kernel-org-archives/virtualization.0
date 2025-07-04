Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2BB2F94BD
	for <virtualization@lists.linux.dev>; Fri,  4 Jul 2025 10:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751624783; cv=none; b=saWurIHaNmnqSyVQjL+7cnPLYUvGtViSCxvGQ6DC4C7yR8/fx6hbI7/FU78Ts0iAL23tHR+l6hpOvv3JXJfl4QENkXwB62JdQn5tW5ksd90khxn5TjJWsqTUnpc6i/OrcHbuTOdvYgfL8bpEsgGGZuYgW7Qel+PtE35F8HJSOJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751624783; c=relaxed/simple;
	bh=C6jPkBseruyPYB2V4vPia4YjzGxO7oc6LRdQsocjdPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Ifczhx951od57gzHufPHKxicUoPYfwMewRR3qjXDkDB6E4dLqmHVv+rseu0qz6U/LYUN83POmpJTnOP7NslXgQ4PcNcexrBJAEA/A4pY50E2I4t7+q2O3IlfVEMr5VucexMCetCOpJgR2znAjXhThVucXODbyZwXDWehpkxuOL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U0CECM+x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0CECM+x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751624780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cJheLoKLsD44QkJTGnHlicWVVgB1MKf4t1jgEN3k6qA=;
	b=U0CECM+xQ1ctnVdC2OEErdoLeu7dP7/ZhWqDPJ7FNxqYWcFy/Ga+hfkhEhPITp7845AhEH
	t5nsD5YbQY6mchppdWP1ysHIswYNGjpoHZVEi0DSJ2wWL9NMEjEoArkG95f6zXbJB1lnsE
	tJDbKlBi0pD+Z374/9BJ7y+/IJr0C5A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-_YY_5VplOZOxAJE0TK4QgQ-1; Fri, 04 Jul 2025 06:26:19 -0400
X-MC-Unique: _YY_5VplOZOxAJE0TK4QgQ-1
X-Mimecast-MFC-AGG-ID: _YY_5VplOZOxAJE0TK4QgQ_1751624778
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4f858bc5eso538145f8f.0
        for <virtualization@lists.linux.dev>; Fri, 04 Jul 2025 03:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751624778; x=1752229578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJheLoKLsD44QkJTGnHlicWVVgB1MKf4t1jgEN3k6qA=;
        b=VsFT5UFqhdKeTOp0tncp20SBTmM5JplNNurdiD5a0WHWAwuC/PDCaXAB836aY7izlY
         zrsovUticJQY5SCQiuhyimvPCyrLdf2FRp9YHmGgiMK422q7eBNotxOdTuicRtxp2jnk
         7Zd46+5jZ1EcDsAVbq4mvu1xbLARLXVaDZS+U7snocLkcRqfrWM1sOJ3fJuu49RaOo8h
         ux24SDhYpPTtaywwfoRD/xk7/8lTpHhuZ3NyksWD0Wdofiep/nunXGvgukzw6uhzKWkr
         pUBBT48zuLfxwxdN9DBMN5C4RNIfWlDNyVKnV8pU6Qu7QG59v9eaa1Y6tvBayBsvG2Zj
         yB7w==
X-Forwarded-Encrypted: i=1; AJvYcCXqxUJQX2e8flox1Yn1MpuEdGp69JIcxRZRY1EnDoL1ePnj3hDxWaK3k3WqFdie4IUhjlIY0CE++WHfCzheNA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwuRnMvkVbyzcnv2gBxPO008QNYvTVZYBtCeWjyBaEOrt3nF1kX
	QNu+SDvRKtoGKuPgL6uz86Q2dQ3YEGdga3kYMpsqlf2cF0JkfV2ENM/oKGcixgqBlxLJhgW8QzS
	Qu3SXZ1Y0kVWuFzsxvc3lRAQw1HzUqpgdcKcesYgpPRXtyhhsgtm3Rn/PelJqWffKLt7J
X-Gm-Gg: ASbGncsIm99Ry7pSnez2XvIPqb5GryOFJBBppW/wJHmaMMKUudMM9IVLxwvLjjVXW5B
	IWG6SUmnp8khP71vWYAf3n2qxS5km1xNczAgR/X3VA5w3CuYTUtlByVOiRcAxS6wn2HSS7x0RJi
	8taW+W93DQrRzIsZfV1i3AT2WotfA5OANTdde8OpXS0vghJEHx7n4AdYzoCgtUikEuZi1vuqGEy
	PphGimWAPYx5kSWVEmERWyTtjJIdx/TvOp85hg0bRVGvwEmc7ZM1n1sHHsgZ0dzltDbWtKGI/0H
	UNy2Q1wTPPY9remS5KXFRa5BC0u/A7D4ME6xaGz8IXyJ9VUmjsM6CZ7IsNTtaF0YYnzvmctHYAB
	Z0WZ4tA==
X-Received: by 2002:a05:6000:2f85:b0:3a5:57b7:cd7b with SMTP id ffacd0b85a97d-3b497019684mr1247108f8f.22.1751624778023;
        Fri, 04 Jul 2025 03:26:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsIhm+puni7M70O9UOfmv7nAn160MUBp8IUwHGoHgLCi+2FqWLpmioUQXF2wdRtw6a1cigug==
X-Received: by 2002:a05:6000:2f85:b0:3a5:57b7:cd7b with SMTP id ffacd0b85a97d-3b497019684mr1247037f8f.22.1751624777474;
        Fri, 04 Jul 2025 03:26:17 -0700 (PDT)
Received: from localhost (p200300d82f2c5500098823f9faa07232.dip0.t-ipconnect.de. [2003:d8:2f2c:5500:988:23f9:faa0:7232])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-454a9969a8bsm51842365e9.2.2025.07.04.03.26.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 03:26:16 -0700 (PDT)
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
Subject: [PATCH v2 17/29] mm/page_isolation: drop __folio_test_movable() check for large folios
Date: Fri,  4 Jul 2025 12:25:11 +0200
Message-ID: <20250704102524.326966-18-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 3EWQatOgxe6rL0FTs3vHXAA71qsPiHjbWO05eR-zSdw_1751624778
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Currently, we only support migration of individual movable_ops pages, so
we can not run into that.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
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

