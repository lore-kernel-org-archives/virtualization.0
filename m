Return-Path: <SRS0=LX6v=GL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D81C433E0
	for <virtualization@archiver.kernel.org>; Fri,  8 Jan 2021 09:43:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BDC4233EA
	for <virtualization@archiver.kernel.org>; Fri,  8 Jan 2021 09:43:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BDC4233EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BB039204F9;
	Fri,  8 Jan 2021 09:43:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N9qfQN9O0Xl7; Fri,  8 Jan 2021 09:43:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id F07DA204F6;
	Fri,  8 Jan 2021 09:43:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C29B1C0893;
	Fri,  8 Jan 2021 09:43:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9EDD5C088B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 09:43:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8B9DD870F7
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 09:43:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GmeBlzOWdMV1
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 09:43:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 828E9870BE
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 09:43:45 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 0EF9EAD2B;
 Fri,  8 Jan 2021 09:43:44 +0000 (UTC)
From: Thomas Zimmermann <tzimmermann@suse.de>
To: sumit.semwal@linaro.org, christian.koenig@amd.com, airlied@redhat.com,
 daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 kraxel@redhat.com, hdegoede@redhat.com, sean@poorly.run, eric@anholt.net,
 sam@ravnborg.org
Subject: [PATCH v4 01/13] dma-buf: Add vmap_local and vnumap_local operations
Date: Fri,  8 Jan 2021 10:43:28 +0100
Message-Id: <20210108094340.15290-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210108094340.15290-1-tzimmermann@suse.de>
References: <20210108094340.15290-1-tzimmermann@suse.de>
MIME-Version: 1.0
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, linaro-mm-sig@lists.linaro.org,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-media@vger.kernel.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

The existing dma-buf calls dma_buf_vmap() and dma_buf_vunmap() are
allowed to pin the buffer or acquire the buffer's reservation object
lock.

This is a problem for callers that only require a short-term mapping
of the buffer without the pinning, or callers that have special locking
requirements. These may suffer from unnecessary overhead or interfere
with regular pin operations.

The new interfaces dma_buf_vmap_local(), dma_buf_vunmapo_local(), and
their rsp callbacks in struct dma_buf_ops provide an alternative without
pinning or reservation locking. Callers are responsible for these
operations.

v4:
	* update documentation (Daniel)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/dma-buf/dma-buf.c | 81 +++++++++++++++++++++++++++++++++++++++
 include/linux/dma-buf.h   | 34 ++++++++++++++++
 2 files changed, 115 insertions(+)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index b8465243eca2..01f9c74d97fa 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -1295,6 +1295,87 @@ void dma_buf_vunmap(struct dma_buf *dmabuf, struct dma_buf_map *map)
 }
 EXPORT_SYMBOL_GPL(dma_buf_vunmap);
 
