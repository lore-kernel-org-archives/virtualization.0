From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/2] virtio: console: Wake up outvq on host notifications
Date: Mon, 31 Jan 2011 09:53:02 +0100
Message-ID: <4D46786E.90001@redhat.com>
References: <eb504880dbb2b70d51c62a63012b69408b80d070.1296459389.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <eb504880dbb2b70d51c62a63012b69408b80d070.1296459389.git.amit.shah@redhat.com>
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
Cc: stable@kernel.org, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Acked-by: Hans de Goede <hdegoede@redhat.com>

On 01/31/2011 08:36 AM, Amit Shah wrote:
> The outvq needs to be woken up on host notifications so that buffers
> consumed by the host can be reclaimed, outvq freed, and application
> writes may proceed again.
>
> The need for this is now finally noticed when I have qemu patches ready
> to use nonblocking IO and flow control.
>
> CC: Hans de Goede<hdegoede@redhat.com>
> CC: stable@kernel.org
> Signed-off-by: Amit Shah<amit.shah@redhat.com>
> ---
>   drivers/tty/hvc/virtio_console.c |   15 +++++++++++++--
>   1 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/hvc/virtio_console.c b/drivers/tty/hvc/virtio_console.c
> index c4b0255..1068095 100644
> --- a/drivers/tty/hvc/virtio_console.c
> +++ b/drivers/tty/hvc/virtio_console.c
> @@ -1473,6 +1473,17 @@ static void control_work_handler(struct work_struct *work)
>   	spin_unlock(&portdev->cvq_lock);
>   }
>
> +static void out_intr(struct virtqueue *vq)
> +{
> +	struct port *port;
> +
> +	port = find_port_by_vq(vq->vdev->priv, vq);
> +	if (!port)
> +		return;
> +
> +	wake_up_interruptible(&port->waitqueue);
> +}
> +
>   static void in_intr(struct virtqueue *vq)
>   {
>   	struct port *port;
> @@ -1577,7 +1588,7 @@ static int init_vqs(struct ports_device *portdev)
>   	 */
>   	j = 0;
>   	io_callbacks[j] = in_intr;
> -	io_callbacks[j + 1] = NULL;
> +	io_callbacks[j + 1] = out_intr;
>   	io_names[j] = "input";
>   	io_names[j + 1] = "output";
>   	j += 2;
> @@ -1591,7 +1602,7 @@ static int init_vqs(struct ports_device *portdev)
>   		for (i = 1; i<  nr_ports; i++) {
>   			j += 2;
>   			io_callbacks[j] = in_intr;
> -			io_callbacks[j + 1] = NULL;
> +			io_callbacks[j + 1] = out_intr;
>   			io_names[j] = "input";
>   			io_names[j + 1] = "output";
>   		}
