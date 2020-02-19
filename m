From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] vhost: introduce vDPA based backend
Date: Wed, 19 Feb 2020 09:11:02 -0400
Message-ID: <20200219131102.GN31668@ziepe.ca>
References: <20200131033651.103534-1-tiwei.bie@intel.com>
 <20200218135359.GA9608@ziepe.ca>
 <20200219025217.GA971968@___>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200219025217.GA971968@___>
Sender: linux-kernel-owner@vger.kernel.org
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: mst@redhat.com, jasowang@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, shahafs@mellanox.com, rob.miller@broadcom.com, haotian.wang@sifive.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, rdunlap@infradead.org, hch@infradead.org, jiri@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com, maxime.coquelin@redhat.com, lingshan.zhu@intel.com, dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Feb 19, 2020 at 10:52:38AM +0800, Tiwei Bie wrote:
> > > +static int __init vhost_vdpa_init(void)
> > > +{
> > > +	int r;
> > > +
> > > +	idr_init(&vhost_vdpa.idr);
> > > +	mutex_init(&vhost_vdpa.mutex);
> > > +	init_waitqueue_head(&vhost_vdpa.release_q);
> > > +
> > > +	/* /dev/vhost-vdpa/$vdpa_device_index */
> > > +	vhost_vdpa.class = class_create(THIS_MODULE, "vhost-vdpa");
> > > +	if (IS_ERR(vhost_vdpa.class)) {
> > > +		r = PTR_ERR(vhost_vdpa.class);
> > > +		goto err_class;
> > > +	}
> > > +
> > > +	vhost_vdpa.class->devnode = vhost_vdpa_devnode;
> > > +
> > > +	r = alloc_chrdev_region(&vhost_vdpa.devt, 0, MINORMASK + 1,
> > > +				"vhost-vdpa");
> > > +	if (r)
> > > +		goto err_alloc_chrdev;
> > > +
> > > +	cdev_init(&vhost_vdpa.cdev, &vhost_vdpa_fops);
> > > +	r = cdev_add(&vhost_vdpa.cdev, vhost_vdpa.devt, MINORMASK + 1);
> > > +	if (r)
> > > +		goto err_cdev_add;
> > 
> > It is very strange, is the intention to create a single global char
> > dev?
> 
> No. It's to create a per-vdpa char dev named
> vhost-vdpa/$vdpa_device_index in dev.
> 
> I followed the code in VFIO which creates char dev
> vfio/$GROUP dynamically, e.g.:
> 
> https://github.com/torvalds/linux/blob/b1da3acc781c/drivers/vfio/vfio.c#L2164-L2180
> https://github.com/torvalds/linux/blob/b1da3acc781c/drivers/vfio/vfio.c#L373-L387
> https://github.com/torvalds/linux/blob/b1da3acc781c/drivers/vfio/vfio.c#L1553
> 
> Is it something unwanted?

Yes it is unwanted. This is some special pattern for vfio's unique
needs. 

Since this has a struct device for each char dev instance please use
the normal cdev_device_add() driven pattern here, or justify why it
needs to be special like this.

Jason
