Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6162621B9F6
	for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 21:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777240072; cv=none; b=Eox1oeoifNQnMszZs7NeHNVxjn8HVZ8gQbIRgPGuk4l49OjubzIof63EA00R7j/i8srGQrED5VB7KjzgLkt+drDfchU7VsKt3Oo9oPHTfs+fsZwuVGm53qvXFpz17jUSn26BmjdPAWzdZDncPLH9SEwX3ay5DY7dJTx9E4CrTBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777240072; c=relaxed/simple;
	bh=+zNBlTlQkFqQMbEC4hj3ywqszA8Y1ImDjehUW9ILJAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=pAZguThwpeS9fh0iVlx2EVkPfWdI5MbMpT89++Eg19+gvgQCnE88wnUypRFcLzcac9lGIpaWL6KkNZQtnz6XUFwS1jHDM+8NXYO+pDH0h9GQ6XUlljTXfFZ7SJWyAgjQKipIKMKBuH7qC9jN9w582B6HTnuHpI2JateuswtM8tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UvKDtvnL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UvKDtvnL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777240069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dn5xupL5V4qF15edJs01tgV6QOrsZ1JWzK8CN9u8yrs=;
	b=UvKDtvnL11JLzEMFQC6f0LRovIRu69QMmhq5he1lU410lFA9LUt0TquPfG1C+Cno8Mt6Ma
	d5SVTzXdP3ZnFbQBCHNlH3cid9FCLvhQdNwRBD/Bcc1EdxHzygftaOyT5VTyhLL5fPxTOk
	WSbp1t3sZ30nkC8EgNwIKJcjE46nmvQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-qkocIluZOSechkXk-sHTPg-1; Sun, 26 Apr 2026 17:47:48 -0400
X-MC-Unique: qkocIluZOSechkXk-sHTPg-1
X-Mimecast-MFC-AGG-ID: qkocIluZOSechkXk-sHTPg_1777240067
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488c0120047so56214975e9.0
        for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 14:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777240067; x=1777844867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dn5xupL5V4qF15edJs01tgV6QOrsZ1JWzK8CN9u8yrs=;
        b=InU0g2S8Svfo4cQJZlKOtj01TvbMOD1UafILy5ylYlP3DfuoD+nR+2uOq7dCUJ46Q8
         F2FzmBzFwQFtGJn7xoDS0JYolCrDmncooF83kuUqw7wsBA4LcKrZsTq5eK0ix3mNyM85
         EM/JKvw+Epy2LXvu7bX9Ad+DcDUv6pWLASgX0SbJK3VY3F9OxVN+5ssPyf93bNSIksEJ
         t61EEisa6r1349Erw6ALUYDO8PDahKXX6RYTHr/JvHtectKV8QJWqIL/hhPBeNzybfrj
         8clkHL2wvIRlCSZYpVYRAmDFCXphBd1ZtM2vSfSbA68CU8rBpjPUlmSBSzc0lQC0z0a/
         a0yw==
X-Forwarded-Encrypted: i=1; AFNElJ/YlsGmSo7e9NkAP926XtEiQnm/pWb/cbTwgOAo9janHOiWIjB6yaNLpjxxZMm33O0LUKPFQIMe1dtbvUj7Rw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8BxTLcajfVEUfe43jjtbLYqie7yqUgWPj43LMJABM7boJ4Ybc
	VGrBfJvLKbDMWsAe+EfgI29CPfyQ+DfwHrOb/xIgC12B0gOQmvj+FmYuf3bPclZ17tFWxDRtHI5
	CMy+7MfQpKyqpC5xJMj7QcpsAtqKpg5iRufOnotj7RY8ZXD4rkzf6vlg8FNjl2bWg+V0L7rBNHl
	vF
X-Gm-Gg: AeBDieuSMlahiTX5esK7JOVKPW3qsvkVJ/3nQfH42LcvSP+UUaDw82ACvqez6M2XGpH
	Up+fs7E+QnDFwF6xFZTG311N2FuUK24JKofHrY2CN2oImfOe6MhVPRSgf0D92g5cnxH7mroGo7n
	UGK7+4qSTAJGjFWAKyKAzAnjlfb83Qk5X6DCmZuBbasoy6Puy0E7la/xIemdjr47Zt3LhRU3hyy
	SMCp0xbMQoK4kZSa1wXLd2Q0hFQXeB/EZ1IDJ1XfQITWs2WQdHMuBCo7sEB1ITPctuV2DqjkY1M
	0A5KCbiSXDI3ShFNpCMCypqAV1FLF/b+9KYmUOhOOFH2pZ7vAtfIH/htSvMGUuBwZrGgKdf0Kr8
	oFpWDVp2asxiXj7uzRmxhPmgoR3JhMn4CuxfK26VpgCUyUnwM6AlLE/w/
X-Received: by 2002:a05:600c:348d:b0:48a:674d:e756 with SMTP id 5b1f17b1804b1-48a677401c7mr138299695e9.20.1777240066830;
        Sun, 26 Apr 2026 14:47:46 -0700 (PDT)
X-Received: by 2002:a05:600c:348d:b0:48a:674d:e756 with SMTP id 5b1f17b1804b1-48a677401c7mr138299475e9.20.1777240066327;
        Sun, 26 Apr 2026 14:47:46 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-47-179.inter.net.il. [80.230.47.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc10019bsm765742785e9.4.2026.04.26.14.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 14:47:45 -0700 (PDT)
Date: Sun, 26 Apr 2026 17:47:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Gregory Price <gourry@gourry.net>, linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH RFC v4 04/22] mm: add folio_zero_user stub for configs
 without THP/HUGETLBFS
Message-ID: <1c5deda275078ffb432af62ae293af1f696d29a7.1777223007.git.mst@redhat.com>
References: <cover.1777223007.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1777223007.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FD_Ht54NeDv5nGGD71ywjGlVwJOayT__34TsYVnkY6E_1777240067
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

folio_zero_user() is defined in mm/memory.c under
CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_HUGETLBFS.  A subsequent patch
will call it from post_alloc_hook() for all user page zeroing, so
configs without THP or HUGETLBFS will need a stub.

Add a macro in the #else branch that falls back to
clear_user_highpages(), which handles cache aliasing correctly on
VIPT architectures and is always available via highmem.h.

Without THP/HUGETLBFS, only order-0 user pages are allocated, so
the locality optimization in the real folio_zero_user() (zero near
the faulting address last) is not needed.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 include/linux/mm.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5be3d8a8f806..541d36e5e420 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4718,6 +4718,9 @@ static inline bool vma_is_special_huge(const struct vm_area_struct *vma)
 				   (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP)));
 }
 
+#else /* !CONFIG_TRANSPARENT_HUGEPAGE && !CONFIG_HUGETLBFS */
+#define folio_zero_user(folio, addr_hint) \
+	clear_user_highpages(&(folio)->page, (addr_hint), folio_nr_pages(folio))
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_HUGETLBFS */
 
 #if MAX_NUMNODES > 1
-- 
MST

