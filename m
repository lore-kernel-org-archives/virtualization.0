Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B64350D7F
	for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 20:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806899; cv=none; b=rKKsVVvuCIG/TH+F3/xHypKIE6V2ziTNc1J5gqOltx88+AL2ve3yDP04bzsxvBxbGb5j38A4meFbqF2FyK1qIhISf3t5Ic82BVIzRaT6WwslPjhPJLWlIOraOA/rx9J4D17CfV3Yd3Lrd0MHweZQ5dPnHVRTNWT1KXzfnjm/n0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806899; c=relaxed/simple;
	bh=o0B/aIsMAhafmNCelOfWp+ALdEBw0Dyti3dxNNba1Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=RHQwWjQGIbqJ3zCOs1rV8U0N2TQUHHjBBvbvNI9YuQ0GnBxaV5Jpkd86Sz2EkRly+x/OWBLOhIgylmEHZ2s34TPX7a6i1oIjLp427gUkK6KN71HQb7raTxR/9wyNtWpftSIrcrQhgCSzPNBzVAaMl/jSFYpiMA4B1MV4OyVI1gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RpPHIlIz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RpPHIlIz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qEz5al18caSg7WeU7/xaDhHrA43/vq8xaUIrOF+uMyw=;
	b=RpPHIlIzTn2wy4DImGCL6lMrvKPiPAG8KmWV9t7khMbi/4nUYWvaLrEGXrPwNwJ+42n/uC
	OErGeNh7AqwBjFtTuJHcMlvC/WwdcxMjwcrabUj3JwiQPwlUalSi2xA3/3xdEl5JlXksFy
	YllAkT3ItE+u3VH4kKDNhliOVy9zE1Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-HFAeOn5oPlORT1AsHvWZAA-1; Thu, 21 Aug 2025 16:08:15 -0400
X-MC-Unique: HFAeOn5oPlORT1AsHvWZAA-1
X-Mimecast-MFC-AGG-ID: HFAeOn5oPlORT1AsHvWZAA_1755806895
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b9e743736dso787495f8f.3
        for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 13:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806894; x=1756411694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qEz5al18caSg7WeU7/xaDhHrA43/vq8xaUIrOF+uMyw=;
        b=dR83HJCZ6dx1f3VRdIkXoH4hnNOBFqSWKyKWGQnvknDsHRGwJyrDq7gkzsIBiS7D5C
         v6ILH7IY36PBBfNLr2zopJp/6ViEuUWFmGhFzhyP7732oyJiaWk5rHs/cy9InXZD/ito
         DXgtaL/aY1j0fm8eEq3IP/Fn6Bbt6YgcQyzz8d83/n1XfT3BHoeSVRCXnGCKOoRglZe/
         QIFMkSfBe/JZ4VMQaUMtPVdUSpxlFb5NrWcM/nQRgomWZzkmRFlmj/jmkJBDXEUcY062
         UVqC0FeeFeovfehNN/5E4OD8d+fd7sM8z5acln2eF0yS3A7t6EyBxvk+L9ceG5VR7WYF
         gcfg==
X-Forwarded-Encrypted: i=1; AJvYcCVRW7x52brZAoOso8523LpNJqkiZVVxU/AgMyzgOPW9Lk3rDb7qE8AWzlx+AcPHzybWxojyGjgGu6arC0wAUA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyORFkT81EJ0kdWc9VC3lW3AocPiEmc1qK9JqQxZmuHmYkGGvMy
	CqY6c7r5vjfI+WPG19S//CEjk1Y5FzB0+/lNODd7Nx/05uHs8xLJzh7uwww0wBzqt/yCAQ64xoi
	/RzCr/P+xqNDSP7wHh488uigMifBuZz6AKkxFamVxiv+cjmgxYCEPlNoYmzUWzuF5CYT0
X-Gm-Gg: ASbGncuee7qdN6de4bsHmGxPBcUux/wihDo1ZJXtAVeltYWxXJoZ730OzmLhamGLqsN
	hr0Z195ixGFXxUl3B1oJuUdLMBHMoV4/sw2HLtS8jpGKWMTOqJg0VV7W1uBZ8qnKAaavI6tAH4r
	kHp7h51OxRaKDf81r042fT0NyCbW2O0LFkUBUnErgwL0aSv9CcnUw0FfdTI9iAY6YtZkOqSbGWU
	K5kI6sDR84341ItIQkW7tJRXa9lGAVImeAVqYhB9c0Vl0ulBCBaka18MrHHWgt3lb2Q9ptSdnVt
	JTvUmPXKEfD8r/Kgu4PW9yNtKau3TWg+erfg1JKSkjLcn8IqeBG8n4b8gGZSJrODTp6NdfJAzzD
	udI/aWTNBKPQHp5T4/pW15g==
X-Received: by 2002:a05:6000:18ad:b0:3b7:9c79:32bb with SMTP id ffacd0b85a97d-3c5dcdf9bd9mr215836f8f.44.1755806894489;
        Thu, 21 Aug 2025 13:08:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYrE9N2OTZOZSEOVxEUY9xhX4UsF8UOhI+5wOqBRpd/3VSIxUjVMLdiea20BiXkc+w3FSZ8A==
X-Received: by 2002:a05:6000:18ad:b0:3b7:9c79:32bb with SMTP id ffacd0b85a97d-3c5dcdf9bd9mr215789f8f.44.1755806894010;
        Thu, 21 Aug 2025 13:08:14 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c074e38d65sm12982954f8f.27.2025.08.21.13.08.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:08:13 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
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
Subject: [PATCH RFC 24/35] ata: libata-eh: drop nth_page() usage within SG entry
Date: Thu, 21 Aug 2025 22:06:50 +0200
Message-ID: <20250821200701.1329277-25-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 9uNjP4LqVRQ-eEQUepXPVdRFePvhHLP2yipFtS_t-UE_1755806895
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

It's no longer required to use nth_page() when iterating pages within a
single SG entry, so let's drop the nth_page() usage.

Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/ata/libata-sff.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 7fc407255eb46..9f5d0f9f6d686 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -614,7 +614,7 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
 	offset = qc->cursg->offset + qc->cursg_ofs;
 
 	/* get the current page and offset */
-	page = nth_page(page, (offset >> PAGE_SHIFT));
+	page += offset / PAGE_SHIFT;
 	offset %= PAGE_SIZE;
 
 	/* don't overrun current sg */
@@ -631,7 +631,7 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
 		unsigned int split_len = PAGE_SIZE - offset;
 
 		ata_pio_xfer(qc, page, offset, split_len);
-		ata_pio_xfer(qc, nth_page(page, 1), 0, count - split_len);
+		ata_pio_xfer(qc, page + 1, 0, count - split_len);
 	} else {
 		ata_pio_xfer(qc, page, offset, count);
 	}
@@ -751,7 +751,7 @@ static int __atapi_pio_bytes(struct ata_queued_cmd *qc, unsigned int bytes)
 	offset = sg->offset + qc->cursg_ofs;
 
 	/* get the current page and offset */
-	page = nth_page(page, (offset >> PAGE_SHIFT));
+	page += offset / PAGE_SIZE;
 	offset %= PAGE_SIZE;
 
 	/* don't overrun current sg */
-- 
2.50.1

