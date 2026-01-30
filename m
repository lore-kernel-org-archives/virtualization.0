Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899C431355C
	for <virtualization@lists.linux.dev>; Fri, 30 Jan 2026 05:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769749687; cv=none; b=JoCFkEY8UeCPwJ1gBVlgyCNC4A9VOleYeciluuanNqe2FQTtz8yIS7RAGT+B4JlF6OSSMpFTWhahlgL0g9E2jrtkWwLzhB0N/SA1ZaXyW6XSu5cBh3DLY5Hcm7Y6Et/VrYqsbbbMh3UkA7FZMhqkPEvjfFL6PyBn2Z/6LhQqh0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769749687; c=relaxed/simple;
	bh=Jj+LXlJqQOlKkxRPXbwCJJTijkMOPwxHoRAkNl14xYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TxrrLRKUet6FZfCCvXsQj9IH/auAR873Onw7OI9R2oGXX+17JZMqcurdy0XUNKaPvpW79PaquGTalJ9aMDdz9sXKyQw5vLJ/Fcea7DkGj+jmVIP1VoCnGNpuc5dAPw6Q1y8xngtSrtsj+Qin3ZCl9DtZlgUeLRF1xCJwU0uc6QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HcL62A+j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HcL62A+j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769749684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IMJwRxEHfAIl5OOD17eYG7N79bWeNFHiCLhK3OOmj9I=;
	b=HcL62A+jpj7zaDEgqXad/vieuLz+fg9mSjOoZL9ekbGp5FCRX//OtLuQ4Yrpd7qzhdcrmC
	dSPOsmEt2NYcN93BRh9LhPfdpVdeIt5dffMvJpf9S9CLJaHlYUlZVtc5cezTuCBWkfQB/c
	SheAnoNA4hF1siA9viWIBQjtEoPVFoE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318-kRpMC9QlMMCWjgSra_knDg-1; Fri,
 30 Jan 2026 00:08:01 -0500
X-MC-Unique: kRpMC9QlMMCWjgSra_knDg-1
X-Mimecast-MFC-AGG-ID: kRpMC9QlMMCWjgSra_knDg_1769749680
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94B391954B14;
	Fri, 30 Jan 2026 05:07:59 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.120.11])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5E7C31956056;
	Fri, 30 Jan 2026 05:07:53 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	xieyongji@bytedance.com,
	stable@vger.kernel.org
Subject: [PATCH] VDUSE: avoid leaking information to userspace
Date: Fri, 30 Jan 2026 13:07:50 +0800
Message-ID: <20260130050750.4050-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The bounceing is not necessarily page aligned, so current VDUSE can
leak kernel information through mapping bounce pages to
userspace. Allocate bounce pages with __GFP_ZERO to avoid leaking
information to userspace.

Fixes: 8c773d53fb7b ("vduse: Implement an MMU-based software IOTLB")
Cc: stable@vger.kernel.org
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa_user/iova_domain.c | 2 +-
 drivers/vdpa/vdpa_user/vduse_dev.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
index 0a9f668467a8..ec743bed361c 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -124,7 +124,7 @@ static int vduse_domain_map_bounce_page(struct vduse_iova_domain *domain,
 		if (!map->bounce_page) {
 			head_map = &domain->bounce_maps[(iova & PAGE_MASK) >> BOUNCE_MAP_SHIFT];
 			if (!head_map->bounce_page) {
-				tmp_page = alloc_page(GFP_ATOMIC);
+				tmp_page = alloc_page(GFP_ATOMIC | __GFP_ZERO);
 				if (!tmp_page)
 					return -ENOMEM;
 				if (cmpxchg(&head_map->bounce_page, NULL, tmp_page))
diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 73d1d517dc6c..57a40a821c65 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -976,7 +976,7 @@ static void *vduse_dev_alloc_coherent(union virtio_map token, size_t size,
 	if (!token.group)
 		return NULL;
 
-	addr = alloc_pages_exact(size, flag);
+	addr = alloc_pages_exact(size, flag | __GFP_ZERO);
 	if (!addr)
 		return NULL;
 
-- 
2.34.1

