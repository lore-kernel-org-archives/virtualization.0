From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH 3/5] vDPA: introduce vDPA bus
Date: Tue, 21 Jan 2020 14:16:40 +0000
Message-ID: <20200121141634.GE12330@mellanox.com>
References: <20200116124231.20253-1-jasowang@redhat.com>
 <20200116124231.20253-4-jasowang@redhat.com>
 <20200116152209.GH20978@mellanox.com>
 <03cfbcc2-fef0-c9d8-0b08-798b2a293b8c@redhat.com>
 <20200117135435.GU20978@mellanox.com>
 <20200120071406-mutt-send-email-mst@kernel.org>
 <20200120175050.GC3891@mellanox.com>
 <20200120164916-mutt-send-email-mst@kernel.org>
 <20200121141200.GC12330@mellanox.com>
 <20200121091456-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200121091456-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-ID: <D789572F2035E04481FCBAD167A48367@eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "tiwei.bie@intel.com" <tiwei.bie@intel.com>, "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>, "cunming.liang@intel.com" <cunming.liang@intel.com>, "zhihong.wang@intel.com" <zhihong.wang@intel.com>, "rob.miller@broadcom.com" <rob.miller@broadcom.com>, "xiao.w.wang@intel.com" <xiao.w.wang@intel.com>, "haotian.wang@sifive.com" <haotian.wang@sifive.com>, "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>, "eperezma@redhat.com" <eperezma@redhat.com>, "lulu@redhat.com" <lulu@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 21, 2020 at 09:15:14AM -0500, Michael S. Tsirkin wrote:
> On Tue, Jan 21, 2020 at 02:12:05PM +0000, Jason Gunthorpe wrote:
> > On Mon, Jan 20, 2020 at 04:56:06PM -0500, Michael S. Tsirkin wrote:
> > > > For vfio? vfio is the only thing I am aware doing
> > > > that, and this is not vfio..
> > >=20
> > > vfio is not doing anything. anyone can use a combination
> > > of unbind and driver_override to attach a driver to a device.
> > >=20
> > > It's not a great interface but it's there without any code,
> > > and it will stay there without maintainance overhead
> > > if we later add a nicer one.
> >=20
> > Well, it is not a great interface, and it is only really used in
> > normal cases by vfio.
> >=20
> > I don't think it is a good idea to design new subsystems with that
> > idea in mind, particularly since detatching the vdpa driver would not
> > trigger destruction of the underlying dynamic resource (ie the SF).
> >=20
> > We need a way to trigger that destruction..
> >=20
> > Jason=20
>=20
> You wanted a netlink command for this, right?

It is my suggestion.

Based on experiance here we started out with sysfs and it was OK, but
slow. When we added container support the entire sysfs thing
completely exploded and we had to replace it with netlink.

Jason
