Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E2232693C
	for <virtualization@lists.linux.dev>; Mon,  5 Jan 2026 08:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767601405; cv=none; b=i/X2f4ZoY0rPw1mbeIr/WZPgQa+XmlXJ6BjPWmt0iQFE6Mg6k1PK2oVCI4gosJes7mertaiDL8uP1C6qWR/VfhHpj3RVz867UiAcExYTywonOTBu6AB9bFdeg6Q58wGTK+1BrsZ1TUCML1g+inzYnvEvkR8wfncgGdXkNv8bxmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767601405; c=relaxed/simple;
	bh=3EF4beueqssYSrJr7jAiyWtRxi/ynmIi31SbgxtAbxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=KtCehl0vrqmYxLT4Ps4xstR2La6WHZ0SaDtbx+UGwQdiWPN1VW57rKhDKhfUm3DudoKJkQlfyglPS9Bz5ZTQRwac4DgZ42Iz3e7FG0eEHuP22YGg/i7LBtM8zo0zM/e8+gKO7R1mDlLG/WR1B2q3cevYPP8c/lSMNq5mGMzqv4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZuLRiZAp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZuLRiZAp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767601399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jlkdUJvLxIuG9RkypEQ1odBgc8hsD/vyeqVzWJtThQg=;
	b=ZuLRiZApR4tn1mofQ3H+f1rjFL9OIrUou6OisAR+h0P6gG5utVUhGbySrfFcF40I6MwbYh
	8kainPTo/2527Xy4Mc+fENoGq9yUhIya0Lsbd48ucJi7dHs986pBsWoUhZMY5vOS2PTsl+
	foEgrO/cAM3NsvVWKCnKPoIMwudJMz0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-AYv6fmtmP3Clb4sf9FVvbQ-1; Mon, 05 Jan 2026 03:23:14 -0500
X-MC-Unique: AYv6fmtmP3Clb4sf9FVvbQ-1
X-Mimecast-MFC-AGG-ID: AYv6fmtmP3Clb4sf9FVvbQ_1767601391
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-430fcf10287so9800527f8f.0
        for <virtualization@lists.linux.dev>; Mon, 05 Jan 2026 00:23:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767601391; x=1768206191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jlkdUJvLxIuG9RkypEQ1odBgc8hsD/vyeqVzWJtThQg=;
        b=PJmY7mY/FEpB4hZY485/m2nQeibBzLjWwGTniGEKd8DvaCD9k6fGUy+W2fY5XOFOCr
         5Rgdyr5ayQFxpNjg2gji6AYKrQ4i2pIAMKTVLaj4IexWwOMJihTqrLWtowdDZFP7J3+E
         hpqNS4U0ASnwVplQY3FVJQ0BNFQXqT7q80ymty2XGOutBd6mPBoyrERX4o7iCdp7mydz
         W6Lhckea7lCxPl7dLl2uvZfBMpjSKAbbjo3bf7Z0BKBHVAIuwcPrp/h88u1BAkHep3Mg
         9+wtNZhK6EpQq1evwbNlLwfGJzetoOeofgg5OYtKaMlNwG02w19iGSIPX5Z8YzIZj4pA
         6eFA==
X-Forwarded-Encrypted: i=1; AJvYcCUx5mDmxPct49rdw7gY4Dd4NlOcbDvnuS0KxlmkstepqpKf6yU+cHQlToFKIFsGHnawnQu2JrhsKBtyFq7PwA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxxpbvLJthnKH8yPLYG4W3UAf+7z9b41IKlUqZwu+5UPMHgv2NT
	nVu2BeahxC0SrE2u1MGZdm+pqnqQ6ZNo1zsNwTWnbKfGSLsqsrZvcX+NOfyjvNvpPqVT9PcyiX4
	FlTqxXtDb65uijWonFC6A45rYLg2e7YJagWU5iOVbLiCFKgOc/xS7rKwqa/axayz40a+Y
X-Gm-Gg: AY/fxX6shFbnUGMSdAvJL5QkDPWz3hA2OwYMXgy8Z9ztdfMF3Uy+owY5lI+gECsM2E+
	SUKJfTm3fEgLy8xeMCqQZ38gJ3JfS+OW8MB09/FiO4oBvlChy/D/WPTdKtUUz77iV447sm+XUgD
	HTE/grKwRhnDvrbDnDbJj89q9Esiprw+Q2WyoQE5nmVJPMc3JnQHLQCYwH2P4vnuaRw/tx8SqRE
	+qMhEcNr0R1/N0ZTtzOahf2NLxXXxG1M+z5utMfS9Y+3GvqDQ1sfuWVvaPDv2vh08RNIdDn1edZ
	FmHHIJdoUIurVJIOJhMkqgHTFql2NFVbxXEDQfDDiuv66whkx2pw3ORsIxJwam1tnws+foRfZ5y
	JU2vvNQ5uWhL4oSf0ltKBmUlA1v8ApYq4oQ==
X-Received: by 2002:a05:6000:2c03:b0:42f:bbc6:edc1 with SMTP id ffacd0b85a97d-4324e4c1230mr54966700f8f.1.1767601390662;
        Mon, 05 Jan 2026 00:23:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwk1Ttr1N2m9x2GBHG1pWtih6zeyM7Sr9HAGjGkjK9L3/ihsrFeD/P27Wy0cj6YonFT6KolQ==
X-Received: by 2002:a05:6000:2c03:b0:42f:bbc6:edc1 with SMTP id ffacd0b85a97d-4324e4c1230mr54966659f8f.1.1767601390077;
        Mon, 05 Jan 2026 00:23:10 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa64cesm99604028f8f.35.2026.01.05.00.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 00:23:09 -0800 (PST)
Date: Mon, 5 Jan 2026 03:23:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Petr Tesarik <ptesarik@suse.com>,
	Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 04/15] docs: dma-api: document DMA_ATTR_CPU_CACHE_CLEAN
Message-ID: <0720b4be31c1b7a38edca67fd0c97983d2a56936.1767601130.git.mst@redhat.com>
References: <cover.1767601130.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1767601130.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZV2on2-RYTbkYsHZ2YOLB5Or5K2RtFHJ34OLEesYaag_1767601391
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Document DMA_ATTR_CPU_CACHE_CLEAN as implemented in the
previous patch.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 Documentation/core-api/dma-attributes.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/core-api/dma-attributes.rst b/Documentation/core-api/dma-attributes.rst
index 0bdc2be65e57..1d7bfad73b1c 100644
--- a/Documentation/core-api/dma-attributes.rst
+++ b/Documentation/core-api/dma-attributes.rst
@@ -148,3 +148,12 @@ DMA_ATTR_MMIO is appropriate.
 For architectures that require cache flushing for DMA coherence
 DMA_ATTR_MMIO will not perform any cache flushing. The address
 provided must never be mapped cacheable into the CPU.
+
+DMA_ATTR_CPU_CACHE_CLEAN
+------------------------
+
+This attribute indicates the CPU will not dirty any cacheline overlapping this
+DMA_FROM_DEVICE/DMA_BIDIRECTIONAL buffer while it is mapped. This allows
+multiple small buffers to safely share a cacheline without risk of data
+corruption, suppressing DMA debug warnings about overlapping mappings.
+All mappings sharing a cacheline should have this attribute.
-- 
MST

