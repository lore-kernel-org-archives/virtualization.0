From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [EXT] Re: [RFC PATCH v2] iommu/virtio: Use page size bitmap
 supported by endpoint
Date: Thu, 2 Apr 2020 11:24:17 +0200
Message-ID: <20200402092417.GA1176452@myrica>
References: <20200401113804.21616-1-bbhushan2@marvell.com>
 <b75beb74-89ce-fd6a-6207-3c0d7f479215@arm.com>
 <20200401154932.GA1124215@myrica>
 <MWHPR1801MB19667BA1D59590BC3DFD87C7E3C60@MWHPR1801MB1966.namprd18.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <MWHPR1801MB19667BA1D59590BC3DFD87C7E3C60@MWHPR1801MB1966.namprd18.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bharat Bhushan <bbhushan2@marvell.com>
Cc: Robin Murphy <robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>, "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 02, 2020 at 03:53:40AM +0000, Bharat Bhushan wrote:
> > > > +struct virtio_iommu_probe_pgsize_mask {
> > > > +	struct virtio_iommu_probe_property	head;
> > > > +	__u8					reserved[4];
> > > > +	__u64					pgsize_bitmap;
> > 
> > Should be __le64
> 
> Based on" iommu/virtio: Fix sparse warning" patch https://www.spinics.net/lists/linux-virtualization/msg41944.html changed to __u64 (not __le64)

Yes that one was only for the virtio config struct, to play nice with
other devices. We should still use __le for the other structures,
including probe properties.

Thanks,
Jean

> 
> Will keep __le64.
> 
> Thanks
> -Bharat
> 
> > 
> > Thanks,
> > Jean
> > 
> > > > +};
> > > > +
> > > >   #define VIRTIO_IOMMU_RESV_MEM_T_RESERVED	0
> > > >   #define VIRTIO_IOMMU_RESV_MEM_T_MSI		1
> > > >
