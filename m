From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 08/10] virtio: console: add locks around buffer removal in
	port unplug path
Date: Mon, 22 Jul 2013 15:26:22 +0930
Message-ID: <87d2qbb0jd.fsf@rustcorp.com.au>
References: <cover.1374177234.git.amit.shah@redhat.com>
	<2b1b00dbdbc7575e8370c3b3ecad7b4b4c0f2833.1374177234.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <2b1b00dbdbc7575e8370c3b3ecad7b4b4c0f2833.1374177234.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Virtualization List <virtualization@lists.linux-foundation.org>
Cc: Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Amit Shah <amit.shah@redhat.com> writes:
> The removal functions act on the vqs, and the vq operations need to be
> locked.
>
> Signed-off-by: Amit Shah <amit.shah@redhat.com>

How can userspace access the port now?  By the time we are cleaning up
buffers, there should be no possibility of such accesses.

The number of bugfixes here is deeply disturbing.  I wonder if it's be
easier to rewrite it all with a lock per port, and one global to protect
ports_driver_data.

Cheers,
Rusty.

> ---
>  drivers/char/virtio_console.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index ce71df1..dd0020d 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1516,18 +1516,22 @@ static void remove_port_data(struct port *port)
>  {
>  	struct port_buffer *buf;
>  
> +	spin_lock_irq(&port->inbuf_lock);
>  	/* Remove unused data this port might have received. */
>  	discard_port_data(port);
>  
> -	reclaim_consumed_buffers(port);
> -
>  	/* Remove buffers we queued up for the Host to send us data in. */
>  	while ((buf = virtqueue_detach_unused_buf(port->in_vq)))
>  		free_buf(buf, true);
> +	spin_unlock_irq(&port->inbuf_lock);
> +
> +	spin_lock_irq(&port->outvq_lock);
> +	reclaim_consumed_buffers(port);
>  
>  	/* Free pending buffers from the out-queue. */
>  	while ((buf = virtqueue_detach_unused_buf(port->out_vq)))
>  		free_buf(buf, true);
> +	spin_unlock_irq(&port->outvq_lock);
>  }
>  
>  /*
> -- 
> 1.8.1.4
