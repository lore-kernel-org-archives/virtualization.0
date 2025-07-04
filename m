Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D492FD581
	for <virtualization@lists.linux.dev>; Fri,  4 Jul 2025 10:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751624802; cv=none; b=jEpFgdfbhcHGZeVR2oyAf387zFS4gkvsntHI+3FxwhSxPOBTsUdN0ODGAGkiOpsi52mUQvG/spU/SKVR62XBpdBsOXM59RniN9O7e4sSktOINN3t+YgUJkhXmQmtIbIOrXb+XFhX9ICqfd5HoSy2drWqP3t7fVhhkgbCS837qCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751624802; c=relaxed/simple;
	bh=1ETQVwTWSzuFM96Cj9uVjywNtHELv/PpY51PqKnqH4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=T3Uyef7tnnDqhCQg7QyGdMmUzLKJjHfWcRi7x7tVJqYleYGxJZrt21jTo34yu+BPYO0SIzANC16qjAd9lSVvpFE9LfwMvBMejokiwPSiYWlh7M/I7jtnMPdMeByXQrL5FKURyVnGz+8XdRsMxEbX36FaRL6M5L3MKvenINs3qcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O4Kymy0X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O4Kymy0X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751624799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NiR5g77+dfB6TjFQFOB3xNqG4FRd5Im1/1G4CsJHDLI=;
	b=O4Kymy0XvQ+sk/Kw54LMKbb/Ml22GcgZel6t5gejYor+cfYw9uiPd57QfhjJz5pt+tmnbc
	ATWDO+rQ4CH32tgeiGa7deKpHbQz7ioXPfeyh8osMEenc8uKUXxppiCPX44nMpL/zlL6da
	wlVLFkvFMHvTAau04elrVrqHyC5m8i8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-Em3gd3W1M9uEo3g6rWNNnw-1; Fri, 04 Jul 2025 06:26:38 -0400
X-MC-Unique: Em3gd3W1M9uEo3g6rWNNnw-1
X-Mimecast-MFC-AGG-ID: Em3gd3W1M9uEo3g6rWNNnw_1751624797
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a50816ccc6so500305f8f.1
        for <virtualization@lists.linux.dev>; Fri, 04 Jul 2025 03:26:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751624797; x=1752229597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NiR5g77+dfB6TjFQFOB3xNqG4FRd5Im1/1G4CsJHDLI=;
        b=go+CxS1nRN7s+WlDw7jgzsX+9O/uvccIfVRjIHVQ1h6+PbXH7ipaU8TNEstIHmBnYP
         cEAWzU3acg/MA9iaTjWuZfYHdmK5cXamM0sgDtmIpyD0G//gO1YeBC4YbrY7VLxPf6+2
         C8lG62a0yD4du2o8fOEOnJk5+Ea1L03Tu48/f3rEn9aTJPKULhyd2dVQFfS61kGZS+bd
         s1p3cPHStU4ZgDZ8BkGpC+Vfxv/6FTYmYUCC29xoJwO47/PgapfeA53b3hWh8ohR9Pg+
         wYUgnHmZMVRS+o6FvcmQeiygYKTghuOShdeKkhbUjNlKtpUDI01vwFX5wqHo/3MiALhK
         wOZw==
X-Forwarded-Encrypted: i=1; AJvYcCUG8jtGu5/kSP8hL96ZXCyTLb4iMZN14b4IYb45TuS6g4M2kSa4X6Cxq7toVGHr/oMSLUE0TDecxBmL03l3dQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1Dv2DZD18DPtt/BrKlE2edk+VHnn5Nc6wdeGhtktgbfDArpqD
	Bxz2RMJVuP5yJos4V434g/qRbiT5UUYnNKQW0DdUDSd4+ClL3NPlpJ0le56WjOsXihPXMQJa4L6
	o7J4Hfh56cs6/9SV7zqekFkk1VBpvlXju4xe3GU+wgCNyoAlABqq0AoWjdkrm8gmb8sh8
X-Gm-Gg: ASbGncuFc9lY5UPgsdfAhO6bK/Q5FatdCXVC8hYlVaPutq5LbddzAQM8MyZMQgIkr/c
	KBCum57e37o8doNBUPFXCF/vULgfYDzNdNM9tp6i/ibVRBs8SMectvW/GWDXY6IivqlPb0luG6c
	jdSMKiA67OktNfKImuxJFAfhTKrnTSot3h0pmya8FmYZfsu4U7q2wr73tJxjClz+0GkIbdcw4b9
	aRkoNOk2E0kiojz6+AdKH0/yzP06zPkOK3ZkBoA5/MhJPmlTVs33ZS1xzuo/OJLTICmPTct4xNO
	eRm/B7LvTqkzK8BCEoXT8/ZWhj8GC6UfJmkU5n6klWjXR8P1hm2pOScXupaNfIvQvU9c6BCxOH6
	EC4G6YQ==
X-Received: by 2002:a05:6000:2112:b0:3a4:ec23:dba5 with SMTP id ffacd0b85a97d-3b49700c571mr954034f8f.5.1751624796806;
        Fri, 04 Jul 2025 03:26:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtfbiTuj+217pme6OFEkgrGo09w9YBtXxahiaI+UfZ531v1EH5FnBXh5DrYfR2GN/01q/x/g==
X-Received: by 2002:a05:6000:2112:b0:3a4:ec23:dba5 with SMTP id ffacd0b85a97d-3b49700c571mr954008f8f.5.1751624796346;
        Fri, 04 Jul 2025 03:26:36 -0700 (PDT)
Received: from localhost (p200300d82f2c5500098823f9faa07232.dip0.t-ipconnect.de. [2003:d8:2f2c:5500:988:23f9:faa0:7232])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b47225985csm2148740f8f.69.2025.07.04.03.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 03:26:35 -0700 (PDT)
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
Subject: [PATCH v2 24/29] mm/page-flags: remove folio_mapping_flags()
Date: Fri,  4 Jul 2025 12:25:18 +0200
Message-ID: <20250704102524.326966-25-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: Q6hxpUa_q0WPRadNnWWgUoFM1Ui6rbSVbC6xXv35y94_1751624797
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

It's unused and the page counterpart is gone, so let's remove it.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/page-flags.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index fc159fa945351..e575ecf880e59 100644
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

