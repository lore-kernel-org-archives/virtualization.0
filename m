Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654A2294A02
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 13:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288493; cv=none; b=lqhIlA7E+K2VzJ8KGwt9cwGNHM2g7aQk0Mk/z4IIeEvZFt6MXGcGkk5XRxP9RZ3cmsd5qFNt7A5kfV/94UzT03ejiXgYmn3TYHbD8bTTW0oCv0qhpDRroJC3LLWn7RlEwt/2kCWbruFgNez9ysYWyWmByRkBy7YtprrVxyhsa6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288493; c=relaxed/simple;
	bh=isaI58t0kWAv0VvFIE40k9qBORzA058ggEZ88nMmJIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=ne2Z8mDJzTw+SzUJ1HRbUi+BDhH5mFIPDr6MqA5aUAqqnenmJge2XcJxvcCPbnCtxidlez8NhbPGApcqkQezzTeh1agBLsW7BIKG8dTK3Gjh71NUlP1FC0pLcMcDubgLOOZ3UiH2d/xjSFbbbzdyLCvJhndxzkIsayHDARcp/GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ykpmepkh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ykpmepkh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751288490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=olXYTUdhc5G5HcwZfX2j4qOOcGFF0hDyepBOzPt910g=;
	b=YkpmepkhLcQ5zB3cNkbC5us+i3rnxX5SBimVrEPh54bcGC9VJxvwRTjxNLRmRzC6/5+Y6w
	z5pEsFFWzJcu49H6WPwNd0SukqoQ4dzakaQ+5sW2WSrrIBKcxJFL7mQ5FbYU/U5Ndw6kCm
	SDBlJEX0Pw9OYz15hG2BgbvMwX24+48=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-IT-pRmWlPvSaX7FlcZuecA-1; Mon, 30 Jun 2025 09:01:28 -0400
X-MC-Unique: IT-pRmWlPvSaX7FlcZuecA-1
X-Mimecast-MFC-AGG-ID: IT-pRmWlPvSaX7FlcZuecA_1751288487
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43e9b0fd00cso23510705e9.0
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 06:01:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288487; x=1751893287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=olXYTUdhc5G5HcwZfX2j4qOOcGFF0hDyepBOzPt910g=;
        b=kJdcI0iOF8lVi0fBamWs0dq84OhBB8Y0y62qveEz45BwaFsH7c8akh3uIfowMoh1aG
         vtVienMYCjRQqIy8pwbyTqSezP2+WWDLIgAs+HhXwa+re/Lk8Zqy3A4vv3CmJ0Rgfxs2
         YaaukOaTKSNVAzMfDICvKAm6qBPX+hGdzN1338W5o4te965pYCdcZUuKUh0NXVYdPQdZ
         n6X0+LGOPd8ICzAS7m0a9V2e1fEZhDZGERxpW6Rj3Jemt6VE8M/vQ7hL9nQlDNsBExAk
         txZAPCaIn/S+DOBM2Tn+/2adE6WHuLVosmWgxdKvGpmYinPn2vDuTaVTuyshcLML1Lx0
         JTsA==
X-Forwarded-Encrypted: i=1; AJvYcCXf7zb2WlK8Sp37dF2QaKRtX1DfMkwFkleLhEFqZ6vXUjc8HnyUHlCXcGxFy/3SiLSlUFu6wHFrJuJuPrdluQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw0QajiQd/I/r+ghdrnQSru4mlOMeL0rrlRERfAMGfgQD/2uyCJ
	bx53T+ff/QBB7KlUf9bHTmyW1Q3f/vnYXgBhO/m5Zqy8yQBgqtM3L0TFY6q81N5UNjhIlNior3a
	W829HI5ivrDRPohv7aZwSQ0XaTY0Ra2jnUAVLcziTHeK7RrY5AFczDWaJ3PItjQD8iqkH
X-Gm-Gg: ASbGncufnwJBUtnXoskisGjg4PedGJvaE5MEflLPdU0u7CU9m823Ozd/5BpxIMOsOpn
	Cz3vsuRLV4KUWmsNjyE4Fxd2ln/yRuKDNndUPfDhNAxkm24Yj51A3vv70UM/gq+AWxdJbV7tj9d
	yE8c7qEuhAFAC4Tb93ONWCTKCT+KmtgPn91mc5L1AKoCq4p4B9jmsQ/lXh4G4opU7+xOUgT4BeZ
	LthRxrZPT+CAduKBNR0Ff+iKBPts4Nl4t2SGiB6uJdTf6jMr0H1EVzue58a3akIOHmixpEf58YR
	/NvgUOWdzWUr/FUHEQ71mKoq+fqz8Pg2MJWshsS6D0qp2POxaIJuTDbEqfT38WwvwtImm4PFPEy
	yXEXpfoM=
X-Received: by 2002:a05:600c:5306:b0:442:f4a3:a2c0 with SMTP id 5b1f17b1804b1-4538f308f2amr124064355e9.13.1751288486207;
        Mon, 30 Jun 2025 06:01:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9JbLrxBujZu2VjgMn1mCOlcQzRUhKdRhzGdc0P5pPEt9jKXPpDvx4Rwh6D/+Yae/APwbOBQ==
X-Received: by 2002:a05:600c:5306:b0:442:f4a3:a2c0 with SMTP id 5b1f17b1804b1-4538f308f2amr124062795e9.13.1751288484673;
        Mon, 30 Jun 2025 06:01:24 -0700 (PDT)
Received: from localhost (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-453823b913esm162071665e9.33.2025.06.30.06.01.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:01:24 -0700 (PDT)
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
Subject: [PATCH v1 24/29] mm/page-flags: remove folio_mapping_flags()
Date: Mon, 30 Jun 2025 15:00:05 +0200
Message-ID: <20250630130011.330477-25-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: OZ0NxdiwcfgdwJ0pPwoPhJGE2X4FcVEPXm7enQDdqGI_1751288487
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

It's unused and the page counterpart is gone, so let's remove it.

Reviewed-by: Zi Yan <ziy@nvidia.com>
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

