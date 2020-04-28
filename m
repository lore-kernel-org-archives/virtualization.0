From: "kraxel@redhat.com" <kraxel@redhat.com>
Subject: Re: [PATCH] virtio_input: Initialize multi-touch slots on ABS_MT_SLOT
Date: Tue, 28 Apr 2020 12:13:37 +0200
Message-ID: <20200428101337.enz7sni4r2hyujdc@sirius.home.kraxel.org>
References: <cbf254cbfde249b99f275a38c5c8cc97@blackberry.com>
 <b5ebe49b77374d53a6cda0ac98f11560@blackberry.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <b5ebe49b77374d53a6cda0ac98f11560@blackberry.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Rudolf Streif <rstreif@blackberry.com>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "mst@redhat.com" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 15, 2020 at 12:24:12AM +0000, Rudolf Streif wrote:
> Resubmit. Thank you.

Better re-send with "git send-email" as new message.
As reply in an existing thread it gets lost easily.

> ________________________________
> From: Virtualization <virtualization-bounces@lists.linux-foundation.org> on behalf of Rudolf Streif <rstreif@blackberry.com>
> Sent: Thursday, January 2, 2020 11:12 AM
> To: kraxel@redhat.com
> Cc: virtualization@lists.linux-foundation.org
> Subject: [PATCH] virtio_input: Initialize multi-touch slots on ABS_MT_SLOT
> 
> 
> For multi-touch devices the frontend needs to initialize the correct
> number of slots for touch tracking. Hardware drivers do this by
> calling input_mt_init_slots() on initialization. For virtio_input
> the function must be called when the backend sends ABS_MT_SLOT.
> 
> Signed-off-by: Rudolf J Streif <rstreif@blackberry.com>
> ---
>  drivers/virtio/virtio_input.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
> index 5ae529671b3d..582ba808b955 100644
> --- a/drivers/virtio/virtio_input.c
> +++ b/drivers/virtio/virtio_input.c
> @@ -3,6 +3,7 @@
>  #include <linux/virtio.h>
>  #include <linux/virtio_config.h>
>  #include <linux/input.h>
> +#include <linux/input/mt.h>
> 
>  #include <uapi/linux/virtio_ids.h>
>  #include <uapi/linux/virtio_input.h>
> @@ -164,6 +165,9 @@ static void virtinput_cfg_abs(struct virtio_input *vi, int abs)
>         virtio_cread(vi->vdev, struct virtio_input_config, u.abs.flat, &fl);
>         input_set_abs_params(vi->idev, abs, mi, ma, fu, fl);
>         input_abs_set_res(vi->idev, abs, re);
> +
> +       if (abs == ABS_MT_SLOT)
> +               input_mt_init_slots(vi->idev, ma + 1, INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

mst, can you pick it up?

thanks,
  Gerd
