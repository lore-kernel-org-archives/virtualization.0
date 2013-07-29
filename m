From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v3 7/9] virtio: console: add locking in port unplug path
Date: Mon, 29 Jul 2013 14:24:22 +0930
Message-ID: <877gga6k5d.fsf@rustcorp.com.au>
References: <cover.1374759439.git.amit.shah@redhat.com>
	<ed4b66e841e0c8cc6f5b6a70aa2001057616af57.1374759439.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <ed4b66e841e0c8cc6f5b6a70aa2001057616af57.1374759439.git.amit.shah@redhat.com>
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
> Port unplug can race with close() in port_fops_release().
> port_fops_release() already takes the necessary locks, ensure
> unplug_port() does that too.
>
> Signed-off-by: Amit Shah <amit.shah@redhat.com>

Applied,
Rusty.

> ---
>  drivers/char/virtio_console.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 9cbed93..e8b707d 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1541,6 +1541,7 @@ static void unplug_port(struct port *port)
>  	list_del(&port->list);
>  	spin_unlock_irq(&port->portdev->ports_lock);
>  
> +	spin_lock_irq(&port->inbuf_lock);
>  	if (port->guest_connected) {
>  		/* Let the app know the port is going down. */
>  		send_sigio_to_port(port);
> @@ -1551,6 +1552,7 @@ static void unplug_port(struct port *port)
>  
>  		wake_up_interruptible(&port->waitqueue);
>  	}
> +	spin_unlock_irq(&port->inbuf_lock);
>  
>  	if (is_console_port(port)) {
>  		spin_lock_irq(&pdrvdata_lock);
> -- 
> 1.8.1.4
