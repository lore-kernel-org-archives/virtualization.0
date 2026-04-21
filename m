Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073722C1788
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 22:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776808894; cv=none; b=YTzx72dLHvxK0rPSnYUg2pmTl8khyxxaxbSrlgEMScNG6g69icicw2KMCagnpMo6V9dIyrHrXuERlJApp7FRiZSWyeQgWj/h0Afyw8kyrlBwtUmUlNWo45FADAFgea3icEbkesWPf/uZccji/bIM3TYAduAblX0sY5TJ3E/MS4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776808894; c=relaxed/simple;
	bh=B4v7SD6SJ84KapLgBy+iXreANiiaF75HE81bu1RBt3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qw97cMfCd6kqYqY0o7k52WZhaAf55rfw8iCok41RoN7dXf0oP+5wOw42iptsBuGOHxMxPZtUXaNURnaGbdxjNvnHBAVWq/pvH0B8x5MGGMTVEqkrDVu4zPmpLra7q2vNF9BXs7TQBp2jCi4LWjNlbKOMWdYViSSxy+UDfGLMmSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aq7IMNGd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aq7IMNGd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776808892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jpAQ9O1oMgUNlo5ukg9OEno1SM1k+70VK2/jH7/8vVM=;
	b=Aq7IMNGdy+vcFdysvnN7cwn345HFShyusYwTAF8UzGdv0/BkSTUI0cwxDI9BIWWOiU8kOF
	aCEILSvOlmzq5NgHrGt6kpNGZzCdA2dfw+/Fn/mTEbA1f2Q3t3n0OOBiXXBJSE8Agvd5hf
	Y37AqHmFMI3O5yJtZStxAAUl+rxt6vM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-K5u9-w23ME6rIVBlby9lXQ-1; Tue, 21 Apr 2026 18:01:30 -0400
X-MC-Unique: K5u9-w23ME6rIVBlby9lXQ-1
X-Mimecast-MFC-AGG-ID: K5u9-w23ME6rIVBlby9lXQ_1776808890
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488f973ddfeso37113745e9.3
        for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 15:01:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776808889; x=1777413689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpAQ9O1oMgUNlo5ukg9OEno1SM1k+70VK2/jH7/8vVM=;
        b=N2ntux0hwTJAymjNDAWJwikM51hJ+ZjnLXuPtjIzuteeIHcPTdg3h6mUjBnFghhF9x
         FI57TUAOdO1S8PcHBKkO/cALFnW3KATLLCPmmwK4c0JZT6mMXPSUd/I8vLQ8e0sZkJ3n
         FZGyg5+QqvbwMTdsEHbuwpDBEdAICYjRnHul2WmkPksaUEP1s760X9U5/Fz3ZR4bHM/e
         rdvMYARH+cD0msatFjFnhKodlMnsUmi6yajbWpnZYAgbTbVsLTBUAUdZl0Kgnr2/otlB
         84Yp1hQnD0Y3Sck4mU6lcTKP5TyTnQfQzCQV+dboj04dtdBs2bCmNGzGmRe0w7rYQKjz
         pnlQ==
X-Forwarded-Encrypted: i=1; AFNElJ83NaDjlSyRylDItvodEBHa3QXAcv6eSgHges8fq5+3tcueJ1W5TlEFtAIYKEW4GqLuw9heogWsUydLNbj2Yg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyz87FGKjsLnwm4ledxSyUsmKYIZvIXTCxMewBZik9mfzcThbqG
	M57vKUxwDV/6tUuckuXJG+xeyWenQqXvGQnDsW67TdF5cCR07Vga87AXRpE9G7KsCuQjwCvg4qb
	Y2AcpcFKdVioRVYVjdun4eO++nrY4Ped97AMZkiOpCd9dBFYjVMrDlvUdioy/DH85UKdR
X-Gm-Gg: AeBDieuTqMIahPCgEViC+8wEjeb25/d5oUmivWOMdkij074mMhoXLWUZOiNOJPtxnMu
	m2nhtPRVmlnYLM7UweFFFsWRMSc4joOVShAuUydBGVY1vduZ+/tw5cNsiHFBxIpLJJjs0WCXeXs
	newkP1P5oOW6X/5ri9GMaeSNkhUnUno4rLnpYHd/m+zQu7SHIJbBNIcEZ98qMDVk1WJ3vVghlAw
	+abT4y8/LqCb5s84hVn6kDrs+PEhurUze4LDsNJNTnWQFI1e0/kc9DkKeF+F4IQW80NzXnIcDUk
	dtEqmJRjcBlMSgnUBbDFhEfqNL4qpOS1ASBRlPMYYGgp0zvBP/sAidNuRudwW0uIzunp22Ht9Wo
	+qulvCMovSy+bU7TyU0Vlz/E9YXVxZbJUpwsL0nm898uSC/3pdWFrvg==
X-Received: by 2002:a05:600c:c10e:b0:488:8185:e672 with SMTP id 5b1f17b1804b1-488fb792e84mr214398155e9.30.1776808889497;
        Tue, 21 Apr 2026 15:01:29 -0700 (PDT)
X-Received: by 2002:a05:600c:c10e:b0:488:8185:e672 with SMTP id 5b1f17b1804b1-488fb792e84mr214397765e9.30.1776808889047;
        Tue, 21 Apr 2026 15:01:29 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc0f8193sm361461265e9.1.2026.04.21.15.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:01:28 -0700 (PDT)
Date: Tue, 21 Apr 2026 18:01:26 -0400
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
Subject: [PATCH RFC v3 05/19] mm: use __GFP_ZERO in
 vma_alloc_zeroed_movable_folio
Message-ID: <f6b439191a5aff5f93cd11c00a388b5ff7261220.1776808210.git.mst@redhat.com>
References: <cover.1776808209.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1776808209.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -MzRHPf7pErxcrQzE8U6Yqy_R4SFwVZgve3NRxscyCI_1776808890
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Now that post_alloc_hook() handles cache-friendly user page
zeroing via folio_zero_user(), convert vma_alloc_zeroed_movable_folio()
to pass __GFP_ZERO instead of zeroing at the callsite.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 include/linux/highmem.h | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index af03db851a1d..ffa683f64f1d 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -320,13 +320,8 @@ static inline
 struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
 				   unsigned long vaddr)
 {
-	struct folio *folio;
-
-	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vaddr);
-	if (folio && user_alloc_needs_zeroing())
-		clear_user_highpage(&folio->page, vaddr);
-
-	return folio;
+	return vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO,
+			      0, vma, vaddr);
 }
 #endif
 
-- 
MST

