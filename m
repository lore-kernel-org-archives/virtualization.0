From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [EXT] Re: [PATCH v5] iommu/virtio: Use page size bitmap
 supported by endpoint
Date: Wed, 13 May 2020 12:45:37 +0200
Message-ID: <20200513104537.GB214296@myrica>
References: <20200505093004.1935-1-bbhushan2@marvell.com>
 <20200505200659-mutt-send-email-mst@kernel.org>
 <MWHPR1801MB1966A23A0298654CA6965FB9E3BF0@MWHPR1801MB1966.namprd18.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <MWHPR1801MB1966A23A0298654CA6965FB9E3BF0@MWHPR1801MB1966.namprd18.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bharat Bhushan <bbhushan2@marvell.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "joro@8bytes.org" <joro@8bytes.org>, "jasowang@redhat.com" <jasowang@redhat.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 13, 2020 at 09:15:22AM +0000, Bharat Bhushan wrote:
> Hi Jean,
> 
> > -----Original Message-----
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, May 6, 2020 5:53 AM
> > To: Bharat Bhushan <bbhushan2@marvell.com>
> > Cc: jean-philippe@linaro.org; joro@8bytes.org; jasowang@redhat.com;
> > virtualization@lists.linux-foundation.org; iommu@lists.linux-foundation.org;
> > linux-kernel@vger.kernel.org; eric.auger.pro@gmail.com; eric.auger@redhat.com
> > Subject: [EXT] Re: [PATCH v5] iommu/virtio: Use page size bitmap supported by
> > endpoint
[...]
> > > +struct virtio_iommu_probe_pgsize_mask {
> > > +	struct virtio_iommu_probe_property	head;
> > > +	__u8					reserved[4];
> > > +	__le64					pgsize_bitmap;
> > > +};
> > > +
> > 
> > This is UAPI. Document the format of pgsize_bitmap please.
> 
> I do not see uapi documentation in "Documentation" folder of other data struct in this file, am I missing something?

I'm not the one requesting this change, but I'm guessing you should add a
comment in this header, above pgsize_bitmap (which should actually be
called page_size_mask to follow the spec). I guess I'd add:

/* Same format as virtio_iommu_config::page_size_mask */

for this field, and then maybe change the comment of virtio_iommu_config,
currently "/* Supported page sizes */", to something more precise such as:

/*
 * Bitmap of supported page sizes. The least significant bit indicates the
 * smallest granularity and the other bits are hints indicating optimal
 * block sizes.
 */

But I don't know how much should be spelled out here, since those details
are available in the spec.

Thanks,
Jean
