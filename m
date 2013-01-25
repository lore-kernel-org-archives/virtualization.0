From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH] virtio_console: Let unconnected rproc device receive data.
Date: Fri, 25 Jan 2013 14:40:24 +0530
Message-ID: <20130125091024.GB30483@amit.redhat.com>
References: <1358425362-4517-1-git-send-email-sjur.brandeland@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1358425362-4517-1-git-send-email-sjur.brandeland@stericsson.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: sjur.brandeland@stericsson.com
Cc: virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On (Thu) 17 Jan 2013 [13:22:42], sjur.brandeland@stericsson.com wrote:
> From: Sjur Br=E6ndeland <sjur.brandeland@stericsson.com>
> =

> Allow rproc serial ports to receive data before the port
> is connected.
> =

> Rproc serial ports usually talk to very simple remote devices
> with no control queue managing open/close events. So we must
> let remote devices write to the virtio ring even if the device
> is not yet fully initialized.
> =

> Signed-off-by: Sjur Br=E6ndeland <sjur.brandeland@stericsson.com>
> ---
> =

> This patch is intended for v3.9.
> =

> Thanks,
> Sjur
> =

>  drivers/char/virtio_console.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> =

> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index ee4dbea..c17b053 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1763,8 +1763,11 @@ static void in_intr(struct virtqueue *vq)
>  	 * tty is spawned) and the host sends out data to console
>  	 * ports.  For generic serial ports, the host won't
>  	 * (shouldn't) send data till the guest is connected.
> +	 * However a remote device might send data before the port is
> +	 * connected. So don't remove data from a rproc_serial device.
>  	 */
> -	if (!port->guest_connected)
> +
> +	if (!port->guest_connected && !is_rproc_serial(port->portdev->vdev))
>  		discard_port_data(port);

How about setting port->guest_connected =3D true in the init routines
instead?  Keeps this code path cleaner.

That's what console ports do as well, in init_port_console().

		Amit
