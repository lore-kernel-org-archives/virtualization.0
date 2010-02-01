From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 21/31] virtio: console: Prepare for writing to userspace
	buffers
Date: Mon, 1 Feb 2010 10:49:51 +1030
Message-ID: <201002011049.52053.rusty@rustcorp.com.au>
References: <1264772563-25517-1-git-send-email-amit.shah@redhat.com>
	<1264772563-25517-3-git-send-email-amit.shah@redhat.com>
	<1264772563-25517-4-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1264772563-25517-4-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 30 Jan 2010 12:12:40 am Amit Shah wrote:
> When ports get advertised as char devices, the buffers will come from
> userspace. Equip the fill_readbuf function with the ability to write
> to userspace buffers.
> 
> Signed-off-by: Amit Shah <amit.shah@redhat.com>
> ---
>  drivers/char/virtio_console.c |   20 ++++++++++++++------
>  1 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 9d33239..5f61021 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -365,7 +365,8 @@ fail:
>   * Give out the data that's requested from the buffer that we have
>   * queued up.
>   */
> -static ssize_t fill_readbuf(struct port *port, char *out_buf, size_t out_count)
> +static ssize_t fill_readbuf(struct port *port, char *out_buf, size_t out_count,
> +			    bool to_user)

This patch does not apply: your previous 19/31 "Introduce a send_buf function
for a common path for sending data to host" made this "void *out_buf".  The
rest I can't even sort out.

I have dropped 19/31 onwards, as listed below.  Please re-xmit privately,
tarball is fine.

Thanks,
Rusty.

Subject: virtio: console: Introduce a send_buf function for a common path for sending data to host
Subject: virtio: console: Add a new MULTIPORT feature, support for generic ports
Subject: virtio: console: Prepare for writing to / reading from userspace buffers
Subject: virtio: console: Associate each port with a char device
Subject: virtio: console: Add file operations to ports for open/read/write/poll
Subject: virtio: console: Ensure only one process can have a port open at a time
Subject: virtio: console: Register with sysfs and create a 'name' attribute for ports
Subject: virtio: console: Remove cached data on port close
Subject: virtio: console: Handle port hot-plug
Subject: virtio: console: Add ability to hot-unplug ports
Subject: virtio: console: Add debugfs files for each port to expose debug info
Subject: virtio: console: show error message if hvc_alloc fails for console ports
