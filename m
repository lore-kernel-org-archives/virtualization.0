Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1693570A2
	for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 20:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806843; cv=none; b=ux/kHjm0w/OEC0qqxgPpwIgGxh3MkbGqdzm8Tjdh0V0BRZFwhOIArbgqQmW/09w7oPUp60L7x5PnRaxYpm8w2+uliRK9gHIS9su4hWruj/URmPn2QSqnc4162XLFFQwV0Z17OLoPk8dQ0HnePXXkqEBALkRyGSvxN0Ur6jVDt4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806843; c=relaxed/simple;
	bh=rCgYuDQcQ3nJcWNFmOxD+pxeBEJSNoep86nFob2zhE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=d0Csahx1KdYRm4/Q/lbY6qhzgOuE/CBaNBCUIWZt0Q0m/GWMqTrCN2JdAIT6n0h6hsy2IVtwP8d2bfHt3rscbFuZNE4Z4/Shjw/q7PTimscChBqyyqsTHhze5syh7POfJN9C5BuMlsyPbukYLIJwYGtyGcP/WNuZ2GkD+Kxk6zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eZz2HS5Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eZz2HS5Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zfh98TqNQqR9uCNr2hB5bEgIJ/15ql7Yv0zNbj5EC/8=;
	b=eZz2HS5Qgs5GbFryREYKUIuQwxjIV5l8GYkR5rCxpmutP66l20cyymv6OJXBFPnkVJiiOm
	9imNhPkrJzOUJb6l3twWFtllMa5v8Xww38KWLzsCnvvre2TT0b4qyjGdzQzPaje2a1D1YV
	95ieoU2LuvsfMHV2YAfxj7ta5lWALWQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-wWGfjlweNBWC62W-O8PkYg-1; Thu, 21 Aug 2025 16:07:17 -0400
X-MC-Unique: wWGfjlweNBWC62W-O8PkYg-1
X-Mimecast-MFC-AGG-ID: wWGfjlweNBWC62W-O8PkYg_1755806836
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b9dc566cb4so995957f8f.1
        for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 13:07:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806836; x=1756411636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zfh98TqNQqR9uCNr2hB5bEgIJ/15ql7Yv0zNbj5EC/8=;
        b=UaFAXynG3MpvFaclXeGqUdLPOR83Bc7ZIatT4605klCmFwrbWH8u518EtwuPPI5hNi
         vdkI6FEVg4ICzmz/zwVQZfX05az1mdvFoaJGcdNXNAdvYyH/fc3GpyktZc1N4vj8lNrL
         2uRjmJMokj/DDZ3AzW3YyAHS6axC63mIR9Gq+wGF4nXrcr25KJv8st5v7i3mDwSzQWwN
         Hyp7zgY1zPBuiCzNLSOn+s1ZjhJduoFL9VDbLxyIqmCIc0n93c76OJPkhb3qsT6DNV+u
         eTQDULwvqMzU2+GGYxKFP8ohLGtt/mPaq4xL4cbb2aP+UoJWucUINioEmFlWQDbzCQg4
         Ui4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOWz13u5g6c+5x0RMr0aSPzwSLvKesedyED0jvuQIq/nMFdQ6zuCecZXjSMo1c2zH49wGfwEC98phhOTY++w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwAfhSLA6qGHba3zeRyrlcYex5NpQVVz8y4Uk0pPF5CAnqItU5S
	5ZdhGsSKFdxszY8AACyafnlklMP4/ws04en2q3RAPTACiGYhJjz05F2wht91SJpprvw5SUiUL16
	5caicxVFKsDu3SUakNYld+74NwCFqOh/bhNxTDRUEf+NIZ4UHgBFFEWRJUqrGwcfEToUo
X-Gm-Gg: ASbGncsm6OGJGIQhs9sTVgW3ndx67y2aVp+ZlH0+39c8H6aAtAyofGDAJbM1M8Tv+Pr
	SdywVM+2FUFTGQ+ZcpdUYTwz+KYcxSEebvIxgNRO55ZgXGs1utH0261VUUzXUAIp9U6FhjhPAiK
	JAtdQqUu04KTCWBi41csqoZZK0YR0GJvPD5kx7dA+Ax4xCxs75Z8HFgWgyLv2qXuUFMo3OVtRH0
	8eCWcWNBPKJFGplL7/jkoxA0Sun/dUGZsNLx52Eut5SoO98cl/m+ZnRIyENrhwhlnUP2+hnL507
	XOnK5hPtKFV+oMDMYa0GDcB289gfKIMKCgpYNNzhxmV5LFLGO6KGyXYdayIGXn0I1+sZTGv8hLI
	C3a3d/13/uEJzOQ4RE3gMxg==
X-Received: by 2002:a05:6000:1445:b0:3a5:27ba:47c7 with SMTP id ffacd0b85a97d-3c5dcc0da36mr162991f8f.48.1755806836144;
        Thu, 21 Aug 2025 13:07:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpC+bUbLbCjHqucY3RiMYJPd72Xl9UYU3JmJwOiC1ZPXsKWXLLEiwWSHifO8HwGgrBWSbiEw==
X-Received: by 2002:a05:6000:1445:b0:3a5:27ba:47c7 with SMTP id ffacd0b85a97d-3c5dcc0da36mr162946f8f.48.1755806835650;
        Thu, 21 Aug 2025 13:07:15 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b50dc00a8sm10958175e9.1.2025.08.21.13.07.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:15 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
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
Subject: [PATCH RFC 03/35] s390/Kconfig: drop superfluous "select SPARSEMEM_VMEMMAP"
Date: Thu, 21 Aug 2025 22:06:29 +0200
Message-ID: <20250821200701.1329277-4-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 4CztTlAEbAKBV2y35glRaqRAbutOZ6RWPIDRa2MGnn8_1755806836
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Now handled by the core automatically once SPARSEMEM_VMEMMAP_ENABLE
is selected.

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index bf680c26a33cf..145ca23c2fff6 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -710,7 +710,6 @@ menu "Memory setup"
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y
 	select SPARSEMEM_VMEMMAP_ENABLE
-	select SPARSEMEM_VMEMMAP
 
 config ARCH_SPARSEMEM_DEFAULT
 	def_bool y
-- 
2.50.1

