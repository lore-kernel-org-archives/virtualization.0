Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E823837427D
	for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 20:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806909; cv=none; b=JqCI/BzhFLJva2AV9nScCuGUp7yDTu75pQgzFc4jYxWLizCFE4I+copHJp3OJYWy/5JnKiv7O23injqr74P/Mq2aBau/azdDEv8A12H8a6LvkeSnNW4kmj9+EXY1c1nELRy/E82PKhuPCCuPLoLm6MiK2BD+698+5rmvBC5vVnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806909; c=relaxed/simple;
	bh=bq2gWh1hWRAlT57D1zXSNbOueAtiEim7ETzHNFHN/Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=iPe00ZB26Bnk+P1C81ct42pJMB5MLV4bRP7LOIs6h67YYXDPsgt27jqAiTr6NzsW3QR32JfGwIdMQ0GRaQlMtwOmTYJqJq5oepnU0Zx4ernecpGjQYBhLYmot3JciVlnLFvhvH1LIbH1Wcpxkze+F6H1CL5+fIz3Ju90fEqo86Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DpJ2gAzW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DpJ2gAzW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yR/3u5W37RASrGsn/s3pQVQ78UUgH4ByCavV3b4UG3M=;
	b=DpJ2gAzWYwi7Z9Viv2yUpZ7N1lD0RdYGI/sPgYXnlupS2AH6sXLySPpgMos2zuETN9W14L
	e0gW2avxc0iiw7xV8wOmW0OMUEJNoron21zFbawAq/1u6csGxhGbsjknuPmfMn3XsRsaCS
	2B3Tt+Fth9wJqNKKRa3Tchr1gEJuXtw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-pc5siqFWPeW1bIFhKBIAvA-1; Thu, 21 Aug 2025 16:08:24 -0400
X-MC-Unique: pc5siqFWPeW1bIFhKBIAvA-1
X-Mimecast-MFC-AGG-ID: pc5siqFWPeW1bIFhKBIAvA_1755806904
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a15f10f31so14275055e9.0
        for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 13:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806904; x=1756411704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yR/3u5W37RASrGsn/s3pQVQ78UUgH4ByCavV3b4UG3M=;
        b=TfvTRnxfqzPuoatG07q9Oy243GAy9c1rFJJE+ebWFFdMpeGZD/wr0MI+TRl2AhnaLr
         AWsmkKMTonxblW96JzOQxBRSaiz2wpGX0rPyq5iqVscmHYCrkXSB+tD6bOjVRYuaYfDD
         fjQEsgcj7RRHOmpwSH/2jsn44JQrvkURKIhlWrofDp8r7YULFccoTttFAmawPCEygbFH
         gsF87IyNbvcbfnlx75+vHMRjjUukTnfPXU0kXUKi8nbUC12X1gZ5RPQnCtvSXrdDRUR9
         hbqaO3y3FpnjjH74aN29wMTHFjx7YgAbqqxxouzGu1DEgIbgUaNasJFABLekatr6mh2G
         gH+A==
X-Forwarded-Encrypted: i=1; AJvYcCUU/qVkjFNSVY6gwSB/lp53wiH2YGquE8NxXNnno1QWa+oKBry5+VqP4lYu7qplZxxoVxbpe9wLFmrSMZE6sw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzRFKrb+i/fwN+jRcRge3/6UgAL54tI191cckhBEEQbXxBnbxps
	SQG0cVi2XMymK88Ut1T3+FmLs1C0BZzXXJbnOCkAy+KEP5FHoArvVxavv7qrcTRQOZ3f/1ovncy
	fq/PbKjEaRoh4KS3jV9NJT2y55UlPzOsyhd/jlo2MCM4lAG9TTYXxiviRrvEbQZWElh/y
