Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01FC36997E
	for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 20:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806846; cv=none; b=fpy8ToxugTk5DnGbSWobszEfej9gAXKMpcnSSSMLarUZVuudzSqLWVlf4v/yWF94/KQGErUqDx9whuB5dkE+8J6Oqb9VZl0uVJVkbzS6UykQVDqXzwSkkK9203TO2tI3kY2AtGBToqlOXWVZeLO9Rv48h8hEOYP86PZh5OQS3pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806846; c=relaxed/simple;
	bh=Cw7Tggvlta2Xmlg9ZVygUv1C92bk8NKTD0n9SH6aeIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=dksQGDumT5EBz2eY1orqaUVWIuytsmecTwpR1sGRHOgwSd08SHRSLW4CjivUOmQ/rWgWGw8HbOSNCUm2L0Za96OHQKuL8R5VWfGG3v/pBx8hbZIlshtc3XSEcD6DOk7gnkVh/dmm/BgKYzPc6uE58LafR+JYeQ66ZZ7xONit1uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bXrZmPeh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bXrZmPeh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iU84NUWejaBSUFBs/T0/O04YrYLlq1RcxZMywEFGjU0=;
	b=bXrZmPehYJDBOtI/hYSV3Tx7nBcN/iN0z8iYigjBFp69tS8F0dO+ewoK6msuz6k5zEHtOU
	76Wdpk2jLgXSDCHIS7dldUMZfjpGBekEKB/s5AW9Z74LxiWeJdM2e5zfWIaRNQO6JzuO1C
	uhm1gEc5RxWdjnA08MZllTSsupy3VvA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-RKN6DHimOJmHEiW6jQsN3g-1; Thu, 21 Aug 2025 16:07:20 -0400
X-MC-Unique: RKN6DHimOJmHEiW6jQsN3g-1
X-Mimecast-MFC-AGG-ID: RKN6DHimOJmHEiW6jQsN3g_1755806839
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b4d6f3ab0so8375755e9.0
        for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 13:07:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806839; x=1756411639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iU84NUWejaBSUFBs/T0/O04YrYLlq1RcxZMywEFGjU0=;
        b=H22ZxE29xa21fDoS1rE3vaoemxyvyD8ptXvFb/ntmoWal++n6NtCGxiqm0WjWbS34C
         Br/exbZS2SgxCaSZXQpI0m/d7nW9c77CEpj/cagqxoPSMrkm03pwo3bg3JInM3IaY7wk
         va7I0cQX/Zybbkg++zRqNwUnHz5Pycv3q/B8TZ4vHHPRBy/r7aVzxTTb6lxrpVkF2pj4
         C6hRrnSi10ud8Hxqni1CCMUsika2Y/1aHOx5Ly/TMGc9wumVoak88W4fhuGBQpy7j6dd
         MiOmm/FWbtcuv01+HhO616dhF2OLMwbJu+5oK5eUiwjAAzDSmcJIQo84Q909rsu1/GIx
         2zlA==
X-Forwarded-Encrypted: i=1; AJvYcCUWG0wxqbGhmYyzF9E9dfDk0V+CdLqcrrdLnGNXjuhXBptapi/WqsRUm5PYfLBESh8DL7bYi+cKvOVhqwac9g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzyzoHheH0AW8O210AX4MjYld1pZzt7VeUbHyYb3r4zg2k0BF+M
	dui8acN6sThG/KQPc1ahqCfdbKqsbQFyLJSz4jeWeXae9kgIAhuI38HsIa91pOvhSdKhn+5tExw
	AChikOPIBZzAapzQzYtMn+5BDQu39TggYrfzbR7rPw6clgu4h0IxIqiisfNOfWj1YHO0Z
X-Gm-Gg: ASbGncv8cj/0ecPKRH9X2QkB4uZqtxRsRQ44jTSmEbYIUWgsxE3a0EQmntzi7MTaZGB
	EGpI6DoJNjttI/vl5/YL7dR4a1tB9jg2wJXv80y+A5Q0ODQ8aAS5ziKEDjzVK5czX5OXBnTYbnv
	UsxPPB0r0xnBnG7/s+lpaK6W/aXm6MWNhSmgt4DvZ7QP8qLuUOa83ilswiWwqYJ3XfqK5cqgBOl
	Bi9j6Ym1Gea3oYrnAJCzWPn3eKQvaNVdeUy5ObGdAB5qCMBlhxQchqtsTHEBxnNQJz8nyEwC5V5
	4jZdDJGc9hAhB5tOwLRADzskcQPg+a62fnvLj3+fMHs7XjUKOGVzJtbLbk5n3usrW8DQRFZT3MJ
	2F4zqrOzd7J73fsa3ohiG5Q==
X-Received: by 2002:a05:600c:1f95:b0:459:db80:c2ce with SMTP id 5b1f17b1804b1-45b51799428mr2845335e9.7.1755806838943;
        Thu, 21 Aug 2025 13:07:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMhnqxttMNkrL8PAxIX9Mfq64uKkvY2MjzJ39LtAH2Yg7PxwVl8kOZ6CXLaaMF5rYTxrWwyA==
X-Received: by 2002:a05:600c:1f95:b0:459:db80:c2ce with SMTP id 5b1f17b1804b1-45b51799428mr2845125e9.7.1755806838506;
        Thu, 21 Aug 2025 13:07:18 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b50dea2b9sm8988005e9.15.2025.08.21.13.07.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:18 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
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
Subject: [PATCH RFC 04/35] x86/Kconfig: drop superfluous "select SPARSEMEM_VMEMMAP"
Date: Thu, 21 Aug 2025 22:06:30 +0200
Message-ID: <20250821200701.1329277-5-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 79cGIn1fJGgySL39tfvNw49wXg_wHsgs_iBuaNNQ6Aw_1755806839
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Now handled by the core automatically once SPARSEMEM_VMEMMAP_ENABLE
is selected.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 58d890fe2100e..e431d1c06fecd 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1552,7 +1552,6 @@ config ARCH_SPARSEMEM_ENABLE
 	def_bool y
 	select SPARSEMEM_STATIC if X86_32
 	select SPARSEMEM_VMEMMAP_ENABLE if X86_64
-	select SPARSEMEM_VMEMMAP if X86_64
 
 config ARCH_SPARSEMEM_DEFAULT
 	def_bool X86_64 || (NUMA && X86_32)
-- 
2.50.1

