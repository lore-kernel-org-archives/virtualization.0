Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795089784;
	b=K2duTNNHQHIzGnYWSC10l2B6UGY4Lj7srvcXyxZFBuvUnhaUNkzGhrDuAGzfs/7dI9Xq
	 oxcEGngLFLFZtJKEdiodN4nmELFfXg8mHpX9gQaFo3SF1ubnxXhiZQUB7ynKpaJjVHDXh
	 B1uvM3EHOYFEFFae53aOxQy/QB1dTG2v4Pt/043Tae4iUfmFU15sjLDutXBAgJy5DaIgz
	 TZQwyHuEU3rktknSmwt2dq4fNSslH8855yTxYplFkA8KrgE9zpBr8ywyKf7LgUfsId/mP
	 6C+Xofahb2m6NppmR++tavgdsX2hb3ny1Tm4Cxi1FafNfBBhkuPCa6Z/xXXeL19EnZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795089784;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mailer:X-Mutt-Fcc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition;
	bh=6K1VKlq2rUeTJU8oPRd92vsLkRSeWvDzIW6gRScpnDs=;
	b=NIzGg4hZt/HLUlJuB3siHYN5ZB4DvM8wPv9yPg8yDaxXXruF1EOhKTvoQR2DDeDyAV6s
	 +94j1ayebWac9PRWJyUPBdhMwSedvM8f5bjBXH9XUyqhYqoaltYuCwq616MywE7G+ZzgW
	 EYYtexdEDW80fiLrz1M4gZfmbosy86Ypn79wV2f7nRLBx9TqSsW8oRwXPZ2GQ78S+T4D3
	 0j5CNMD4hfHFvxHk0gdOsH+Du2RoZgxGiuJq/M7H9Y8CSA1+EdDvOksN6l1eJSw5o0sW7
	 cOHpSt74ECog54C9TZECiCSenf4Cn7vzdJr1R9AxQCsQqjLNdgK12w0cu4PKjc/fzxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FkMpQ5Fd;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F6A606A333
	for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 12:03:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7F6A606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FkMpQ5Fd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795089782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6K1VKlq2rUeTJU8oPRd92vsLkRSeWvDzIW6gRScpnDs=;
	b=FkMpQ5FdALzIbLfCqM3upw+0pap6AF/nx/msRJk/Q9YcYLBm5pzHPB3T065Cay2LogniaI
	dD9u1cGrAD4zPqAN99BuSRFY5wrasCUkB8VlZxcbHmuk5hxH1rDcl1G80P7LAKI54hENT5
	AJRyN+CJIb54ff2RByFiVBub1RvkaK8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-3ks96BgRMcmcpEOb4IEo0A-1; Thu, 19 Nov 2026 07:02:58 -0500
X-MC-Unique: 3ks96BgRMcmcpEOb4IEo0A-1
X-Mimecast-MFC-AGG-ID: 3ks96BgRMcmcpEOb4IEo0A_1795089778
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c465c4c8da0so239389166b.2
        for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 04:02:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795089777; x=1795694577;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6K1VKlq2rUeTJU8oPRd92vsLkRSeWvDzIW6gRScpnDs=;
        b=ury197O3f93ayu1Wmh5tksGIUb2jl/M17FHIAJsfGsSrMLanpl3h7sdAn4RMQB5uGv
         a+z+HkDGQD8zhJZnYmUCMvCJAXbDk5lLRzm4t0edK0gkEymcpwL5LXsS1+xbm06fqJzs
         RZgni/ranzWFH/a6GhUJR8yr2X7mMVtDAj2LCXjxB5BXZnRy33UDRmS5b7p1l9iFDzI+
         ErW1mw0vueDwIKBE38jxnbOYuU2cNXFA1jTUMjJPK6NcX7S5Vz66zQGWF5dDGsVZ+BZ9
         PpQFSBQgJoi1uCE6inyacopGl+AixIsJJmwcjvm/z3wDae+3CrNOpkyP3ICHs53DPe/S
         5IVw==
