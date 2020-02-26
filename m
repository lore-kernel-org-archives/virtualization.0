From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH V4 5/5] vdpasim: vDPA device simulator
Date: Wed, 26 Feb 2020 13:19:05 -0400
Message-ID: <20200226171905.GS26318@mellanox.com>
References: <20200220061141.29390-1-jasowang@redhat.com>
 <20200220061141.29390-6-jasowang@redhat.com>
 <20200220151215.GU23930@mellanox.com>
 <6c341a77-a297-b7c7-dea5-b3f7b920b1f3@redhat.com>
 <793a1b81-4f78-c405-4aae-f32a2bf67d87@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <793a1b81-4f78-c405-4aae-f32a2bf67d87@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "tiwei.bie@intel.com" <tiwei.bie@intel.com>, "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>, "cunming.liang@intel.com" <cunming.liang@intel.com>, "zhihong.wang@intel.com" <zhihong.wang@intel.com>, "rob.miller@broadcom.com" <rob.miller@broadcom.com>, "xiao.w.wang@intel.com" <xiao.w.wang@intel.com>, "haotian.wang@sifive.com" <haotian.wang@sifive.com>, "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>, "eperezma@redhat.com" <eperezma@redhat.com>, "lulu@redhat.com" <lulu@redhat.co>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Feb 26, 2020 at 02:12:26PM +0800, Jason Wang wrote:
> > > It is a bit weird to be creating this dummy parent, couldn't this be
> > > done by just passing a NULL parent to vdpa_alloc_device, doing
> > > set_dma_ops() on the vdpasim->vdpa->dev and setting dma_device to
> > > vdpasim->vdpa->dev ?
> > 
> > 
> > I think it works.
> 
> 
> Rethink about this, since most hardware vDPA driver will have a parent and
> will use it to find the parent structure e.g
> 
> dev_get_drvdata(vdpa->dev->parent)

Oh that seems like a sketchy pattern

> So I keep this dummy parent in V5.

The dummy parent is visible in sysfs, I think you should remove it so
the syfs for this virtual device makes sense.

Jason
