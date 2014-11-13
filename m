From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 52/56] drivers/char/virtio: support compiling out splice
Date: Thu, 13 Nov 2014 14:09:49 -0800
Message-ID: <20141113220949.GC546@kroah.com>
References: <pieter@boesman.nl>
	<1415913813-362-1-git-send-email-pieter@boesman.nl>
	<1415913813-362-53-git-send-email-pieter@boesman.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1415913813-362-53-git-send-email-pieter@boesman.nl>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pieter Smith <pieter@boesman.nl>
Cc: Amit Shah <amit.shah@redhat.com>, open list <linux-kernel@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>, Arnd Bergmann <arnd@arndb.de>, "open list:VIRTIO CONSOLE DR..." <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Nov 13, 2014 at 10:23:29PM +0100, Pieter Smith wrote:
> Compile out splice support from virtio character driver when the splice-family
> of syscalls is not supported by the system (i.e. CONFIG_SYSCALL_SPLICE is
> undefined).
> 
> Signed-off-by: Pieter Smith <pieter@boesman.nl>
> ---
>  drivers/char/virtio_console.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index b585b47..de5e2cb 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -870,6 +870,7 @@ struct sg_list {
>  	struct scatterlist *sg;
>  };
>  
> +#ifdef CONFIG_SYSCALL_SPLICE
>  static int pipe_to_sg(struct pipe_inode_info *pipe, struct pipe_buffer *buf,
>  			struct splice_desc *sd)
>  {
> @@ -976,6 +977,7 @@ error_out:
>  	pipe_unlock(pipe);
>  	return ret;
>  }
> +#endif /* #ifdef CONFIG_SYSCALL_SPLICE */

Not worth the #ifdef mess.
