From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 3/5] vDPA: introduce vDPA bus
Date: Mon, 20 Jan 2020 16:56:06 -0500
Message-ID: <20200120164916-mutt-send-email-mst@kernel.org>
References: <20200116124231.20253-1-jasowang@redhat.com>
 <20200116124231.20253-4-jasowang@redhat.com>
 <20200116152209.GH20978@mellanox.com>
 <03cfbcc2-fef0-c9d8-0b08-798b2a293b8c@redhat.com>
 <20200117135435.GU20978@mellanox.com>
 <20200120071406-mutt-send-email-mst@kernel.org>
 <20200120175050.GC3891@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200120175050.GC3891@mellanox.com>
Sender: kvm-owner@vger.kernel.org
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: Jason Wang <jasowang@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "tiwei.bie@intel.com" <tiwei.bie@intel.com>, "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>, "cunming.liang@intel.com" <cunming.liang@intel.com>, "zhihong.wang@intel.com" <zhihong.wang@intel.com>, "rob.miller@broadcom.com" <rob.miller@broadcom.com>, "xiao.w.wang@intel.com" <xiao.w.wang@intel.com>, "haotian.wang@sifive.com" <haotian.wang@sifive.com>, "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>, "eperezma@redhat.com" <eperezma@redhat.com>, "lulu@redhat.com" <lulu@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jan 20, 2020 at 05:50:55PM +0000, Jason Gunthorpe wrote:
> On Mon, Jan 20, 2020 at 07:17:26AM -0500, Michael S. Tsirkin wrote:
> > On Fri, Jan 17, 2020 at 01:54:42PM +0000, Jason Gunthorpe wrote:
> > > > 1) "virtio" vs "vhost", I implemented matching method for this in mdev
> > > > series, but it looks unnecessary for vDPA device driver to know about this.
> > > > Anyway we can use sysfs driver bind/unbind to switch drivers
> > > > 2) virtio device id and vendor id. I'm not sure we need this consider the
> > > > two drivers so far (virtio/vhost) are all bus drivers.
> > > 
> > > As we seem to be contemplating some dynamic creation of vdpa devices I
> > > think upon creation time it should be specified what mode they should
> > > run it and then all driver binding and autoloading should happen
> > > automatically. Telling the user to bind/unbind is a very poor
> > > experience.
> > 
> > Maybe but OTOH it's an existing interface. I think we can reasonably
> > start with bind/unbind and then add ability to specify
> > the mode later. bind/unbind come from core so they will be
> > maintained anyway.
> 
> Existing where?

Driver core.

> For vfio? vfio is the only thing I am aware doing
> that, and this is not vfio..
> 
> Jason


vfio is not doing anything. anyone can use a combination
of unbind and driver_override to attach a driver to a device.

It's not a great interface but it's there without any code,
and it will stay there without maintainance overhead
if we later add a nicer one.

-- 
MST
