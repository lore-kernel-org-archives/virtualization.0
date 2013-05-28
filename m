From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH rusty/virtio-pci-new-layout] virtio: new layout minor
	header fixups
Date: Tue, 28 May 2013 10:59:08 +0930
Message-ID: <87txlnopsr.fsf@rustcorp.com.au>
References: <20130527155943.GA18246@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130527155943.GA18246@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org
Cc: David Howells <dhowells@redhat.com>, Dave Jones <davej@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
> Fix issues observed with the new layout code, seen
> when implementing device in qemu:
> 	- use of uXX in uapi header
> 	- incorrect readonly tag on one field
> 	- unconditional warning breaks builds with -Werr
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Hmm, this means if we ever *do* remove those defines, qemu will break.

But perhaps that's OK, because we'll probably remove legacy support at
the same time as we break the header.

Applied, thanks!
Rusty.

> This patch is on top of rusty/virtio-pci-new-layout.
>
>  include/uapi/linux/virtio_pci.h | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
> index 3e61d55..cda688f 100644
> --- a/include/uapi/linux/virtio_pci.h
> +++ b/include/uapi/linux/virtio_pci.h
> @@ -86,8 +86,10 @@
>  #define VIRTIO_PCI_LEGACY_VRING_ALIGN		4096
>  
>  #ifndef VIRTIO_PCI_NO_LEGACY
> +#ifndef VIRTIO_PCI_LEGACY_COMPAT_NAMES
>  /* Don't break compile of old userspace code.  These will go away. */
>  #warning "Please support virtio_pci non-legacy mode!"
> +#endif
>  #define VIRTIO_PCI_HOST_FEATURES VIRTIO_PCI_LEGACY_HOST_FEATURES
>  #define VIRTIO_PCI_GUEST_FEATURES VIRTIO_PCI_LEGACY_GUEST_FEATURES
>  #define VIRTIO_PCI_QUEUE_PFN VIRTIO_PCI_LEGACY_QUEUE_PFN
> @@ -125,10 +127,10 @@
>  
>  /* This is the PCI capability header: */
>  struct virtio_pci_cap {
> -	u8 cap_vndr;	/* Generic PCI field: PCI_CAP_ID_VNDR */
> -	u8 cap_next;	/* Generic PCI field: next ptr. */
> -	u8 cfg_type;	/* One of the VIRTIO_PCI_CAP_*_CFG. */
> -	u8 bar;		/* Where to find it. */
> +	__u8 cap_vndr;	/* Generic PCI field: PCI_CAP_ID_VNDR */
> +	__u8 cap_next;	/* Generic PCI field: next ptr. */
> +	__u8 cfg_type;	/* One of the VIRTIO_PCI_CAP_*_CFG. */
> +	__u8 bar;		/* Where to find it. */
>  	__le32 offset;	/* Offset within bar. */
>  	__le32 length;	/* Length. */
>  };
> @@ -144,7 +146,7 @@ struct virtio_pci_common_cfg {
>  	__le32 device_feature_select;	/* read-write */
>  	__le32 device_feature;		/* read-only */
>  	__le32 guest_feature_select;	/* read-write */
> -	__le32 guest_feature;		/* read-only */
> +	__le32 guest_feature;		/* read-write */
>  	__le16 msix_config;		/* read-write */
>  	__le16 num_queues;		/* read-only */
>  	__u8 device_status;		/* read-write */
> -- 
> MST