X-Gm-Gg: ASbGnctEFrGoax7lyiuTVQ98fHDmu+wMhwvTipmORj1eTYrfaOcqCChBqETcVN+5zTZ
	dHd4icc3HkdihukOFNTnAXLNFqDpSv2HV88Er0TEvhLxbAYeod9Mh9h0Xft3JDFnX6BQOoIHPmL
	zT1P7i9gtnD8jR0f6mQnuNGQ6c07jOqsZPvSI4ziAwHRIbuGqGJ7K7bC7IqaMTIfwhIPjjHbLrQ
	RYTGE9scxQnJ+yB0K/6vtvYwp6JM8HoSebWuG9/OaUXc2D0fkMrsmhS62dhvuoddtCcQTjUW9vv
	Zdb6KtOhLidJqP7aWHT9EhpAib5Lv40xtMZsYFhHWkKAU88KcP41ARYWSLOj4u2ptnTISVs4nAI
	vFwdfEi+EA487joeXpu+TKA==
X-Received: by 2002:a05:6000:310e:b0:3c3:5406:12b0 with SMTP id ffacd0b85a97d-3c5d53b40abmr247301f8f.30.1755806903656;
        Thu, 21 Aug 2025 13:08:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+53ePp4gOBoZK5+aLlST4uu6G3xHtHBUa0vmdrbtPfJ4bf44S3Zn2IpCr0m84pAneAOD81g==
X-Received: by 2002:a05:6000:310e:b0:3c3:5406:12b0 with SMTP id ffacd0b85a97d-3c5d53b40abmr247245f8f.30.1755806903113;
        Thu, 21 Aug 2025 13:08:23 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c0771c1708sm13032145f8f.38.2025.08.21.13.08.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:08:22 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Maxim Levitsky <maximlevitsky@gmail.com>,
	Alex Dubov <oakad@yahoo.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
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
Subject: [PATCH RFC 27/35] memstick: drop nth_page() usage within SG entry
Date: Thu, 21 Aug 2025 22:06:53 +0200
Message-ID: <20250821200701.1329277-28-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: DJS9bieAUAkxp9qqT3C4-dXAQ4OEa21cPtJaIKqERT8_1755806904
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

It's no longer required to use nth_page() when iterating pages within a
single SG entry, so let's drop the nth_page() usage.

Cc: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Alex Dubov <oakad@yahoo.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/memstick/host/jmb38x_ms.c | 3 +--
 drivers/memstick/host/tifm_ms.c   | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/memstick/host/jmb38x_ms.c b/drivers/memstick/host/jmb38x_ms.c
index cddddb3a5a27f..c5e71d39ffd51 100644
--- a/drivers/memstick/host/jmb38x_ms.c
+++ b/drivers/memstick/host/jmb38x_ms.c
@@ -317,8 +317,7 @@ static int jmb38x_ms_transfer_data(struct jmb38x_ms_host *host)
 		unsigned int p_off;
 
 		if (host->req->long_data) {
-			pg = nth_page(sg_page(&host->req->sg),
-				      off >> PAGE_SHIFT);
+			pg = sg_page(&host->req->sg) + off / PAGE_SIZE;
 			p_off = offset_in_page(off);
 			p_cnt = PAGE_SIZE - p_off;
 			p_cnt = min(p_cnt, length);
diff --git a/drivers/memstick/host/tifm_ms.c b/drivers/memstick/host/tifm_ms.c
index db7f3a088fb09..0d64184ca10a9 100644
--- a/drivers/memstick/host/tifm_ms.c
+++ b/drivers/memstick/host/tifm_ms.c
@@ -201,8 +201,7 @@ static unsigned int tifm_ms_transfer_data(struct tifm_ms *host)
 		unsigned int p_off;
 
 		if (host->req->long_data) {
-			pg = nth_page(sg_page(&host->req->sg),
-				      off >> PAGE_SHIFT);
+			pg = sg_page(&host->req->sg) + off / PAGE_SIZE;
 			p_off = offset_in_page(off);
 			p_cnt = PAGE_SIZE - p_off;
 			p_cnt = min(p_cnt, length);
-- 
2.50.1

