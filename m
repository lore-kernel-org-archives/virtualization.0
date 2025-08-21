Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3533F371EB3
	for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 20:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806904; cv=none; b=rb/tPS4HCIqZNfNBRxMQXWJxNsWYAKJPcBQvODKJuounvVe3JgQ0g37Hs1U38VQF+1IbYhMH6XiB83Wwb+R5Iffo0IgWt+Ot4XlIfSAg4GksDHph6uEkIVAwS7aE1ftUvBpSq5ZWpBytFjNmxshuPkLFWcMbViMPew7yksTL8Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806904; c=relaxed/simple;
	bh=r9aVOOwiYkYkJ2XxN3c4oDiixJCUuv2T31t2h3Fc0ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Jzlvu824qpDvuJKQlgTvjTjCYgyedEyUzn5siuQGqhhCY2sLCjJ7Vh1adu21BRJuD50zCEzheQ/11iFdf1S6F1qtBJFxeriugTQC6FI6pUG3s213fh8bXLdxDhx77Sl9CrrKBFRdfbU8+cXd0hJBpe+v9sBfTUmezvckZIE7x1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VHXQnlag; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VHXQnlag"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5INZuVEW8ZoCVRVHt0CSLhpT4h786L9PUsnD4NVlnkc=;
	b=VHXQnlagpzamWqw2r6ysufuABBblpE5+d8b9qzHLlz7bzDoB+8N8sg3N7ATQPLlIwkZrKR
	cgW6U4E59jMI5TnXzVoMfwlsuhFBXmRY3L3nF9KEq6dhoYLGrqVEuVLadXdDj9CRS+Flu7
	o1gyKGC6di7fo0+9whgfjWohez+4aYA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-2KnlptuNMdeOkGkX0_eRqQ-1; Thu, 21 Aug 2025 16:08:19 -0400
X-MC-Unique: 2KnlptuNMdeOkGkX0_eRqQ-1
X-Mimecast-MFC-AGG-ID: 2KnlptuNMdeOkGkX0_eRqQ_1755806898
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a1b0c5366so7719045e9.3
        for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 13:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806898; x=1756411698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5INZuVEW8ZoCVRVHt0CSLhpT4h786L9PUsnD4NVlnkc=;
        b=jEk1GSxlWnbJAqcjBmRIkgk829frFqdw6DwHdm5S8wOwaLUCN2qB344rATnxrrm/vZ
         k51qIydGo5LzrIEIulyJ345E8QZTyDAMaG475pJGGDAvytbCZH7mLaZd/x+tGqS9OGXU
         HsSTOViTNHFWPnXOXDdCfpGbSFq0X4wHc7aNktiwfDwfES2e6ufZvl3WYSYi0brRGwhk
         Vr4uqymPwjsCwJ+baPRRhcUfAmVkDLLOb56qkS4P/RAWkfyyh+KP0SaJgrNxbeLcXkWX
         zcEBZ1qYC4SAY81oFlj/pISfe2w6p35HH0D0dmLiRKe9xPlmfFjBPAX3FRFEdToi1Pwa
         Vfkw==
X-Forwarded-Encrypted: i=1; AJvYcCXKS7aQNH025UixdYMImtLGk0A1WKLDJpM9saOmZOknm10crrpebzlGj73psAsmWYvH0rtuuqGBz7xg1OGEJg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwMwItL4kK7EAiEgXBmmFx6lYhGzu6kVOVblUX/1M7nFprqD01T
	xcIrqv6tuSTuey4r9/3aNaSbB/XE39CGePueOcmrpbKktFBy74rlf7xWSj4MrFhemvwsE+N5u9D
	k86+d0M3DExhSW4I9eY03jfJQQ20EFdufk0YpNXwpNacL46SAobiW0ckhTWHwWqXmrXYl
X-Gm-Gg: ASbGncuG7OTAXXiQ73ryPynWB811TuFynlSTGCn8DlGDWONfS+ra+1Av3XM8kOKpOa3
	4zJcF0xIqkt7JJSN6/mYGOTXR76LNou+QadlfLGuq5tE72JE4YNIajjeRcn4sMVO0IHpcfSYPPU
	xZPzaahMXWM2yFCzxznWrRCuBLY11KNI/rb0Xo6qx8PLE5Es7rVHRBZ9fcll33xPd/jbJIqLRWV
	xTmvrjJtWrdaQ5+ao84esybhfzbBMyEt05MDFrbIXhavvA5kJ7Z7YCNKeaGeH3tz3Yqbv89WGA3
	znco+YRqhBYPSmaos2lypAj6sHbiNzyT9umonnLWuVcNKSTSG/EwkuMYJXVTp50qpH6PE7A7CvS
	DgxxuV00SVm9yLagwVh3o1Q==
X-Received: by 2002:a05:600c:470c:b0:456:285b:db29 with SMTP id 5b1f17b1804b1-45b517d416bmr2506315e9.29.1755806897492;
        Thu, 21 Aug 2025 13:08:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPdYXvWWhsiYzUao4v8GSpApokx2tOJxTxGWaryOs6bj53AmOc+7o5w7P2pIRGnKU6jzi+ow==
X-Received: by 2002:a05:600c:470c:b0:456:285b:db29 with SMTP id 5b1f17b1804b1-45b517d416bmr2505625e9.29.1755806896948;
        Thu, 21 Aug 2025 13:08:16 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b50e3a551sm8831035e9.19.2025.08.21.13.08.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:08:16 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
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
Subject: [PATCH RFC 25/35] drm/i915/gem: drop nth_page() usage within SG entry
Date: Thu, 21 Aug 2025 22:06:51 +0200
Message-ID: <20250821200701.1329277-26-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: PuPWkIZC5Pl2z0LtGMfWdJkUDjFYUWV_WNcajHDCpV0_1755806898
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

It's no longer required to use nth_page() when iterating pages within a
single SG entry, so let's drop the nth_page() usage.

Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_pages.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_pages.c b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
index c16a57160b262..031d7acc16142 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_pages.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
@@ -779,7 +779,7 @@ __i915_gem_object_get_page(struct drm_i915_gem_object *obj, pgoff_t n)
 	GEM_BUG_ON(!i915_gem_object_has_struct_page(obj));
 
 	sg = i915_gem_object_get_sg(obj, n, &offset);
-	return nth_page(sg_page(sg), offset);
+	return sg_page(sg) + offset;
 }
 
 /* Like i915_gem_object_get_page(), but mark the returned page dirty */
-- 
2.50.1

