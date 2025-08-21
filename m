Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2280237428D
	for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 20:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806912; cv=none; b=fFpSVR3TeV0HR9G39NWyb1uQXnUtEZwyXyr5lciP45/zZyoUws4UtGRLFXrZteIItuSry68QYSU1l5pA4oid2xuDtrjd4278zuEzw59fPv5+bE779ZTq75NAjSha6GAgRYa6FMyaD/9bC/o+NOiW4T/WWitabx2DazNV1fZXSMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806912; c=relaxed/simple;
	bh=SsQg42O77qinr7crb+JX5LkctmenW7x9L4AwEMidQkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=pc0fZx8ZrYNyTxEeAnZURsf/vtfQlUItH6LmDT91J5xAnOM9YW4rsyHYjA+9IN205H0VH41dAnXy2HBTfbbmqryWYz5g4WY3n4aTknqOUMKel/Nm3UsRe0qhQGgZ2rwVcEUiji88eKEoPJ5IvronCJHxlSQphMie92VXTsPBW+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F1Xy2Jaz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F1Xy2Jaz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yKmA6ti8X8/YIeKKq4I8EEiHVsObQn302mzSXytdc/A=;
	b=F1Xy2JazIX5kSzYpOkD9uBJ0KRMQRl464YTdEAsDFcDJObdr8wbwMzo/J+YjxSSila48bM
	l09wA3Qd7XZwi781BNKYsteKIhdXBOV+lPCu0wduPov4qexKMLKvC1k2Ie0M0SEQXZEHxm
	GdZjmicy9+sRAHDxRAZUSrP24KGsh0o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-8oI64j84NTqYAfl42N_aSg-1; Thu, 21 Aug 2025 16:08:27 -0400
X-MC-Unique: 8oI64j84NTqYAfl42N_aSg-1
X-Mimecast-MFC-AGG-ID: 8oI64j84NTqYAfl42N_aSg_1755806907
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b9e4f039ecso759936f8f.2
        for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 13:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806907; x=1756411707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yKmA6ti8X8/YIeKKq4I8EEiHVsObQn302mzSXytdc/A=;
        b=PXZa/HJrEidZI/67oly+SWdiEDwdalUIQtCUXz1tjceudPK7tdoA+vW6uu3lWjkUzs
         XzP+wTMJqxIm4jdfHQGYT32wolY3TNXzHxjWHsWScy7j66wB7V+RT8EmOgQfvpQsLh3E
         peFvmeq/XHfuz7w4YEC73fPqbm2UWTS6ChaTKmYGo731bQsekBeM7OB3Au27m3umvMIA
         tuhxpeOPDUis2OKut8Jq5fKMZHfRnKjbneImaP2FFKfsuDsIWkGfu/zUYJUQyXT+rorI
         pO/m92Cm9yl7qeOwX9GcTrfDJKJY+jNaLCW8s0Aof58axvtuQFar/xmiKOFJ7A5yM3l0
         lNKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBha6L+yAxdXrQ97LCJ0lFWXFcLPX18U+kTCsJNJ8kkEe0S6/0V9em+2rdj+tiUwoLclzssU2l2ihEM0SkHQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3JEr9NnqMoHTSIeY9IYbgQ/cBnL/uPOVuuKxtZSi1Tyspi61b
	Yz2Q+Yw2nzyDNdFbZUDUXVtZ1K8i37z9kgUf9WxwdZre8GZaIA0KFTWUZjrh48r8Hdk17jVLzHr
	x9fc6ObME1+gUkOaRe1q9dpePrE1OqWJvuQptO+1q13NJ7o5iHtPPVlGJeOqFqt+tpVr9
X-Gm-Gg: ASbGncsbNMtp7Iz4rYlc4WewRQlCv+Y4jQZWagHVay47tfw1dTRMALfahGlaEpo5FrM
	UyEcJGdEmzN6wGu/isNdRSZGq5JDv5mbwfPmTKy3EHzIv0faP0+DZxa4AB6tr6ZvvgwJnqt+chK
	zug42YKZdcm/HJomqcX6+Rgq82Bc5gxlAeZM82IRDUCB/i1IgOsNBWfCUHi5D8Udhp37iREnKA1
	w7/WvzQutZtg5mSh+GX+JhyJNIHehIkAfESgprPFkBv3BEBJqtwVfBuYgJdP7sYCUh7RfwfXb/P
	SQyufCbmnglhr+k78gf3VEJKLw2GbuQWdevAVlLhCpGbt2nmjP5A4lb3WX6RMe3bWbaCxU579ER
	e7sxlZvvApbHdSyLKRrVU/A==
