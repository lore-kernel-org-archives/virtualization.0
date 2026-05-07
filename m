Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4BF39BFEF
	for <virtualization@lists.linux.dev>; Thu,  7 May 2026 22:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778192632; cv=none; b=JFfkOOtkk/BmOeBX58LThieKmIlnOZvDTd8OYRtz/xSK433jJtW1wZMFNOPCDE9wkCbKEtkpeGKEOuAr3/FfgfdjBvB1qesDMBcyrNP5BXg2WKWkzPfCdUsfRplbLk2kyJ014msbcbin3prXUzZi9K7wrnumFhsvJsxiNTI4Itw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778192632; c=relaxed/simple;
	bh=mQqx6N7f4HKujpbDEae/MRGG23U+Ado82zzAxmBrUmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=X6NhYbDsd2DihqjAo/AWhArntEjYnPvyUL6NjBV8DQJ/r4OCHMprOkYsNCWpJzj2WJ9upe0EoI34g3nSoss/Bjas7T40ATn0PWAVGnc/csTdYEyrbJ5e/fC3CuJJ+bW+79Mm+kmJYQIUBhmzHTnGVPxFC9uiDB0XPram5amnBLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X3v5X80Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X3v5X80Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778192626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MpBn8Jg+yemSfT/rKcYB8AJ8VmedmgkSc9fIviOsi3s=;
	b=X3v5X80QYwCwtXsa9QfVKjPEzIBKZ3FeRF1ZNoNlSiT/XRzPGmIz//yxeFAE4yL10aaEr2
	HPc0ccPKlCMd3+agszx80c0DIEws21Dt5xxisQZ4gjPjdyca34KH/LhPa4klQ2VlMDIm/1
	ZkbJeB3ZCzZAmbldWD0KkZMqvzzM3zA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-X_oXF_0oNHWHjD736jPyOw-1; Thu, 07 May 2026 18:23:43 -0400
X-MC-Unique: X_oXF_0oNHWHjD736jPyOw-1
X-Mimecast-MFC-AGG-ID: X_oXF_0oNHWHjD736jPyOw_1778192623
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d789cebcfso1679849f8f.1
        for <virtualization@lists.linux.dev>; Thu, 07 May 2026 15:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778192623; x=1778797423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MpBn8Jg+yemSfT/rKcYB8AJ8VmedmgkSc9fIviOsi3s=;
        b=buUztVejlXMQkZDSBSgurCyzbydy+rFX9wxJFiPs3JNQzDq+ZurqZlNOon/QU/fSIz
         5k4O3mcUzLMFxZ0BGyuxjwChhToGvBiVs08utdDZmqw31TZvnxtlUbEc02liy/wSbQP0
         DP6pZuubEwyIIj8GFjnKnbgeqfswW9/fGtHieS3mE7wQaMIJj/dCnBDfegctvVlqU+ic
         mF6hyzZB3XnCXQfdjuPtuD6jgIWwZuKgJwzVx+SQgPTmfJwFSrzTotR5R3Rl9RVlOe1o
         rRF5J5hLxu6KYWMPuz/esbkLp/bS1eSMoUk3iVBP0LJKIL87CzGNH62F0ge4+Vo00+tx
         A3aw==
X-Forwarded-Encrypted: i=1; AFNElJ/sVlm9EwD1Jg92HQ0uwZfNBLvi/q89UN6nNiwlYoPVmxw+OFER5Xo+u9m8FtPhz05aVY/1LoFxEHxMbH0xSg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzbqx/SmGXPzj3vXdZff9e+KqpZAD8/4u9tXQM8j//Z04mE3Uj+
	ISJ4HpefgBcf7MAVEEcerIZV5zuakNBU3X52UMV9d3jKRFqlv1tWNrSRe33wtI0hO5bREUhwT5Y
	9VpVVKI6/Kofj72jUAA0kZgTPsG/0UC2fhCOxTNhZBN7CSl5lsWxLoMkujzaCryWRyWUv
X-Gm-Gg: AeBDieu7pb1qxYe3R2XhVnVfUq4yCQy9llAuMlEFyDV/41PinnkaVvZvTDoqAsDI8+M
	F6Nm40Z4GEudePIodSBKCKUnlyClUWbQPi24D98LysuZp1scHAgYhjE/DoNQp4JNvMgmEfptmMH
	6+/YMCup6O3R+38gKVDGjYYmcdCc7VLXDjEnu1KvCOB1CYb3lj5kjmRhg0TI06CezrIizQi0OGY
	2SO07zRaKTRli4G0vxNNj2m+mDn6lPoRphxdKRdntNgRzUMEcWBpqmbZo3+titvGDZJJ7LgkWpB
	Rnk3igAbzCwF0QVZHSQ86Fw644Yg6Hk+d0rYvDx4ZYLo1dP1WumqUEF0Fiij4Q+Q8Z3Hg+yy+bM
	lbu+hoZ5wbiqYMKNNatULj8zpGXNN43PYrO2XPNeN
X-Received: by 2002:a05:600c:a10a:b0:48d:50a:6ef4 with SMTP id 5b1f17b1804b1-48e5dffab24mr53046465e9.11.1778192622546;
        Thu, 07 May 2026 15:23:42 -0700 (PDT)
X-Received: by 2002:a05:600c:a10a:b0:48d:50a:6ef4 with SMTP id 5b1f17b1804b1-48e5dffab24mr53046285e9.11.1778192622056;
        Thu, 07 May 2026 15:23:42 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538a517bsm166228835e9.4.2026.05.07.15.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 15:23:41 -0700 (PDT)
Date: Thu, 7 May 2026 18:23:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org,
	virtualization@lists.linux.dev
Subject: [PATCH v5 26/28] mm: balloon: use put_page_zeroed for zeroed balloon
 pages
Message-ID: <f3e0f47bba9181f7411086bcb7d229e8575d58b0.1778192416.git.mst@redhat.com>
References: <cover.1778192416.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1778192416.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vYrgErVYSaDTTzE3mmgn9L1IAjV3dombOtNTM9e7MG8_1778192623
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When a balloon page marked PageZeroed is freed during migration,
use put_page_zeroed() to propagate the zeroed hint to the buddy
allocator. Previously the hint was silently lost via plain put_page().

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 mm/balloon.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/balloon.c b/mm/balloon.c
index 96a8f1e20bc6..1bf7eb2642a9 100644
--- a/mm/balloon.c
+++ b/mm/balloon.c
@@ -324,7 +324,12 @@ static int balloon_page_migrate(struct page *newpage, struct page *page,
 	balloon_page_finalize(page);
 	spin_unlock_irqrestore(&balloon_pages_lock, flags);
 
-	put_page(page);
+	if (PageZeroed(page)) {
+		__ClearPageZeroed(page);
+		put_page_zeroed(page);
+	} else {
+		put_page(page);
+	}
 
 	return 0;
 }
-- 
MST

