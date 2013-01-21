From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/6] virtio_host: host-side implementation of virtio rings.
Date: Tue, 22 Jan 2013 09:27:15 +1030
Message-ID: <87k3r6uotw.fsf@rustcorp.com.au>
References: <1358418584-26345-1-git-send-email-rusty@rustcorp.com.au>
	<20130117112314.GA15504@redhat.com>
	<877gn7w9fc.fsf@rustcorp.com.au> <87r4levjmk.fsf@rustcorp.com.au>
	<20130121122431.GB3969@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
> On Mon, Jan 21, 2013 at 10:22:03PM +1030, Rusty Russell wrote:
>> Rusty Russell <rusty@rustcorp.com.au> writes:
>> > "Michael S. Tsirkin" <mst@redhat.com> writes:
>> >>> +		iov->iov[iov->i].iov_base = (__force __user void *)addr;
>> >>> +		iov->iov[iov->i].iov_len = desc.len;
>> >>
>> >> The following comment from the previous version still applies:
>> >> 	> This looks like it won't do the right thing if desc.len spans multiple
>> >> 	> ranges. I don't know if this happens in practice but this is something
>> >> 	> vhost supports ATM.
>> >> in otgher words, we might need to split a single desc to multiple
>> >> iov entries.
>> >
>> > Ah, separate offsets for consecutive ranges, right.  I'd prefer to say
>> > "don't do that", but qemu is rarely sane.  I'll fix it.
>> 
>> Actually, you make the same assumption for vhost, with your use of
>> getuser and putuser for accessing the ring.
>
> There's no requirement that ring is mapped directly into guest
> memory. If a ring is not contigious qemu can allocate
> it's own virtuall contigious rings and copy data back and forth.

True, but it's the guest which allocates the ring.  If QEMU sets up a
guest with a offset-discontiguous mapping, vhost would be unreliable
today.

>> The complexity and cost of handling this is significant,
>
> Why is it? Just add a while loop, increment desc.addr
> and decrement desc.len.

Indirect handling now needs to re-check the boundaries for every
descriptor it fetches, and handle the case where a single descriptor
overlaps the boundary.

The ability to verify the indirect descriptor table all at once makes
the code fast and neat.

From your other mail:

> It seems it could happen if e.g. one region is ROM and another one is
> RAM.  This means it won't be used for the ring (which is R/W) but could
> be for the data.

That case wouldn't be so bad, I think, since it's a simple loop.

I'll create some patches and see if it's too ugly to live...

Thanks,
Rusty.
