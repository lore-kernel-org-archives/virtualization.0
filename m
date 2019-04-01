From: Mukesh Ojha <mojha@codeaurora.org>
Subject: Re: [PATCH 1/3] drm/virtio: add missing drm_atomic_helper_shutdown()
	call.
Date: Mon, 1 Apr 2019 20:38:23 +0530
Message-ID: <1431a9d8-7a60-079d-57ba-33eea6d30ce2__9301.50112123869$1555717678$gmane$org@codeaurora.org>
References: <20190401140306.28063-1-kraxel@redhat.com>
	<20190401140306.28063-2-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190401140306.28063-2-kraxel@redhat.com>
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
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Please atleast mention here why it is required?

-Mukesh

On 4/1/2019 7:33 PM, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   drivers/gpu/drm/virtio/virtgpu_display.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
> index 653ec7d0bf4d..86843a4d6102 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_display.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_display.c
> @@ -385,5 +385,6 @@ void virtio_gpu_modeset_fini(struct virtio_gpu_device *vgdev)
>   
>   	for (i = 0 ; i < vgdev->num_scanouts; ++i)
>   		kfree(vgdev->outputs[i].edid);
> +	drm_atomic_helper_shutdown(vgdev->ddev);
>   	drm_mode_config_cleanup(vgdev->ddev);
>   }
