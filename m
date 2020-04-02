From: Bharat Bhushan <bbhushan2-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [EXT] Re: [RFC PATCH v2] iommu/virtio: Use page size bitmap
 supported by endpoint
Date: Thu, 2 Apr 2020 03:53:40 +0000
Message-ID: <MWHPR1801MB19667BA1D59590BC3DFD87C7E3C60@MWHPR1801MB1966.namprd18.prod.outlook.com>
References: <20200401113804.21616-1-bbhushan2@marvell.com>
 <b75beb74-89ce-fd6a-6207-3c0d7f479215@arm.com>
 <20200401154932.GA1124215@myrica>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20200401154932.GA1124215@myrica>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Sender: "iommu" <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
To: Jean-Philippe Brucker <jean-philippe-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: "mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Jean-Philippe Brucker <jean-philippe-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Sent: Wednesday, April 1, 2020 9:20 PM
> To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> Cc: Bharat Bhushan <bbhushan2-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org;
> mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; virtualization-cunTk1MwBs/ROKNJybVBZg@public.gmane.org
> foundation.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> Subject: [EXT] Re: [RFC PATCH v2] iommu/virtio: Use page size bitmap supported by
> endpoint
> 
> External Email
> 
> ----------------------------------------------------------------------
> On Wed, Apr 01, 2020 at 02:00:13PM +0100, Robin Murphy wrote:
> > On 2020-04-01 12:38 pm, Bharat Bhushan wrote:
> > > Different endpoint can support different page size, probe endpoint
> > > if it supports specific page size otherwise use global page sizes.
> > >
> > > Signed-off-by: Bharat Bhushan <bbhushan2-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> > > ---
> > >   drivers/iommu/virtio-iommu.c      | 33 +++++++++++++++++++++++++++----
> > >   include/uapi/linux/virtio_iommu.h |  7 +++++++
> > >   2 files changed, 36 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/iommu/virtio-iommu.c
> > > b/drivers/iommu/virtio-iommu.c index cce329d71fba..c794cb5b7b3e
> > > 100644
> > > --- a/drivers/iommu/virtio-iommu.c
> > > +++ b/drivers/iommu/virtio-iommu.c
> > > @@ -78,6 +78,7 @@ struct viommu_endpoint {
> > >   	struct viommu_dev		*viommu;
> > >   	struct viommu_domain		*vdomain;
> > >   	struct list_head		resv_regions;
> > > +	u64				pgsize_bitmap;
> > >   };
> > >   struct viommu_request {
> > > @@ -415,6 +416,20 @@ static int viommu_replay_mappings(struct
> viommu_domain *vdomain)
> > >   	return ret;
> > >   }
> > > +static int viommu_set_pgsize_bitmap(struct viommu_endpoint *vdev,
> > > +				    struct virtio_iommu_probe_pgsize_mask *mask,
> > > +				    size_t len)
> > > +
> > > +{
> > > +	u64 pgsize_bitmap = le64_to_cpu(mask->pgsize_bitmap);
> > > +
> > > +	if (len < sizeof(*mask))
> > > +		return -EINVAL;
> > > +
> > > +	vdev->pgsize_bitmap = pgsize_bitmap;
> > > +	return 0;
> > > +}
> > > +
> > >   static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
> > >   			       struct virtio_iommu_probe_resv_mem *mem,
> > >   			       size_t len)
> > > @@ -494,11 +509,13 @@ static int viommu_probe_endpoint(struct
> viommu_dev *viommu, struct device *dev)
> > >   	while (type != VIRTIO_IOMMU_PROBE_T_NONE &&
> > >   	       cur < viommu->probe_size) {
> > >   		len = le16_to_cpu(prop->length) + sizeof(*prop);
> > > -
> 
> Whitespace change
> 
> > >   		switch (type) {
> > >   		case VIRTIO_IOMMU_PROBE_T_RESV_MEM:
> > >   			ret = viommu_add_resv_mem(vdev, (void *)prop, len);
> > >   			break;
> > > +		case VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK:
> > > +			ret = viommu_set_pgsize_bitmap(vdev, (void *)prop, len);
> > > +			break;
> > >   		default:
> > >   			dev_err(dev, "unknown viommu prop 0x%x\n", type);
> > >   		}
> > > @@ -607,16 +624,23 @@ static struct iommu_domain
> *viommu_domain_alloc(unsigned type)
> > >   	return &vdomain->domain;
> > >   }
> > > -static int viommu_domain_finalise(struct viommu_dev *viommu,
> > > +static int viommu_domain_finalise(struct viommu_endpoint *vdev,
> > >   				  struct iommu_domain *domain)
> > >   {
> > >   	int ret;
> > >   	struct viommu_domain *vdomain = to_viommu_domain(domain);
> > > +	struct viommu_dev *viommu = vdev->viommu;
> > >   	vdomain->viommu		= viommu;
> > >   	vdomain->map_flags	= viommu->map_flags;
> > > -	domain->pgsize_bitmap	= viommu->pgsize_bitmap;
> > > +	/* Devices in same domain must support same size pages */
> >
> > AFAICS what the code appears to do is enforce that the first endpoint
> > attached to any domain has the same pgsize_bitmap as the most recently
> > probed viommu_dev instance, then ignore any subsequent endpoints
> > attached to the same domain. Thus I'm not sure that comment is accurate.
> >
> 
> Yes viommu_domain_finalise() is only called once. What I had in mind is
> something like:

Ohh, I did not realized that viommu_domain_finalise().
I have included below suggested changes

> 
> ---- 8< ----
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c index
> 750f69c49b95..8303b7b513ff 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -639,6 +639,29 @@ static int viommu_domain_finalise(struct
> viommu_endpoint *vdev,
>  	return 0;
>  }
> 
> +/*
> + * Check whether the endpoint's capabilities are compatible with other
> +endpoints
> + * in the domain. Report any inconsistency.
> + */
> +static bool viommu_endpoint_is_compatible(struct viommu_endpoint *vdev,
> +					  struct viommu_domain *vdomain)
> +{
> +	struct device *dev = vdev->dev;
> +
> +	if (vdomain->viommu != vdev->viommu) {
> +		dev_err(dev, "cannot attach to foreign vIOMMU\n");
> +		return false;
> +	}
> +
> +	if (vdomain->domain.pgsize_bitmap != vdev->pgsize_bitmap) {
> +		dev_err(dev, "incompatible domain bitmap 0x%lx != 0x%lx\n",
> +			vdomain->domain.pgsize_bitmap, vdev->pgsize_bitmap);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
>  static void viommu_domain_free(struct iommu_domain *domain)  {
>  	struct viommu_domain *vdomain = to_viommu_domain(domain); @@ -
> 670,9 +693,8 @@ static int viommu_attach_dev(struct iommu_domain *domain,
> struct device *dev)
>  		 * owns it.
>  		 */
>  		ret = viommu_domain_finalise(vdev, domain);
> -	} else if (vdomain->viommu != vdev->viommu) {
> -		dev_err(dev, "cannot attach to foreign vIOMMU\n");
> -		ret = -EXDEV;
> +	} else if (!viommu_endpoint_is_compatible(vdev, vdomain)) {
> +		ret = -EINVAL;
>  	}
>  	mutex_unlock(&vdomain->mutex);
> ---- >8 ----
> 
> >
> > > +	if ((domain->pgsize_bitmap != viommu->pgsize_bitmap) &&
> > > +	    (domain->pgsize_bitmap != vdev->pgsize_bitmap))
> > > +		return -EINVAL;
> > > +
> > > +	domain->pgsize_bitmap = vdev->pgsize_bitmap;
> > > +
> > >   	domain->geometry	= viommu->geometry;
> > >   	ret = ida_alloc_range(&viommu->domain_ids, viommu->first_domain,
> > > @@ -657,7 +681,7 @@ static int viommu_attach_dev(struct iommu_domain
> *domain, struct device *dev)
> > >   		 * Properly initialize the domain now that we know which viommu
> > >   		 * owns it.
> > >   		 */
> > > -		ret = viommu_domain_finalise(vdev->viommu, domain);
> > > +		ret = viommu_domain_finalise(vdev, domain);
> > >   	} else if (vdomain->viommu != vdev->viommu) {
> > >   		dev_err(dev, "cannot attach to foreign vIOMMU\n");
> > >   		ret = -EXDEV;
> > > @@ -875,6 +899,7 @@ static int viommu_add_device(struct device *dev)
> > >   	vdev->dev = dev;
> > >   	vdev->viommu = viommu;
> > > +	vdev->pgsize_bitmap = viommu->pgsize_bitmap;
> > >   	INIT_LIST_HEAD(&vdev->resv_regions);
> > >   	fwspec->iommu_priv = vdev;
> > > diff --git a/include/uapi/linux/virtio_iommu.h
> > > b/include/uapi/linux/virtio_iommu.h
> > > index 237e36a280cb..dc9d3f40bcd8 100644
> > > --- a/include/uapi/linux/virtio_iommu.h
> > > +++ b/include/uapi/linux/virtio_iommu.h
> > > @@ -111,6 +111,7 @@ struct virtio_iommu_req_unmap {
> > >   #define VIRTIO_IOMMU_PROBE_T_NONE		0
> > >   #define VIRTIO_IOMMU_PROBE_T_RESV_MEM		1
> > > +#define VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK	2
> > >   #define VIRTIO_IOMMU_PROBE_T_MASK		0xfff
> > > @@ -119,6 +120,12 @@ struct virtio_iommu_probe_property {
> > >   	__le16					length;
> > >   };
> > > +struct virtio_iommu_probe_pgsize_mask {
> > > +	struct virtio_iommu_probe_property	head;
> > > +	__u8					reserved[4];
> > > +	__u64					pgsize_bitmap;
> 
> Should be __le64

Based on" iommu/virtio: Fix sparse warning" patch https://www.spinics.net/lists/linux-virtualization/msg41944.html changed to __u64 (not __le64)

Will keep __le64.

Thanks
-Bharat

> 
> Thanks,
> Jean
> 
> > > +};
> > > +
> > >   #define VIRTIO_IOMMU_RESV_MEM_T_RESERVED	0
> > >   #define VIRTIO_IOMMU_RESV_MEM_T_MSI		1
> > >
