From: lepton <ytht.net@gmail.com>
Subject: Re: [PATCH] drm/virtio: add create_handle support.
Date: Mon, 13 Nov 2017 14:19:29 -0800
Message-ID: <CALqoU4y=w8m5g_vCHTRmiBYg1g8W1xcJ5qih2pj+HQeQ2tNo2Q__38466.3654295311$1511414801$gmane$org@mail.gmail.com>
References: <20171108125659.oyjzylx26zmz7753@phenom.ffwll.local>
	<20171108184209.46211-1-ytht.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171108184209.46211-1-ytht.net@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: airlied@linux.ie, kraxel@redhat.com
Cc: Lepton Wu <ytht.net@gmail.com>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Ping.

On Wed, Nov 8, 2017 at 10:42 AM, Lepton Wu <ytht.net@gmail.com> wrote:
> Add create_handle support to virtio fb. Without this, screenshot tool
> in chromium OS can't work.
>
> Signed-off-by: Lepton Wu <ytht.net@gmail.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_display.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
> index b6d52055a11f..274b4206ca96 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_display.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_display.c
> @@ -71,7 +71,19 @@ virtio_gpu_framebuffer_surface_dirty(struct drm_framebuffer *fb,
>         return virtio_gpu_surface_dirty(virtio_gpu_fb, clips, num_clips);
>  }
>
> +static int
> +virtio_gpu_framebuffer_create_handle(struct drm_framebuffer *fb,
> +                                    struct drm_file *file_priv,
> +                                    unsigned int *handle)
> +{
> +       struct virtio_gpu_framebuffer *virtio_gpu_fb =
> +               to_virtio_gpu_framebuffer(fb);
> +
> +       return drm_gem_handle_create(file_priv, virtio_gpu_fb->obj, handle);
> +}
> +
>  static const struct drm_framebuffer_funcs virtio_gpu_fb_funcs = {
> +       .create_handle = virtio_gpu_framebuffer_create_handle,
>         .destroy = virtio_gpu_user_framebuffer_destroy,
>         .dirty = virtio_gpu_framebuffer_surface_dirty,
>  };
> --
> 2.15.0.403.gc27cc4dac6-goog
>
