Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795089771;
	b=3AHOtN9k6kCTY7Hxgvt31MWlS4x/Az9XZv8x8yaqo6/pK1EYGpM3kKYO11kHLc0SdgaG
	 Elo3hORe7IMcVzk1R2YtoFdQrWWv8Nrywh3qPIclrGNKg1Cpgz1Zs2qh6VtuY52+Fnf5U
	 SFNN1JSLcKSLEp15bXwlVLei6KTiVaTadbbRohmfdNCimQtVoEW6ThGkyrIy5ZG22hzRf
	 QwZZxyuQDakykiFcW8h1+vJZwHLju7rUcgF0JJ+Zv8OyAUzoNVN1h4d1ir+dW9nbaYmLS
	 qGprYv/opD50naRZC+lYK2C4jSwSyczYthb8nr9UlHv65dWtZSmCngS3OD5xKB2tepQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795089771;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mailer:X-Mutt-Fcc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition;
	bh=7t7J49HOFuAWT+vhD+UjJuGaxZiXmraSo4eTZkGtO3s=;
	b=xr5r/32GLeN+PN7odI+ieqXbfZ8c8/lkr8zfK4IahYHclQS0XKToEV+QLIYp974otCfB
	 j2I4gTt/5caUAUHiOpCNXJ+0jbXtKa7472/xZkXtHu0jTRsaDr5NW0I6GXzylm+r2yUIZ
	 4bz3SJ5rBrnPlhXwGNrFX9dH4SfaWFA+EG7mHS++R0gXT66ZTBpXPhMI4esY4xKfd5FnJ
	 RHRJX+L4a9cic+s/N68UcvNWv0j7gfmTSrs4bFTZtlSebKYepV/gIE6At8q41aZTnbA4I
	 x/xCJORefqyTnK8qwIVeo8Xq5vw5vYgqf9BR8hbZIGXKCgRJ48pFkuiRUQQbeJC8Lfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Sa92fmUb;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5C9606A331
	for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 12:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F5C9606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Sa92fmUb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795089769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7t7J49HOFuAWT+vhD+UjJuGaxZiXmraSo4eTZkGtO3s=;
	b=Sa92fmUbD9Bj7fPe9n8vQkEaO9h4t4J9ZKMdIDcQd8za8ExNs/orEnlKnGDbVGc7rHcn1W
	Jn9FgxqIfPqAx0dCJXYREhjOzHYhsRFfQGdLP7MdoyDvZx8B5lsMmH7Qrzw3yVpESmjfSi
	tBkCKKh3JVfcULWVXBYRB3vGx2OuwdM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-IEH83xXoOz-FIpvRLxCk9g-1; Thu, 19 Nov 2026 12:02:48 +0000
X-MC-Unique: IEH83xXoOz-FIpvRLxCk9g-1
X-Mimecast-MFC-AGG-ID: IEH83xXoOz-FIpvRLxCk9g_1795089767
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4915ba023d4so1476361f8f.0
        for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 04:02:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795089767; x=1795694567;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7t7J49HOFuAWT+vhD+UjJuGaxZiXmraSo4eTZkGtO3s=;
        b=IBC9R5zaFYbQWRCkWi3qzCfON4xrrzwdLYMot03uw6Tv41dGVr+v8DdVm8pc94EY3M
         IF0LtQDtOy9MknTJGqJGYalIDix7mJP8Ce29NkV62PNOeP/1DGnIunICX464KtM8ur9G
         tfkExnQeTvjMJz/PJGjw96qPrAbwOCpmU0FWPlG2MOoqJ5F720ZBMU4HMUNEq81g8OF5
         JpKxI9bGAhBhHy/6EMN/h1n6y5GopFSz6lVdtoiRWX8E64c9VeYprK/ontEaTJLsa3wj
         Bg2aswO15POTNjd6o19g6aev2xtDhvKA3BjdUz5wFMJ8viPwBTc83SlSy7CfImN9u8HK
         9hiQ==
X-Forwarded-Encrypted: i=1; AL+hErEka5vrsQAfwfLq4yKbkMnw8N/vvBkIQSgDekfYyOWwsTjBz5auXgJ+gmqlO5KKQXTjpHSJRzgm8E06oWtg9Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z/6olhpyQMtNmBcqlamr8xXDRNdAsVLGJXUkaRkeDlBIZCZtPdu
	u0nFOtW8clZnCXvtjx8+OTxBkzkdCzOoZHsSWoYyfFlBMMqJO2ByhOeZgbsb23gnJ7AUe+L4xU7
	sdk1CIsFUcmz+NvUz3L5tr/lGwiuaSBaet7hKxIBD/3HNS5IBNMKIBv+2Tq+FgMm6vNvw
X-Gm-Gg: AYBFou3M6SH+eXqggU1wublqsAlOc5z/zC3S31I6blpgouElFTfIM73WueS+X4251jO
	snCQ1MnzlggCzDzZmApA9u+C6aQImrkUaumWFiMiS+Opo3tNw/dsZZPaP30/C2NDY7rH7o+OoAc
	KOA+snaguYSw2ikpuR2AlcY+5xQZ0MXmLwsB9zBKGRx1oXevGgXylZXUJcy+3O4mzJvWUWTbbOp
	4j6IDGe8PphLLuB6j/4pHsjJAgLJ3Grv1cxayuoI6CXZYnHpz2lA2qsZ1cIXWRmmYAOOyL3rxbH
	ekwc0ChfRQtTRYgJqbCo+P4Q+3H7pV+UUO0wPez6tR33hyGf7BXhhkP52WeAVQ5+AhOV74lsXSL
	9XHDSI3n1UoNT/OZ58ALyytCN3j4Y7e2IT2HE1nkvbsg=
X-Received: by 2002:a05:600d:4:b0:4bb:818d:8d8f with SMTP id 5b1f17b1804b1-4bb818d8df2mr59688125e9.23.1795089766808;
        Thu, 19 Nov 2026 04:02:46 -0800 (PST)
X-Received: by 2002:a05:600d:4:b0:4bb:818d:8d8f with SMTP id 5b1f17b1804b1-4bb818d8df2mr59687405e9.23.1795089766192;
        Thu, 19 Nov 2026 04:02:46 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1520:4400:d78d:7b2d:2f5d:e08f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8535741esm50675225e9.11.2026.11.19.04.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 04:02:44 -0800 (PST)
Date: Thu, 19 Nov 2026 07:02:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>, Dev Jain <dev.jain@arm.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Gregory Price <gourry@gourry.net>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Lance Yang <lance.yang@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Miaohe Lin <linmiaohe@huawei.com>, Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org, virtualization@lists.linux.dev,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>, Barry Song <baohua@kernel.org>,
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>
Subject: [PATCH v11 3/7] mm: skip zeroing in vma_alloc_anon_folio_pmd for
 pre-zeroed pages
Message-ID: <37575b5efa8e04527f390eafada7fda928744130.1795089715.git.mst@redhat.com>
References: <cover.1795089715.git.mst@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <cover.1795089715.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5du8KU4BH7LIGhtLhaDcuP0WHDqjIl13llVsXvrn85k_1795089767
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Initialize newly allocated anonymous PMD folios through folio_init_user(),
to skip initialization of PG_zeroed pages.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: LLM
---
 mm/huge_memory.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index eb913acb03b74..80bd9b54eff2a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1375,17 +1375,10 @@ static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
 
 	folio_throttle_swaprate(folio, gfp);
 
-       /*
-	* When a folio is not zeroed during allocation (__GFP_ZERO not used)
-	* or user folios require special handling, folio_zero_user() is used to
-	* make sure that the page corresponding to the faulting address will be
-	* hot in the cache after zeroing.
-	*/
-	if (user_alloc_needs_zeroing())
-		folio_zero_user(folio, addr);
+	folio_init_user(folio, addr);
 	/*
 	 * The memory barrier inside __folio_mark_uptodate makes sure that
-	 * folio_zero_user writes become visible before the set_pmd_at()
+	 * folio initialization becomes visible before the set_pmd_at()
 	 * write.
 	 */
 	__folio_mark_uptodate(folio);
-- 
MST

