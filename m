Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9441C84C9
	for <virtualization@lists.linux.dev>; Fri, 14 Mar 2025 21:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988318; cv=none; b=a7XckdE6ykFg7/fL0EiyXc7buX/qtLGQxnuAqjVtE88FuUBpqWhn9YfD3GnPWlPYwyEJX2kfLoUw6AoFu7ZzUIwCnNonnurRm7TFh2vYQlQP0OcGLr1xiaQro7xQhrYIPy5lBuaoBFX4DaqHQtvUmNrwxaEapIDphZDrni4V1q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988318; c=relaxed/simple;
	bh=AzqFum6Agw13RjN3Fu1tKvuI6gP3XBpPLw2tmwLYzUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZnmqjAe/wsr4GN4qGv/WL6yNPXJLbI+wl2066KCWD3P9YOuEn/WLThpKbMeqENc8qKV6I21ofatjv51bPngTkI7sj5jnQ3gDJgg0Ce/vbb14H9HpCWtNx12ZWi0DaDZww+xUaCbOdoIVE6W0sCVuM9OgOsJwv7JWsDfRjV+lm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UBDEGuQ7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UBDEGuQ7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741988315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vPsYu1/Zt9JxInUUfAbvJhaRjTUPwV0c8VAQrmxs/V8=;
	b=UBDEGuQ7jvwuARdq/JI27Y5cXJ6jZrg6ZA1wLa9wLrKAFLyGuLcVFFo3aUw70BE1upZGi3
	ZjO2UQa30dxtSkmgyPPQbzp2EZDh8V1X5RK1UVdL45Q/zoMN6CceWFD7kImaLb7Lz6FBnE
	mXuaSaa0Q0Evir7rXG8IYRkm0IkYvLg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-Q0pkQj-lPNqdUoh8sMEMxQ-1; Fri,
 14 Mar 2025 17:38:31 -0400
X-MC-Unique: Q0pkQj-lPNqdUoh8sMEMxQ-1
X-Mimecast-MFC-AGG-ID: Q0pkQj-lPNqdUoh8sMEMxQ_1741988308
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5CFF81955E95;
	Fri, 14 Mar 2025 21:38:28 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.80.88])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CD5E61943582;
	Fri, 14 Mar 2025 21:38:22 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	virtualization@lists.linux.dev
Cc: alexander.atanasov@virtuozzo.com,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev,
	mhocko@kernel.org,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	jgross@suse.com,
	sstabellini@kernel.org,
	oleksandr_tyshchenko@epam.com,
	akpm@linux-foundation.org,
	mst@redhat.com,
	david@redhat.com,
	yosry.ahmed@linux.dev,
	hannes@cmpxchg.org,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	kanchana.p.sridhar@intel.com,
	llong@redhat.com,
	shakeel.butt@linux.dev
Subject: [PATCH v2 3/4] hv_balloon: update the NR_BALLOON_PAGES state
Date: Fri, 14 Mar 2025 15:37:56 -0600
Message-ID: <20250314213757.244258-4-npache@redhat.com>
In-Reply-To: <20250314213757.244258-1-npache@redhat.com>
References: <20250314213757.244258-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Update the NR_BALLOON_PAGES counter when pages are added to or
removed from the Hyper-V balloon.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 drivers/hv/hv_balloon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index fec2f18679e3..2b4080e51f97 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -1192,6 +1192,7 @@ static void free_balloon_pages(struct hv_dynmem_device *dm,
 		__ClearPageOffline(pg);
 		__free_page(pg);
 		dm->num_pages_ballooned--;
+		mod_node_page_state(page_pgdat(pg), NR_BALLOON_PAGES, -1);
 		adjust_managed_page_count(pg, 1);
 	}
 }
@@ -1221,6 +1222,7 @@ static unsigned int alloc_balloon_pages(struct hv_dynmem_device *dm,
 			return i * alloc_unit;
 
 		dm->num_pages_ballooned += alloc_unit;
+		mod_node_page_state(page_pgdat(pg), NR_BALLOON_PAGES, alloc_unit);
 
 		/*
 		 * If we allocatted 2M pages; split them so we
-- 
2.48.1

