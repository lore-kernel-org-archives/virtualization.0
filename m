From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [EXT] Re: [PATCH RFC] iommu/virtio: Use page size bitmap
 supported by endpoint
Date: Tue, 24 Mar 2020 07:48:11 +0100
Message-ID: <20200324064811.GA2173442@myrica>
References: <20200323084108.1721-1-bbhushan2@marvell.com>
 <20200323095943.GA2038940@myrica>
 <MWHPR1801MB1966865A8DE5AB8FFFAEC85FE3F00@MWHPR1801MB1966.namprd18.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <MWHPR1801MB1966865A8DE5AB8FFFAEC85FE3F00@MWHPR1801MB1966.namprd18.prod.outlook.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Bharat Bhushan <bbhushan2@marvell.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "joro@8bytes.org" <joro@8bytes.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Mar 23, 2020 at 06:04:37PM +0000, Bharat Bhushan wrote:
> > > -static int viommu_domain_finalise(struct viommu_dev *viommu,
> > > +static int viommu_domain_finalise(struct viommu_endpoint *vdev,
> > >  				  struct iommu_domain *domain)
> > >  {
> > >  	int ret;
> > >  	struct viommu_domain *vdomain = to_viommu_domain(domain);
> > > +	struct viommu_dev *viommu = vdev->viommu;
> > >
> > >  	vdomain->viommu		= viommu;
> > >  	vdomain->map_flags	= viommu->map_flags;
> > >
> > > -	domain->pgsize_bitmap	= viommu->pgsize_bitmap;
> > > +	if (vdev->pgsize_bitmap)
> > > +		domain->pgsize_bitmap = vdev->pgsize_bitmap;
> > > +	else
> > > +		domain->pgsize_bitmap	= viommu->pgsize_bitmap;
> > > +
> > 
> > nit: it could be nicer to initialize vdev->pgsize_bitmap in add_device(),
> 
> To what size we should initialize in add_device, PAGE_SIZE?

No to viommu->pgsize_bitmap

Thanks,
Jean
