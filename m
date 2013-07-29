From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v3 9/9] virtio: console: prevent use-after-free of port
	name in port unplug
Date: Mon, 29 Jul 2013 14:26:09 +0930
Message-ID: <871u6i6k2e.fsf@rustcorp.com.au>
References: <cover.1374759439.git.amit.shah@redhat.com>
	<83c058bc32c4e377a75235120885aec7dfd223c7.1374759439.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <83c058bc32c4e377a75235120885aec7dfd223c7.1374759439.git.amit.shah@redhat.com>
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
> Remove the debugfs path before freeing port->name, to prevent a possible
> use-after-free.
>
> Reported-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Amit Shah <amit.shah@redhat.com>

Applied,
Rusty.

> ---
>  drivers/char/virtio_console.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 4e380c1..e910bec 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1574,9 +1574,8 @@ static void unplug_port(struct port *port)
>  	device_destroy(pdrvdata.class, port->dev->devt);
>  	cdev_del(port->cdev);
>  
> -	kfree(port->name);
> -
>  	debugfs_remove(port->debugfs_file);
> +	kfree(port->name);
>  
>  	/*
>  	 * Locks around here are not necessary - a port can't be
> -- 
> 1.8.1.4
