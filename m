From: Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH] drm/virtio: track virtual output state
Date: Tue, 4 Sep 2018 09:42:54 +1000
Message-ID: <CAPM=9txw2=wtTArOY-EHGsq28xfnWse070fRzLT7JR4oyxZN8g__15475.7042452276$1536018099$gmane$org@mail.gmail.com>
References: <20180813152855.12863-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180813152855.12863-1-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Dave Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE,
	NET..." <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 14 Aug 2018 at 01:30, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Track whenever an virtual output (crtc) is enabled or disabled.
>
> On atomic updates check for both framebuffer being present and crtc
> being enabled to figure whenever the output is active or not.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Dave Airlie <airlied@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h     | 1 +
>  drivers/gpu/drm/virtio/virtgpu_display.c | 4 ++++
>  drivers/gpu/drm/virtio/virtgpu_plane.c   | 2 +-
>  3 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index 65605e207b..d46f10e656 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -114,6 +114,7 @@ struct virtio_gpu_output {
>         struct virtio_gpu_update_cursor cursor;
>         int cur_x;
>         int cur_y;
> +       bool enabled;
>  };
>  #define drm_crtc_to_virtio_gpu_output(x) \
>         container_of(x, struct virtio_gpu_output, crtc)
> diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
> index 25503b9335..9f1e0a669d 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_display.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_display.c
> @@ -109,6 +109,9 @@ static void virtio_gpu_crtc_mode_set_nofb(struct drm_crtc *crtc)
>  static void virtio_gpu_crtc_atomic_enable(struct drm_crtc *crtc,
>                                           struct drm_crtc_state *old_state)
>  {
> +       struct virtio_gpu_output *output = drm_crtc_to_virtio_gpu_output(crtc);
> +
> +       output->enabled = true;
>  }
>
>  static void virtio_gpu_crtc_atomic_disable(struct drm_crtc *crtc,
> @@ -119,6 +122,7 @@ static void virtio_gpu_crtc_atomic_disable(struct drm_crtc *crtc,
>         struct virtio_gpu_output *output = drm_crtc_to_virtio_gpu_output(crtc);
>
>         virtio_gpu_cmd_set_scanout(vgdev, output->index, 0, 0, 0, 0, 0);
> +       output->enabled = false;
>  }
>
>  static int virtio_gpu_crtc_atomic_check(struct drm_crtc *crtc,
> diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
> index dc5b5b2b7a..88f2fb8c61 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
> @@ -152,7 +152,7 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
>         if (WARN_ON(!output))
>                 return;
>
> -       if (plane->state->fb) {
> +       if (plane->state->fb && output->enabled) {
>                 vgfb = to_virtio_gpu_framebuffer(plane->state->fb);
>                 bo = gem_to_virtio_gpu_obj(vgfb->base.obj[0]);
>                 handle = bo->hw_res_handle;
> --
> 2.9.3
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
