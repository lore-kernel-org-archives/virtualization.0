Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCFF37D5AE
	for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 20:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806916; cv=none; b=NTHNXXlpmpL3JbtJJWsZ/Ic8yV/Vo9C1W0FuCD6ga+kj5ZsoIDWs7rJBDXVecvrMXeqSbrx0HIhHRGQo6cXuNJve3iZPyVoCa97SURYCJotA17R0k7mOvtnThUa4mCG05Un4sEPU5BT4wPe8+mfqyzXndv4reXFkIiu0BFc6GJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806916; c=relaxed/simple;
	bh=nQnlX0DDaNxbga/DhB7JLie8Amiy5HfSv4XT65Hn/xQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=fYr3a7Q5iD+22CwOiFCxrV16KOpLK8VfZH/x8+gVI9FStF8vlrCiePzSNVIW/iwZ/Uqxhg00S+JvzTFcX5V/LkL8Qtok3ME6XtwKD+N4PpO1giJJBIQB6+bvnNIeFztDtB2qwj9hmrJNPHpTLi4dS78sYHlFgartgnmXFkldkzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E/KO9xJP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E/KO9xJP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6kuJ+10C4pYxyWPcGDJkWqMBAcRGmXje5KFYns7NWu0=;
	b=E/KO9xJP0YDwduCbaEPPq7YLrvtQCc3Z8TyPZBcXsz00h6654GmKf/8pfObbdClc/wpHwJ
	HDLphXChXhi+4noPGDW1BT5q6aNE2Q59BSKnGxl4WOmkzBU5AAnwYCAxXDMLPotve6sDRU
	0DWtDpFJqjGtxHYv2hJLbjqkgotpSKk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-cioASQYuN6uU7HPL2QZr7w-1; Thu, 21 Aug 2025 16:08:30 -0400
X-MC-Unique: cioASQYuN6uU7HPL2QZr7w-1
X-Mimecast-MFC-AGG-ID: cioASQYuN6uU7HPL2QZr7w_1755806910
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b9e41475edso915770f8f.2
        for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 13:08:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806909; x=1756411709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6kuJ+10C4pYxyWPcGDJkWqMBAcRGmXje5KFYns7NWu0=;
        b=gFSB2ctMX5b3Hqfhsep7cUQN8S8Glt9O9WiK04uqk5GkfX/r3Rut9Fq9GJVRhy4Qhl
         han/Tkp5xc1as5RyQKwFxySppAaHF6L0XFXHvP+ozVjCgcAyREe9bWambURGSfuD5Io+
         6qzm5gKa+2uPGNDEINS2fb74bjhThFeSfrM35BY9P/Ax8mVRbSdW3qLJMSMFTL/ylwH6
         QMUGdNgns3wLtO2mIF4CG6I+n7r8jW2ghqI1DXmL2yDuaRCnPJWrC09obcaIant6qL4y
         Q6LWYObUJQ1OlrfrD52lkc5IepWfIcTQLxwCenpuF6ZPvfIcAkOBBFFcTXRMTHQaQ2S2
         Nnfw==
X-Forwarded-Encrypted: i=1; AJvYcCWNRjhut+zTojs9MaoHT2VorYDpSa7qgF0YoLMHnC+X+WzvzeSxY5LfW/Stu0kn4C6dkcjLwGMmNn4lWRotAg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyz2ZJfStpfUgn2TyyCYAeA+ZQXHr5TxuQLedtpCn5JcNyjsjaK
	kCscqzE+8H+4D4ndHB4E8lYymkwC3z5EouQOMKbK91rEc/F4c/kIpUsRhJ1uDoQX6oVae3otJj4
	N/aWQskWx9sfLcJwUPNRfVRSPri+yH7a3maKZ+PIlJMtbqjkk8wAR8r6iF/juhv9vm0Ce
X-Gm-Gg: ASbGncurTYGwtI/Peor2y5ALrweVoeNTxZzYEDu1UaW1Gt3HBiB7Sz12LqUlfjTRbR1
	6rRCKHLsbqD8+BmHKKNe9DJLku7NnNAEVoizkR6u7EUaDhns5XTVzjOHX7OPkZLhF4bH1iTh7Xn
	5l3mRR05FYG8z6sieAadtyBBdb/TJ5Nbp9sCv5anhizNooLyDkKBIy5VcPOQWil8lU8qBQWIkE4
	SlNeZlyzuKOU3ViuckacB22y/MkF/dQVHEI2xJA5pJX1Bi/vzgI6HpLOtAIUbDcny1jEq0OYeH9
	Pvc0+YDa2v10I2PWk+dkKQm826AmT4fK+3SzXirh3etHAaal1Fs0Fa7zJ1hW98yBOWljfAKraD9
	W9kSkPw5a7m/EoB8p/tDv0Q==
X-Received: by 2002:a05:6000:18a6:b0:3b9:48f:4967 with SMTP id ffacd0b85a97d-3c5dd6bbb33mr155520f8f.56.1755806909416;
        Thu, 21 Aug 2025 13:08:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRykwWh31JVJGBkobbD9YNZEskJV981iF0h0FASAg1XfgxaqZA4MQnDyPntA4/emfIOpWurA==
X-Received: by 2002:a05:6000:18a6:b0:3b9:48f:4967 with SMTP id ffacd0b85a97d-3c5dd6bbb33mr155476f8f.56.1755806908930;
        Thu, 21 Aug 2025 13:08:28 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c5317abe83sm2432791f8f.40.2025.08.21.13.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:08:28 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Doug Gilbert <dgilbert@interlog.com>,
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
Subject: [PATCH RFC 29/35] scsi: core: drop nth_page() usage within SG entry
Date: Thu, 21 Aug 2025 22:06:55 +0200
Message-ID: <20250821200701.1329277-30-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: FVfKP7l7IY9jy9QSGncJZhd4rFOJriuHW-SjvwXWQYo_1755806910
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

It's no longer required to use nth_page() when iterating pages within a
single SG entry, so let's drop the nth_page() usage.

Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Doug Gilbert <dgilbert@interlog.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/scsi/scsi_lib.c | 3 +--
 drivers/scsi/sg.c       | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 0c65ecfedfbd6..f523f85828b89 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -3148,8 +3148,7 @@ void *scsi_kmap_atomic_sg(struct scatterlist *sgl, int sg_count,
 	/* Offset starting from the beginning of first page in this sg-entry */
 	*offset = *offset - len_complete + sg->offset;
 
-	/* Assumption: contiguous pages can be accessed as "page + i" */
-	page = nth_page(sg_page(sg), (*offset >> PAGE_SHIFT));
+	page = sg_page(sg) + *offset / PAGE_SIZE;
 	*offset &= ~PAGE_MASK;
 
 	/* Bytes in this sg-entry from *offset to the end of the page */
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 3c02a5f7b5f39..2c653f2b21133 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1235,8 +1235,7 @@ sg_vma_fault(struct vm_fault *vmf)
 		len = vma->vm_end - sa;
 		len = (len < length) ? len : length;
 		if (offset < len) {
-			struct page *page = nth_page(rsv_schp->pages[k],
-						     offset >> PAGE_SHIFT);
+			struct page *page = rsv_schp->pages[k] + offset / PAGE_SIZE;
 			get_page(page);	/* increment page count */
 			vmf->page = page;
 			return 0; /* success */
-- 
2.50.1

