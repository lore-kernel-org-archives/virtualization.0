From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 1/3] iommu/virtio: Add topology description to
 virtio-iommu config space
Date: Mon, 13 Apr 2020 09:22:25 -0400
Message-ID: <20200413091355-mutt-send-email-mst@kernel.org>
References: <20200228172537.377327-1-jean-philippe@linaro.org>
 <20200228172537.377327-2-jean-philippe@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200228172537.377327-2-jean-philippe@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, linux-pci@vger.kernel.org, joro@8bytes.org, bhelgaas@google.com, jasowang@redhat.com, kevin.tian@intel.com, sebastien.boeuf@intel.com, eric.auger@redhat.com, jacob.jun.pan@intel.com, robin.murphy@arm.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 28, 2020 at 06:25:36PM +0100, Jean-Philippe Brucker wrote:
> diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
> index 237e36a280cb..ec57d215086a 100644
> --- a/include/uapi/linux/virtio_iommu.h
> +++ b/include/uapi/linux/virtio_iommu.h
> @@ -16,6 +16,7 @@
>  #define VIRTIO_IOMMU_F_BYPASS			3
>  #define VIRTIO_IOMMU_F_PROBE			4
>  #define VIRTIO_IOMMU_F_MMIO			5
> +#define VIRTIO_IOMMU_F_TOPOLOGY			6
>  
>  struct virtio_iommu_range_64 {
>  	__le64					start;
> @@ -27,6 +28,12 @@ struct virtio_iommu_range_32 {
>  	__le32					end;
>  };
>  
> +struct virtio_iommu_topo_config {
> +	__le32					offset;

Any restrictions on offset? E.g. alignment?

> +	__le32					num_items;
> +	__le32					item_length;
> +};
> +
>  struct virtio_iommu_config {
>  	/* Supported page sizes */
>  	__le64					page_size_mask;
> @@ -36,6 +43,25 @@ struct virtio_iommu_config {
>  	struct virtio_iommu_range_32		domain_range;
>  	/* Probe buffer size */
>  	__le32					probe_size;
> +	struct virtio_iommu_topo_config		topo_config;
> +};
> +
> +#define VIRTIO_IOMMU_TOPO_PCI_RANGE		0x1
> +#define VIRTIO_IOMMU_TOPO_ENDPOINT		0x2
> +
> +struct virtio_iommu_topo_pci_range {
> +	__le16					type;
> +	__le16					hierarchy;
> +	__le16					requester_start;
> +	__le16					requester_end;
> +	__le32					endpoint_start;
> +};
> +
> +struct virtio_iommu_topo_endpoint {
> +	__le16					type;
> +	__le16					reserved;
> +	__le32					endpoint;
> +	__le64					address;
>  };
>  
>  /* Request types */

As any UAPI change, this needs to be copied to virtio TC.

I believe an old version of QEMU patches was published there
but I don't think it was the latest one you tested against.

Description should preferably be added to spec too.

In partucular please add comments (in this header, too)
documenting the new fields, values and structures.

> -- 
> 2.25.0