+/**
+ * dma_buf_vmap_local - Create virtual mapping for the buffer object into kernel
+ * address space.
+ * @dmabuf:	[in]	buffer to vmap
+ * @map:	[out]	returns the vmap pointer
+ *
+ * Unlike dma_buf_vmap() this is a short term mapping and will not pin
+ * the buffer. The struct dma_resv for the @dmabuf must be locked until
+ * dma_buf_vunmap_local() is called.
+ *
+ * Returns:
+ * 0 on success, or a negative errno code otherwise.
+ */
+int dma_buf_vmap_local(struct dma_buf *dmabuf, struct dma_buf_map *map)
+{
+	struct dma_buf_map ptr;
+	int ret = 0;
+
+	dma_buf_map_clear(map);
+
+	if (WARN_ON(!dmabuf))
+		return -EINVAL;
+
+	dma_resv_assert_held(dmabuf->resv);
+
+	if (!dmabuf->ops->vmap_local)
+		return -EINVAL;
+
+	mutex_lock(&dmabuf->lock);
+	if (dmabuf->vmapping_counter) {
+		dmabuf->vmapping_counter++;
+		BUG_ON(dma_buf_map_is_null(&dmabuf->vmap_ptr));
+		*map = dmabuf->vmap_ptr;
+		goto out_unlock;
+	}
+
+	BUG_ON(dma_buf_map_is_set(&dmabuf->vmap_ptr));
+
+	ret = dmabuf->ops->vmap_local(dmabuf, &ptr);
+	if (WARN_ON_ONCE(ret))
+		goto out_unlock;
+
+	dmabuf->vmap_ptr = ptr;
+	dmabuf->vmapping_counter = 1;
+
+	*map = dmabuf->vmap_ptr;
+
+out_unlock:
+	mutex_unlock(&dmabuf->lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dma_buf_vmap_local);
+
+/**
+ * dma_buf_vunmap_local - Unmap a vmap obtained by dma_buf_vmap_local.
+ * @dmabuf:	[in]	buffer to vunmap
+ * @map:	[in]	vmap pointer to vunmap
+ *
+ * Release a mapping established with dma_buf_vmap_local().
+ */
+void dma_buf_vunmap_local(struct dma_buf *dmabuf, struct dma_buf_map *map)
+{
+	if (WARN_ON(!dmabuf))
+		return;
+
+	dma_resv_assert_held(dmabuf->resv);
+
+	BUG_ON(dma_buf_map_is_null(&dmabuf->vmap_ptr));
+	BUG_ON(dmabuf->vmapping_counter == 0);
+	BUG_ON(!dma_buf_map_is_equal(&dmabuf->vmap_ptr, map));
+
+	mutex_lock(&dmabuf->lock);
+	if (--dmabuf->vmapping_counter == 0) {
+		if (dmabuf->ops->vunmap_local)
+			dmabuf->ops->vunmap_local(dmabuf, map);
+		dma_buf_map_clear(&dmabuf->vmap_ptr);
+	}
+	mutex_unlock(&dmabuf->lock);
+}
+EXPORT_SYMBOL_GPL(dma_buf_vunmap_local);
+
 #ifdef CONFIG_DEBUG_FS
 static int dma_buf_debug_show(struct seq_file *s, void *unused)
 {
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index 628681bf6c99..aeed754b5467 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -264,6 +264,38 @@ struct dma_buf_ops {
 
 	int (*vmap)(struct dma_buf *dmabuf, struct dma_buf_map *map);
 	void (*vunmap)(struct dma_buf *dmabuf, struct dma_buf_map *map);
+
+	/**
+	 * @vmap_local:
+	 *
+	 * Creates a virtual mapping for the buffer into kernel address space.
+	 *
+	 * This callback establishes short-term mappings for situations where
+	 * callers only use the buffer for a bounded amount of time; such as
+	 * updates to the framebuffer or reading back contained information.
+	 * In contrast to the regular @vmap callback, vmap_local does never pin
+	 * the buffer to a specific domain or acquire the buffer's reservation
+	 * lock.
+	 *
+	 * This is called with the &dma_buf.resv object locked. Callers must hold
+	 * the lock until after removing the mapping with @vunmap_local.
+	 *
+	 * This callback is optional.
+	 *
+	 * Returns:
+	 *
+	 * 0 on success or a negative error code on failure.
+	 */
+	int (*vmap_local)(struct dma_buf *dmabuf, struct dma_buf_map *map);
+
+	/**
+	 * @vunmap_local:
+	 *
+	 * Removes a virtual mapping that was established by @vmap_local.
+	 *
+	 * This callback is optional.
+	 */
+	void (*vunmap_local)(struct dma_buf *dmabuf, struct dma_buf_map *map);
 };
 
 /**
@@ -501,4 +533,6 @@ int dma_buf_mmap(struct dma_buf *, struct vm_area_struct *,
 		 unsigned long);
 int dma_buf_vmap(struct dma_buf *dmabuf, struct dma_buf_map *map);
 void dma_buf_vunmap(struct dma_buf *dmabuf, struct dma_buf_map *map);
+int dma_buf_vmap_local(struct dma_buf *dmabuf, struct dma_buf_map *map);
+void dma_buf_vunmap_local(struct dma_buf *dmabuf, struct dma_buf_map *map);
 #endif /* __DMA_BUF_H__ */
-- 
2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
