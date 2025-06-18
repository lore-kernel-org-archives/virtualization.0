Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3D73DAC02
	for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 17:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268452; cv=none; b=WWK1rMP/OPxkS094KyPKTHgJJC/pU66Ea+gtelRbC3wf4b6rPZvq6djlDD2fO7WU4QNPNeZu90ZgRMMd8w9v9GXSGNRH9vO5CcNvJSZjq2G1UGkcWvtj5cIZpPULodGUdKcxqVyrLNA5HYK6JcGGryPNf02JwVSgR90gwtVOvYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268452; c=relaxed/simple;
	bh=4i7IUlR1GYEmR6zjKB+4nkWLQlvD9f6ku5JrjlUDoK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=etq0I8OwFjm0OZ/hABfZQxyNfsv0VDGc3fTRAYmrT9uybhYSRJrOzZjqUBzNhdq0b9eeeQALuswbfx5S6Mr5TJyjMlVZL6p+DkZMfDXbTiXWz84Dhv5j/skSl/5+w4dJEYsMGmC1v4ebPLc101d5rMZ0rslSzcMsn4Rgb8gs+lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e7Nm/RUU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e7Nm/RUU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750268446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fwm1uiBUBcXGnja63XmY2QjIjVtNliVfN8dAKrOXwFc=;
	b=e7Nm/RUUh/I5QNx4/SMJ/Qfr2Ibc0hi9S9YC9aeNNmpf4kSMNR67pdnxRaNlw4O3PvZfHB
	t5SbIljRlC3af4jJM0U8jgqmS5HNasPJ23MT12I3l3RIx8BRGNx1SM4pnMVVQN5jJ21BJL
	k+Yq2MgVkhAYvX6RnNVK+OTK7QTsmJE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-Sl5YEEYtPceVv84MWj1TAg-1; Wed, 18 Jun 2025 13:40:44 -0400
X-MC-Unique: Sl5YEEYtPceVv84MWj1TAg-1
X-Mimecast-MFC-AGG-ID: Sl5YEEYtPceVv84MWj1TAg_1750268444
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4eb6fcd88so4232727f8f.1
        for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 10:40:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750268444; x=1750873244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fwm1uiBUBcXGnja63XmY2QjIjVtNliVfN8dAKrOXwFc=;
        b=tfkf+kEaYH7zVyvdxhU2Tbe1XwQkv808dAvrhT2UoA/vB4X7vTEdk/JDO46zVNJJ32
         Z5U1qtfK+VU30LWqDyOO8iIceUVyxMibkOxvhjHi1diRiFY2XzH9IjeFJgVDHHS6GPmr
         /HgE1k5x17aujx4VhMs5WUdg8VQWpX5aDC+NUYEAc7afJ1PuPovG2hvYe3fUXITqXAgU
         s6Kl/l9//6cKrXyNLe1d11ZqCAUEs5YvxlmLPKZpI6cQPC+VCn+OHLaxINuk8CpxatM3
         wC7QLPZ2UBviq/lgh3GQQhD6rlMSUVLJgTzZ2BegjBNHb1h6uBv7pK7epWTOTJXwyBMv
         o97w==
X-Forwarded-Encrypted: i=1; AJvYcCUtK9joSRJptTccAINeIy+GpAtPztHYs8E8/DN7ikVWQRbY9K9FX57BOfQ1mLuUJWUBbPSJvhbSyMisZCMIlA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwFb/1Xgu72/fl3dc/cl4TlzhyevgLk5LSVWGuT/G5wVfjiea9e
	b6cu/3tBx+hLUQn0n3yr9ndGuTOr4kA8sTMNhZVYFqBsd8gB6UlbtEFy5LKlsqfPFbISYHKgg5S
	L0vxyl7l+HOILslu/wr6Iu4MEJ1cWpXZuC5mAx2C2r0LHXK7qp92tqMs9l0I9C0vF4ErT
X-Gm-Gg: ASbGncuEtShy+X3MO0LnlxNe4PSC1qlp27SHvUbDzFp1hHto/PGuZOtNY50G0BxbYmW
	nYCRXOY95yUiySUgIMP7qxT8M09yA15MdgML4gYsmh8lhpGggu9V/tziSb1et+s3K6AEYuQ212B
	5mvqfr0FRTCbnaPl42rpcIPiaA2g9Fmb+HKjxBupwcW8reAbsWg/J7oIlRTyai726CJn58yBape
	/ejbBravgfRXHuPUCajsJncYRDPJIgyH9GelzuHKyYbvPOloIxJk7gYtokx+ExuIFKFotEoK3rh
	1bneA17UuPasrde/fVZWLwuAiuM3QHyadUzCyVARJ10WhgTKcZ/pQN47IeGoSla7pH9hoe6lbYw
	SNVCGqQ==
X-Received: by 2002:a05:6000:71c:b0:3a4:cfbf:51ae with SMTP id ffacd0b85a97d-3a572367afbmr15684691f8f.4.1750268443738;
        Wed, 18 Jun 2025 10:40:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEywSnKMkZlpTz2OAMYD8vOZkvPdDtLDDWrsPSDJX8ViTkX0laZRXIHvaFqn8ElXQBewjN+xg==
X-Received: by 2002:a05:6000:71c:b0:3a4:cfbf:51ae with SMTP id ffacd0b85a97d-3a572367afbmr15684628f8f.4.1750268443292;
        Wed, 18 Jun 2025 10:40:43 -0700 (PDT)
Received: from localhost (p200300d82f2d2400405203b5fff94ed0.dip0.t-ipconnect.de. [2003:d8:2f2d:2400:4052:3b5:fff9:4ed0])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a568a54b7asm17688084f8f.16.2025.06.18.10.40.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 10:40:42 -0700 (PDT)
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
Subject: [PATCH RFC 10/29] mm/migrate: remove folio_test_movable() and folio_movable_ops()
Date: Wed, 18 Jun 2025 19:39:53 +0200
Message-ID: <20250618174014.1168640-11-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: asETs_uDD_Tb86PaCcostfD6v52t00pR4D9gwnKe6P8_1750268444
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Folios will have nothing to do with movable_ops page migration. These
functions are now unused, so let's remove them.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/migrate.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index c0ec7422837bd..c99a00d4ca27d 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -118,20 +118,6 @@ static inline void __ClearPageMovable(struct page *page)
 }
 #endif
 
-static inline bool folio_test_movable(struct folio *folio)
-{
-	return PageMovable(&folio->page);
-}
-
-static inline
-const struct movable_operations *folio_movable_ops(struct folio *folio)
-{
-	VM_BUG_ON(!__folio_test_movable(folio));
-
-	return (const struct movable_operations *)
-		((unsigned long)folio->mapping - PAGE_MAPPING_MOVABLE);
-}
-
 static inline
 const struct movable_operations *page_movable_ops(struct page *page)
 {
-- 
2.49.0

