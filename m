From: Fam Zheng <famz@redhat.com>
Subject: Re: [PATCH] virtio: Remove virtio device during shutdown
Date: Wed, 11 Mar 2015 18:11:35 +0800
Message-ID: <20150311101135.GA13653@ad.nay.redhat.com>
References: <1426061357-4440-1-git-send-email-famz@redhat.com>
	<20150311095814-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20150311095814-mutt-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 03/11 10:06, Michael S. Tsirkin wrote:
> On Wed, Mar 11, 2015 at 04:09:17PM +0800, Fam Zheng wrote:
> > Currently shutdown is nop for virtio devices, but the core code could
> > remove things behind us such as MSI-X handler etc. For example in the
> > case of virtio-scsi-pci, the device may still try to send interupts,
> > which will be on IRQ lines seeing MSI-X disabled. Those interrupts will
> > be unhandled, and may cause flood.

Here is the problem I want to solve - file system driver hang:

If a fs code happen to hit __wait_on_buffer right after pci pci_device_shutdown
disabled msix, it will never make progress because the requests it waits for
will never be completed. So the system hangs.

In other words we will want to reset virtio device before pci_device_shutdown
AND wake up all waiters.

Unfortunately, neither your patch nor mine does that, because virtio bus can be
shutdown after pci bus (thanks to Jason for pointing out this). In that case,
any completion after disabling msix is lost.

Maybe we need both the pci shutdown handler to reset the device and the virtio
shutdown handler to remove the device?

Fam

> 
> This sounds very tentative. Do you, in fact, observe some problems
> with virtio scsi? How to reproduce them? this needs to go
> into the commit messages.

OK, my bad.

> 
> > Remove the device in "shutdown" callback to allow device drivers clean
> > up things.
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> 
> I'm concerned this will cause more hangs on shutdown: one
> of the reasons for reboot is device mal-functioning.
> How about we just reset devices instead? Something like
> the below (untested).
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 5ce2aa4..0769941 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -269,6 +269,17 @@ static int virtio_dev_remove(struct device *_d)
>  	return 0;
>  }
>  
> +static void virtio_dev_shutdown(struct device *_d)
> +{
> +	struct virtio_device *dev = dev_to_virtio(_d);
> +	/*
> +	 * Reset the device to make it stop sending interrupts, DMA, etc.
> +	 * We are shutting down, no need for full cleanup.
> +	 */
> +	dev->config->reset(dev);
> +
> +}
> +
>  static struct bus_type virtio_bus = {
>  	.name  = "virtio",
>  	.match = virtio_dev_match,
> @@ -276,6 +288,7 @@ static struct bus_type virtio_bus = {
>  	.uevent = virtio_uevent,
>  	.probe = virtio_dev_probe,
>  	.remove = virtio_dev_remove,
> +	.shutdown = virtio_dev_shutdown,
>  };
>  
>  bool virtio_device_is_legacy_only(struct virtio_device_id id)
