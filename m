Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB3232570D
	for <virtualization@lists.linux.dev>; Sun, 12 Apr 2026 22:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776034259; cv=none; b=DCNzp9IfACswXTT69O8pCmjXIVyqtqk03LXyrgN25e+YXPvxVZSrupsD+7yMRMUUswDbWvO7gyjHOFXzNrTA+netesYuEOz0W5B4tai9J0FI8U2xDgB9kd/Rykwdeg3WHhY+zgKwzNtkrQZWzBUvGhOVR23tdADNPVhkXaX8ouA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776034259; c=relaxed/simple;
	bh=tyevfehojZyLx0rvZbifr9tVTcR+LX8179KCtTitZQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=NPR7904SCfRrm0Y+JaXNhmiJJH1Xc3sygZBmvufdAY6bfp00ni9hAoW0/LQo2/cwqdPnLgD3F0qBGpk+s/nEPPrtbK6WAiE+HV7xq7Ah0xegRBWgAEldRF3p1K8VdVL0CZElcmpmWPr1Vc5ThVG8CDdJz036g7VO+DgiObrDL5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uag5eyoL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uag5eyoL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776034255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jGJCJcDO5/5MpQsdc/D5wN/ajh0fH6KE567pAXfVmHs=;
	b=Uag5eyoLKGncGgU1M2wcaFI60YlK+T+1iZw1KEAoadc+7DLladnnB/0jwLwh9RjScSBRrl
	akC39FtuNxeXFkTUTfONiQVFuuIKyxqYIMtnIutNDASwA7aX7M4mCPCbPL+OT82ae/VMo9
	W6rIEFhzBjFM/3yhtU9uvWiqdIIvwos=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-qzBuz5ImOBiVOMP5KpwhkA-1; Sun, 12 Apr 2026 18:50:52 -0400
X-MC-Unique: qzBuz5ImOBiVOMP5KpwhkA-1
X-Mimecast-MFC-AGG-ID: qzBuz5ImOBiVOMP5KpwhkA_1776034251
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d103e46c3so2337010f8f.3
        for <virtualization@lists.linux.dev>; Sun, 12 Apr 2026 15:50:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776034251; x=1776639051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jGJCJcDO5/5MpQsdc/D5wN/ajh0fH6KE567pAXfVmHs=;
        b=jgmtCCZjoUe+SMM7G2wAYvQ5blUrjm/IHQlO0pYAaTI4Xk/KwgVuZU9RYqyf4P0OfV
         eKUQu8+8qD14/MKJvcC1NTREvtYPmgddJS/s1neZR53znAQVqLrdOvmkyIUzi+D0kx/a
         HHHcym9PIQjoBHRWGhu0VrWgE0hr4YKRYmk/uC3SiwMCuB3r439xO2vq7LqVkWf0Q/c4
         +cuuvkHP2ecJQx7txvh/vZwWtthvByL3HGHhpVn4+lyTE4ATMefexTWLnXNLB/SzEav8
         +tRCDLdTgNdmCJKNnv1yZy+ib9RHEn7YUdYhLXMDPbK0VJa4aVfNmhp7Pe3fhgZVlWAu
         ivuQ==
X-Forwarded-Encrypted: i=1; AFNElJ83FZ5Ux0xeF/Bc2G/+iy/ZisYDjIvTSg7Z2AsvTJuunDIO1CGhDsVHU+iNQxJlRvAebSlNV1E+WU+aaNVQWw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxqMhxAHSCi042QgqtDaf6StaXs5PC9YTgOS9qlvb5AMGH6w7Z7
	0t1Etk7kj7oeXgBHgRyvh+jWoJMK7lBK1+7BosL64rnw0WwGvdhz5SKH9urEX8i73n8HpgPaz/T
	wRnhVNuvyejWaMp1nXK7SFPvTbh2YQpAps0A4zibAH64IN4vZbu7IwnqFol6F4NHNyZ3g
X-Gm-Gg: AeBDievmle2LIGHEdViJ9S8WWtp/rfesqMnWneJwoS/kX99RoTDQCbVF129Q5sO+ZTy
	zCmCgsunuVnW/uNicwO6dLUJTYQMxN0l5CiqwD+kglo4LobfSHYdiI1ecnUmUucXyxcIZWYtnfv
	/O1McyY498Z+6i+yuu6LrETMHEdNyn1l+i3XN3oTi5Mnri5EADfMJRYuykrjpJ8PLOXp1jL1cCX
	uaAEotqag0Z3xO06aAP6dKYr44zeflAO1/dBTBL1ufws6UgKHacut9QfQt1iBhpX1DIXD8v5/+o
	sTy3wjj/RAeJ0txnR9we2pA8qFAIsAq/uIBtsWnPlI3X/9uI1BqTtb/5B7qZCOtCDgmUpqSoIVD
	YgeqQBp+NzoiY6MP9Su/fyiBQI2WVbxIrAHwSOOg3reQ=
