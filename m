From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 12/22] virtio_pci: allow duplicate capabilities.
Date: Thu, 21 Mar 2013 12:28:14 +0200
Message-ID: <20130321102814.GC30493@redhat.com>
References: <1363854584-25795-1-git-send-email-rusty@rustcorp.com.au>
	<1363854584-25795-13-git-send-email-rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1363854584-25795-13-git-send-email-rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: "H. Peter Anvin" <hpa@zytor.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 21, 2013 at 06:59:33PM +1030, Rusty Russell wrote:
> Another HPA suggestion: that the device be allowed to offer duplicate
> capabilities, particularly so it can offer a mem and an I/O bar and let
> the guest decide (Linux guest probably doesn't care?).
> 
> Cc: H. Peter Anvin <hpa@zytor.com>
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

I think guests is exactly the wrong place to decide,
it really does not know whether it's running on a
hypervisor with fast IO or fast memory.
Also, as long as we have an IO BAR, we have problems allocating it.
So I think we don't need this, see my suggestion
about fixed IO addresses instead.


> ---
>  drivers/virtio/virtio_pci_legacy.c |    3 ++-
>  include/linux/virtio_pci.h         |   20 ++++++++++++++++----
>  2 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> index 501fa79..c7aadcb 100644
> --- a/drivers/virtio/virtio_pci_legacy.c
> +++ b/drivers/virtio/virtio_pci_legacy.c
> @@ -728,7 +728,8 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
>  	}
>  
>  	/* We leave modern virtio-pci for the modern driver. */
> -	cap = virtio_pci_find_capability(pci_dev, VIRTIO_PCI_CAP_COMMON_CFG);
> +	cap = virtio_pci_find_capability(pci_dev, VIRTIO_PCI_CAP_COMMON_CFG,
> +					 IORESOURCE_IO|IORESOURCE_MEM);
>  	if (cap) {
>  		if (force_nonlegacy)
>  			dev_info(&pci_dev->dev,
> diff --git a/include/linux/virtio_pci.h b/include/linux/virtio_pci.h
> index 2714160..6d2816b 100644
> --- a/include/linux/virtio_pci.h
> +++ b/include/linux/virtio_pci.h
> @@ -4,18 +4,30 @@
>  #define VIRTIO_PCI_NO_LEGACY
>  #include <uapi/linux/virtio_pci.h>
>  
> -/* Returns offset of the capability, or 0. */
> -static inline int virtio_pci_find_capability(struct pci_dev *dev, u8 cfg_type)
> +/**
> + * virtio_pci_find_capability - walk capabilities to find device info.
> + * @dev: the pci device
> + * @cfg_type: the VIRTIO_PCI_CAP_* value we seek
> + * @ioresource_types: IORESOURCE_MEM and/or IORESOURCE_IO.
> + *
> + * Returns offset of the capability, or 0.
> + */
> +static inline int virtio_pci_find_capability(struct pci_dev *dev, u8 cfg_type,
> +					     u32 ioresource_types)
>  {
>  	int pos;
>  
>  	for (pos = pci_find_capability(dev, PCI_CAP_ID_VNDR);
>  	     pos > 0;
>  	     pos = pci_find_next_capability(dev, pos, PCI_CAP_ID_VNDR)) {
> -		u8 type;
> +		u8 type, bar;
>  		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
>  							 cfg_type), &type);
> -		if (type == cfg_type)
> +		if (type != cfg_type)
> +			continue;
> +		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
> +							 bar), &bar);
> +		if (pci_resource_flags(dev, bar) & ioresource_types)
>  			return pos;
>  	}
>  	return 0;
> -- 
> 1.7.10.4
> 
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
