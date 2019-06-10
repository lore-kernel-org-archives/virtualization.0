From: davidriley@chromium.org
Subject: [PATCH v2 3/4] drm/virtio: Fix cache entry creation race.
Date: Mon, 10 Jun 2019 14:18:09 -0700
Message-ID: <20190610211810.253227-4-davidriley__11722.2495538712$1560201543$gmane$org@chromium.org>
References: <20190605234423.11348-1-davidriley@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190605234423.11348-1-davidriley@chromium.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>
List-Id: virtualization@lists.linuxfoundation.org

From: David Riley <davidriley@chromium.org>

virtio_gpu_cmd_get_capset would check for the existence of an entry
under lock.  If it was not found, it would unlock and call
virtio_gpu_cmd_get_capset to create a new entry.  The new entry would
be added it to the list without checking if it was added by another
task during the period where the lock was not held resulting in
duplicate entries.

Compounding this issue, virtio_gpu_cmd_capset_cb would stop iterating
after find the first matching entry.  Multiple callbacks would modify
the first entry, but any subsequent entries and their associated waiters
would eventually timeout since they don't become valid, also wasting
memory along the way.

Signed-off-by: David Riley <davidriley@chromium.org>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index da71568adb9a..dd5ead2541c2 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -684,8 +684,11 @@ int virtio_gpu_cmd_get_capset(struct virtio_gpu_device *vgdev,
 	struct virtio_gpu_vbuffer *vbuf;
 	int max_size;
 	struct virtio_gpu_drv_cap_cache *cache_ent;
+	struct virtio_gpu_drv_cap_cache *search_ent;
 	void *resp_buf;
 
+	*cache_p = NULL;
+
 	if (idx >= vgdev->num_capsets)
 		return -EINVAL;
 
@@ -716,9 +719,26 @@ int virtio_gpu_cmd_get_capset(struct virtio_gpu_device *vgdev,
 	atomic_set(&cache_ent->is_valid, 0);
 	cache_ent->size = max_size;
 	spin_lock(&vgdev->display_info_lock);
-	list_add_tail(&cache_ent->head, &vgdev->cap_cache);
+	/* Search while under lock in case it was added by another task. */
+	list_for_each_entry(search_ent, &vgdev->cap_cache, head) {
+		if (search_ent->id == vgdev->capsets[idx].id &&
+		    search_ent->version == version) {
+			*cache_p = search_ent;
+			break;
+		}
+	}
+	if (!*cache_p)
+		list_add_tail(&cache_ent->head, &vgdev->cap_cache);
 	spin_unlock(&vgdev->display_info_lock);
 
+	if (*cache_p) {
+		/* Entry was found, so free everything that was just created. */
+		kfree(resp_buf);
+		kfree(cache_ent->caps_cache);
+		kfree(cache_ent);
+		return 0;
+	}
+
 	cmd_p = virtio_gpu_alloc_cmd_resp
 		(vgdev, &virtio_gpu_cmd_capset_cb, &vbuf, sizeof(*cmd_p),
 		 sizeof(struct virtio_gpu_resp_capset) + max_size,
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog
