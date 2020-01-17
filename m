From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH 4/5] virtio: introduce a vDPA based transport
Date: Fri, 17 Jan 2020 14:00:18 +0000
Message-ID: <20200117140013.GV20978@mellanox.com>
References: <20200116124231.20253-1-jasowang@redhat.com>
 <20200116124231.20253-5-jasowang@redhat.com>
 <20200116153807.GI20978@mellanox.com>
 <8e8aa4b7-4948-5719-9618-e28daffba1a5@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8e8aa4b7-4948-5719-9618-e28daffba1a5@redhat.com>
Content-Language: en-US
Content-ID: <BCEE5E4AAADEB445898F0BB179338629@eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "tiwei.bie@intel.com" <tiwei.bie@intel.com>, "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>, "cunming.liang@intel.com" <cunming.liang@intel.com>, "zhihong.wang@intel.com" <zhihong.wang@intel.com>, "rob.miller@broadcom.com" <rob.miller@broadcom.com>, "xiao.w.wang@intel.com" <xiao.w.wang@intel.com>, "haotian.wang@sifive.com" <haotian.wang@sifive.com>, "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>, "eperezma@redhat.com" <eperezma@redhat.com>, "lulu@redhat.com" <lulu@redhat.co>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jan 17, 2020 at 05:32:35PM +0800, Jason Wang wrote:
> >=20
> > > +	const struct vdpa_config_ops *ops =3D vdpa->config;
> > > +	struct virtio_vdpa_device *vd_dev;
> > > +	int rc;
> > > +
> > > +	vd_dev =3D devm_kzalloc(dev, sizeof(*vd_dev), GFP_KERNEL);
> > > +	if (!vd_dev)
> > > +		return -ENOMEM;
> > This is not right, the struct device lifetime is controled by a kref,
> > not via devm. If you want to use a devm unwind then the unwind is
> > put_device, not devm_kfree.
>=20
> I'm not sure I get the point here. The lifetime is bound to underlying vD=
PA
> device and devres allow to be freed before the vpda device is released. B=
ut
> I agree using devres of underlying vdpa device looks wired.

Once device_initialize is called the only way to free a struct device
is via put_device, while here you have a devm trigger that will
unconditionally do kfree on a struct device without respecting the
reference count.

reference counted memory must never be allocated with devm.

> > > +	vd_dev->vdev.dev.release =3D virtio_vdpa_release_dev;
> > > +	vd_dev->vdev.config =3D &virtio_vdpa_config_ops;
> > > +	vd_dev->vdpa =3D vdpa;
> > > +	INIT_LIST_HEAD(&vd_dev->virtqueues);
> > > +	spin_lock_init(&vd_dev->lock);
> > > +
> > > +	vd_dev->vdev.id.device =3D ops->get_device_id(vdpa);
> > > +	if (vd_dev->vdev.id.device =3D=3D 0)
> > > +		return -ENODEV;
> > > +
> > > +	vd_dev->vdev.id.vendor =3D ops->get_vendor_id(vdpa);
> > > +	rc =3D register_virtio_device(&vd_dev->vdev);
> > > +	if (rc)
> > > +		put_device(dev);
> > And a ugly unwind like this is why you want to have device_initialize()
> > exposed to the driver,
>=20
> In this context, which "driver" did you mean here? (Note, virtio-vdpa is =
the
> driver for vDPA bus here).

'driver' is the thing using the 'core' library calls to implement a
device, so here the 'vd_dev' is the driver and
'register_virtio_device' is the core

> >=20
> > Where is the various THIS_MODULE's I expect to see in a scheme like
> > this?
> >=20
> > All function pointers must be protected by a held module reference
> > count, ie the above probe/remove and all the pointers in ops.
>=20
> Will double check, since I don't see this in other virtio transport drive=
rs
> (PCI or MMIO).

pci_register_driver is a macro that provides a THIS_MODULE, and the
pci core code sets driver.owner, then the rest of the stuff related to
driver ops is supposed to work against that to protect the driver ops.

For the device module refcounting you either need to ensure that
'unregister' is a strong fence and guanentees that no device ops are
called past unregister (noting that this is impossible for release),
or you need to hold the module lock until release.

It is common to see non-core subsystems get this stuff wrong.

Jason
