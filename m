From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v3 1/9] virtio: console: fix race with port unplug and
	open/close
Date: Mon, 29 Jul 2013 14:18:52 +0930
Message-ID: <87ob9m6kej.fsf__38924.6670100421$1375083220$gmane$org@rustcorp.com.au>
References: <cover.1374759439.git.amit.shah@redhat.com>
	<7ca111ad3bca069f921b4234e5b3ccbbfd7a11d8.1374759439.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <7ca111ad3bca069f921b4234e5b3ccbbfd7a11d8.1374759439.git.amit.shah@redhat.com>
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
Cc: Amit Shah <amit.shah@redhat.com>, stable@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Amit Shah <amit.shah@redhat.com> writes:
> There's a window between find_port_by_devt() returning a port and us
> taking a kref on the port, where the port could get unplugged.  Fix it
> by taking the reference in find_port_by_devt() itself.
>
> Problem reported and analyzed by Mateusz Guzik.

This fix is clearly correct, but what about the other find_port_by_*
functions?

Applied,
Rusty.

>
> CC: <stable@vger.kernel.org>
> Reported-by: Mateusz Guzik <mguzik@redhat.com>
> Signed-off-by: Amit Shah <amit.shah@redhat.com>
> ---
>  drivers/char/virtio_console.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 1b456fe..291f437 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -272,9 +272,12 @@ static struct port *find_port_by_devt_in_portdev(struct ports_device *portdev,
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&portdev->ports_lock, flags);
> -	list_for_each_entry(port, &portdev->ports, list)
> -		if (port->cdev->dev == dev)
> +	list_for_each_entry(port, &portdev->ports, list) {
> +		if (port->cdev->dev == dev) {
> +			kref_get(&port->kref);
>  			goto out;
> +		}
> +	}
>  	port = NULL;
>  out:
>  	spin_unlock_irqrestore(&portdev->ports_lock, flags);
> @@ -1019,14 +1022,10 @@ static int port_fops_open(struct inode *inode, struct file *filp)
>  	struct port *port;
>  	int ret;
>  
> +	/* We get the port with a kref here */
>  	port = find_port_by_devt(cdev->dev);
>  	filp->private_data = port;
>  
> -	/* Prevent against a port getting hot-unplugged at the same time */
> -	spin_lock_irq(&port->portdev->ports_lock);
> -	kref_get(&port->kref);
> -	spin_unlock_irq(&port->portdev->ports_lock);
> -
>  	/*
>  	 * Don't allow opening of console port devices -- that's done
>  	 * via /dev/hvc
> -- 
> 1.8.1.4
