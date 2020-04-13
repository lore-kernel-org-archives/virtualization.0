From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/6] i915/gvt: remove unused xen bits
Date: Mon, 13 Apr 2020 15:08:06 +0200
Message-ID: <20200413130806.GA14455@lst.de>
References: <20200404094101.672954-1-hch@lst.de> <20200404094101.672954-4-hch@lst.de> <20200408014437.GF11247@zhen-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200408014437.GF11247@zhen-hp.sh.intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Felipe Balbi <balbi@kernel.org>, amd-gfx@lists.freedesktop.org, "Michael S. Tsirkin" <mst@redhat.com>, Felix Kuehling <Felix.Kuehling@amd.com>, linux-usb@vger.kernel.org, io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, intel-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, intel-gvt-dev@lists.freedesktop.org, Jason Wang <jasowang@redhat.com>, Zhi Wang <zhi.a.wang@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 08, 2020 at 09:44:37AM +0800, Zhenyu Wang wrote:
> On 2020.04.04 11:40:58 +0200, Christoph Hellwig wrote:
> > No Xen support anywhere here.  Remove a dead declaration and an unused
> > include.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> 
> We'll keep that off-tree.
> 
> Acked-by: Zhenyu Wang <zhenyuw@linux.intel.com>

Can you pick this up through the i915 tree?
