Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8E030EF6B
	for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 21:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777240127; cv=none; b=m15btAxyAgVHdYZaZi/cvr2laZBDty54y/KvTEAwb8N/LTCTq1zm7UpYjhj0dsojmMhOK/fetP8EAUL8sKnurexxodLkSu9JhaHiSO0vfoFOmWRN5gDoYgfpe5Pqhul6oj1mKsmDJhMJFPSTuISTfwsfaB4QYzUr1ATPUPgptCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777240127; c=relaxed/simple;
	bh=AwIv3WhJazU+sFjaROXcIit57FR98tq+do8n4h80ZYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TOoNIbo+8FepIqAOjl/Ox2SftCC3sgSY3I4+IcJ3poaxC+wKJQ3SClkwkfyYHl2gaKEqjNmu+JjhXl47+8HyNWCeH3+Lev+FX8uzZybDt6Mu1GbanKoM1/MPIq1h81Q22zfA0hLjQRYlQ4LmhQ3+/kztSxZbWO3XO0IwP9WWss8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QiyDtpd/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QiyDtpd/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777240125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sf8WIccv4sYUoC01taSJ6nrrobzratXFM4dveYAPw/U=;
	b=QiyDtpd/lzCDcYBK0IJ3GQAGYZSTmtotUwgW1lSaxQ6atJrCqjQ2vJDfF6GKEwlEqpdkc0
	gqe7NYXxReEqBe7ql3FkphfhBkakSGn6Qi11PVA6LW/Ko3+Vco9+M3FT1nK/2wR6MlCRR4
	9KsFcG3XC2q1SQIt5kQGxeirhFb5vX0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-0AnoJfsGPh685yVr7KHAUA-1; Sun, 26 Apr 2026 17:48:44 -0400
X-MC-Unique: 0AnoJfsGPh685yVr7KHAUA-1
X-Mimecast-MFC-AGG-ID: 0AnoJfsGPh685yVr7KHAUA_1777240123
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43d7757463eso6129004f8f.0
        for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 14:48:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777240123; x=1777844923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sf8WIccv4sYUoC01taSJ6nrrobzratXFM4dveYAPw/U=;
        b=QSAjMNJLy3FNKufYarHcUcKVwFo6DTC0buoWd5XoSwrUyDzbY1XrHUNQDi5q18zj7F
         Kzhp1xakuOtRLhPLqb7RxaJpqxwNWJ2nPZVZ2UGf5Yasc5APBpSbf+P+qCU8cFVlK0gN
         cn25iYAE8YWS6a2NsU5WkLAzNqkeHLE+Iwnuh/zJZt5ZM/YPREOCNoEdsWvBIUx805hN
         NXWasmxcSoUqtYxgSAwCwUnBaqMzlg9ScmIvtM77ATLV3ZpLyXnDGneHnU75L0dmDEFT
         6hh+RRbFVVxwem8xeJc9ImBuRKq/FIsceySd2FGUcibOCOMQliAI2BfJgTlqNMr/nelq
         jThw==
X-Forwarded-Encrypted: i=1; AFNElJ+fmo5y/jcLIYbQT+mhNuRmtYvSzQQjY3NDWL9NudY617BQfO0yO2ytnTQZa7M/koSKwi0pENy9zwdVmJ2/ew==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKC1GcImBkoI5lbgGzwyexg6HxtOfoTg02eJVkHD7FJI/X6qtR
	XUNLFacAZIuKfAiH9K8pkCNqS9AAQfNhfEmkm8Nzb+sAtJbH413juEk83wS9G1Y5fQP4lmiNDep
	rqDmmR/jsz3+VopoBR7kpkK1DfQN44oLaEWm08/dphaVWsI4+7gN6xlnnaa46Ff8Ertt7
X-Gm-Gg: AeBDiesh4Xpyv/cZihG9SCCvfREr7+tMx1lw0WRSYgN+B7+VcGNyx30xlTSzB4jW3vb
	CpBZ1591w5vnBk3ylOUldr3Ek+DPj0Ea98p4V3VGXg0p0dHx0HrtIUkFnHquPhBYd4pK0TISqeF
	Auv5K8IChg5Faj4lIu9s4srTqm50UZPjp34LwBLLLuoEgEbgW4F6heySurgPSePlJvLAS/Cjx1/
	W4wbtnet7xucxKibKaTmR2wkrI7L9F2nqSpSxFIZJQXlqb90fo+lE5hzOr6RGrLbEEa9Ibx9WGN
	rohpCjUv7+3p1Rt5X1iCXWSWI0Uih5+IXN8te/VwOGpC1aDd0GLNzFmu46R0Z/f9eOIpRgvDMZp
	hSE2o/zLtgELEtCg0oE7nhSFkwkfQpam543076vodbmhfS8AdNj+Agviw
X-Received: by 2002:a5d:6f13:0:b0:43e:a703:3675 with SMTP id ffacd0b85a97d-43fe40329ecmr53892355f8f.5.1777240122765;
        Sun, 26 Apr 2026 14:48:42 -0700 (PDT)
X-Received: by 2002:a5d:6f13:0:b0:43e:a703:3675 with SMTP id ffacd0b85a97d-43fe40329ecmr53892312f8f.5.1777240122338;
        Sun, 26 Apr 2026 14:48:42 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-47-179.inter.net.il. [80.230.47.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a341sm81502808f8f.24.2026.04.26.14.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 14:48:41 -0700 (PDT)
Date: Sun, 26 Apr 2026 17:48:39 -0400
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
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PATCH RFC v4 22/22] virtio_balloon: mark deflated pages as zeroed
Message-ID: <966969d970f95ee2a573e83ac26162e15f758261.1777223007.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: S4ccXmpvYUtDTEXh-VltE4TfKfX1IA1jMOOmPlvzTXg_1777240123
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When host_zeroes_pages is set, the host has zeroed the balloon
pages on reclaim.  Use put_page_zeroed() during deflation so
the freed pages are marked as zeroed in the buddy allocator,
allowing the next allocation to skip redundant zeroing.

put_page_zeroed() is best-effort: if the balloon is the sole
holder (the common case), the zeroed hint reaches the buddy
allocator via free_frozen_pages_zeroed().  If someone else
holds a reference, the hint is silently lost.

Once balloon pages are converted to frozen pages (no refcount),
this can switch to free_frozen_pages_zeroed() directly.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 drivers/virtio/virtio_balloon.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 8c15530b51b3..cdc3c960397d 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -304,7 +304,10 @@ static void release_pages_balloon(struct virtio_balloon *vb,
 
 	list_for_each_entry_safe(page, next, pages, lru) {
 		list_del(&page->lru);
-		put_page(page); /* balloon reference */
+		if (host_zeroes_pages && !page_poisoning_enabled_static())
+			put_page_zeroed(page);
+		else
+			put_page(page); /* balloon reference */
 	}
 }
 
-- 
MST

