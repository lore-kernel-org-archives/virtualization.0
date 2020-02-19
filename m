From: Tiwei Bie <tiwei.bie@intel.com>
Subject: Re: [PATCH V2 3/5] vDPA: introduce vDPA bus
Date: Wed, 19 Feb 2020 10:59:48 +0800
Message-ID: <20200219025948.GA972742@___>
References: <cf7abcc9-f8ef-1fe2-248e-9b9028788ade@redhat.com>
 <20200212125108.GS4271@mellanox.com>
 <12775659-1589-39e4-e344-b7a2c792b0f3@redhat.com>
 <20200213134128.GV4271@mellanox.com>
 <ebaea825-5432-65e2-2ab3-720a8c4030e7@redhat.com>
 <20200213150542.GW4271@mellanox.com>
 <8b3e6a9c-8bfd-fb3c-12a8-2d6a3879f1ae@redhat.com>
 <20200214135232.GB4271@mellanox.com>
 <01c86ebb-cf4b-691f-e682-2d6f93ddbcf7@redhat.com>
 <20200218135608.GS4271@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200218135608.GS4271@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: Jason Wang <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>, "cunming.liang@intel.com" <cunming.liang@intel.com>, "zhihong.wang@intel.com" <zhihong.wang@intel.com>, "rob.miller@broadcom.com" <rob.miller@broadcom.com>, "xiao.w.wang@intel.com" <xiao.w.wang@intel.com>, "haotian.wang@sifive.com" <haotian.wang@sifive.com>, "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>, "eperezma@redhat.com" <eperezma@redhat.com>, "lulu@redhat.com" <lulu@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 18, 2020 at 01:56:12PM +0000, Jason Gunthorpe wrote:
> On Mon, Feb 17, 2020 at 02:08:03PM +0800, Jason Wang wrote:
> 
> > I thought you were copied in the patch [1], maybe we can move vhost related
> > discussion there to avoid confusion.
> >
> > [1] https://lwn.net/Articles/811210/
> 
> Wow, that is .. confusing.
> 
> So this is supposed to duplicate the uAPI of vhost-user? But it is
> open coded and duplicated because .. vdpa?

Do you mean the vhost-user in DPDK? There is no vhost-user
in Linux kernel.

Thanks,
Tiwei

> 
> > So it's cheaper and simpler to introduce a new bus instead of refactoring a
> > well known bus and API where brunches of drivers and devices had been
> > implemented for years.
> 
> If you reason for this approach is to ease the implementation then you
> should talk about it in the cover letters/etc
> 
> Maybe it is reasonable to do this because the rework is too great, I
> don't know, but to me this whole thing looks rather messy. 
> 
> Remember this stuff is all uAPI as it shows up in sysfs, so you can
> easilly get stuck with it forever.
> 
> Jason
