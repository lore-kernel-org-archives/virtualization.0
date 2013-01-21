From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/6] virtio_host: host-side implementation of virtio rings.
Date: Mon, 21 Jan 2013 14:40:29 +0200
Message-ID: <20130121124029.GA4112@redhat.com>
References: <1358418584-26345-1-git-send-email-rusty@rustcorp.com.au>
	<20130117112314.GA15504@redhat.com>
	<877gn7w9fc.fsf@rustcorp.com.au> <87r4levjmk.fsf@rustcorp.com.au>
	<20130121122431.GB3969@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130121122431.GB3969@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jan 21, 2013 at 02:24:31PM +0200, Michael S. Tsirkin wrote:
> On Mon, Jan 21, 2013 at 10:22:03PM +1030, Rusty Russell wrote:
> > Rusty Russell <rusty@rustcorp.com.au> writes:
> > > "Michael S. Tsirkin" <mst@redhat.com> writes:
> > >>> +		iov->iov[iov->i].iov_base = (__force __user void *)addr;
> > >>> +		iov->iov[iov->i].iov_len = desc.len;
> > >>
> > >> The following comment from the previous version still applies:
> > >> 	> This looks like it won't do the right thing if desc.len spans multiple
> > >> 	> ranges. I don't know if this happens in practice but this is something
> > >> 	> vhost supports ATM.
> > >> in otgher words, we might need to split a single desc to multiple
> > >> iov entries.
> > >
> > > Ah, separate offsets for consecutive ranges, right.  I'd prefer to say
> > > "don't do that", but qemu is rarely sane.  I'll fix it.
> > 
> > Actually, you make the same assumption for vhost, with your use of
> > getuser and putuser for accessing the ring.
> 
> There's no requirement that ring is mapped directly into guest
> memory. If a ring is not contigious qemu can allocate
> it's own virtuall contigious rings and copy data back and forth.
> 
> > The complexity and cost of handling this is significant,
> 
> Why is it? Just add a while loop, increment desc.addr
> and decrement desc.len.
> 
> > and the error
> > if it ever did happen is distinctive.  Does qemu ever create such
> > things?
> > 
> > Thanks,
> > Rusty.
> 
> I think qemu does create ranges that are consequitive in guest pa
> space but not in qemu va ranges. I'm sick today, will try to dig out
> some examples later.

It seems it could happen if e.g. one region is ROM and another one is
RAM.  This means it won't be used for the ring (which is R/W) but could
be for the data.

> -- 
> MST
