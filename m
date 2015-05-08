From: walter harms <wharms@bfs.de>
Subject: Re: [patch v2] virtio_console: silence a static checker warning
Date: Fri, 08 May 2015 11:30:09 +0200
Message-ID: <554C8221.9070304__40019.5174072453$1431358000$gmane$org@bfs.de>
References: <20150508091624.GS14154@mwanda>
Reply-To: wharms@bfs.de
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150508091624.GS14154@mwanda>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Amit Shah <amit.shah@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel-janitors@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



Am 08.05.2015 11:16, schrieb Dan Carpenter:
> My static checker complains that this sprintf() can overflow but really
> it can't.  Just silence the warning by using snprintf().
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> v2: the overflow is not possible so just leave the buffer size alone and
>     silence the warning with snprintf().
> 
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 50754d20..8283989 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1492,8 +1492,8 @@ static int add_port(struct ports_device *portdev, u32 id)
>  		 * Finally, create the debugfs file that we can use to
>  		 * inspect a port's state at any time
>  		 */
> -		sprintf(debugfs_name, "vport%up%u",
> -			port->portdev->vdev->index, id);
> +		snprintf(debugfs_name, sizeof(debugfs_name), "vport%up%u",
> +			 port->portdev->vdev->index, id);


would it help to use %03u (or so) to make it more obvious ?

Note: i prefer a leading 0 in my programms to make it more easy
to work with grep and friends. you may thing otherwise.


re,
 wh

>  		port->debugfs_file = debugfs_create_file(debugfs_name, 0444,
>  							 pdrvdata.debugfs_dir,
>  							 port,
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
