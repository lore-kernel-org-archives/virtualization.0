From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 054/171] drm/virtio: Add memory barriers for
	capset cache.
Date: Thu, 18 Jul 2019 23:54:45 -0400
Message-ID: <20190719035643.14300-54-sashal__10517.9088584677$1563508750$gmane$org@kernel.org>
References: <20190719035643.14300-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190719035643.14300-1-sashal@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: David Riley <davidriley@chromium.org>

[ Upstream commit 9ff3a5c88e1f1ab17a31402b96d45abe14aab9d7 ]

After data is copied to the cache entry, atomic_set is used indicate
that the data is the entry is valid without appropriate memory barriers.
Similarly the read side was missing the corresponding memory barriers.

Signed-off-by: David Riley <davidriley@chromium.org>
Link: http://patchwork.freedesktop.org/patch/msgid/20190610211810.253227-5-davidriley@chromium.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 3 +++
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 949a264985fc..19fbffd0f7a3 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -542,6 +542,9 @@ static int virtio_gpu_get_caps_ioctl(struct drm_device *dev,
 	if (!ret)
 		return -EBUSY;
 
+	/* is_valid check must proceed before copy of the cache entry. */
+	smp_rmb();
+
 	ptr = cache_ent->caps_cache;
 
 copy_exit:
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 5bb0f0a084e9..a7684f9c80db 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -583,6 +583,8 @@ static void virtio_gpu_cmd_capset_cb(struct virtio_gpu_device *vgdev,
 		    cache_ent->id == le32_to_cpu(cmd->capset_id)) {
 			memcpy(cache_ent->caps_cache, resp->capset_data,
 			       cache_ent->size);
+			/* Copy must occur before is_valid is signalled. */
+			smp_wmb();
 			atomic_set(&cache_ent->is_valid, 1);
 			break;
 		}
-- 
2.20.1
