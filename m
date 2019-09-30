From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH V2 6/8] mdev: introduce virtio device and its device ops
Date: Mon, 30 Sep 2019 15:36:01 -0600
Message-ID: <20190930153601.31e29f7e__31111.2095763505$1569879425$gmane$org@x1.home>
References: <20190924135332.14160-1-jasowang@redhat.com>
	<20190924135332.14160-7-jasowang@redhat.com>
	<20190924170640.1da03bae@x1.home>
	<AM0PR05MB48662BA1D397D74DF4F5B9AFD1810@AM0PR05MB4866.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <AM0PR05MB48662BA1D397D74DF4F5B9AFD1810@AM0PR05MB4866.eurprd05.prod.outlook.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Parav Pandit <parav@mellanox.com>
Cc: "christophe.de.dinechin@gmail.com" <christophe.de.dinechin@gmail.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "airlied@linux.ie" <airlied@linux.ie>, "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "rob.miller@broadcom.com" <rob.miller@broadcom.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "sebott@linux.ibm.com" <sebott@linux.ibm.com>, "lulu@redhat.com" <lulu@redhat.com>, "eperezma@redhat.com" <eperezma@redhat.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, haotian.wang@sifive.c
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 27 Sep 2019 16:25:13 +0000
Parav Pandit <parav@mellanox.com> wrote:

> Hi Alex,
> 
> 
> > -----Original Message-----
> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Tuesday, September 24, 2019 6:07 PM
> > To: Jason Wang <jasowang@redhat.com>
> > Cc: kvm@vger.kernel.org; linux-s390@vger.kernel.org; linux-
> > kernel@vger.kernel.org; dri-devel@lists.freedesktop.org; intel-
> > gfx@lists.freedesktop.org; intel-gvt-dev@lists.freedesktop.org;
> > kwankhede@nvidia.com; mst@redhat.com; tiwei.bie@intel.com;
> > virtualization@lists.linux-foundation.org; netdev@vger.kernel.org;
> > cohuck@redhat.com; maxime.coquelin@redhat.com;
> > cunming.liang@intel.com; zhihong.wang@intel.com;
> > rob.miller@broadcom.com; xiao.w.wang@intel.com;
> > haotian.wang@sifive.com; zhenyuw@linux.intel.com; zhi.a.wang@intel.com;
> > jani.nikula@linux.intel.com; joonas.lahtinen@linux.intel.com;
> > rodrigo.vivi@intel.com; airlied@linux.ie; daniel@ffwll.ch;
> > farman@linux.ibm.com; pasic@linux.ibm.com; sebott@linux.ibm.com;
> > oberpar@linux.ibm.com; heiko.carstens@de.ibm.com; gor@linux.ibm.com;
> > borntraeger@de.ibm.com; akrowiak@linux.ibm.com; freude@linux.ibm.com;
> > lingshan.zhu@intel.com; Ido Shamay <idos@mellanox.com>;
> > eperezma@redhat.com; lulu@redhat.com; Parav Pandit
> > <parav@mellanox.com>; christophe.de.dinechin@gmail.com;
> > kevin.tian@intel.com
> > Subject: Re: [PATCH V2 6/8] mdev: introduce virtio device and its device ops
> > 
> > On Tue, 24 Sep 2019 21:53:30 +0800
> > Jason Wang <jasowang@redhat.com> wrote:
> >   
> > > This patch implements basic support for mdev driver that supports
> > > virtio transport for kernel virtio driver.
> > >
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >  include/linux/mdev.h        |   2 +
> > >  include/linux/virtio_mdev.h | 145
> > > ++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 147 insertions(+)
> > >  create mode 100644 include/linux/virtio_mdev.h
> > >
> > > diff --git a/include/linux/mdev.h b/include/linux/mdev.h index
> > > 3414307311f1..73ac27b3b868 100644
> > > --- a/include/linux/mdev.h
> > > +++ b/include/linux/mdev.h
> > > @@ -126,6 +126,8 @@ struct mdev_device *mdev_from_dev(struct device
> > > *dev);
> > >
> > >  enum {
> > >  	MDEV_ID_VFIO = 1,
> > > +	MDEV_ID_VIRTIO = 2,
> > > +	MDEV_ID_VHOST = 3,  
> > 
> > MDEV_ID_VHOST isn't used yet here.  Also, given the strong interdependence
> > between the class_id and the ops structure, we might wand to define them in
> > the same place.  Thanks,
> >   
> 
> When mlx5_core creates mdevs (parent->ops->create() and it wants to
> bind to mlx5 mdev driver (which does mdev_register_driver()), mlx5
> core driver will publish MDEV_ID_MLX5_NET defined in central place as
> include/linux/mdev.h without any ops structure. Because such ops are
> not relevant. It uses usual, standard ops probe() remove() on the
> mdev (similar to a regular PCI device). So for VHOST case ops may be
> closely related to ID, but not for other type of ID.
> 
> Just want to make sure, that scope of ID covers this case.

AIUI, these device-ops are primarily meant to have 1:N multiplexing of
the mdev bus driver.  One mdev bus driver supports N vendor drivers via
a common "protocol" defined by this structure.  vfio-mdev supports
GVT-g, GRID, and several sample drivers.  I think Jason and Tiwei are
attempting something similar if we have multiple vendors that may
provide virtio/vhost parent drivers.  If you have a 1:1 model with
mlx5 where you're not trying to abstract a common channel between the
mdev bus driver and the mdev vendor driver, then I suppose you might
not use the device-ops capabilities of the mdev-core.  Did I interpret
the question correctly?  I think that's probably fine, mdev-core
shouldn't have any dependencies on the device-ops and we shouldn't
really be dictating the bus/vendor link through mdev.  Thanks,

Alex
