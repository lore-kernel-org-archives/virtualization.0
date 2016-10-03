From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH 3/4] virtio_blk: Delete an unnecessary initialisation in
	init_vq()
Date: Mon, 3 Oct 2016 10:09:51 +0100
Message-ID: <CAJSP0QV+1AYuifSf3oeixuXyThP8Upnd1sxPX=S6i-9Qiu5QKw__12442.7815237597$1475485811$gmane$org@mail.gmail.com>
References: <566ABCD9.1060404@users.sourceforge.net>
	<02054675-8395-ac81-6863-e3a5cbfc9032@users.sourceforge.net>
	<52a07fc8-21a0-8f98-fa9d-5751fbf95afa@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <52a07fc8-21a0-8f98-fa9d-5751fbf95afa@users.sourceforge.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Julia Lawall <julia.lawall@lip6.fr>, "Michael S. Tsirkin" <mst@redhat.com>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Sep 13, 2016 at 1:14 PM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 13 Sep 2016 13:43:50 +0200
>
> The local variable "err" will be set to an appropriate value
> by a following statement.
> Thus omit the explicit initialisation at the beginning.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/block/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index d28dbcf..696f452 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -376,7 +376,7 @@ static void virtblk_config_changed(struct virtio_device *vdev)
>
>  static int init_vq(struct virtio_blk *vblk)
>  {
> -       int err = 0;
> +       int err;
>         int i;
>         vq_callback_t **callbacks;
>         const char **names;

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
