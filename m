From: Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH v2] drm/bochs: add edid support.
Date: Thu, 18 Oct 2018 11:15:25 +1000
Message-ID: <CAPM=9twEjDr5dj+9B==QSYtAB7uqy0Szn2d7cw9swSk+THMA2g__32639.1493938447$1539825219$gmane$org@mail.gmail.com>
References: <20181005120934.21959-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181005120934.21959-1-kraxel@redhat.com>
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

On Fri, 5 Oct 2018 at 22:10, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Recent qemu (latest master branch, upcoming 3.1 release) got support
> for EDID data.  This patch adds guest driver support.
>
> EDID support in qemu is not (yet) enabled by default, so please use
> 'qemu -device VGA,edid=on' for testing.

The EDID never changes after boot? Is there plans to let it?
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/bochs/bochs.h     |  1 +
>  drivers/gpu/drm/bochs/bochs_hw.c  | 38 ++++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/bochs/bochs_kms.c | 18 +++++++++++++++---
>  3 files changed, 54 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
> index e7a69077e4..06b8166efa 100644
> --- a/drivers/gpu/drm/bochs/bochs.h
> +++ b/drivers/gpu/drm/bochs/bochs.h
> @@ -66,6 +66,7 @@ struct bochs_device {
>         u16 yres_virtual;
>         u32 stride;
>         u32 bpp;
> +       struct edid *edid;
>
>         /* drm */
>         struct drm_device  *dev;
> diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
> index cacff73a64..6ce4cdac38 100644
> --- a/drivers/gpu/drm/bochs/bochs_hw.c
> +++ b/drivers/gpu/drm/bochs/bochs_hw.c
> @@ -69,6 +69,41 @@ static void bochs_hw_set_little_endian(struct bochs_device *bochs)
>  #define bochs_hw_set_native_endian(_b) bochs_hw_set_little_endian(_b)
>  #endif
>
> +static int bochs_load_edid(struct bochs_device *bochs)
> +{
> +       uint8_t *blob;
> +       size_t i, len;
> +       uint8_t num_exts;
> +
> +       if (!bochs->mmio)
> +               return -1;
> +
> +       if ((readb(bochs->mmio+0) != 0x00 ||
> +            readb(bochs->mmio+1) != 0xff))
> +               return -1;
> +
> +       num_exts = readb(bochs->mmio + 126);
> +       len = EDID_LENGTH * (1 + num_exts);
> +       if (len > 0x400 /* vga register offset */)
> +               return -1;
> +
> +       kfree(bochs->edid);
> +       bochs->edid = kmalloc(len, GFP_KERNEL);

Don't you need to free it somewhere?

Dave.
