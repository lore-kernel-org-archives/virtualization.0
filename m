From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v5] iommu/virtio: Use page size bitmap supported by
 endpoint
Date: Tue, 12 May 2020 18:47:03 +0200
Message-ID: <20200512164703.GA1902@myrica>
References: <20200505093004.1935-1-bbhushan2@marvell.com>
 <20200512105149-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200512105149-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Bharat Bhushan <bbhushan2@marvell.com>, joro@8bytes.org, jasowang@redhat.com, virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, eric.auger.pro@gmail.com, eric.auger@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, May 12, 2020 at 10:53:39AM -0400, Michael S. Tsirkin wrote:
> >  static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
> >  			       struct virtio_iommu_probe_resv_mem *mem,
> >  			       size_t len)
> > @@ -499,6 +513,9 @@ static int viommu_probe_endpoint(struct viommu_dev *viommu, struct device *dev)
> >  		case VIRTIO_IOMMU_PROBE_T_RESV_MEM:
> >  			ret = viommu_add_resv_mem(vdev, (void *)prop, len);
> >  			break;
> > +		case VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK:
> > +			ret = viommu_set_pgsize_bitmap(vdev, (void *)prop, len);
> > +			break;
> >  		default:
> >  			dev_err(dev, "unknown viommu prop 0x%x\n", type);
> >  		}
> 
> So given this is necessary early in boot, how about we
> add this in the config space? And maybe ACPI too ...

A page_size_mask field is already in the config space and applies to all
endpoints. Here we add a property to override the global value for
individual endpoints. It can be necessary when mixing physical (pass-
through) and virtual endpoints under the same virtio-iommu device.

Thanks,
Jean