X-Received: by 2002:a5d:5f46:0:b0:43d:1cec:4766 with SMTP id ffacd0b85a97d-43d642b6b9cmr16170663f8f.23.1776034251177;
        Sun, 12 Apr 2026 15:50:51 -0700 (PDT)
X-Received: by 2002:a5d:5f46:0:b0:43d:1cec:4766 with SMTP id ffacd0b85a97d-43d642b6b9cmr16170628f8f.23.1776034250679;
        Sun, 12 Apr 2026 15:50:50 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e46713sm28673200f8f.21.2026.04.12.15.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 15:50:49 -0700 (PDT)
Date: Sun, 12 Apr 2026 18:50:46 -0400
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
	Mike Rapoport <rppt@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
Subject: [PATCH RFC 3/9] mm: add __GFP_PREZEROED flag and
 folio_test_clear_prezeroed()
Message-ID: <b21b0ba353330f24b9e10ee5bf01b60f32043327.1776033771.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: p-84Co69edrzEQsxfqERHKwj3n6yBRwPrH2EKfMIvyM_1776034251
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The previous patch skips zeroing in post_alloc_hook() when
__GFP_ZERO is used.  However, several page allocation paths
zero pages via folio_zero_user() or clear_user_highpage() after
allocation, not via __GFP_ZERO.

Add __GFP_PREZEROED gfp flag that tells post_alloc_hook() to
preserve the MAGIC_PAGE_ZEROED sentinel in page->private so the
caller can detect pre-zeroed pages and skip its own zeroing.
Add folio_test_clear_prezeroed() helper to check and clear
the sentinel.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 include/linux/gfp_types.h |  5 +++++
 include/linux/mm.h        | 16 ++++++++++++++++
 mm/page_alloc.c           |  8 +++++++-
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 6c75df30a281..903f87c7fec9 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -56,6 +56,7 @@ enum {
 	___GFP_NOLOCKDEP_BIT,
 #endif
 	___GFP_NO_OBJ_EXT_BIT,
+	___GFP_PREZEROED_BIT,
 	___GFP_LAST_BIT
 };
 
@@ -97,6 +98,7 @@ enum {
 #define ___GFP_NOLOCKDEP	0
 #endif
 #define ___GFP_NO_OBJ_EXT       BIT(___GFP_NO_OBJ_EXT_BIT)
+#define ___GFP_PREZEROED	BIT(___GFP_PREZEROED_BIT)
 
 /*
  * Physical address zone modifiers (see linux/mmzone.h - low four bits)
@@ -292,6 +294,9 @@ enum {
 #define __GFP_SKIP_ZERO ((__force gfp_t)___GFP_SKIP_ZERO)
 #define __GFP_SKIP_KASAN ((__force gfp_t)___GFP_SKIP_KASAN)
 
+/* Caller handles pre-zeroed pages; preserve MAGIC_PAGE_ZEROED in private */
+#define __GFP_PREZEROED ((__force gfp_t)___GFP_PREZEROED)
+
 /* Disable lockdep for GFP context tracking */
 #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 59fc77c4c90e..caa1de31bbca 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4820,6 +4820,22 @@ static inline bool user_alloc_needs_zeroing(void)
  */
 #define MAGIC_PAGE_ZEROED	0x5A45524FU	/* ZERO */
 
+/**
+ * folio_test_clear_prezeroed - test and clear the pre-zeroed marker.
+ * @folio: the folio to test.
+ *
+ * Returns true if the folio was pre-zeroed by the host, and clears
+ * the marker.  Callers can skip their own zeroing.
+ */
+static inline bool folio_test_clear_prezeroed(struct folio *folio)
+{
+	if (page_private(&folio->page) == MAGIC_PAGE_ZEROED) {
+		set_page_private(&folio->page, 0);
+		return true;
+	}
+	return false;
+}
+
 int arch_get_shadow_stack_status(struct task_struct *t, unsigned long __user *status);
 int arch_set_shadow_stack_status(struct task_struct *t, unsigned long status);
 int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index efb65eee826b..fba8321c45ed 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1867,7 +1867,13 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 	bool zero_tags = init && (gfp_flags & __GFP_ZEROTAGS);
 	int i;
 
-	set_page_private(page, 0);
+	/*
+	 * If the page is pre-zeroed and the caller opted in via
+	 * __GFP_PREZEROED, preserve the marker so the caller can
+	 * skip its own zeroing.  Otherwise always clear private.
+	 */
+	if (!(prezeroed && (gfp_flags & __GFP_PREZEROED)))
+		set_page_private(page, 0);
 
 	/*
 	 * If the page is pre-zeroed, skip memory initialization.
-- 
MST

