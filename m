From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio_mem: prevent overflow with subblock size
Date: Mon, 8 Jun 2020 05:41:46 -0400
Message-ID: <20200608053807-mutt-send-email-mst@kernel.org>
References: <20200608061406.709211-1-mst@redhat.com>
 <0930c9d0-0708-c079-29bd-b80d4e3ce446@redhat.com>
 <20200608030423-mutt-send-email-mst@kernel.org>
 <d10e9515-8408-037c-385a-d69259ce70ee@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d10e9515-8408-037c-385a-d69259ce70ee@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, virtualization@lists.linux-foundation.org, teawater <teawaterz@linux.alibaba.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 08, 2020 at 09:17:45AM +0200, David Hildenbrand wrote:
> On 08.06.20 09:08, Michael S. Tsirkin wrote:
> > On Mon, Jun 08, 2020 at 08:58:31AM +0200, David Hildenbrand wrote:
> >> On 08.06.20 08:14, Michael S. Tsirkin wrote:
> >>> If subblock size is large (e.g. 1G) 32 bit math involving it
> >>> can overflow. Rather than try to catch all instances of that,
> >>> let's tweak block size to 64 bit.
> >>
> >> I fail to see where we could actually trigger an overflow. The reported
> >> warning looked like a false positive to me.
> > 
> > 
> > So
> > 
> >     const uint64_t size = count * vm->subblock_size;
> > 
> > is it unreasonable for count to be 4K with subblock_size being 1M?
> 
> virtio_mem_mb_plug_sb() and friends are only called on subblocks
> residing within a single Linux memory block. (currently, 128MB .. 2G on
> x86-64). A subblock on x86-64 is currently at least 4MB.
> 
> So "count * vm->subblock_size" can currently not exceed the Linux memory
> block size (in practice, it is max 128MB).
> 
> > 
> >>>
> >>> It ripples through UAPI which is an ABI change, but it's not too late to
> >>> make it, and it will allow supporting >4Gbyte blocks while might
> >>> become necessary down the road.
> >>>
> >>
> >> This might break cloud-hypervisor, who's already implementing this
> >> protocol upstream (ccing Hui).
> >> https://github.com/cloud-hypervisor/cloud-hypervisor/blob/master/vm-virtio/src/mem.rs
> >>
> >> (blocks in the gigabyte range were never the original intention of
> >> virtio-mem, but I am not completely opposed to that)
> > 
> > 
> > So in that case, can you code up validation in the probe function?
> 
> If we would currently have a "block_size" > Linux memory block size, we
> bail out.
> 
> virtio_mem_init():
> 
> if (vm->device_block_size > memory_block_size_bytes()) {
> 	dev_err(&vm->vdev->dev,
> 		"The block size is not supported (too big).\n");
> 	return -EINVAL;
> }

Sounds good.

> So what's reported can currently not happen. Having that said, changing
> "subblock_size" to be an uint64_t is a good cleanup, especially for the
> future.

OK, no need to argue about it then. I tweaked the subject as you
suggested and queued it then.

> 
> 
> 
> -- 
> Thanks,
> 
> David / dhildenb
