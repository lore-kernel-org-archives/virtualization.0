From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 05/10] virtio: console: update private_data in struct file
	only on successful open
Date: Mon, 22 Jul 2013 15:07:52 +0930
Message-ID: <87ip03b1e7.fsf__16210.6313546703$1374534602$gmane$org@rustcorp.com.au>
References: <cover.1374177234.git.amit.shah@redhat.com>
	<a012f8e8c562c84c2302e57e5360291ef7d4ff21.1374177234.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <a012f8e8c562c84c2302e57e5360291ef7d4ff21.1374177234.git.amit.shah@redhat.com>
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
> Mateusz Guzik points out that we update the 'file' struct's private_data
> field before we've successfully done all our checks.  This means we can
> return an error with the private_data field updated.  This could lead to
> problems.
>
> Fix by moving the assignment after all checks are done.

No, this is a bit weird, but it's fine.

If we fail open, filp will be destroyed; we won't be told about it, and
private_data will never be accessed.

Cheers,
Rusty.

> CC: <stable@vger.kernel.org>
> Reported-by: Mateusz Guzik <mguzik@redhat.com>
> Signed-off-by: Amit Shah <amit.shah@redhat.com>
> ---
>  drivers/char/virtio_console.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index a39702a..7728af9 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1032,7 +1032,6 @@ static int port_fops_open(struct inode *inode, struct file *filp)
>  		/* Port was unplugged before we could proceed */
>  		return -ENXIO;
>  	}
> -	filp->private_data = port;
>  
>  	/*
>  	 * Don't allow opening of console port devices -- that's done
> @@ -1051,6 +1050,7 @@ static int port_fops_open(struct inode *inode, struct file *filp)
>  		goto out;
>  	}
>  
> +	filp->private_data = port;
>  	port->guest_connected = true;
>  	spin_unlock_irq(&port->inbuf_lock);
>  
> -- 
> 1.8.1.4
