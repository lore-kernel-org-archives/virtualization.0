From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio-pci: also bind to Amazon PCI vendor ID
Date: Mon, 15 Sep 2014 11:20:15 +0300
Message-ID: <20140915082015.GB6480@redhat.com>
References: <1410751773-10519-1-git-send-email-anthony@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1410751773-10519-1-git-send-email-anthony@codemonkey.ws>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: kernel@vger.kernel.org, Matt Wilson <msw@amazon.com>, Anthony Liguori <aliguori@amazon.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Sep 14, 2014 at 08:29:33PM -0700, Anthony Liguori wrote:
> From: Anthony Liguori <aliguori@amazon.com>
> 
> See https://issues.oasis-open.org/browse/VIRTIO-16 although it
> was prematurely closed.

The reason it was closed is described in the comments. and I quote:
" I think anyone can use a different subsystem vendor id and whql the
driver. virtio-102 will make this even easier, by making the subsystem
id flexible. Let's close this and re-open if someone tries to do this
and runs into a problem. "

Look here for example:
https://github.com/YanVugenfirer/kvm-guest-drivers-windows/blob/master/NetKVM/NDIS5/wxp/netkvm.inf
Replace SUBSYS_00011AF4 with SUBSYS_00011D0F, and you will get
a virtio-net driver that (I think) you should be able to WHQL.

On the host side, you will need a QEMU patch to allow libvirt control of
the subsystem vendor ID.

All this while all Linux guests will keep working without changes,
which seems like a better approach.

Looking on the web, I found:
http://download.microsoft.com/download/1/6/1/161ba512-40e2-4cc9-843a-923143f3456c/pciidspec-11.doc
"Test will read and properly concatenate PCI IDs and verify uniqueness"
this is likely what you are running into: IDs must be unique,
so if you want to put your driver in Microsoft's database,
it must match a different set of IDs.
But you should not need to change the vendor ID to make them unique,
changing subsystem vendor ID will do.

Did you try this?


> Red Hat has non-redistributable Windows drivers and Microsoft
> will not allow anyone else to WHQL certify drivers using that
> vendor ID. 

Don't see what Red Hat's windows drivers have to do with Linux really.
Amazon.com can do whatever it wants with its vendor ID, and if there is a 
hypervisor with a different vendor ID that can use the virtio drivers, this
patch is required.
The following would be a reasonable commit log in that case:

"Amazon.com uses PV devices with vendor ID 0x1d0f that are otherwise
 compatible with Linux virtio drivers. Add 0x1d0f ID to the list
 to make Linux work with these devices."
Feel free to use :)


But I'd like to note that by doing this on the hypervisor side,
you lose the ability to run older Linux guests,
and create work for all distros who now need to update their
kernels to work with your ID, apparently for no good reason.

So if this isn't out in the field yet, I would suggest examining
the alternative listed above.

OTOH if it *is* decided this is going to be out there in the field, please add
the new devices to the PCI IDs list.
http://pci-ids.ucw.cz/
Otherwise there's no way to be sure someone won't try to
use these IDs for something else.

> That makes it impossible to use virtio drivers with
> a Windows guest without changing the vendor ID.

Hardly impossible: virtio drivers are available from a
variety of sources.

But this is IMO beside the point.

> Cc: Matt Wilson <msw@amazon.com>
> Cc: Rusty Russell <rusty@rustcorp.com.au>
> Cc: Michael Tsirkin <mst@redhat.com>
> Signed-off-by: Anthony Liguori <aliguori@amazon.com>

I'd like to see the response/confirmation of the above, and/or the
commit log replaced before this patch is applied.

Thanks!

> ---
>  drivers/virtio/virtio_pci.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
> index 101db3f..9cbac33 100644
> --- a/drivers/virtio/virtio_pci.c
> +++ b/drivers/virtio/virtio_pci.c
> @@ -93,6 +93,8 @@ struct virtio_pci_vq_info
>  /* Qumranet donated their vendor ID for devices 0x1000 thru 0x10FF. */
>  static DEFINE_PCI_DEVICE_TABLE(virtio_pci_id_table) = {
>  	{ PCI_DEVICE(0x1af4, PCI_ANY_ID) },
> +	/* Amazon.com vendor ID */
> +	{ PCI_DEVICE(0x1d0f, PCI_ANY_ID) },
>  	{ 0 }
>  };
>  
> -- 
> 1.7.9.5
