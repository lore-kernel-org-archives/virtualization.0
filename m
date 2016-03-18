From: Joe Perches <joe@perches.com>
Subject: [PATCH] gpu/drm: Use u64_to_user_pointer
Date: Fri, 18 Mar 2016 10:20:55 -0700
Message-ID: <b70b7949e8344abe13d85d6e8e5a8e11bb9c5f02.1458321299.git.joe__20684.006464626$1458322618$gmane$org@perches.com>
References: <1458315564.9556.56.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1458315564.9556.56.camel@perches.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gustavo Padovan <gustavo@padovan.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Terje=20Bergstr=C3=B6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Rob Clark <robdclark@gmail.com>, linux-tegra@vger.kernel.org, Daniel Vetter <daniel.vetter@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Use the newly added u64_to_user_pointer a bit more frequently.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/gpu/drm/armada/armada_gem.c    |  2 +-
 drivers/gpu/drm/nouveau/nouveau_gem.c  |  7 ++++---
 drivers/gpu/drm/tegra/drm.c            | 15 ++++++++-------
 drivers/gpu/drm/vc4/vc4_bo.c           |  4 ++--
 drivers/gpu/drm/vc4/vc4_gem.c          | 10 +++++-----
 drivers/gpu/drm/virtio/virtgpu_ioctl.c |  5 ++---
 6 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_gem.c b/drivers/gpu/drm/armada/armada_gem.c
