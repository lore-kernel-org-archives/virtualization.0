From: Bharat Bhushan <bbhushan2-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [EXT] Re: [PATCH RFC] iommu/virtio: Use page size bitmap
 supported by endpoint
Date: Mon, 23 Mar 2020 17:25:17 +0000
Message-ID: <MWHPR1801MB196689B3880CD9316942A2B8E3F00@MWHPR1801MB1966.namprd18.prod.outlook.com>
References: <20200323084108.1721-1-bbhushan2@marvell.com>
 <20200323095943.GA2038940@myrica>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20200323095943.GA2038940@myrica>
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
To: Jean-Philippe Brucker <jean-philippe-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Jean,

> -----Original Message-----
> From: Jean-Philippe Brucker <jean-philippe-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Sent: Monday, March 23, 2020 3:30 PM
> To: Bharat Bhushan <bbhushan2-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org;
> virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org;
> eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> Subject: [EXT] Re: [PATCH RFC] iommu/virtio: Use page size bitmap supported by
> endpoint
> 
> External Email
> 
> ----------------------------------------------------------------------
> Hi Bharat,
> 
> Please add the IOMMU list on your next posting

iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org is there, any other mailing list we need to add?

> 
> On Mon, Mar 23, 2020 at 02:11:08PM +0530, Bharat Bhushan wrote:
> > Different endpoint can support different page size, probe endpoint if
> > it supports specific page size otherwise use global page sizes.
> >
> > Signed-off-by: Bharat Bhushan <bbhushan2-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> > ---
> >  drivers/iommu/virtio-iommu.c      | 24 ++++++++++++++++++++----
> >  include/uapi/linux/virtio_iommu.h |  6 ++++++
> >  2 files changed, 26 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/iommu/virtio-iommu.c
> > b/drivers/iommu/virtio-iommu.c index cce329d71fba..e69347ca4ee6 100644
> > --- a/drivers/iommu/virtio-iommu.c
> > +++ b/drivers/iommu/virtio-iommu.c
> > @@ -78,6 +78,7 @@ struct viommu_endpoint {
> >  	struct viommu_dev		*viommu;
> >  	struct viommu_domain		*vdomain;
> >  	struct list_head		resv_regions;
> > +	u64				pgsize_bitmap;
> >  };
> >
> >  struct viommu_request {
> > @@ -415,6 +416,14 @@ static int viommu_replay_mappings(struct
> viommu_domain *vdomain)
> >  	return ret;
> >  }
> >
> > +static int viommu_set_pgsize_bitmap(struct viommu_endpoint *vdev,
> > +				    struct virtio_iommu_probe_pgsize_mask *mask)
> > +
> > +{
> > +	vdev->pgsize_bitmap = mask->pgsize_bitmap;
> 
> We need to read this through le64_to_cpu(). Also check that the length of the field
> provided by the device is >= sizeof(mask) (like
> viommu_add_resv_mem() does)

Will take care of all the comments in next verions

Thank
-Bharat

> 
> > +	return 0;
> > +}
> > +
> >  static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
> >  			       struct virtio_iommu_probe_resv_mem *mem,
> >  			       size_t len)
> > @@ -494,11 +503,13 @@ static int viommu_probe_endpoint(struct viommu_dev
> *viommu, struct device *dev)
> >  	while (type != VIRTIO_IOMMU_PROBE_T_NONE &&
> >  	       cur < viommu->probe_size) {
> >  		len = le16_to_cpu(prop->length) + sizeof(*prop);
> > -
> >  		switch (type) {
> >  		case VIRTIO_IOMMU_PROBE_T_RESV_MEM:
> >  			ret = viommu_add_resv_mem(vdev, (void *)prop, len);
> >  			break;
> > +		case VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK:
> > +			ret = viommu_set_pgsize_bitmap(vdev, (void *)prop);
> > +			break;
> >  		default:
> >  			dev_err(dev, "unknown viommu prop 0x%x\n", type);
> >  		}
> > @@ -607,16 +618,21 @@ static struct iommu_domain
> *viommu_domain_alloc(unsigned type)
> >  	return &vdomain->domain;
> >  }
> >
> > -static int viommu_domain_finalise(struct viommu_dev *viommu,
> > +static int viommu_domain_finalise(struct viommu_endpoint *vdev,
> >  				  struct iommu_domain *domain)
> >  {
> >  	int ret;
> >  	struct viommu_domain *vdomain = to_viommu_domain(domain);
> > +	struct viommu_dev *viommu = vdev->viommu;
> >
> >  	vdomain->viommu		= viommu;
> >  	vdomain->map_flags	= viommu->map_flags;
> >
> > -	domain->pgsize_bitmap	= viommu->pgsize_bitmap;
> > +	if (vdev->pgsize_bitmap)
> > +		domain->pgsize_bitmap = vdev->pgsize_bitmap;
> > +	else
> > +		domain->pgsize_bitmap	= viommu->pgsize_bitmap;
> > +
> 
> nit: it could be nicer to initialize vdev->pgsize_bitmap in add_device(), override it
> in probe_endpoint(), and just copy it here.
> 
> >  	domain->geometry	= viommu->geometry;
> >
> >  	ret = ida_alloc_range(&viommu->domain_ids, viommu->first_domain, @@
> > -657,7 +673,7 @@ static int viommu_attach_dev(struct iommu_domain
> *domain, struct device *dev)
> >  		 * Properly initialize the domain now that we know which viommu
> >  		 * owns it.
> >  		 */
> > -		ret = viommu_domain_finalise(vdev->viommu, domain);
> > +		ret = viommu_domain_finalise(vdev, domain);
> 
> Attaching additional endpoints with different masks to the domain should return
> an error
> 
> >  	} else if (vdomain->viommu != vdev->viommu) {
> >  		dev_err(dev, "cannot attach to foreign vIOMMU\n");
> >  		ret = -EXDEV;
> > diff --git a/include/uapi/linux/virtio_iommu.h
> > b/include/uapi/linux/virtio_iommu.h
> > index 237e36a280cb..aff3db0ef54b 100644
> > --- a/include/uapi/linux/virtio_iommu.h
> > +++ b/include/uapi/linux/virtio_iommu.h
> > @@ -111,6 +111,7 @@ struct virtio_iommu_req_unmap {
> >
> >  #define VIRTIO_IOMMU_PROBE_T_NONE		0
> >  #define VIRTIO_IOMMU_PROBE_T_RESV_MEM		1
> > +#define VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK	2
> >
> >  #define VIRTIO_IOMMU_PROBE_T_MASK		0xfff
> >
> > @@ -119,6 +120,11 @@ struct virtio_iommu_probe_property {
> >  	__le16					length;
> >  };
> >
> > +struct virtio_iommu_probe_pgsize_mask {
> > +	struct virtio_iommu_probe_property	head;
> 
> Compilers will introduce 4 bytes of padding here, to align the next field.
> We need to make them explicit by adding a 4-bytes 'reserved' field.
> 
> > +	uint64_t				pgsize_bitmap;
> 
> __le64
> 
> Thanks,
> Jean
> 
> > +};
> > +
> >  #define VIRTIO_IOMMU_RESV_MEM_T_RESERVED	0
> >  #define VIRTIO_IOMMU_RESV_MEM_T_MSI		1
> >
> > --
> > 2.17.1
> >