X-Forwarded-Encrypted: i=1; AL+hErEIkkKWPSdoWEmgo2BNariLp62rp4v/pBZ6WHnSY0pah65ZUHxqo2edoM+w0Lq3uQ6/o4JLFpfotYQQc6cPRw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/TGd7mg/SJDanKSv5PzIMvwzcNzxHqtgsUnycnFx7xP2O27c1W
	J59+5OzuuFs2JZIij/RdqmSYYxtc4dDoyrjjmhl2pvkfeVAknH8GJ5t/btkVfvWWiKlpdXBvQtK
	ECd6ehbLv/vVgu8Vddip6J+0cda51UC9Rh/z1BxFKu/xrtcPSSE+wjPm8fAMjpGzFqA0U
X-Gm-Gg: AYBFou17YVuVx9nRQb4em510XswOB8Qd6dyxQoWcCXPhq+8ocDQC4wokqsotuA1Cv2G
	rRvUVeZZ5D7YofBFQqoC8DZrYyHyYAV27nYqvJT2T8eXvoUvZ93f6I02wa/4tNTqt3/e5FBCLdH
	XX1pSvEH8JD7PaDkZ2TLuYnTUn7hcSxa2X/anUPiTx7KV9L7EFMOXn2FWkK6zc7fyrpxFVz1m/5
	PAMViVX0ELRdxFPRnetUMOMRx1ytOum5tHtAMxf3bD4d1wpGH3YpBjO94k8Uy8lYIxT2K1I5m2B
	0vKWBsZMfATwqaC35awFbI+42Mg/AsZfEE/4fFC/+tZxzshYRfVz3uM/vO7MPzzn9TiA56V3lTO
	r6LXdtbZ1IwKpSUlIeZDJyIdsYA0nb5pXmYpNMWHgwJM=
X-Received: by 2002:a17:907:3f82:b0:c33:ae8b:817d with SMTP id a640c23a62f3a-c510e58fac3mr532074866b.46.1795089777356;
        Thu, 19 Nov 2026 04:02:57 -0800 (PST)
X-Received: by 2002:a17:907:3f82:b0:c33:ae8b:817d with SMTP id a640c23a62f3a-c510e58fac3mr532065466b.46.1795089776668;
        Thu, 19 Nov 2026 04:02:56 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1520:4400:d78d:7b2d:2f5d:e08f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a6560961cfsm10496541f8f.39.2026.11.19.04.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 04:02:55 -0800 (PST)
Date: Thu, 19 Nov 2026 07:02:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>, Dev Jain <dev.jain@arm.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Gregory Price <gourry@gourry.net>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Lance Yang <lance.yang@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Miaohe Lin <linmiaohe@huawei.com>, Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org, virtualization@lists.linux.dev,
	"Liam R. Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v11 5/7] mm: skip zeroing in alloc_anon_folio for pre-zeroed
 pages
Message-ID: <0e8d142ec28ccfb548797652e1d39783046bddda.1795089715.git.mst@redhat.com>
References: <cover.1795089715.git.mst@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <cover.1795089715.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ac-4YSKULQ2YZdvJxpOuq9E_J2Sr4nhqJvwPmZ6InSI_1795089778
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Initialize newly allocated anonymous multi-size THP folios through
folio_init_user().

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: LLM
---
 mm/memory.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index ec3d9d99ccee2..020ae881b226e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5479,15 +5479,7 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
 			goto fallback;
 		}
 		folio_throttle_swaprate(folio, gfp);
-		/*
-		 * When a folio is not zeroed during allocation
-		 * (__GFP_ZERO not used) or user folios require special
-		 * handling, folio_zero_user() is used to make sure
-		 * that the page corresponding to the faulting address
-		 * will be hot in the cache after zeroing.
-		 */
-		if (user_alloc_needs_zeroing())
-			folio_zero_user(folio, vmf->address);
+		folio_init_user(folio, vmf->address);
 		return folio;
 next:
 		count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK);
-- 
MST

