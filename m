From: Chia-I Wu <olvaffe@gmail.com>
Subject: Re: [PATCH 1/3] drm/virtio: skip set_scanout if framebuffer didn't
 change
Date: Wed, 11 Dec 2019 10:27:39 -0800
Message-ID: <CAPaKu7TyMPt4Wpq9FoWyTJSppURrz9XuFqD4fmFg6aX_9p+jtw__3553.67503814108$1576088884$gmane$org@mail.gmail.com>
References: <20191211084216.25405-1-kraxel@redhat.com>
 <20191211084216.25405-2-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191211084216.25405-2-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: David Airlie <airlied@linux.ie>, Gurchetan Singh <gurchetansingh@chromium.org>, open list <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Dec 11, 2019 at 12:42 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_plane.c | 31 ++++++++++++++------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
> index bc4bc4475a8c..a0f91658c2bc 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
> @@ -151,20 +151,23 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
>         if (bo->dumb)
>                 virtio_gpu_update_dumb_bo(vgdev, bo, plane->state);
>
> -       DRM_DEBUG("handle 0x%x, crtc %dx%d+%d+%d, src %dx%d+%d+%d\n",
> -                 bo->hw_res_handle,
> -                 plane->state->crtc_w, plane->state->crtc_h,
> -                 plane->state->crtc_x, plane->state->crtc_y,
> -                 plane->state->src_w >> 16,
> -                 plane->state->src_h >> 16,
> -                 plane->state->src_x >> 16,
> -                 plane->state->src_y >> 16);
> -       virtio_gpu_cmd_set_scanout(vgdev, output->index,
> -                                  bo->hw_res_handle,
> -                                  plane->state->src_w >> 16,
> -                                  plane->state->src_h >> 16,
> -                                  plane->state->src_x >> 16,
> -                                  plane->state->src_y >> 16);
> +       if (plane->state->fb != old_state->fb) {
Should we check src_{w,h,x,y} as well?
> +               DRM_DEBUG("handle 0x%x, crtc %dx%d+%d+%d, src %dx%d+%d+%d\n",
> +                         bo->hw_res_handle,
> +                         plane->state->crtc_w, plane->state->crtc_h,
> +                         plane->state->crtc_x, plane->state->crtc_y,
> +                         plane->state->src_w >> 16,
> +                         plane->state->src_h >> 16,
> +                         plane->state->src_x >> 16,
> +                         plane->state->src_y >> 16);
> +               virtio_gpu_cmd_set_scanout(vgdev, output->index,
> +                                          bo->hw_res_handle,
> +                                          plane->state->src_w >> 16,
> +                                          plane->state->src_h >> 16,
> +                                          plane->state->src_x >> 16,
> +                                          plane->state->src_y >> 16);
> +       }
> +
>         virtio_gpu_cmd_resource_flush(vgdev, bo->hw_res_handle,
>                                       plane->state->src_x >> 16,
>                                       plane->state->src_y >> 16,
> --
> 2.18.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
