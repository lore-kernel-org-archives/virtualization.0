From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 4/4] virtio: disable multiport console support.
Date: Wed, 31 Mar 2010 21:35:39 +0300
Message-ID: <20100331183539.GA5241@redhat.com>
References: <201003301549.43186.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201003301549.43186.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Amit Shah <amit.shah@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 30, 2010 at 03:49:43PM +1030, Rusty Russell wrote:
> Unfortunately there proved to be at least one bug which requires an
> ABI change, so we're best off not introducing multiport support until
> 2.6.35.
> 
> While I generally left the multiport code paths intact, I really wanted
> to remove the ABI defines from the header, which meant some quite deep cuts.
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> To: Amit Shah <amit.shah@redhat.com>
> ---
> diff --git a/include/linux/virtio_console.h b/include/linux/virtio_console.h
> --- a/include/linux/virtio_console.h
> +++ b/include/linux/virtio_console.h
> @@ -12,7 +12,6 @@
>  
>  /* Feature bits */
>  #define VIRTIO_CONSOLE_F_SIZE	0	/* Does host provide console size? */
> -#define VIRTIO_CONSOLE_F_MULTIPORT 1	/* Does host provide multiple ports? */
>  
>  struct virtio_console_config {
>  	/* colums of the screens */
> @@ -25,24 +24,6 @@ struct virtio_console_config {
>  	__u32 nr_ports;
>  } __attribute__((packed));

We also want to remove nr_ports, correct?
