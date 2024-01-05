Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6341938F83
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jan 2024 18:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PLJ35Kr9"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EAF12436C1
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jan 2024 18:47:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EAF12436C1
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=PLJ35Kr9
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ASmRaSoc6vTn
	for <virtualization@lists.linux-foundation.org>;
	Fri,  5 Jan 2024 18:47:07 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [IPv6:2a00:1098:ed:100::25])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E27E0436A4
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jan 2024 18:47:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E27E0436A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704480425;
	bh=n3hnUXa5rluasw0Ba4uFJ6xIbIY38qEptryUL9/Mlug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PLJ35Kr9M6RCca7l9xI++W2rK719IWUm+1nZ4aTWDZJEj67CVmMfoN6D6U6Gzq5Ld
	 jL40ZlU06lMn4SdhmaKxSz2EaQ0jcvzq4zKKUTzi2kzu7jJQ8WP7Z5ZGmontcK+OLJ
	 h/gzZRlOmajo6zE50Yrs9l3t+I3i1CVk/onosyKEv8UYcyxyvZYmC61QExPsK7HhXi
	 opsaVm1g1AzUU4OQV/hlz3H+2XcjdB5WfU0iubq7Xz7hXNmgW48AQileJT5n+NXAyg
	 qEPvVibHijLxHJwWa+IJlwdJtwGaull+JMULndzEE5HUQ2ZZOo4iYsEb7I84cnQIfh
	 lrg1NFN8azc3g==
Received: from workpc.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0A6B73782056;
	Fri,  5 Jan 2024 18:47:03 +0000 (UTC)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: David Airlie <airlied@gmail.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Qiang Yu <yuq825@gmail.com>,
	Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Emma Anholt <emma@anholt.net>,
	Melissa Wen <mwen@igalia.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v19 13/30] drm/shmem-helper: Make drm_gem_shmem_get_pages() public
Date: Fri,  5 Jan 2024 21:46:07 +0300
Message-ID: <20240105184624.508603-14-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We're going to move away from having implicit get_pages() done by
get_pages_sgt() to simplify refcnt handling. Drivers will manage
get/put_pages() by themselves. Expose the drm_gem_shmem_get_pages()
in a public drm-shmem API.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 10 +++++++++-
 include/drm/drm_gem_shmem_helper.h     |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 799a3c5015ad..dc416a4bce1b 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -228,7 +228,14 @@ void drm_gem_shmem_put_pages_locked(struct drm_gem_shmem_object *shmem)
 }
 EXPORT_SYMBOL_GPL(drm_gem_shmem_put_pages_locked);
 
-static int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem)
+/*
+ * drm_gem_shmem_get_pages - Increase use count on the backing pages for a shmem GEM object
+ * @shmem: shmem GEM object
+ *
+ * This function Increases the use count and allocates the backing pages if
+ * use-count equals to zero.
+ */
+int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem)
 {
 	int ret;
 
@@ -241,6 +248,7 @@ static int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(drm_gem_shmem_get_pages);
 
 static int drm_gem_shmem_pin_locked(struct drm_gem_shmem_object *shmem)
 {
diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index 18020f653d7e..6dedc0739fbc 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -110,6 +110,7 @@ struct drm_gem_shmem_object {
 struct drm_gem_shmem_object *drm_gem_shmem_create(struct drm_device *dev, size_t size);
 void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem);
 
+int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem);
 void drm_gem_shmem_put_pages_locked(struct drm_gem_shmem_object *shmem);
 int drm_gem_shmem_pin(struct drm_gem_shmem_object *shmem);
 void drm_gem_shmem_unpin(struct drm_gem_shmem_object *shmem);
-- 
2.43.0

