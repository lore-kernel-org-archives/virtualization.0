From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] virtio-spec: document block CMD and FLUSH
Date: Tue, 4 May 2010 20:54:59 +0200
Message-ID: <20100504185459.GA24998@lst.de>
References: <20100218222220.GA14847@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100218222220.GA14847@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Anthony Liguori <anthony@codemonkey.ws>, hch@lst.de
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 19, 2010 at 12:22:20AM +0200, Michael S. Tsirkin wrote:
> I took a stub at documenting CMD and FLUSH request types in virtio
> block.  Christoph, could you look over this please?
> 
> I note that the interface seems full of warts to me,
> this might be a first step to cleaning them.

The whole virtio-blk interface is full of warts.  It has been
extended rather ad-hoc, so that is rather expected.

> One issue I struggled with especially is how type
> field mixes bits and non-bit values. I ended up
> simply defining all legal values, so that we have
> CMD = 2, CMD_OUT = 3 and so on.

It's basically a complete mess without much logic behind it.

> +\change_unchanged
> +the high bit
> +\change_inserted 0 1266497301
> + (VIRTIO_BLK_T_BARRIER)
> +\change_unchanged
> + indicates that this request acts as a barrier and that all preceeding requests
> + must be complete before this one, and all following requests must not be
> + started until this is complete.
> +
> +\change_inserted 0 1266504385
> + Note that a barrier does not flush caches in the underlying backend device
> + in host, and thus does not serve as data consistency guarantee.
> + Driver must use FLUSH request to flush the host cache.
> +\change_unchanged

I'm not sure it's even worth documenting it.  I can't see any way to
actually implement safe behaviour with the VIRTIO_BLK_T_BARRIER-style
barriers.


Btw, did I mention that .lyx is a a really horrible format to review
diffs for?  Plain latex would be a lot better..
