From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [PATCH] qemu: virtio save/load bindings
Date: Tue, 26 May 2009 03:34:32 -0500
Message-ID: <4A1BA998.8040803__7049.50596341423$1243327024$gmane$org@codemonkey.ws>
References: <20090525133405.GA6166@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090525133405.GA6166@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paul Brook <paul@codesourcery.com>, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Michael S. Tsirkin wrote:
> Implement bindings for virtio save/load. Use them in virtio pci.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>
> Is anyone working to fill in load/save bindings so that saving virtio
> devices works? Here's a trivial patch to do this (this one is on top of my
> MSI-X patchset).
> Comments?
>
>  hw/virtio-pci.c |   49 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  hw/virtio.c     |   31 ++++++++++++++-----------------
>  hw/virtio.h     |    4 ++++
>  3 files changed, 66 insertions(+), 18 deletions(-)
>
>  static void virtio_init_pci(VirtIOPCIProxy *proxy, VirtIODevice *vdev,
> diff --git a/hw/virtio.c b/hw/virtio.c
> index 63ffcff..b773dff 100644
> --- a/hw/virtio.c
> +++ b/hw/virtio.c
> @@ -568,9 +568,8 @@ void virtio_save(VirtIODevice *vdev, QEMUFile *f)
>  {
>      int i;
>  
> -    /* FIXME: load/save binding.  */
> -    //pci_device_save(&vdev->pci_dev, f);
> -    //msix_save(&vdev->pci_dev, f);
>   

qdev regressed save/restore?  What else is broken right now from the 
qdev commit?

I'm beginning to think committing in the state it was in was a mistake.  
Paul, can you put together a TODO so that we know all of the things that 
have regressed so we can get things back into shape?

Regards,

Anthony Liguori