index 6e731db..7629dd2 100644
--- a/drivers/gpu/drm/armada/armada_gem.c
+++ b/drivers/gpu/drm/armada/armada_gem.c
@@ -382,7 +382,7 @@ int armada_gem_pwrite_ioctl(struct drm_device *dev, void *data,
 	if (args->size == 0)
 		return 0;
 
-	ptr = (char __user *)(uintptr_t)args->ptr;
+	ptr = u64_to_user_ptr(args->ptr);
 
 	if (!access_ok(VERIFY_READ, ptr, args->size))
 		return -EFAULT;
diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
index a0865c4..1a6604c9 100644
--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -467,11 +467,12 @@ validate_list(struct nouveau_channel *chan, struct nouveau_cli *cli,
 	      uint64_t user_pbbo_ptr)
 {
 	struct nouveau_drm *drm = chan->drm;
-	struct drm_nouveau_gem_pushbuf_bo __user *upbbo =
-				(void __force __user *)(uintptr_t)user_pbbo_ptr;
+	struct drm_nouveau_gem_pushbuf_bo __user *upbbo;
 	struct nouveau_bo *nvbo;
 	int ret, relocs = 0;
 
+	upbbo = u64_to_user_ptr(user_pbbo_ptr);
+
 	list_for_each_entry(nvbo, list, entry) {
 		struct drm_nouveau_gem_pushbuf_bo *b = &pbbo[nvbo->pbbo_index];
 
@@ -565,7 +566,7 @@ static inline void *
 u_memcpya(uint64_t user, unsigned nmemb, unsigned size)
 {
 	void *mem;
-	void __user *userptr = (void __force __user *)(uintptr_t)user;
+	void __user *userptr = u64_to_user_ptr(user);
 
 	size *= nmemb;
 
diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index 8e6b18c..b20c87d 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -329,12 +329,9 @@ int tegra_drm_submit(struct tegra_drm_context *context,
 	unsigned int num_cmdbufs = args->num_cmdbufs;
 	unsigned int num_relocs = args->num_relocs;
 	unsigned int num_waitchks = args->num_waitchks;
-	struct drm_tegra_cmdbuf __user *cmdbufs =
-		(void __user *)(uintptr_t)args->cmdbufs;
-	struct drm_tegra_reloc __user *relocs =
-		(void __user *)(uintptr_t)args->relocs;
-	struct drm_tegra_waitchk __user *waitchks =
-		(void __user *)(uintptr_t)args->waitchks;
+	struct drm_tegra_cmdbuf __user *cmdbufs;
+	struct drm_tegra_reloc __user *relocs;
+	struct drm_tegra_waitchk __user *waitchks;
 	struct drm_tegra_syncpt syncpt;
 	struct host1x_job *job;
 	int err;
@@ -354,6 +351,10 @@ int tegra_drm_submit(struct tegra_drm_context *context,
 	job->class = context->client->base.class;
 	job->serialize = true;
 
+	cmdbufs = u64_to_user_ptr(args->cmdbufs);
+	relocs = u64_to_user_ptr(args->relocs);
+	waitchks = u64_to_user_ptr(args->waitchks);
+
 	while (num_cmdbufs) {
 		struct drm_tegra_cmdbuf cmdbuf;
 		struct host1x_bo *bo;
@@ -389,7 +390,7 @@ int tegra_drm_submit(struct tegra_drm_context *context,
 		goto fail;
 	}
 
-	if (copy_from_user(&syncpt, (void __user *)(uintptr_t)args->syncpts,
+	if (copy_from_user(&syncpt, u64_to_user_ptr(args->syncpts),
 			   sizeof(syncpt))) {
 		err = -EFAULT;
 		goto fail;
diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
index 9807bc9..fe3a4aa 100644
--- a/drivers/gpu/drm/vc4/vc4_bo.c
+++ b/drivers/gpu/drm/vc4/vc4_bo.c
@@ -499,8 +499,8 @@ vc4_create_shader_bo_ioctl(struct drm_device *dev, void *data,
 		return PTR_ERR(bo);
 
 	if (copy_from_user(bo->base.vaddr,
-			     (void __user *)(uintptr_t)args->data,
-			     args->size)) {
+			   u64_to_user_ptr(args->data),
+			   args->size)) {
 		ret = -EFAULT;
 		goto fail;
 	}
diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
index 8d4384f..89d7931 100644
--- a/drivers/gpu/drm/vc4/vc4_gem.c
+++ b/drivers/gpu/drm/vc4/vc4_gem.c
@@ -120,7 +120,7 @@ vc4_get_hang_state_ioctl(struct drm_device *dev, void *data,
 		bo_state[i].size = vc4_bo->base.base.size;
 	}
 
-	if (copy_to_user((void __user *)(uintptr_t)get_state->bo,
+	if (copy_to_user(u64_to_user_ptr(get_state->bo),
 			 bo_state,
 			 state->bo_count * sizeof(*bo_state)))
 		ret = -EFAULT;
@@ -550,7 +550,7 @@ vc4_cl_lookup_bos(struct drm_device *dev,
 	}
 
 	ret = copy_from_user(handles,
-			     (void __user *)(uintptr_t)args->bo_handles,
+			     u64_to_user_ptr(args->bo_handles),
 			     exec->bo_count * sizeof(uint32_t));
 	if (ret) {
 		DRM_ERROR("Failed to copy in GEM handles\n");
@@ -624,21 +624,21 @@ vc4_get_bcl(struct drm_device *dev, struct vc4_exec_info *exec)
 	exec->shader_state_size = args->shader_rec_count;
 
 	if (copy_from_user(bin,
-			   (void __user *)(uintptr_t)args->bin_cl,
+			   u64_to_user_ptr(args->bin_cl),
 			   args->bin_cl_size)) {
 		ret = -EFAULT;
 		goto fail;
 	}
 
 	if (copy_from_user(exec->shader_rec_u,
-			   (void __user *)(uintptr_t)args->shader_rec,
+			   u64_to_user_ptr(args->shader_rec),
 			   args->shader_rec_size)) {
 		ret = -EFAULT;
 		goto fail;
 	}
 
 	if (copy_from_user(exec->uniforms_u,
-			   (void __user *)(uintptr_t)args->uniforms,
+			   u64_to_user_ptr(args->uniforms),
 			   args->uniforms_size)) {
 		ret = -EFAULT;
 		goto fail;
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index b4de18e..e602bb6 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -123,7 +123,7 @@ static int virtio_gpu_execbuffer(struct drm_device *dev,
 			return -ENOMEM;
 		}
 
-		user_bo_handles = (void __user *)(uintptr_t)exbuf->bo_handles;
+		user_bo_handles = u64_to_user_ptr(exbuf->bo_handles);
 		if (copy_from_user(bo_handles, user_bo_handles,
 				   exbuf->num_bo_handles * sizeof(uint32_t))) {
 			ret = -EFAULT;
@@ -158,8 +158,7 @@ static int virtio_gpu_execbuffer(struct drm_device *dev,
 		ret = -ENOMEM;
 		goto out_unresv;
 	}
-	if (copy_from_user(buf, (void __user *)(uintptr_t)exbuf->command,
-			   exbuf->size)) {
+	if (copy_from_user(buf, u64_to_user_ptr(exbuf->command), exbuf->size)) {
 		kfree(buf);
 		ret = -EFAULT;
 		goto out_unresv;
-- 
2.6.3.368.gf34be46
