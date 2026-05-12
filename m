Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF613C8C73
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 21:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778619998; cv=none; b=PPo9eEsl+M5OinxS6WKP6bvHytw+L/KYLx639QHJbxacMtWvfwPRMl5F9CHGtUiUGAfy8uY8cDcH9tncI0VylZAe2Paol+ebeiPg11Xr+xSejMpt9csktwdii5uBZSyGEB9yWc8KgmKFtScNEFY0whvas0vJ/9ncH/GGacbI784=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778619998; c=relaxed/simple;
	bh=m8forpKa92wSEANoV2LwX8iYn506Fg/3SPdqojZoxqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YRUiaU5gH9yDny8MLvpz8phLa3uyl+M78gRz2Mq+jjOLFlU9rqDn7h9+RmHuIDzKbmOQoUSch+TzfMPG+Ijd3qUEgQEjLl+r03eSUr+wiTCX0BZgiNXueji0mmz1+If5CP9Z+Qjnu3vWduNQe5RMRBbWOw/kIawc/kEwR0by3yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TVKJim5q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TVKJim5q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778619996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=awVRqRC+b/AmjARdxVJbu/50IYPO1xelbVaktsnFd6g=;
	b=TVKJim5qqLTzAZP9o/QRetb0rz1LO20TgxBF+otvEJWUdc+jvyjfanNqKF/ETs/PvY1yqJ
	nf6dQ+uHujlAiy9roMI00wpaAc3UzVZ9kvE18NtowNZTAg/9PBve3GDjbZXUQUScziwqvs
	SNUbTu9EjdcMBG6ZeIXv9wi1icG3GpU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-0ANOQeFVNXKIUG0TdkgPMw-1; Tue, 12 May 2026 17:06:35 -0400
X-MC-Unique: 0ANOQeFVNXKIUG0TdkgPMw-1
X-Mimecast-MFC-AGG-ID: 0ANOQeFVNXKIUG0TdkgPMw_1778619993
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-486fa07f2bbso35893685e9.2
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 14:06:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778619993; x=1779224793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awVRqRC+b/AmjARdxVJbu/50IYPO1xelbVaktsnFd6g=;
        b=ZyYrg4PSAmweH8yoCMOwV4akAR472nqUCCezrhOtzz6zfFKpqlhkmSqaG7IKyzPe24
         WbR2zo7XGkNy5rZ/Qfrx1i0ct0T1ZiEYBiaZVekYCHmr77DX2RsQAibB7qep6+hwPBm6
         lVObdmsTle0NozWEKagNKFn5RSr82/Bu8Ep5qV0U5/wbYELZb46TeGOAsmdUmrG/jPjc
         vrspKKsREBwjoxj4vmk019Cq9gzIr+pIcQm0Ob/d61cNJUHiIilyBhDRRhGmn3KSVTOb
         3DReIvfpqQwN5r1ojzkLaJz07iqbN0dYtqVjbQA56zHon+/SrbgtuZ/XLckn28TL2q7r
         4GhQ==
X-Forwarded-Encrypted: i=1; AFNElJ8YrGa6joqWiiLo2PZC7HXrNiRbRDpKAMlGD/i8XGj2ghTKZda1BSD1eEtJPp/5i7/adFgV9alwp87V9eGUSQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwktUaWKHsLtnMRj2lDwXi2rT46XCJOGKX0JkjS8kZ0nrG2nvAZ
	DKN1ApS4gKMoIEjtTdKv7zDNfDd/NpjmvfVcGSl6G1g4snCabdZjVj4WaTwHEqAHM2NeT+zoMWJ
	LvCEjQvV1vz3t5STj1vYrj5yiOaQL7b/9fR36IUxa4WggqRiEaoL573WAVNooTwmKNNMP
X-Gm-Gg: Acq92OF3kKkjkCPaX0TeO4FfjCa+eODN4Yt8Wy+SsOAd+juKq7KRQ0vhLmX1+mPFFQP
	RC6AVch/luNL0WKEzI2JBWqYiu2wNZ7TxowcA5X6kpGtKXNGghkJIu4oIDQjVpoHIEwe+xQuSx2
	4gDuRRVIoEjMR4vFzYjOY0kMh/gEIFcQKc8c1YgNvHbty/jmkRzxrVQyBl/6Lf+suvmelbPPo0G
	oWbg/FS5NGKKjv7LMLQOI3nwBbX8YU3VM1qy5U1ye1Rk+m4pRXvRC3+Juoi2StrIxM2Qvfx2Njh
	slF1hR/QRGkOH/Tnf7I5KvJCGf1VxskB2Omk+iREPgyah5j6Mk08zfnbmMJeO3CgRJ+3YjttUj9
	kr5fHMrMH+Ye1FsocUADIK9CCn0BLwew4EVI81OmP
X-Received: by 2002:a05:600c:871b:b0:48a:75b9:b0bc with SMTP id 5b1f17b1804b1-48fc9a5ed3amr5818085e9.29.1778619992869;
        Tue, 12 May 2026 14:06:32 -0700 (PDT)
X-Received: by 2002:a05:600c:871b:b0:48a:75b9:b0bc with SMTP id 5b1f17b1804b1-48fc9a5ed3amr5817805e9.29.1778619992358;
        Tue, 12 May 2026 14:06:32 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fc8d19854sm24100025e9.1.2026.05.12.14.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:06:31 -0700 (PDT)
Date: Tue, 12 May 2026 17:06:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	virtualization@lists.linux.dev, linux-mm@kvack.org,
	Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v7 15/31] mm: vma_alloc_anon_folio_pmd: pass raw fault
 address to vma_alloc_folio
Message-ID: <411a7b6a750c1904b99be92fad0e678ad791ca82.1778616612.git.mst@redhat.com>
References: <cover.1778616612.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1778616612.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: d7juKe_Tt2mu8TNLnCyCfytwOsyvXLRmy0WeoJuaVXQ_1778619993
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Now that vma_alloc_folio aligns the address internally, drop the
redundant HPAGE_PMD_MASK alignment at the callsite.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 mm/huge_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 970e077019b7..d689e6491ddb 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1337,7 +1337,7 @@ static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
 	const int order = HPAGE_PMD_ORDER;
 	struct folio *folio;
 
-	folio = vma_alloc_folio(gfp, order, vma, addr & HPAGE_PMD_MASK);
+	folio = vma_alloc_folio(gfp, order, vma, addr);
 
 	if (unlikely(!folio)) {
 		count_vm_event(THP_FAULT_FALLBACK);
-- 
MST

