Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE972BE621
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 22:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776808884; cv=none; b=j22/ZWTm2483M8LdYNXMAP8Lra+nZtnVMmqfxGVULs5NRbamIqkdTOt0V4CKmm7cLedIpY45D+vOH6Up2Z28YajLZ4Mm/zlecMTqkfDxXv9NyORuraNsE4S0dBTKGxGNPwe+I1kXqBSMkU+oUbT3ePfZ4DQpFnZzxRP/YUlCJSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776808884; c=relaxed/simple;
	bh=+zNBlTlQkFqQMbEC4hj3ywqszA8Y1ImDjehUW9ILJAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=GWQ37oImvs8NOlr4CiohyyFPwehawVsQnWWmsfEMnQqatJATIFsrHpgQA3DMS7lws5M8n8iyOM2oLbee3OnB2NoDDTrrc0qpLGb8WzJbA8ammz0zAJB3ZJ1nuHD0dFF742+3p6dJi+vRpwdIR/mZmAoMR8kdfy7tgxSq4fW6kQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BnEaIBwH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BnEaIBwH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776808882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dn5xupL5V4qF15edJs01tgV6QOrsZ1JWzK8CN9u8yrs=;
	b=BnEaIBwHg0DmQBiMMo7rNi07jDmfjgA0gwy4Ztu2XQpKt5LfGFeZnDiQ+9bOTr4NLgMaAm
	ydxmDAjmlkdMPW7HH2o4ubcy8WYHQE5IeydINVsH19Uh6pAggBSUEzbNtJWK5NMe3dr927
	eMaBj81dtRReCTRwpYxxbQ0fXQh0p4I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-0ZR9iQggOeaznRw51O1fdw-1; Tue, 21 Apr 2026 18:01:20 -0400
X-MC-Unique: 0ZR9iQggOeaznRw51O1fdw-1
X-Mimecast-MFC-AGG-ID: 0ZR9iQggOeaznRw51O1fdw_1776808880
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488dcaf2f2fso39132745e9.0
        for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 15:01:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776808880; x=1777413680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dn5xupL5V4qF15edJs01tgV6QOrsZ1JWzK8CN9u8yrs=;
        b=gqTIySTzQQqpqkJoMKcs3CsFS31vg7nojsd59PJTroUzVLBUQrmKmF5XUS0QfJRbf+
         5QrIgtVaTKCNPm7+ExYg0pfox8lDemGTiOm8vSbqW7bx+399N9JvoHJVrItDIZLdYFR5
         t4ta48tpV2vbdP6PsVdiNMBHYEdTmkOfbSS9HpL27C+h9oQLXEmvoteSUKJgoxKQt+A+
         0r5pUDov+24tjsxhDBXmkRYdfx8eMmZtVc+i+NjMI5w2vvgITqxRvUutFP3W2JsWk2UO
         n9c903vFS+8s/EWZ6uibRCmYowixYVFyepzmHBMRdebAL37pXAyS+GW9IotdesNXKIax
         YC5w==
X-Forwarded-Encrypted: i=1; AFNElJ+CtQku79+Phw4tKMewB5+rMX+wsuidPmmFmvcMu2o0KccTNnxqT94cKP0THLG9Gc8b8cWTmQ0Upn7tcAUwnQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyhDQ4OJLUo1d4xTyFKPNpz9luRmdaNzlLpCvC7zD3pTQHs1zyR
	8xKF5QN/jO2qkosSyawmzTZzlZ/gk4wBoMN4pnv9Jd0Xvu5GswcLYoOkb38nTA6FKGS7J+9ro+j
	SwHzcQNLVOAkcgzFBTgtznBWWVwjX8P6Ib2IpEZH7QtGoADlLty2MeBiA/HkLtXhlkKEU
X-Gm-Gg: AeBDievPRKKnCvpCu0jarSdZTlaPoQ88/gIDpu/v+V9XLCQ6Nj6z/HjH7ybVI2oyc4s
	njad0T8s5RZywi5tzY0OH+gMNYOD4bxF/ZqwA037fSwbUbkc0xeDADVCUErIw41NHPh2aMbo2qP
	eGDpi7RBfQon5LPPgDRF0QXIHbWM1eKuXfaFuuCX+7h2UnWaJZHgJItnGQe/I7yqtQ+l6lOOHx+
	cTdNZxNYV1DZHB5fXqIT5jyw/N1nxV5t/nVVnJXLoTe5FPAvHsRNE+KMPsV9+q/Lex4Cef9eGVE
	9OFieoUyyIZKGOK8W7Zy3LiVEYi4O1z3vH2A7t1H/Elo31QYCi9124q8/rDrb+zPfMbzQgVx6C/
	hBU3lXnycsaGnFmgX7514dTV1b4Lg8huPY83uOp0LG0UirM8ncsTDEw==
X-Received: by 2002:a05:600c:1e09:b0:48a:592c:e655 with SMTP id 5b1f17b1804b1-48a592ce7c2mr22291555e9.17.1776808879619;
        Tue, 21 Apr 2026 15:01:19 -0700 (PDT)
X-Received: by 2002:a05:600c:1e09:b0:48a:592c:e655 with SMTP id 5b1f17b1804b1-48a592ce7c2mr22291235e9.17.1776808879144;
        Tue, 21 Apr 2026 15:01:19 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891df9e50asm153245945e9.0.2026.04.21.15.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:01:18 -0700 (PDT)
Date: Tue, 21 Apr 2026 18:01:16 -0400
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
Subject: [PATCH RFC v3 02/19] mm: add folio_zero_user stub for configs
 without THP/HUGETLBFS
Message-ID: <2c8e630afa8b68232d648c08eec4b2fc7d933dc1.1776808210.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: Xur96FhuMIOSUAw7VyW26sJrafIg1wzEdP1SRYGrv4I_1776808880
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

