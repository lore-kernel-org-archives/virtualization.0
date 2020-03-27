From: Bharat Bhushan <bbhushan2-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [EXT] Re: [PATCH v2 3/3] iommu/virtio: Reject IOMMU page granule
 larger than PAGE_SIZE
Date: Fri, 27 Mar 2020 05:48:52 +0000
Message-ID: <MWHPR1801MB19666FB2B5F81924E565FA89E3CC0@MWHPR1801MB1966.namprd18.prod.outlook.com>
References: <20200326093558.2641019-1-jean-philippe@linaro.org>
 <20200326093558.2641019-4-jean-philippe@linaro.org>
 <04ed8a3e-5602-1a5f-1fa3-ac517fede0b1@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <04ed8a3e-5602-1a5f-1fa3-ac517fede0b1-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
To: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jean-Philippe Brucker <jean-philippe-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: "mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Jean,

> -----Original Message-----
> From: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Sent: Thursday, March 26, 2020 11:11 PM
> To: Jean-Philippe Brucker <jean-philippe-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>; iommu-cunTk1MwBs/ROKNJybVBZg@public.gmane.org
> foundation.org
> Cc: virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org;
> jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; Bharat Bhushan <bbhushan2-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> Subject: [EXT] Re: [PATCH v2 3/3] iommu/virtio: Reject IOMMU page granule larger
> than PAGE_SIZE
> 
> External Email
> 
> ----------------------------------------------------------------------
> Hi Jean,
> 
> On 3/26/20 10:35 AM, Jean-Philippe Brucker wrote:
> > We don't currently support IOMMUs with a page granule larger than the
> > system page size. The IOVA allocator has a BUG_ON() in this case, and
> > VFIO has a WARN_ON().
> >
> > Removing these obstacles ranges doesn't seem possible without major
> > changes to the DMA API and VFIO. Some callers of iommu_map(), for
> > example, want to map multiple page-aligned regions adjacent to each
> > others for scatter-gather purposes. Even in simple DMA API uses, a
> > call to dma_map_page() would let the endpoint access neighbouring
> > memory. And VFIO users cannot ensure that their virtual address buffer
> > is physically contiguous at the IOMMU granule.
> >
> > Rather than triggering the IOVA BUG_ON() on mismatched page sizes,
> > abort the vdomain finalise() with an error message. We could simply
> > abort the viommu probe(), but an upcoming extension to virtio-iommu
> > will allow setting different page masks for each endpoint.
> >
> > Reported-by: Bharat Bhushan <bbhushan2-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Reviewed-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Reviewed-by: Eric Auger <bbhushan2-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

Thanks
-Bharat

> 
> Thanks
> 
> Eric
> > ---
> > v1->v2: Move to vdomain_finalise(), improve commit message
> > ---
> >  drivers/iommu/virtio-iommu.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iommu/virtio-iommu.c
> > b/drivers/iommu/virtio-iommu.c index 5eed75cd121f..750f69c49b95 100644
> > --- a/drivers/iommu/virtio-iommu.c
> > +++ b/drivers/iommu/virtio-iommu.c
> > @@ -607,12 +607,22 @@ static struct iommu_domain
> *viommu_domain_alloc(unsigned type)
> >  	return &vdomain->domain;
> >  }
> >
> > -static int viommu_domain_finalise(struct viommu_dev *viommu,
> > +static int viommu_domain_finalise(struct viommu_endpoint *vdev,
> >  				  struct iommu_domain *domain)
> >  {
> >  	int ret;
> > +	unsigned long viommu_page_size;
> > +	struct viommu_dev *viommu = vdev->viommu;
> >  	struct viommu_domain *vdomain = to_viommu_domain(domain);
> >
> > +	viommu_page_size = 1UL << __ffs(viommu->pgsize_bitmap);
> > +	if (viommu_page_size > PAGE_SIZE) {
> > +		dev_err(vdev->dev,
> > +			"granule 0x%lx larger than system page size 0x%lx\n",
> > +			viommu_page_size, PAGE_SIZE);
> > +		return -EINVAL;
> > +	}
> > +
> >  	ret = ida_alloc_range(&viommu->domain_ids, viommu->first_domain,
> >  			      viommu->last_domain, GFP_KERNEL);
> >  	if (ret < 0)
> > @@ -659,7 +669,7 @@ static int viommu_attach_dev(struct iommu_domain
> *domain, struct device *dev)
> >  		 * Properly initialize the domain now that we know which viommu
> >  		 * owns it.
> >  		 */
> > -		ret = viommu_domain_finalise(vdev->viommu, domain);
> > +		ret = viommu_domain_finalise(vdev, domain);
> >  	} else if (vdomain->viommu != vdev->viommu) {
> >  		dev_err(dev, "cannot attach to foreign vIOMMU\n");
> >  		ret = -EXDEV;
> >
