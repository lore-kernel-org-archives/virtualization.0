From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] virtio_blk: allow re-reading config space at runtime
Date: Tue, 1 Feb 2011 18:33:12 +0100
Message-ID: <20110201173312.GD16883@lst.de>
References: <20110114160137.GA18721@lst.de> <20110127153220.GB4898@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110127153220.GB4898@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jan 27, 2011 at 05:32:21PM +0200, Michael S. Tsirkin wrote:
> This needs to be flushed on device removal, I think,
> otherwise the vdev pointer will go stale.

Indeed.

> 
> > +}
> > +
> > +
> 
> Two empty lines :)


I'll fix it up.