X-Received: by 2002:a05:6000:288a:b0:3c3:f134:28ba with SMTP id ffacd0b85a97d-3c5db2dcc73mr210142f8f.28.1755806906760;
        Thu, 21 Aug 2025 13:08:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFquQDwTQ7641wc0kBtooMvxSzqNfE3+XbhkCNDvunKpGE2abRVQ6uRBkb0Dc/grDWRh0uIiA==
X-Received: by 2002:a05:6000:288a:b0:3c3:f134:28ba with SMTP id ffacd0b85a97d-3c5db2dcc73mr210077f8f.28.1755806906301;
        Thu, 21 Aug 2025 13:08:26 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c077789d12sm12702699f8f.54.2025.08.21.13.08.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:08:25 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Alex Dubov <oakad@yahoo.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Lars Persson <lars.persson@axis.com>,
	Alexander Potapenko <glider@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Jackman <jackmanb@google.com>,
	Christoph Lameter <cl@gentwo.org>,
	Dennis Zhou <dennis@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	iommu@lists.linux.dev,
	io-uring@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	John Hubbard <jhubbard@nvidia.com>,
	kasan-dev@googlegroups.com,
	kvm@vger.kernel.org,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-arm-kernel@axis.com,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Marco Elver <elver@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	netdev@vger.kernel.org,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tejun Heo <tj@kernel.org>,
	virtualization@lists.linux.dev,
	Vlastimil Babka <vbabka@suse.cz>,
	wireguard@lists.zx2c4.com,
	x86@kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH RFC 28/35] mmc: drop nth_page() usage within SG entry
Date: Thu, 21 Aug 2025 22:06:54 +0200
Message-ID: <20250821200701.1329277-29-david@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821200701.1329277-1-david@redhat.com>
References: <20250821200701.1329277-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: s18kw5tPNzWhgeYpsfX53ZGn3zQSnuFQYBLGjozn89A_1755806907
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

It's no longer required to use nth_page() when iterating pages within a
single SG entry, so let's drop the nth_page() usage.

Cc: Alex Dubov <oakad@yahoo.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Lars Persson <lars.persson@axis.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/mmc/host/tifm_sd.c    | 4 ++--
 drivers/mmc/host/usdhi6rol0.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/tifm_sd.c b/drivers/mmc/host/tifm_sd.c
index ac636efd911d3..f1ede2b39b505 100644
--- a/drivers/mmc/host/tifm_sd.c
+++ b/drivers/mmc/host/tifm_sd.c
@@ -191,7 +191,7 @@ static void tifm_sd_transfer_data(struct tifm_sd *host)
 		}
 		off = sg[host->sg_pos].offset + host->block_pos;
 
-		pg = nth_page(sg_page(&sg[host->sg_pos]), off >> PAGE_SHIFT);
+		pg = sg_page(&sg[host->sg_pos]) + off / PAGE_SIZE;
 		p_off = offset_in_page(off);
 		p_cnt = PAGE_SIZE - p_off;
 		p_cnt = min(p_cnt, cnt);
@@ -240,7 +240,7 @@ static void tifm_sd_bounce_block(struct tifm_sd *host, struct mmc_data *r_data)
 		}
 		off = sg[host->sg_pos].offset + host->block_pos;
 
-		pg = nth_page(sg_page(&sg[host->sg_pos]), off >> PAGE_SHIFT);
+		pg = sg_page(&sg[host->sg_pos]) + off / PAGE_SIZE;
 		p_off = offset_in_page(off);
 		p_cnt = PAGE_SIZE - p_off;
 		p_cnt = min(p_cnt, cnt);
diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
index 85b49c07918b3..3bccf800339ba 100644
--- a/drivers/mmc/host/usdhi6rol0.c
+++ b/drivers/mmc/host/usdhi6rol0.c
@@ -323,7 +323,7 @@ static void usdhi6_blk_bounce(struct usdhi6_host *host,
 
 	host->head_pg.page	= host->pg.page;
 	host->head_pg.mapped	= host->pg.mapped;
-	host->pg.page		= nth_page(host->pg.page, 1);
+	host->pg.page		= host->pg.page + 1;
 	host->pg.mapped		= kmap(host->pg.page);
 
 	host->blk_page = host->bounce_buf;
@@ -503,7 +503,7 @@ static void usdhi6_sg_advance(struct usdhi6_host *host)
 	/* We cannot get here after crossing a page border */
 
 	/* Next page in the same SG */
-	host->pg.page = nth_page(sg_page(host->sg), host->page_idx);
+	host->pg.page = sg_page(host->sg) + host->page_idx;
 	host->pg.mapped = kmap(host->pg.page);
 	host->blk_page = host->pg.mapped;
 
-- 
2.50.1

