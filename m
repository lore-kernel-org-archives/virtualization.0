From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 7/7] virtio: console: Return -EPIPE if port on the host
	isn't connected
Date: Tue, 23 Mar 2010 11:00:23 +0200
Message-ID: <20100323090023.GD22774@redhat.com>
References: <1269334680-1369-1-git-send-email-amit.shah@redhat.com>
	<1269334680-1369-2-git-send-email-amit.shah@redhat.com>
	<1269334680-1369-3-git-send-email-amit.shah@redhat.com>
	<1269334680-1369-4-git-send-email-amit.shah@redhat.com>
	<1269334680-1369-5-git-send-email-amit.shah@redhat.com>
	<1269334680-1369-6-git-send-email-amit.shah@redhat.com>
	<1269334680-1369-7-git-send-email-amit.shah@redhat.com>
	<1269334680-1369-8-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1269334680-1369-8-git-send-email-amit.shah@redhat.com>
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

On Tue, Mar 23, 2010 at 02:28:00PM +0530, Amit Shah wrote:
> The virtio-serial ports are like pipes, if there's no reader on the
> other end, sending data might get it either ignored or the host might
> return '0', which would make guests get -EAGAIN. Since we know the state
> of the host port connection, it's appropriate to let the application
> know that the other end isn't connected.
> 
> Signed-off-by: Amit Shah <amit.shah@redhat.com>
> ---
>  drivers/char/virtio_console.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 55de0b5..4562964 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -411,6 +411,9 @@ static ssize_t send_buf(struct port *port, void *in_buf, size_t in_count)
>  	ssize_t ret;
>  	unsigned int len;
>  
> +	if (use_multiport(port->portdev) && !port->host_connected)
> +		return -EPIPE;
> +

Hmm, do applications actually handle this error?

>  	out_vq = port->out_vq;
>  
>  	sg_init_one(sg, in_buf, in_count);
> -- 
> 1.6.2.5
