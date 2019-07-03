From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 1/5] drm/client: Support unmapping of DRM client buffers
Date: Wed,  3 Jul 2019 10:32:58 +0200
Message-ID: <20190703083302.2609-2-tzimmermann__22692.9983285785$1562143446$gmane$org@suse.de>
References: <20190703083302.2609-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190703083302.2609-1-tzimmermann@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: airlied@redhat.com, daniel@ffwll.ch, kraxel@redhat.com, maarten.lankhorst@linux.intel.com, maxime.ripard@bootlin.com, sean@poorly.run, noralf@tronnes.org, sam@ravnborg.org, yc_chen@aspeedtech.com
Cc: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

DRM clients, such as the fbdev emulation, have their buffer objects
mapped by default. Mapping a buffer implicitly prevents its relocation.
Hence, the buffer may permanently consume video memory while it's
allocated. This is a problem for drivers of low-memory devices, such as
ast, mgag200 or older framebuffer hardware, which will then not have
enough memory to display other content (e.g., X11).

This patch introduces drm_client_buffer_vmap() and _vunmap(). Internal
DRM clients can use these functions to unmap and remap buffer objects
as needed.

There's no reference counting for vmap operations. Callers are expected
to either keep buffers mapped (as it is now), or call vmap and vunmap
in pairs around code that accesses the mapped memory.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_client.c | 71 +++++++++++++++++++++++++++++++-----
 include/drm/drm_client.h     |  3 ++
 2 files changed, 64 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/drm_client.c b/drivers/gpu/drm/drm_client.c
index 410572f14257..d04660c4470a 100644
--- a/drivers/gpu/drm/drm_client.c
+++ b/drivers/gpu/drm/drm_client.c
@@ -235,7 +235,8 @@ static void drm_client_buffer_delete(struct drm_client_buffer *buffer)
 {
 	struct drm_device *dev = buffer->client->dev;
 
-	drm_gem_vunmap(buffer->gem, buffer->vaddr);
+	if (buffer->vaddr)
+		drm_gem_vunmap(buffer->gem, buffer->vaddr);
 
 	if (buffer->gem)
 		drm_gem_object_put_unlocked(buffer->gem);
@@ -281,6 +282,43 @@ drm_client_buffer_create(struct drm_client_dev *client, u32 width, u32 height, u
 
 	buffer->gem = obj;
 
+	vaddr = drm_client_buffer_vmap(buffer);
+	if (IS_ERR(vaddr)) {
+		ret = PTR_ERR(vaddr);
+		goto err_delete;
+	}
+
+	return buffer;
+
+err_delete:
+	drm_client_buffer_delete(buffer);
+
+	return ERR_PTR(ret);
+}
+
+/**
+ * drm_client_buffer_vmap - Map DRM client buffer into address space
+ * @buffer: DRM client buffer
+ *
+ * This function maps a client buffer into kernel address space. If the
+ * buffer is already mapped, it returns the mapping's address.
+ *
+ * Client buffer mappings are not ref'counted. Each call to
+ * drm_client_buffer_vmap() should be followed by a call to
+ * drm_client_buffer_vunmap(); or the client buffer should be mapped
+ * throughout its lifetime. The latter is the default.
+ *
+ * Returns:
+ *	The mapped memory's address
+ */
+void *
+drm_client_buffer_vmap(struct drm_client_buffer *buffer)
+{
+	void *vaddr;
+
+	if (buffer->vaddr)
+		return buffer->vaddr;
+
 	/*
 	 * FIXME: The dependency on GEM here isn't required, we could
 	 * convert the driver handle to a dma-buf instead and use the
@@ -289,21 +327,34 @@ drm_client_buffer_create(struct drm_client_dev *client, u32 width, u32 height, u
 	 * fd_install step out of the driver backend hooks, to make that
 	 * final step optional for internal users.
 	 */
-	vaddr = drm_gem_vmap(obj);
-	if (IS_ERR(vaddr)) {
-		ret = PTR_ERR(vaddr);
-		goto err_delete;
-	}
+	vaddr = drm_gem_vmap(buffer->gem);
+	if (IS_ERR(vaddr))
+		return vaddr;
 
 	buffer->vaddr = vaddr;
 
-	return buffer;
+	return vaddr;
+}
+EXPORT_SYMBOL(drm_client_buffer_vmap);
 
-err_delete:
-	drm_client_buffer_delete(buffer);
+/**
+ * drm_client_buffer_vunmap - Unmap DRM client buffer
+ * @buffer: DRM client buffer
+ *
+ * This function removes a client buffer's memory mmapping. This
+ * function is only required by clients that manage their buffers
+ * by themselves. By default, DRM client buffers are mapped throughout
+ * their entire lifetime.
+ */
+void drm_client_buffer_vunmap(struct drm_client_buffer *buffer)
+{
+	if (!buffer->vaddr)
+		return;
 
-	return ERR_PTR(ret);
+	drm_gem_vunmap(buffer->gem, buffer->vaddr);
+	buffer->vaddr = NULL;
 }
+EXPORT_SYMBOL(drm_client_buffer_vunmap);
 
 static void drm_client_buffer_rmfb(struct drm_client_buffer *buffer)
 {
diff --git a/include/drm/drm_client.h b/include/drm/drm_client.h
index 72d51d1e9dd9..e1db1d9da0bf 100644
--- a/include/drm/drm_client.h
+++ b/include/drm/drm_client.h
@@ -149,6 +149,9 @@ struct drm_client_buffer {
 struct drm_client_buffer *
 drm_client_framebuffer_create(struct drm_client_dev *client, u32 width, u32 height, u32 format);
 void drm_client_framebuffer_delete(struct drm_client_buffer *buffer);
+void *
+drm_client_buffer_vmap(struct drm_client_buffer *buffer);
+void drm_client_buffer_vunmap(struct drm_client_buffer *buffer);
 
 int drm_client_modeset_create(struct drm_client_dev *client);
 void drm_client_modeset_free(struct drm_client_dev *client);
-- 
2.21.0
