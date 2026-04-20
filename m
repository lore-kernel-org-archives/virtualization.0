Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345893A1E67
	for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 12:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776689457; cv=none; b=lFOSPVDEwWTYTSa6yigQP/hLWPuvM6CdQ/WRN5P6D+xdfXncezg6B/NN/XWh6G+uUcSCBotoEVpkiSF3ugp9kNn0lv18PZAOjiIkZRa2mc/IpfxzaFwtvPg8x7Q+9R7M7QKQarYEmbqc1pUtlbHfDall9xA5ICZjBXIh3Lt2e3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776689457; c=relaxed/simple;
	bh=DbRu+tF2pO7MxmVyVwdlz+4D60lwlbakGMBh20fbcW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=clZDJXNHE95pg0VSL2LmaJ3d8Q+K5/ZuYEyMZR4YY0cEzw8S0FCudfYaHLc1n1xQAx+6mWc55MhNoEaworIMkH0C2+bQp+pd2ncDpPsITKivBDHm3Lbtd7ebusywxJAh9y1jzhaICqIjAi4Nu6MQ+pVF0jy8Vb00m4Qz4Sm+Q7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QsbL+G2x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QsbL+G2x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776689455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qyYPevVtD446gJgwyEFeHqxZY1ZBEj3WK1MuiedCKFk=;
	b=QsbL+G2x25KnVRX4smKmuXflKgYQtBnNMtn7U3qAxU+igyug/56ffF0kXThSfgDHkXPPsJ
	Ik6n+g6qR37kHd2xnPXudUvCaSysA95iKeixzICKBKLc+OkU1e3JU8DAFMkuqViyyIdR6G
	gWRKEu0i0TCqtU0FKSMdP402w5p57ZA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-j9F5loeKMnyHIP7l4x6MeQ-1; Mon, 20 Apr 2026 08:50:54 -0400
X-MC-Unique: j9F5loeKMnyHIP7l4x6MeQ-1
X-Mimecast-MFC-AGG-ID: j9F5loeKMnyHIP7l4x6MeQ_1776689453
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-488c2aa6becso29950635e9.2
        for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 05:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776689453; x=1777294253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qyYPevVtD446gJgwyEFeHqxZY1ZBEj3WK1MuiedCKFk=;
        b=DvrvGmPQhcM1rSOh10qS6HmpKLdyJUFH3o3D5RxaXkabFwdvNrLZV8Kc6VarYB4gdj
         zUQC6rZXn32y1qeMOu1NfY4UA4Dm+rb55gDU4NCn8/WEnHG9RGzwcK6tq01Psdui+5cn
         5ek9IhdBIX52kRAkoRftlobo9p5mK2AlvTprFVdX8aALOHcr9nB/814+S+KMJzAl2tFU
         FLrJhdPhBBWZkXsJeM37MRdha2JepSnw0HHY7WzPlK6uXjBqqvh5/8GoPzFkbZJPAiN9
         MsHWZvVOhLqzWVT1wgu6Rck1WaFzz48zfhlUXL6Ini3gHZ238pcWZ+k5kDqcCGtoHk+G
         FMmA==
X-Forwarded-Encrypted: i=1; AFNElJ98j5VKwZ3JMa3v/RI+Q9ja/olMXiYOfRf4njR/DZkE70FzqQ/JWMoVMF1Pv96L5Xn52BzIss2m/PoY+fJWPQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz9uKyDb78esOwm3xJqG7Zj0wT+Pethd1Vs1QsEOoozKrWFq1Ta
	LaZHNvFoczWCYWrS1NrKTUJva6gaK3N/7xDD2HdYBDCF5cJcFc94FLg/qgLPZxRPmwFh0qk6uyD
	YCTAeg7k/feRifVEFOqLnrATVTBfHzINNlx0IIpQg0/8jHhfJwwEVhB5JtLNRmKrDRZ5t
X-Gm-Gg: AeBDietOu3+TMjk4fzO+khSGfM9s3bT8UG/Cx427HHJJ1wAJ1ZgvR6Jue8A1esviNsS
	hdTgMAKr7JEZZJVvSSnhe6ugqLQlJ5L120d0XEFj3sn/4pTaOFVOaXN3jt+2l/p4yLCrtze1N1I
	NhnXxf6yklvyCcCm4QelrmDUoC9+Ws+SSh1koNYy3w/TZLmUhwnLyCXa9chj3hdcWJ0S88VpA+f
	buZ82CcKma+ggkb2dbqHanirPF40ePLCGQEGgmcaT5CRdIO2f/KE5UfPm4bjZbkzI1BbcN2G+E+
	zQsDRDN3qCVXy+aW76ej5b1fU/EPAQi35xpWXXHcIUJ/odX99YHOWV6yDCGv7FQ1NdWy17Rztav
	efHPW8HmZ1rupe6Yud8O4ptIsCSYs2zF5tHiZKTRsH8Ai4QHYsZzD5w==
X-Received: by 2002:a05:600c:c4a5:b0:489:96e8:1ef0 with SMTP id 5b1f17b1804b1-48996e8200amr30131585e9.30.1776689453001;
        Mon, 20 Apr 2026 05:50:53 -0700 (PDT)
X-Received: by 2002:a05:600c:c4a5:b0:489:96e8:1ef0 with SMTP id 5b1f17b1804b1-48996e8200amr30130895e9.30.1776689452402;
        Mon, 20 Apr 2026 05:50:52 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4890009e759sm216401175e9.6.2026.04.20.05.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 05:50:52 -0700 (PDT)
Date: Mon, 20 Apr 2026 08:50:49 -0400
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
	virtualization@lists.linux.dev, Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH RFC v2 11/18] mm: skip zeroing in
 vma_alloc_zeroed_movable_folio for pre-zeroed pages
Message-ID: <39c3c8e647fc4c8e3dcb5c9d12f2e29b5404e8f2.1776689093.git.mst@redhat.com>
References: <cover.1776689093.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1776689093.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2YIVl2ikG8yxoaXfKQkIyFyW24nNj7Xt5Zgw35TJkmE_1776689453
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use vma_alloc_folio_hints() and check PGHINT_ZEROED to skip
clear_user_highpage() when the page is already zeroed.

On x86, vma_alloc_zeroed_movable_folio is overridden by a macro
that uses __GFP_ZERO directly, so this change has no effect there.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 include/linux/highmem.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index af03db851a1d..8bb67772c1cb 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -321,9 +321,11 @@ struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
 				   unsigned long vaddr)
 {
 	struct folio *folio;
+	pghint_t hints;
 
-	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vaddr);
-	if (folio && user_alloc_needs_zeroing())
+	folio = vma_alloc_folio_hints(GFP_HIGHUSER_MOVABLE, 0, vma, vaddr,
+				      &hints);
+	if (folio && user_alloc_needs_zeroing() && !(hints & PGHINT_ZEROED))
 		clear_user_highpage(&folio->page, vaddr);
 
 	return folio;
-- 
MST

