Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D073101A7
	for <virtualization@lists.linux.dev>; Sun, 12 Apr 2026 22:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776034270; cv=none; b=jePffEC0/My2NHJhqDhShdJPalFvd+GH2RZnmcPMKmb37X8x0/mlVbxqJJsjblpWv+mIvJrYbPFSn1jYesLUQ06IwX5sYk6IC4+fHNDl6NBMzu9U5TgmI8zqX5v+5iHwaj1Tj1nL9iHd7pagr1dR7IZo+eGdTWn8Ry97IA69fUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776034270; c=relaxed/simple;
	bh=3c1PROdbIMYmY2GV+qxQCYKAu2jqElfAQaiDsBAfyhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rcMuLadKTruPFWyC4CiRqiCUJUKqlUecANfAneO2eHzDLjAcfdXXbmKrx2lPEb9+nI0eT1yk8ASE8gVlUoVruKpRtzYpS8ulQQsIeIee583ARoROcl6sauVzFbwoBVXTYOHkZpjylSfFrp/CRJrHryDG6u0JE0FpiCaXcB9FFPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dE2tCgWg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dE2tCgWg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776034264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KFX8n0nPntDWisBxedrwOsXfOmZ1OSsMtUQjLyBO7ck=;
	b=dE2tCgWgMFV8RjkfhiDuqQad17M0zim5ikBDqzD8hdX5enfYaWBLbUEw9EeBLTNg34i1cT
	Gj75+iOTmp0eHxEyTGG6tFRxfYxo1AjivNsDzDV1KVxCwqqIq4JHvoV/tOVFvkalBNhSSV
	PlsexaVK0igjAjDSrWrcykEgAYPFYcM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-H5_eiFFaNYqtJJdks8Y-rA-1; Sun, 12 Apr 2026 18:51:01 -0400
X-MC-Unique: H5_eiFFaNYqtJJdks8Y-rA-1
X-Mimecast-MFC-AGG-ID: H5_eiFFaNYqtJJdks8Y-rA_1776034255
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d7757463eso179313f8f.0
        for <virtualization@lists.linux.dev>; Sun, 12 Apr 2026 15:51:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776034255; x=1776639055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KFX8n0nPntDWisBxedrwOsXfOmZ1OSsMtUQjLyBO7ck=;
        b=ClsiNszppsKGB5CNHwzHzGMBJphba57MGvGFBZTECdNUaZ7vdgGfvbAq0TUuajs3nL
         7WLkvGlvCTVCM0VM2tmgibquhUhgti8WlQh+hviuUbgNJswY6VzPPqbhPX2Ujup+VDmm
         9YX5o5fWqFvrs9xsGsID6DoUqkMrlHd+5S0IoAUYCDLAwa/2u/bAdwBWgoVT9hahCgZv
         kLLuOIWzEbQe3Alydx2TgbTGPyHF1fO0NXzAJcqzeww8ATEhO5zmE9wwfYnx5LzBiYaJ
         gchmcAZ2N3UtwGzirvNBbLLqXYeHl7oRN/q1UK7acGBcshneDwCXfo6K12ttjFJhWgUD
         9fDw==
X-Forwarded-Encrypted: i=1; AFNElJ+efihUHa5Z39caetEwyiQYENy0/EM16LWzEsAJIWu5ryzucTkRf3zGLtEFI92ctqPsz1aUEbWKS1X/yNlk9Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/YAgtsz18m4IHAG9VM4msPfSXxbh5yZqvVrYaN2aECW5pjHp/
	eBMpe/R9pcS+DtbLJGj2ne7iyahfnWbbVGg+ohZ6FpI+xuHoeyZwYNISkaj0BA2Oxfh3nTVQVbe
	PwltWf9dUn5MvmPl6zwqrforFUDjrP09dpJJoBqiGWBcvSC3ysyBPrsswXau2loi8tm8k
X-Gm-Gg: AeBDietXYhp01k5DcICcLyQd607mbmEH6H6Q5L16nM3GGpGEWBycuTEM+Zow7kW/hUo
	jGvWNy4x39yvEN6094C4olrv7WAHEkmoD5z5j0XKke0LiEmWMXyOc9rN0oYxA1l9yputYA6uELz
	7YiMNtno/GKNsvGU9xJMOunHUwJCers9ElEqk6i+I9tPBhK/2tA682iv9om7iGcl21Lj2Kdot62
	IYIE8fIsCUYfO20RIS4mqEvFYgSsRZT6nDqnEwXSiP2/89TI18HmJZ7Hjo/ot/pAeQQ0H5xP8+O
	/uvaLJnU26SvGtm0cArjGdy50FpxAQ+AEpsuqpz2nWs/NQfRGbbWTRmBXnuFHL34lmpTbj69W9S
	yyRJrA6VncjMHxB6q4Y4Ffkr3MoFhccjqpBlc/BT0okg=
X-Received: by 2002:a5d:6e5e:0:b0:43c:f5d0:4f6a with SMTP id ffacd0b85a97d-43d595cd582mr15728267f8f.21.1776034254653;
        Sun, 12 Apr 2026 15:50:54 -0700 (PDT)
X-Received: by 2002:a5d:6e5e:0:b0:43c:f5d0:4f6a with SMTP id ffacd0b85a97d-43d595cd582mr15728249f8f.21.1776034254149;
        Sun, 12 Apr 2026 15:50:54 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63dec27fsm27061714f8f.11.2026.04.12.15.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 15:50:52 -0700 (PDT)
Date: Sun, 12 Apr 2026 18:50:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH RFC 4/9] mm: skip zeroing in vma_alloc_zeroed_movable_folio
 for pre-zeroed pages
Message-ID: <027a31beac698f90e76aa68ba6a6101ba60246d0.1776033771.git.mst@redhat.com>
References: <cover.1776033471.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1776033471.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qLK7N9LIPOayL3DPS2MuJTyVnzL1s1c9ck7-ItvPku4_1776034255
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use __GFP_PREZEROED and folio_test_clear_prezeroed() to skip
clear_user_highpage() when the page is already zeroed.

On x86, vma_alloc_zeroed_movable_folio is overridden by a macro
that uses __GFP_ZERO directly, so this change has no effect there.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 include/linux/highmem.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index af03db851a1d..b649e7e315f4 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -322,8 +322,10 @@ struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
 {
 	struct folio *folio;
 
-	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vaddr);
-	if (folio && user_alloc_needs_zeroing())
+	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_PREZEROED,
+			       0, vma, vaddr);
+	if (folio && user_alloc_needs_zeroing() &&
+	    !folio_test_clear_prezeroed(folio))
 		clear_user_highpage(&folio->page, vaddr);
 
 	return folio;
-- 
MST

