From: Shahaf Shuler <shahafs@mellanox.com>
Subject: RE: [PATCH 3/5] vDPA: introduce vDPA bus
Date: Mon, 20 Jan 2020 20:51:43 +0000
Message-ID: <AM0PR0502MB3795C92485338180FC8059CFC3320@AM0PR0502MB3795.eurprd05.prod.outlook.com>
References: <20200116124231.20253-1-jasowang@redhat.com>
 <20200116124231.20253-4-jasowang@redhat.com>
 <20200117070324-mutt-send-email-mst@kernel.org>
 <239b042c-2d9e-0eec-a1ef-b03b7e2c5419@redhat.com>
 <CAJPjb1+fG9L3=iKbV4Vn13VwaeDZZdcfBPvarogF_Nzhk+FnKg@mail.gmail.com>
 <AM0PR0502MB379553984D0D55FDE25426F6C3330@AM0PR0502MB3795.eurprd05.prod.outlook.com>
 <d69918ca-8af4-44b2-9652-633530d4c113@redhat.com>
 <20200120174933.GB3891@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200120174933.GB3891@mellanox.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Gunthorpe <jgg@mellanox.com>, Jason Wang <jasowang@redhat.com>
Cc: Rob Miller <rob.miller@broadcom.com>, "Michael S. Tsirkin" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Netdev <netdev@vger.kernel.org>, "Bie, Tiwei" <tiwei.bie@intel.com>, "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>, "Liang, Cunming" <cunming.liang@intel.com>, "Wang, Zhihong" <zhihong.wang@intel.com>, "Wang, Xiao W" <xiao.w.wang@intel.com>, "haotian.wang@sifive.com" <haotian.wang@sifive.com>, "Zhu, Lingshan" <lingshan.zhu@intel.com>, "eperezma@redhat.com" <eperezma@redhat.com>, "lulu@redhat.com" <lulu@redhat.com>, Parav Pandit <parav@mellanox.com>, "Tian, Kevin" <kevi>
List-Id: virtualization@lists.linuxfoundation.org

Monday, January 20, 2020 7:50 PM, Jason Gunthorpe:
> Subject: Re: [PATCH 3/5] vDPA: introduce vDPA bus
>=20
> On Mon, Jan 20, 2020 at 04:43:53PM +0800, Jason Wang wrote:
> > This is similar to the design of platform IOMMU part of vhost-vdpa. We
> > decide to send diffs to platform IOMMU there. If it's ok to do that in
> > driver, we can replace set_map with incremental API like map()/unmap().
> >
> > Then driver need to maintain rbtree itself.
>=20
> I think we really need to see two modes, one where there is a fixed
> translation without dynamic vIOMMU driven changes and one that supports
> vIOMMU.
>=20
> There are different optimization goals in the drivers for these two
> configurations.

+1.
It will be best to have one API for static config (i.e. mapping can be set =
only before virtio device gets active), and one API for dynamic changes tha=
t can be set after the virtio device is active.=20

>=20
> > > If the first one, then I think memory hotplug is a heavy flow
> > > regardless. Do you think the extra cycles for the tree traverse will
> > > be visible in any way?
> >
> > I think if the driver can pause the DMA during the time for setting up
> > new mapping, it should be fine.
>=20
> This is very tricky for any driver if the mapping change hits the virtio =
rings. :(
>=20
> Even a IOMMU using driver is going to have problems with that..
>=20
> Jason
