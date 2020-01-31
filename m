From: Tiwei Bie <tiwei.bie@intel.com>
Subject: Re: [PATCH] vhost: introduce vDPA based backend
Date: Fri, 31 Jan 2020 13:52:13 +0800
Message-ID: <20200131055213.GA111365@___>
References: <20200131033651.103534-1-tiwei.bie@intel.com>
 <43aeecb4-4c08-df3d-1c1d-699ec4c494bd@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <43aeecb4-4c08-df3d-1c1d-699ec4c494bd@infradead.org>
Sender: netdev-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: mst@redhat.com, jasowang@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, shahafs@mellanox.com, jgg@mellanox.com, rob.miller@broadcom.com, haotian.wang@sifive.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, hch@infradead.org, jiri@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com, maxime.coquelin@redhat.com, lingshan.zhu@intel.com, dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jan 30, 2020 at 07:56:43PM -0800, Randy Dunlap wrote:
> Hi,
> 
> On 1/30/20 7:36 PM, Tiwei Bie wrote:
> > diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> > index f21c45aa5e07..13e6a94d0243 100644
> > --- a/drivers/vhost/Kconfig
> > +++ b/drivers/vhost/Kconfig
> > @@ -34,6 +34,18 @@ config VHOST_VSOCK
> >  	To compile this driver as a module, choose M here: the module will be called
> >  	vhost_vsock.
> >  
> > +config VHOST_VDPA
> > +	tristate "Vhost driver for vDPA based backend"
> > +	depends on EVENTFD && VDPA
> > +	select VHOST
> > +	default n
> > +	---help---
> > +	This kernel module can be loaded in host kernel to accelerate
> > +	guest virtio devices with the vDPA based backends.
> 
> 	                              vDPA-based

Will fix this and other similar ones in the patch. Thanks!

> 
> > +
> > +	To compile this driver as a module, choose M here: the module
> > +	will be called vhost_vdpa.
> > +
> 
> The preferred Kconfig style nowadays is
> (a) use "help" instead of "---help---"
> (b) indent the help text with one tab + 2 spaces
> 
> and don't use "default n" since that is already the default.

Will fix in the next version.

Thanks,
Tiwei

> 
> >  config VHOST
> >  	tristate
> >          depends on VHOST_IOTLB
> 
> thanks.
> -- 
> ~Randy
> 
