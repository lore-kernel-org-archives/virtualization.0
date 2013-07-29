From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v3 2/9] virtio: console: fix race in port_fops_open() and
	port unplug
Date: Mon, 29 Jul 2013 14:20:56 +0930
Message-ID: <87iozu6kb3.fsf__15569.5976493464$1375083251$gmane$org@rustcorp.com.au>
References: <cover.1374759439.git.amit.shah@redhat.com>
	<a3aca79feb7163e08b940ddefceabf78ab4cd8ce.1374759439.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <a3aca79feb7163e08b940ddefceabf78ab4cd8ce.1374759439.git.amit.shah@redhat.com>
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
> Between open() being called and processed, the port can be unplugged.
> Check if this happened, and bail out.
>
> A simple test script to reproduce this is:
>
> while true; do for i in $(seq 1 100); do echo $i > /dev/vport0p3; done; done;
>
> This opens and closes the port a lot of times; unplugging the port while
> this is happening triggers the bug.
>
> CC: <stable@vger.kernel.org>
> Signed-off-by: Amit Shah <amit.shah@redhat.com>
> ---
>  drivers/char/virtio_console.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 291f437..b04ec95 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1024,6 +1024,10 @@ static int port_fops_open(struct inode *inode, struct file *filp)
>  
>  	/* We get the port with a kref here */
>  	port = find_port_by_devt(cdev->dev);
> +	if (!port) {
> +		/* Port was unplugged before we could proceed */
> +		return -ENXIO;
> +	}
>  	filp->private_data = port;
>  
>  	/*
> -- 
> 1.8.1.4

Applied.

Thanks,
Rusty.
