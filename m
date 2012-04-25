From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/1] virtio: console: tell host of open ports after
	resume from s3/s4
Date: Wed, 25 Apr 2012 13:37:18 +0300
Message-ID: <20120425103717.GA26878@redhat.com>
References: <393cb3180cbb3dd4ca71ac90714f71b0472c5b48.1335345026.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <393cb3180cbb3dd4ca71ac90714f71b0472c5b48.1335345026.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: stable@vger.kernel.org.#.Only.for.3.3, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 25, 2012 at 02:40:39PM +0530, Amit Shah wrote:
> If a port was open before going into one of the sleep states, the port
> can continue normal operation after restore.  However, the host has to
> be told that the guest side of the connection is open to restore
> pre-suspend state.
> 
> This wasn't noticed so far due to a bug in qemu that was fixed recently
> (which marked the guest-side connection as always open).
> 
> CC: stable@vger.kernel.org   # Only for 3.3
> 
> Signed-off-by: Amit Shah <amit.shah@redhat.com>

Applied and queued for the next 3.4 pull, thanks.

> ---
>  drivers/char/virtio_console.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index ddf86b6..cdf2f54 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1895,6 +1895,13 @@ static int virtcons_restore(struct virtio_device *vdev)
>  
>  		/* Get port open/close status on the host */
>  		send_control_msg(port, VIRTIO_CONSOLE_PORT_READY, 1);
> +
> +		/*
> +		 * If a port was open at the time of suspending, we
> +		 * have to let the host know that it's still open.
> +		 */
> +		if (port->guest_connected)
> +			send_control_msg(port, VIRTIO_CONSOLE_PORT_OPEN, 1);
>  	}
>  	return 0;
>  }
> -- 
> 1.7.7.6
