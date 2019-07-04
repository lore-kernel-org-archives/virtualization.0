From: Tiwei Bie <tiwei.bie@intel.com>
Subject: Re: [RFC v2] vhost: introduce mdev based hardware vhost backend
Date: Thu, 4 Jul 2019 09:36:36 +0800
Message-ID: <20190704013636.GA26992__18056.0366877884$1562204303$gmane$org@___>
References: <20190703091339.1847-1-tiwei.bie@intel.com>
	<20190703123157.2452bf95@x1.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190703123157.2452bf95@x1.home>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, maxime.coquelin@redhat.com, zhihong.wang@intel.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 03, 2019 at 12:31:57PM -0600, Alex Williamson wrote:
> On Wed,  3 Jul 2019 17:13:39 +0800
> Tiwei Bie <tiwei.bie@intel.com> wrote:
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index 8f10748dac79..6c5718ab7eeb 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -201,6 +201,7 @@ struct vfio_device_info {
> >  #define VFIO_DEVICE_FLAGS_AMBA  (1 << 3)	/* vfio-amba device */
> >  #define VFIO_DEVICE_FLAGS_CCW	(1 << 4)	/* vfio-ccw device */
> >  #define VFIO_DEVICE_FLAGS_AP	(1 << 5)	/* vfio-ap device */
> > +#define VFIO_DEVICE_FLAGS_VHOST	(1 << 6)	/* vfio-vhost device */
> >  	__u32	num_regions;	/* Max region index + 1 */
> >  	__u32	num_irqs;	/* Max IRQ index + 1 */
> >  };
> > @@ -217,6 +218,7 @@ struct vfio_device_info {
> >  #define VFIO_DEVICE_API_AMBA_STRING		"vfio-amba"
> >  #define VFIO_DEVICE_API_CCW_STRING		"vfio-ccw"
> >  #define VFIO_DEVICE_API_AP_STRING		"vfio-ap"
> > +#define VFIO_DEVICE_API_VHOST_STRING		"vfio-vhost"
> >  
> >  /**
> >   * VFIO_DEVICE_GET_REGION_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 8,
> > @@ -573,6 +575,23 @@ enum {
> >  	VFIO_CCW_NUM_IRQS
> >  };
> >  
> > +/*
> > + * The vfio-vhost bus driver makes use of the following fixed region and
> > + * IRQ index mapping. Unimplemented regions return a size of zero.
> > + * Unimplemented IRQ types return a count of zero.
> > + */
> > +
> > +enum {
> > +	VFIO_VHOST_CONFIG_REGION_INDEX,
> > +	VFIO_VHOST_NOTIFY_REGION_INDEX,
> > +	VFIO_VHOST_NUM_REGIONS
> > +};
> > +
> > +enum {
> > +	VFIO_VHOST_VQ_IRQ_INDEX,
> > +	VFIO_VHOST_NUM_IRQS
> > +};
> > +
> 
> Note that the vfio API has evolved a bit since vfio-pci started this
> way, with fixed indexes for pre-defined region types.  We now support
> device specific regions which can be identified by a capability within
> the REGION_INFO ioctl return data.  This allows a bit more flexibility,
> at the cost of complexity, but the infrastructure already exists in
> kernel and QEMU to make it relatively easy.  I think we'll have the
> same support for interrupts soon too.  If you continue to pursue the
> vfio-vhost direction you might want to consider these before committing
> to fixed indexes.  Thanks,

Thanks for the details! Will give it a try!

Thanks,
Tiwei
