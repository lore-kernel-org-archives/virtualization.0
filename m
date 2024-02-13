Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CAC56B6A
	for <virtualization@lists.linux.dev>; Tue, 13 Feb 2024 13:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707832476; cv=none; b=YZqOMGqAzTGWA2Watf10amG3cAdPuOlU5mp0GfttN5oi5UX/oDheHmu+u4x4qKWn+b8lxngXRY4ci8qDNkF1f+tMosCoKnzGDtpx6XqL1eVl6g5RvKRiyA/bRhdDKshYZJwJAygAjMQFJ/BbPyeRUrbvGuQQVKnZLgR5F1dCtcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707832476; c=relaxed/simple;
	bh=CdzJ7tlgmV7vHQNreg/mcFgOnHtMI4tMFptux7nMTkw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UAEBeKn8kJCRylHDSwITwr5o05zJpUXzERHWSqsy0f4fsxafUt+cy4CYjkFPEItst2StenNVbqPB2TZubCZ6N6ZdhcdcGWklCKR6D3/Ur+DEmYl7/aj0U0ibpljtas1s+PYGd6xcdXNod9dnOlNJEWn20fDiGlgrxTaNlmowqnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g/4BvcJb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g/4BvcJb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707832473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qXAJ3RuPet5I6Ig8N3etuSJO6+znX1aFjcW0irspUQU=;
	b=g/4BvcJbQNknWFTthjM4RoiJyEcZbLnOnrgdLVSpYArFZwwoYYs0sln/hENFOh76CwFisB
	IcnOHo5nxY/AtNzU7dMrXaki/skNGE4bj/7w22iz6+iohElwL3VZLgyR3oOOFgjJbKJx73
	K7dvIJbGCARU4hWtZbWY/qQOuBii1n8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-E2zSnLL3O3GkQqq8v4X6Qw-1; Tue, 13 Feb 2024 08:54:29 -0500
X-MC-Unique: E2zSnLL3O3GkQqq8v4X6Qw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 003F11064BFB;
	Tue, 13 Feb 2024 13:54:29 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.250])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 97C46112132A;
	Tue, 13 Feb 2024 13:54:26 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux.dev,
	David Hildenbrand <david@redhat.com>,
	stable@kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v1] virtio: reenable config if freezing device failed
Date: Tue, 13 Feb 2024 14:54:25 +0100
Message-ID: <20240213135425.795001-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Currently, we don't reenable the config if freezing the device failed.

For example, virtio-mem currently doesn't support suspend+resume, and
trying to freeze the device will always fail. Afterwards, the device
will no longer respond to resize requests, because it won't get notified
about config changes.

Let's fix this by re-enabling the config if freezing fails.

Fixes: 22b7050a024d ("virtio: defer config changed notifications")
Cc: <stable@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index f4080692b351..f513ee21b1c1 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -510,8 +510,10 @@ int virtio_device_freeze(struct virtio_device *dev)
 
 	if (drv && drv->freeze) {
 		ret = drv->freeze(dev);
-		if (ret)
+		if (ret) {
+			virtio_config_enable(dev);
 			return ret;
+		}
 	}
 
 	if (dev->config->destroy_avq)

base-commit: c664e16bb1ba1c8cf1d7ecf3df5fd83bbb8ac15a
-- 
2.43.0

