From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH V2 3/5] vDPA: introduce vDPA bus
Date: Wed, 12 Feb 2020 08:51:08 -0400
Message-ID: <20200212125108.GS4271@mellanox.com>
References: <20200210035608.10002-1-jasowang@redhat.com>
 <20200210035608.10002-4-jasowang@redhat.com>
 <20200211134746.GI4271@mellanox.com>
 <cf7abcc9-f8ef-1fe2-248e-9b9028788ade@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cf7abcc9-f8ef-1fe2-248e-9b9028788ade@redhat.com>
Sender: netdev-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, tiwei.bie@intel.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, kevin.tian@intel.com, stefanha@redhat.com, rdunlap@infradead.org, hch@infradead.org, aadam@redhat.com, jiri@mellanox.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Feb 12, 2020 at 03:55:31PM +0800, Jason Wang wrote:
> > The ida_simple_remove should probably be part of the class release
> > function to make everything work right
> 
> It looks to me bus instead of class is the correct abstraction here since
> the devices share a set of programming interface but not the semantics.

device_release() doesn't call the bus release? You have dev, type or
class to choose from. Type is rarely used and doesn't seem to be used
by vdpa, so class seems the right choice

Jason
