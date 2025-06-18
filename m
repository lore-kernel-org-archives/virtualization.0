Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989C730380D
	for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 17:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268487; cv=none; b=sVcnqoHYwI4QHyWTEEAh9XPAyk+g0E7o5162c1qYF2ynXuIg2fDLP4TqsvXWNb6kXw6Q4tnhhAvhHC37fmVYrmpbZXZTJWTPONSzmex9bt7xNJidUzz6HspDFjih8UzFvijzRn3kQ+J9eLiy0L90cYaBQa7UUSy8N+ZWOifFmjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268487; c=relaxed/simple;
	bh=/g8pHF1/RVrgJ0Pc+SNNZki6HQmNZWyjtOO510JBXkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=qbRlCA7D0A9EUgbRFYyTMyHaHuqcadRpP/xT+RIh07BEvFL/0SexNfFzaAWV8Fj5uZBpswV+hXHbeBpO5vYGf7W+BAq9hdA1dp08zfYwRU43c+YLmA9EkQ+Agv/1hZEijn/ML8ZZOnpe3P5+PirbEK40zj2XZ3ko1dCxxUdT5jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A2+BygkM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A2+BygkM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750268484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CdeAYiIbvuQl6YyCSbJM0KZ+PwGvgoJ4GiSuuebq9Wc=;
	b=A2+BygkMDeqDgf28VdR2bCuohxD5qsY8iIt8f3Q4j9/4VOtX6UCQeGrgJORHWwboa8jpzV
	XnuWjI6d7TrpXspTIxs/nPZ8IG7oIaZYxqZQxE+NiWaVcuClClGMKUfOxvhtz1QkifcMcc
	yEA4HvWHnaLd9YLsfICfUpF0V9dElK8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-l8AQ7CRKMHeE8LnIZOHxsA-1; Wed, 18 Jun 2025 13:41:23 -0400
X-MC-Unique: l8AQ7CRKMHeE8LnIZOHxsA-1
X-Mimecast-MFC-AGG-ID: l8AQ7CRKMHeE8LnIZOHxsA_1750268482
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43eed325461so45822435e9.3
        for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 10:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750268482; x=1750873282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CdeAYiIbvuQl6YyCSbJM0KZ+PwGvgoJ4GiSuuebq9Wc=;
        b=IwjqRMMnQeYoJXUbGTTZ1LhKBlvhuVw1tl/Be2lO7FpQAcKGmDlkAc9GJOL6ZcUGmy
         tGP6fSfB6VVZFmSwUiNkd0c0LLL/Tf9l5fNfK3WUKKEln0B3hUjCCZrDK0kz5PWVKo1C
         PnYaOgYGXJQNzJdDMMJJm0mVVYIdUDol+K9wm6sPmT9/bqTxzN/BoTIacM+aE/zjc/bI
         ccpQclrwYSd0SDLIW95QkBNFTMnxoi57OvihZBaqmhRAk3wp6WHxomBoYKlhykee8HJl
         8fG8cgKgW2AXC20GyyGmU90oCxzoRo7YlrkE3WWdc4IUjZETavLXTJCgdJzAdGC/YFg5
         YkSQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4HiTFALpV6+ydvNCSet55jQy3Wr0QPmjBKoPR9B14XF9ozaGOs2UG/Ij6sTYVhY/sPU1MZBvWqT2omZBXSw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxe/jrc6Sb9mNMAG2m60IKn3vLwibhWnbLPJOzFxYUP/A1VL2bE
	tNkmAKYBt3srAtpZ1UKJjNwvRIENbwZ/Ce6nGz/wXMpEII7c7gei8ZTVu/6uXvdwRx66ykQI9Ng
	thOrZ0HTePTfYjxKk7dykTMY/lX5BfjoeoRh6SQbIcAAU33mi+UJbjXzbrVrV/MTq1FWv
X-Gm-Gg: ASbGncsB9IlgUjqyfw7dZ8FSvHsxVkqFq8DeV9Gkh9T0wn6NCemEsmZAPQ8gkVqMQzZ
	QcEbNLedzaFBK7sl0roZZ4pbExoUCMomZZaOzLg0YrghhQUFA222A3CkyCXMv0m9ImekpJbTP44
	4l7BzJmGzDGFK3sLGljyokgGpOhFvQKFQ7QqjV4bn8WVgA7kRPyTUM5yljCHDyR332QalONBQZF
	M/gznoDTR6jq+DZcnEuTbbM8tMvJdte/gRmFj+jMuBKuBylaqfjqub5ZrXtyLz5JGf4IwW8GCpl
	84MWM16s5zyHGMxdPDhTYbhF4gaUYy+fSIhva3Lkunb+FxscDfrrvG/bXsC9qdGyWyEzTy1qOqM
	Q/dTf3w==
X-Received: by 2002:a05:600c:3489:b0:453:78f:faa8 with SMTP id 5b1f17b1804b1-4533cacf0b2mr167448165e9.6.1750268482487;
        Wed, 18 Jun 2025 10:41:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrKZ8zfCrGufAh/HvE/XIf55Hjs+1HFJqQV1cfkKzvu6o7QRQJ1IpAcZ7M33DksKCqTfpzKA==
X-Received: by 2002:a05:600c:3489:b0:453:78f:faa8 with SMTP id 5b1f17b1804b1-4533cacf0b2mr167447475e9.6.1750268482090;
        Wed, 18 Jun 2025 10:41:22 -0700 (PDT)
Received: from localhost (p200300d82f2d2400405203b5fff94ed0.dip0.t-ipconnect.de. [2003:d8:2f2d:2400:4052:3b5:fff9:4ed0])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4535ebcee09sm3315485e9.38.2025.06.18.10.41.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 10:41:21 -0700 (PDT)
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
Subject: [PATCH RFC 24/29] mm/page-flags: remove folio_mapping_flags()
Date: Wed, 18 Jun 2025 19:40:07 +0200
Message-ID: <20250618174014.1168640-25-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 0FMHSZTP8ImuEyXBq704M_aVAKSaj9mCoFXrTyd3vA4_1750268482
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

It's unused and the page counterpart is gone, so let's remove it.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/page-flags.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index f539bd5e14200..b42986a578b71 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -718,11 +718,6 @@ PAGEFLAG_FALSE(VmemmapSelfHosted, vmemmap_self_hosted)
 #define PAGE_MAPPING_KSM	(PAGE_MAPPING_ANON | PAGE_MAPPING_ANON_KSM)
 #define PAGE_MAPPING_FLAGS	(PAGE_MAPPING_ANON | PAGE_MAPPING_ANON_KSM)
 
-static __always_inline bool folio_mapping_flags(const struct folio *folio)
-{
-	return ((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS) != 0;
-}
-
 static __always_inline bool folio_test_anon(const struct folio *folio)
 {
 	return ((unsigned long)folio->mapping & PAGE_MAPPING_ANON) != 0;
-- 
2.49.0

