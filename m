From: Sean Paul via Virtualization <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH] drm/virtio: kconfig: Fixup white space.
Date: Fri, 21 Oct 2016 10:53:27 -0400
Message-ID: <CAOw6vbLjxghzxVdNYADTSPSfJq51YHJQHQ5VMJEmtHqVKmu+kw@mail.gmail.com>
References: <1475913318-12275-1-git-send-email-peter.griffin@linaro.org>
Reply-To: Sean Paul <seanpaul@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1475913318-12275-1-git-send-email-peter.griffin@linaro.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Griffin <peter.griffin@linaro.org>
Cc: kernel@stlinux.com, Dave Airlie <airlied@linux.ie>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, Lee Jones <lee.jones@linaro.org>, Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Oct 8, 2016 at 3:55 AM, Peter Griffin <peter.griffin@linaro.org> wrote:
> Use tabs instead of spaces.
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Acked-by: Lee Jones <lee.jones@linaro.org>

Applied to drm-misc, thanks

> ---
>  drivers/gpu/drm/virtio/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/Kconfig b/drivers/gpu/drm/virtio/Kconfig
> index e1afc3d..81d1807 100644
> --- a/drivers/gpu/drm/virtio/Kconfig
> +++ b/drivers/gpu/drm/virtio/Kconfig
> @@ -1,10 +1,10 @@
>  config DRM_VIRTIO_GPU
>         tristate "Virtio GPU driver"
>         depends on DRM && VIRTIO
> -        select DRM_KMS_HELPER
> -        select DRM_TTM
> +       select DRM_KMS_HELPER
> +       select DRM_TTM
>         help
>            This is the virtual GPU driver for virtio.  It can be used with
> -           QEMU based VMMs (like KVM or Xen).
> +          QEMU based VMMs (like KVM or Xen).
>
>            If unsure say M.
> --
> 1.9.1
>
