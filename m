From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 3/5] vDPA: introduce vDPA bus
Date: Tue, 21 Jan 2020 09:16:02 -0500
Message-ID: <20200121091540-mutt-send-email-mst@kernel.org>
References: <20200116124231.20253-4-jasowang@redhat.com>
 <20200117070324-mutt-send-email-mst@kernel.org>
 <239b042c-2d9e-0eec-a1ef-b03b7e2c5419@redhat.com>
 <CAJPjb1+fG9L3=iKbV4Vn13VwaeDZZdcfBPvarogF_Nzhk+FnKg@mail.gmail.com>
 <AM0PR0502MB379553984D0D55FDE25426F6C3330@AM0PR0502MB3795.eurprd05.prod.outlook.com>
 <d69918ca-8af4-44b2-9652-633530d4c113@redhat.com>
 <20200120174933.GB3891@mellanox.com>
 <AM0PR0502MB3795C92485338180FC8059CFC3320@AM0PR0502MB3795.eurprd05.prod.outlook.com>
 <20200120162449-mutt-send-email-mst@kernel.org>
 <20200121140755.GB12330@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200121140755.GB12330@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: Shahaf Shuler <shahafs@mellanox.com>, Jason Wang <jasowang@redhat.com>, Rob Miller <rob.miller@broadcom.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Netdev <netdev@vger.kernel.org>, "Bie, Tiwei" <tiwei.bie@intel.com>, "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>, "Liang, Cunming" <cunming.liang@intel.com>, "Wang, Zhihong" <zhihong.wang@intel.com>, "Wang, Xiao W" <xiao.w.wang@intel.com>, "haotian.wang@sifive.com" <haotian.wang@sifive.com>, "Zhu, Lingshan" <lingshan.zhu@intel.com>, "eperezma@redhat.com" <eperezma@redhat.com>, "lulu@redhat.com" <lulu@redhat.com>, Parav Pandit <parav@m>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 21, 2020 at 02:07:59PM +0000, Jason Gunthorpe wrote:
> On Mon, Jan 20, 2020 at 04:25:23PM -0500, Michael S. Tsirkin wrote:
> > On Mon, Jan 20, 2020 at 08:51:43PM +0000, Shahaf Shuler wrote:
> > > Monday, January 20, 2020 7:50 PM, Jason Gunthorpe:
> > > > Subject: Re: [PATCH 3/5] vDPA: introduce vDPA bus
> > > > 
> > > > On Mon, Jan 20, 2020 at 04:43:53PM +0800, Jason Wang wrote:
> > > > > This is similar to the design of platform IOMMU part of vhost-vdpa. We
> > > > > decide to send diffs to platform IOMMU there. If it's ok to do that in
> > > > > driver, we can replace set_map with incremental API like map()/unmap().
> > > > >
> > > > > Then driver need to maintain rbtree itself.
> > > > 
> > > > I think we really need to see two modes, one where there is a fixed
> > > > translation without dynamic vIOMMU driven changes and one that supports
> > > > vIOMMU.
> > > > 
> > > > There are different optimization goals in the drivers for these two
> > > > configurations.
> > > 
> > > +1.
> > > It will be best to have one API for static config (i.e. mapping can be
> > > set only before virtio device gets active), and one API for dynamic
> > > changes that can be set after the virtio device is active. 
> > 
> > Frankly I don't see when we'd use the static one.
> > Memory hotplug is enabled for most guests...
> 
> If someone wants to run a full performance application, like dpdk,
> then they may wish to trade memory hotplug in that VM for more
> performance.

Right. But let let's get basic functionality working first.

> Perhaps Shahaf can quantify the performance delta?
> 
> Jason
