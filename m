From: Chia-I Wu <olvaffe@gmail.com>
Subject: Re: [PATCH] drm/virtio: Fix warning in
	virtio_gpu_queue_fenced_ctrl_buffer.
Date: Thu, 12 Sep 2019 14:46:28 -0700
Message-ID: <CAPaKu7RcJC-rZiYhqGeLeyu45ML6ymiycmWA+RjOq02u=PsK9Q__22368.8982938015$1568324816$gmane$org@mail.gmail.com>
References: <20190912160048.212495-1-davidriley@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190912160048.212495-1-davidriley@chromium.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Riley <davidriley@chromium.org>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE,
	NET AND BLOCK DRIVERS" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Sep 12, 2019 at 9:00 AM David Riley <davidriley@chromium.org> wrote:
>
> Fix warning introduced with commit e1218b8c0cc1
> ("drm/virtio: Use vmalloc for command buffer allocations.")
> from drm-misc-next.
>
> Signed-off-by: David Riley <davidriley@chromium.org>
Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_vq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index 9f9b782dd332..80176f379ad5 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -358,7 +358,7 @@ static void virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
>                         sgt = vmalloc_to_sgt(vbuf->data_buf, vbuf->data_size,
>                                              &outcnt);
>                         if (!sgt)
> -                               return -ENOMEM;
> +                               return;
>                         vout = sgt->sgl;
>                 } else {
>                         sg_init_one(&sg, vbuf->data_buf, vbuf->data_size);
> --
> 2.23.0.162.g0b9fbb3734-goog
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
