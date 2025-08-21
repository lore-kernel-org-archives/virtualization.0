Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD2034F49A
	for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 20:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806848; cv=none; b=QbVE6r5OswQl0beV2HTb1BJybHs/eCMvZShni4Sn+mH+fpJiUK6J22tnMcAfUPR1XJEAogQ4wat7ZrXHgTlHoKZ9xoVDstrgYGuTtSNpFZqlA7eUPUSLnr9Eb9c7Qb1MjVCGQw/9jBs/egKbrzpuTMeMjDLX2/QCsne3W6lg1iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806848; c=relaxed/simple;
	bh=vLP4m8ubY62ddowshnJEYGhNc+fB41I1n0umGIUlXAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=UYTUpv+ZGX+T4260Qw5m8Oi6Rx2TcFrf8KnUtGfULS5y2fL7SNfAEBftVLquocxgORby1VSCo/6Sfnur7nMryCKzrUf7r0KmU+hGlLfbdeAVqasdyroqZWUuXbcmfO/9rME1LxGfJlA9FeBFfS6TOJsyRbYqA2lOnRvoOqFKF5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UTMr6Gx8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UTMr6Gx8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aOl+Pd7m6DQCTUATshUDhXjEbKNtUx8aQQ0CVjE/d9w=;
	b=UTMr6Gx80u/MdHhmb0nX9KR9K1Y9mBBNZdMhmiTyizUXmPVAka1kPbgfHeSrj+xq5AU449
	31vHiecKeLgib3giSO/EvygS+/4G6YvCO+CVyrFduoeJdrdAMNjkmPmttA0i9gEeMyzGSB
	6GKlHo3EyWP+28+KQHE1pqIN/h3+5rA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-rlBH-6gPPn-f_Pmn2QmiBg-1; Thu, 21 Aug 2025 16:07:23 -0400
X-MC-Unique: rlBH-6gPPn-f_Pmn2QmiBg-1
X-Mimecast-MFC-AGG-ID: rlBH-6gPPn-f_Pmn2QmiBg_1755806842
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1b0b6466so9581265e9.2
        for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 13:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806842; x=1756411642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOl+Pd7m6DQCTUATshUDhXjEbKNtUx8aQQ0CVjE/d9w=;
        b=r6x83xHNaK04T8mLASynpAv6kILoSt6HvFYyE+Ad/oDeg2nOzjQbB+sx1L0c2ftVJs
         /S0crSxj724TdcXsi5ZGcvTy/n/+MNS63j0HkLx+WkG61Pr8hYw1+jOhzJFiFxvkJvhv
         CSj3BETD13TNBL1E5MhImkC1YkjZm5euIsFAkGSEPbl9dc+GRGXo6jpe4IjNbEWUDfW1
         ooxZ/FH3OojKQGAb2e7aeSnCBOuKXe9avYPhgD+Xx3C6AMNjIbenTFuOuB1mk4eHNJby
         fixWBuGqs+uc4amuhb4LLvw12UWGw1cLVqSikK6vQ13UMUmsQK2XgRa6ZvFv7ketQBGH
         lMAg==
X-Forwarded-Encrypted: i=1; AJvYcCWmDCEaf2HTd4bvh3wFYwNT7Uq7JqXBGjv9R4PP8a68Nex8gVf8PzYZzaHr0i7JcdQaENLQQygr2prM3h4kqA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5temQR2vRcJJDu5MbS/OIYfPnisE008nmNTPOYfC0DpVvIKvQ
	vXMccpPhR60RbAc/i8RmhKF00j0N0GTr8AMEUGI26D7jPObWUXJLV/CuPH8bX+KENdPBnKykx+h
	bkY3LIzYOHriwVbKBOs9QWiSk8dg+5wmz3iC85T310nSC2/3LbNOd1ryCwaJDD582lYOH
X-Gm-Gg: ASbGncuEmiTYamW+l4nElt2w9rjzsTHspe5lhYM8qwrPgm8Ss7BruYcjV1sCXzd21bu
	LM/hKSV+uzvOImdlQZfpQ8W6uMbPA9UjB2gUGaERYphqwWG9m6VLBlHEmvrtMV7cZhdZRVFPnsz
	nE/fiEBAuO33DDMKKXADviZVqr20azMLRaqw6WEhnfZFQE3uWbs0N/M18kxBSelR99W+dtOSxEz
	+s138HaZlVJwZDzHbAItjsHsthsCwoFcLnNtHlA2YPWwSVIrzonfjLOt//2z6SJtbGDZlL3H2OH
	KAreSy29OzuhzlQAHmC6ULGLBTfBuIR322w9oXundXYxiMmaMGoAwSoIv9+FHC+YlRD8G1Te+oo
	PM5vd/13aYDM9PhM0FRZx1A==
X-Received: by 2002:a05:600c:1993:b0:456:e39:ec1a with SMTP id 5b1f17b1804b1-45b517ad4a9mr2412465e9.14.1755806841676;
        Thu, 21 Aug 2025 13:07:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtBnzBdejX2oNj8vG9iZBZKJew+pPrkGWxHzVnhFEnb5RkXIsj+cBFTtJrIXnzr/4lYhSU+w==
X-Received: by 2002:a05:600c:1993:b0:456:e39:ec1a with SMTP id 5b1f17b1804b1-45b517ad4a9mr2412295e9.14.1755806841198;
        Thu, 21 Aug 2025 13:07:21 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b50dc00a8sm10960275e9.1.2025.08.21.13.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:20 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Shuah Khan <shuah@kernel.org>,
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
Subject: [PATCH RFC 05/35] wireguard: selftests: remove CONFIG_SPARSEMEM_VMEMMAP=y from qemu kernel config
Date: Thu, 21 Aug 2025 22:06:31 +0200
Message-ID: <20250821200701.1329277-6-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: gx6g5LIOqLudUodQaD8MhAnC8ArhXGCDVuEO11g4gA8_1755806842
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

It's no longer user-selectable (and the default was already "y"), so
let's just drop it.

Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tools/testing/selftests/wireguard/qemu/kernel.config | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/wireguard/qemu/kernel.config b/tools/testing/selftests/wireguard/qemu/kernel.config
index 0a5381717e9f4..1149289f4b30f 100644
--- a/tools/testing/selftests/wireguard/qemu/kernel.config
+++ b/tools/testing/selftests/wireguard/qemu/kernel.config
@@ -48,7 +48,6 @@ CONFIG_JUMP_LABEL=y
 CONFIG_FUTEX=y
 CONFIG_SHMEM=y
 CONFIG_SLUB=y
-CONFIG_SPARSEMEM_VMEMMAP=y
 CONFIG_SMP=y
 CONFIG_SCHED_SMT=y
 CONFIG_SCHED_MC=y
-- 
2.50.1

