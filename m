Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6376E34F48C
	for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 20:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806839; cv=none; b=eX/QWtmWPHJUYw6vYVCnQZKn9BDpMXboq3oCjbPZCPXnbPxNbyjhgG4/hWiz8iQ/QtmDiIw86c+FfpUy1PJElA2b86lnSsLFmc7e+bOTs35p7o+AoOw+1kzNUbdPogrv584R94lhuJ7Okg42WrRALYRcSDUlaFi1PDvhd7GWQ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806839; c=relaxed/simple;
	bh=3FOM28sJXvbUF2Tn/5jLCVekviR1dLu1+OtM4m//AQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=aUl3gokNF0bVFUXNbkPLUR1r5YeVXuKmitcTskefhhymEDy4yn/4oLaGhojW81n4NZehQB3B5awIELwME0XTvBf2FvTgbviOubfsO3P5AW9+dZW7qDrWnyU0fG2iewsO6JO9ekw0Sj/oS3gKdsQB5fmF1jL5+98sdBTCiWMrVY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HgJ7eRIi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HgJ7eRIi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7sWLap5u4LkaWlbSo2T/W3JLtp2tuveUv2Z9sucaeo0=;
	b=HgJ7eRIiRnHUwprw8uD+r1ajPbmAARMgTrShQtGg1sioMAt8EgUgFef4vrY+ot4FQmuFbk
	0Ii31kXOjJrOklrts4rPKdqCnpL3OwIhKWoYf1d76pOXYRfVgQeRDIgAAGOPPypiYEq77G
	Yxj9qQkyxewoHCwOAyMLSjVhWqngJBU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-mAIvAUmtOnK49MMILMLieQ-1; Thu, 21 Aug 2025 16:07:14 -0400
X-MC-Unique: mAIvAUmtOnK49MMILMLieQ-1
X-Mimecast-MFC-AGG-ID: mAIvAUmtOnK49MMILMLieQ_1755806833
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1b0ccb6cso6963365e9.3
        for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 13:07:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806833; x=1756411633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7sWLap5u4LkaWlbSo2T/W3JLtp2tuveUv2Z9sucaeo0=;
        b=nyw4X07XD61ERR/tJXR7s5DMqSYTGCAmtG8DLELSBXY/k2jhL7TFPFg4aj80+R7SO6
         tdkcWAA8kgfS6IWMzBk6XL9ytzKV2B9wv+H/lIEFxFrbmsf40yvLngh813RgC+m0GC+e
         9OZZIkbeglK4qs016EcTNtLepKX9nDzYoyOcNEe2OCwhU094rq4BtFuY8pxFxsyP+g9l
         way1iA25MdhztWe3KfSgm8N+X/JFEzFGO9YfEBXF49ERsr9FIt8XcdJJFRRX/4f7gxe4
         Zx7mo/d51PIAjke+ljLzeP6za4DOnkeLxy4cdtza90XOaskAAlNmnb8Eb1Pon3Ff73pd
         K+Mg==
X-Forwarded-Encrypted: i=1; AJvYcCUbhqDqxt3rQgEMh24FRLLygrrUDdmLoI8sO00MP+76JreL0NkZmT3f8+k1ooa2IknH7iYuADpBCljqpmmDwg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxVPdy4wqQQShV1ptnhxthLFBVzFmSFSURQKovZ5admqDqn6JCE
	WW4CbSncnl5jBUL9LkN3q99++KZqMLTKKLNOI0TeG1vgz0VdTUojik3GUg8s+Lk9JjhWoiaMtvh
	jfGL1k4wX7+hyYsZeOqosDqoBkwa/kKzDeaB41Q5GO1TdSsxPnlj48jLkrXHRajonCPxL
X-Gm-Gg: ASbGncu0l0Hwmwh7balbbLm2xFPgNhyvaTICCN5jzYf/AbV7oXnUIl8T+tdImyFtI0s
	YN7PqpX17bmBafKrRXhPhb4FK17DHmaSGBwsdhFQtlebER2L9TAQSwyYNFo6B/JPo21CoiAetiC
	UYuNSr6H1nmnf0eY95/Jj2XP6uV+IGG8KsCzNu9jFfpBGr2YEKh0FOqfMzAzReCXMfkYDE7mrp2
	JKFd/hzJiLo0MNnLDd0CosOuQ8Ys3uxQx55QGACTYMvSkfcAGwFkEUY13LdKBHVUa3HjtXVoSFA
	AB+3tpbWiyltvdGCm0dORwNy0SPDCsV7AJcJ19TQIWrDKDIXDsg/Lg2E0HAGVfg/I00zaVdHACG
	HmTwJblA4uv2fpVEGDhp82A==
X-Received: by 2002:a05:600c:1d06:b0:455:ed48:144f with SMTP id 5b1f17b1804b1-45b5179669dmr2598225e9.14.1755806833345;
        Thu, 21 Aug 2025 13:07:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSutx6qbatKffMJ28UfT2ZDXFlSv+vNq81oYks3KAGI73zxxTWKo8ClwQ/mmPq6W0wDfVQow==
X-Received: by 2002:a05:600c:1d06:b0:455:ed48:144f with SMTP id 5b1f17b1804b1-45b5179669dmr2597955e9.14.1755806832889;
        Thu, 21 Aug 2025 13:07:12 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c0771c166bsm12916801f8f.33.2025.08.21.13.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:11 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
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
Subject: [PATCH RFC 02/35] arm64: Kconfig: drop superfluous "select SPARSEMEM_VMEMMAP"
Date: Thu, 21 Aug 2025 22:06:28 +0200
Message-ID: <20250821200701.1329277-3-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: Lrp4g679CdZvnhQzMZ1TeUcOOljRJWrCj18UH9c_evs_1755806833
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Now handled by the core automatically once SPARSEMEM_VMEMMAP_ENABLE
is selected.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/arm64/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e9bbfacc35a64..b1d1f2ff2493b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1570,7 +1570,6 @@ source "kernel/Kconfig.hz"
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y
 	select SPARSEMEM_VMEMMAP_ENABLE
-	select SPARSEMEM_VMEMMAP
 
 config HW_PERF_EVENTS
 	def_bool y
-- 
2.50.1

