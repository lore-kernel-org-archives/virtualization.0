From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vdpa-sim: depend on HAS_DMA
Date: Mon, 6 Apr 2020 11:50:30 -0400
Message-ID: <20200406115000-mutt-send-email-mst@kernel.org>
References: <20200405081355.2870-1-mst@redhat.com>
 <20200406130927.GA20291@infradead.org>
 <20200406095931-mutt-send-email-mst@kernel.org>
 <0f4f2502-e810-e87a-2fba-dc887d2f4272@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0f4f2502-e810-e87a-2fba-dc887d2f4272@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 06, 2020 at 10:12:56PM +0800, Jason Wang wrote:
> 
> On 2020/4/6 下午10:02, Michael S. Tsirkin wrote:
> > On Mon, Apr 06, 2020 at 06:09:27AM -0700, Christoph Hellwig wrote:
> > > Pleae just drop the code - we should not add new drivers with custom
> > > DMA ops.
> > I'm not sure there's another way to do this: this not a driver, it's a
> > software emulator that pretends to be an actual device. We can't
> > have the platform supply DMA ops here since the platform is a regular
> > x86 or whatever.
> 
> 
> Yes, actually vdpa-sim does not depends on HAS_DMA. Maybe we can do shortcut
> like dev->dma_ops = vdpasim_dma_ops;
> 
> Thanks
> 

We can do that - does it them actually work - and not just compile?

-- 
MST
