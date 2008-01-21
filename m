From: Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: [PATCH] virtio: remove explicit pci ids from virtio_pci.c
Date: Sun, 20 Jan 2008 22:34:26 -0600
Message-ID: <479420D2.7050902__23960.814116481$1200890181$gmane$org@us.ibm.com>
References: <200801211130.51401.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200801211130.51401.rusty@rustcorp.com.au>
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
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> Qumranet let us use their PCI vendor ID, with device ids >= 0x1000.
> We can specify that we accept all of them in the device ID table, and
> then return -ENODEV in the probe routine.
>   

I thought the device id range was smaller.  Avi?

Regards,

Anthony Liguori

> modprobe will load all the modules which match a given alias so we
> might be loaded when we're not needed, but that's the worst that can
> happen.
>
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> ---
>  drivers/virtio/virtio_pci.c |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff -r 4edff5e24614 drivers/virtio/virtio_pci.c
> --- a/drivers/virtio/virtio_pci.c	Sun Jan 20 21:01:32 2008 +1100
> +++ b/drivers/virtio/virtio_pci.c	Mon Jan 21 11:05:19 2008 +1100
> @@ -62,10 +62,9 @@ struct virtio_pci_vq_info
>  	struct list_head node;
>  };
>
> -/* We have to enumerate here all virtio PCI devices. */
> +/* Qumranet donated their vendor ID and devices >= 0x1000 */
>  static struct pci_device_id virtio_pci_id_table[] = {
> -	{ 0x1af4, 0x1000, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* virtio net */
> -	{ 0x1af4, 0x1001, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* virtio blk */
> +	{ 0x1af4, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
>  	{ 0 },
>  };
>
> @@ -303,6 +302,10 @@ static int __devinit virtio_pci_probe(st
>  	struct virtio_pci_device *vp_dev;
>  	int err;
>
> +	/* We only own device ids >= 0x1000 */
> +	if (pci_dev->device < 0x1000)
> +		return -ENODEV;
> +
>  	/* allocate our structure and fill it out */
>  	vp_dev = kzalloc(sizeof(struct virtio_pci_device), GFP_KERNEL);
>  	if (vp_dev == NULL)
>   
