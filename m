Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6706370587
	for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 20:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806905; cv=none; b=Av93akdE/Lfa2Bwmfh4tOJR5WWQAvqRG43yIqpxl6zwkIt3P5+AKaEw1mRNh6xD6shF8HRpZz09N4sf2ahDD/uLxtyLc/khmmuOxSnq4kCsvSHB88HiZKJof3/JNSy89chDEutMMAwPZeva1SM6W0B5wVPD7r/kQZOXchnPgtW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806905; c=relaxed/simple;
	bh=sP22NtXAK7RUwr0f+hWxIzaLt9EECIyrZ2EEKfR5Am4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=QtMX0q5CbzI0AxLclYvfZ3nbVv4OexrbtL99crjiuwuU2Q1315ikMzpJax6yvuw6iITvohB3QWut7LsKwrZXrGg6XmXVzEeZJFxRxa0SgDyg/U9pbl2DTgsojIG2zBxNmUCWr615bCTc/+5fJ1JMTd/AMqY+bpsMplDDTjn87x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M5eIkUTN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M5eIkUTN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5m4ogAvLOK+AKMqlHwhkjmyVbS/4gGgmBykcdwEFmjg=;
	b=M5eIkUTNOfZAbO1HhqbvK8RSCTkC+xAMYuzo1rzYrLAiykPHIn9lv2D7YmsNWuK+auNtW9
	7N/xoysrIBK1RHpxBqWGbrNnt4lj4AfcHUWHUIgQIyZ9wk2VIpl9iXubDpi//Zhf/jHKKX
	2SBbugQ5LFxqtQ24PpWJWqhhPJ9qqn4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-XFVuAx84OniU9_hd34xOPw-1; Thu, 21 Aug 2025 16:08:21 -0400
X-MC-Unique: XFVuAx84OniU9_hd34xOPw-1
X-Mimecast-MFC-AGG-ID: XFVuAx84OniU9_hd34xOPw_1755806900
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45a1b05b15eso10523295e9.1
        for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 13:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806900; x=1756411700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5m4ogAvLOK+AKMqlHwhkjmyVbS/4gGgmBykcdwEFmjg=;
        b=w1DN2VKDGS9thHmN2b1VhJLOrE7en4Ig4KYFZYmCrE6LwJxxHTYsgRlg4AaL2nJ9eX
         98nP/nA5NJTPPPbJBhtSD1rXG+brz7bPFPQ6MwmE9zVzoNH7Raa3dp3UJkDXdj2mlm2U
         fd7e4N82HFRv5Zt+RXjA3ka04osolp0PJLtQhV0SeL2LUVeZY2CftnuDRSMJ6nc0Igoo
         pxXJcvDJTb2VFPe8v+SivaW5+s1pQ+bxR7PwmvVGwrsnMG/eWmyx6UZDTq/9bpoeS73x
         nROEc84qqQFVecjrNuABjQzNYxossGB2evcU8JmLm0Qd/2m0DlI6jFANYt74Yg56AiXc
         sy6A==
X-Forwarded-Encrypted: i=1; AJvYcCXbx0QJInttdcIjlEdeXI78PXfg2hnboEPQmAv4OT/NS7ol1hFb7ZUa6vLwoEz6BSBbGplzKRW1a6RNsVvQtg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9cr6+NIXTcLFf51y0s69EbbpsnieNgfRnk8Gh7rFMSeUGDNGr
	TK//ZA83beKptADmVynfvs/U5NdiK4Hm8CJ6kv7VDjikjjGEIrhLKtpH3gsy8+YeKKPb4JGXZlI
	dKBjY+q0K91xKd3ZBSUgX+U+682Ew6JWHM0+Or/pcnWjJJs/dXeB5orAko2UYsIzp9oG+
X-Gm-Gg: ASbGncseOSr3y8YqvB00qxIv9qNVIHqC5ZMn2RTRZrCHTmusSOD4jnRkhA1xyp93PC4
	rhzp5LdtuwDIs/d1tdpQFb1z+uHWdPYgPsR82q9Z2C7Cc3g4raCKCJ58Q2Zy4XWSSIlvZGQGzA/
	XtwjGYoa2LfI68wVEaeiouzuXzqiGtAXDC9ikI7L04Ucl6sbF7uXdXpny3sx4iZyRwlsZkEiAT2
	q6lCnmrQEJ5b6olsTwzBNMjkoeZWdNMMy2SWq2fGOXLloW6fDzIw87l9PA/Kx4/atxjQoNRLEaU
	GfGytIDX7VskFdMWURAs0QbeWx/DSXRx0Od6k9RCo2xMF/BTQ2mHAkhNZZPrilh5R8rkxPd/cS4
	n5ehEdt6ogwJl5ZnGmvI63A==
X-Received: by 2002:a05:600d:15a:10b0:458:bc3f:6a77 with SMTP id 5b1f17b1804b1-45b51f2fe8dmr510505e9.2.1755806900319;
        Thu, 21 Aug 2025 13:08:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpV2b3uhR/IYbmrTMgtg0gx1wkF4+JdBDenNBBSMhYf9nynPUCNMa8PTADPxo4/liFiw6TqA==
X-Received: by 2002:a05:600d:15a:10b0:458:bc3f:6a77 with SMTP id 5b1f17b1804b1-45b51f2fe8dmr509915e9.2.1755806899756;
        Thu, 21 Aug 2025 13:08:19 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c07487986fsm13999227f8f.1.2025.08.21.13.08.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:08:19 -0700 (PDT)
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
Subject: [PATCH RFC 26/35] mspro_block: drop nth_page() usage within SG entry
Date: Thu, 21 Aug 2025 22:06:52 +0200
Message-ID: <20250821200701.1329277-27-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 2vT_uijAKqyXXuZ6c8b3Tr8VQZifZxIGigCqyz0_el0_1755806900
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
 drivers/memstick/core/mspro_block.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
index c9853d887d282..985cfca3f6944 100644
--- a/drivers/memstick/core/mspro_block.c
+++ b/drivers/memstick/core/mspro_block.c
@@ -560,8 +560,7 @@ static int h_mspro_block_transfer_data(struct memstick_dev *card,
 		t_offset += msb->current_page * msb->page_size;
 
 		sg_set_page(&t_sg,
-			    nth_page(sg_page(&(msb->req_sg[msb->current_seg])),
-				     t_offset >> PAGE_SHIFT),
+			    sg_page(&(msb->req_sg[msb->current_seg])) + t_offset / PAGE_SIZE,
 			    msb->page_size, offset_in_page(t_offset));
 
 		memstick_init_req_sg(*mrq, msb->data_dir == READ
-- 
2.50.1

