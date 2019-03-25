From: Mukesh Ojha <mojha@codeaurora.org>
Subject: Re: [PATCH v2 -next] drm/virtio: remove set but not used variable
	'vgdev'
Date: Mon, 25 Mar 2019 17:05:26 +0530
Message-ID: <e15b1f58-080f-c5b8-d210-c6a819f829d3__26660.3181998775$1555717650$gmane$org@codeaurora.org>
References: <20190320020308.12745-1-yuehaibing@huawei.com>
	<20190325092631.152060-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2124774030552844822=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190325092631.152060-1-yuehaibing@huawei.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: YueHaibing <yuehaibing@huawei.com>, David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--===============2124774030552844822==
Content-Type: multipart/alternative;
 boundary="------------D4021CC7E0B3F614E6F51445"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------D4021CC7E0B3F614E6F51445
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/25/2019 2:56 PM, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/gpu/drm/virtio/virtgpu_ttm.c: In function 'virtio_gpu_init_mem_type':
> drivers/gpu/drm/virtio/virtgpu_ttm.c:117:28: warning:
>   variable 'vgdev' set but not used [-Wunused-but-set-variable]
>
> drivers/gpu/drm/virtio/virtgpu_ttm.c: In function 'virtio_gpu_bo_swap_notify':
> drivers/gpu/drm/virtio/virtgpu_ttm.c:300:28: warning:
>   variable 'vgdev' set but not used [-Wunused-but-set-variable]
>
> It is never used since introduction in dc5698e80cf7 ("Add virtio gpu driver.")
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org 
<mailto:mojha@codeaurora.org>>

Thanks.
Mukesh

> ---
> v2: fix patch prefix
> ---
>   drivers/gpu/drm/virtio/virtgpu_ttm.c | 6 ------
>   1 file changed, 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ttm.c b/drivers/gpu/drm/virtio/virtgpu_ttm.c
> index d6225ba20b30..eb007c2569d8 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ttm.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ttm.c
> @@ -114,10 +114,6 @@ static const struct ttm_mem_type_manager_func virtio_gpu_bo_manager_func = {
>   static int virtio_gpu_init_mem_type(struct ttm_bo_device *bdev, uint32_t type,
>   				    struct ttm_mem_type_manager *man)
>   {
> -	struct virtio_gpu_device *vgdev;
> -
> -	vgdev = virtio_gpu_get_vgdev(bdev);
> -
>   	switch (type) {
>   	case TTM_PL_SYSTEM:
>   		/* System memory */
> @@ -297,10 +293,8 @@ static void virtio_gpu_bo_move_notify(struct ttm_buffer_object *tbo,
>   static void virtio_gpu_bo_swap_notify(struct ttm_buffer_object *tbo)
>   {
>   	struct virtio_gpu_object *bo;
> -	struct virtio_gpu_device *vgdev;
>   
>   	bo = container_of(tbo, struct virtio_gpu_object, tbo);
> -	vgdev = (struct virtio_gpu_device *)bo->gem_base.dev->dev_private;
>   
>   	if (bo->pages)
>   		virtio_gpu_object_free_sg_table(bo);
>
>
>

--------------D4021CC7E0B3F614E6F51445
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 3/25/2019 2:56 PM, YueHaibing wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20190325092631.152060-1-yuehaibing@huawei.com">
      <pre class="moz-quote-pre" wrap="">Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/virtio/virtgpu_ttm.c: In function 'virtio_gpu_init_mem_type':
drivers/gpu/drm/virtio/virtgpu_ttm.c:117:28: warning:
 variable 'vgdev' set but not used [-Wunused-but-set-variable]

drivers/gpu/drm/virtio/virtgpu_ttm.c: In function 'virtio_gpu_bo_swap_notify':
drivers/gpu/drm/virtio/virtgpu_ttm.c:300:28: warning:
 variable 'vgdev' set but not used [-Wunused-but-set-variable]

It is never used since introduction in dc5698e80cf7 ("Add virtio gpu driver.")

Signed-off-by: YueHaibing <a class="moz-txt-link-rfc2396E" href="mailto:yuehaibing@huawei.com">&lt;yuehaibing@huawei.com&gt;</a></pre>
    </blockquote>
    <p><br>
    </p>
    <p>
      Reviewed-by: Mukesh Ojha &lt;<a href="mailto:mojha@codeaurora.org"
        title="mojha@codeaurora.org" class="mailto">mojha@codeaurora.org</a>&gt;
    </p>
    <p>
      Thanks.<br>
      Mukesh
    </p>
    <blockquote type="cite"
      cite="mid:20190325092631.152060-1-yuehaibing@huawei.com">
      <pre class="moz-quote-pre" wrap="">
---
v2: fix patch prefix
---
 drivers/gpu/drm/virtio/virtgpu_ttm.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ttm.c b/drivers/gpu/drm/virtio/virtgpu_ttm.c
index d6225ba20b30..eb007c2569d8 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ttm.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ttm.c
@@ -114,10 +114,6 @@ static const struct ttm_mem_type_manager_func virtio_gpu_bo_manager_func = {
 static int virtio_gpu_init_mem_type(struct ttm_bo_device *bdev, uint32_t type,
 				    struct ttm_mem_type_manager *man)
 {
-	struct virtio_gpu_device *vgdev;
-
-	vgdev = virtio_gpu_get_vgdev(bdev);
-
 	switch (type) {
 	case TTM_PL_SYSTEM:
 		/* System memory */
@@ -297,10 +293,8 @@ static void virtio_gpu_bo_move_notify(struct ttm_buffer_object *tbo,
 static void virtio_gpu_bo_swap_notify(struct ttm_buffer_object *tbo)
 {
 	struct virtio_gpu_object *bo;
-	struct virtio_gpu_device *vgdev;
 
 	bo = container_of(tbo, struct virtio_gpu_object, tbo);
-	vgdev = (struct virtio_gpu_device *)bo-&gt;gem_base.dev-&gt;dev_private;
 
 	if (bo-&gt;pages)
 		virtio_gpu_object_free_sg_table(bo);



</pre>
    </blockquote>
  </body>
</html>

--------------D4021CC7E0B3F614E6F51445--

--===============2124774030552844822==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2124774030552844822==--
