From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost: introduce vDPA based backend
Date: Wed, 5 Feb 2020 08:14:46 -0500
Message-ID: <20200205081210-mutt-send-email-mst@kernel.org>
References: <20200131033651.103534-1-tiwei.bie@intel.com>
 <7aab2892-bb19-a06a-a6d3-9c28bc4c3400@redhat.com>
 <20200205020247.GA368700@___>
 <AM0PR0502MB37952015716C1D5E07E390B6C3020@AM0PR0502MB3795.eurprd05.prod.outlook.com>
 <112858a4-1a01-f4d7-e41a-1afaaa1cad45@redhat.com>
 <20200205125648.GV23346@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200205125648.GV23346@mellanox.com>
Sender: kvm-owner@vger.kernel.org
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: Jason Wang <jasowang@redhat.com>, Shahaf Shuler <shahafs@mellanox.com>, Tiwei Bie <tiwei.bie@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "rob.miller@broadcom.com" <rob.miller@broadcom.com>, "haotian.wang@sifive.com" <haotian.wang@sifive.com>, "eperezma@redhat.com" <eperezma@redhat.com>, "lulu@redhat.com" <lulu@redhat.com>, Parav Pandit <parav@mellanox.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>, "hch@infradead.org" <hch@infradead.org>, Jiri Pirko <jiri@mellanox.com>, "hanand@xilinx.com" <hanand@xilinx.com>, mhabets@solarflare.
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Feb 05, 2020 at 08:56:48AM -0400, Jason Gunthorpe wrote:
> On Wed, Feb 05, 2020 at 03:50:14PM +0800, Jason Wang wrote:
> > > Would it be better for the map/umnap logic to happen inside each device ?
> > > Devices that needs the IOMMU will call iommu APIs from inside the driver callback.
> > 
> > Technically, this can work. But if it can be done by vhost-vpda it will make
> > the vDPA driver more compact and easier to be implemented.
> 
> Generally speaking, in the kernel, it is normal to not hoist code of
> out drivers into subsystems until 2-3 drivers are duplicating that
> code. It helps ensure the right design is used
> 
> Jason

That's up to the sybsystem maintainer really, as there's also some
intuition involved in guessing a specific API is widely useful.
In-kernel APIs are flexible, if we find something isn't needed we just
drop it.

-- 
MST
