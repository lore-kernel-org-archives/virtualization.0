From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Using PCI config space to indicate config location
Date: Fri, 12 Oct 2012 08:59:36 +1030
Message-ID: <87391k7icv.fsf__43246.4228979827$1350009050$gmane$org@rustcorp.com.au>
References: <87zk4c2tqq.fsf@rustcorp.com.au> <874nmajcmj.fsf@codemonkey.ws>
	<87y5jhpuu2.fsf@rustcorp.com.au> <20121010083033.GA4799@redhat.com>
	<87bog9957l.fsf@rustcorp.com.au> <20121011102333.GA5552@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20121011102333.GA5552@redhat.com>
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
Cc: Anthony Liguori <aliguori@us.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
> On Thu, Oct 11, 2012 at 11:48:22AM +1030, Rusty Russell wrote:
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>> > On Mon, Oct 08, 2012 at 12:51:25PM +1030, Rusty Russell wrote:
>> >> Note before anyone gets confused; we were talking about using the PCI
>> >> config space to indicate what BAR(s) the virtio stuff is in.  An
>> >> alternative would be to simply specify a new layout format in BAR1.
>> >
>> > One problem we are still left with is this: device specific
>> > config accesses are still non atomic.
>> > This is a problem for multibyte fields such as MAC address
>> > where MAC could change while we are accessing it.
>> 
>> It's also a problem for related fields, eg. console width and height, or
>> disk geometry.
>> 
>> > I was thinking about some backwards compatible way to solve this, but if
>> > we are willing to break compatiblity or use some mode switch, how about
>> > we give up on virtio config space completely, and do everything besides
>> > IO and ISR through guest memory?
>> 
>> I think there's still a benefit in the simple publishing of information:
>> I don't really want to add a control queue for the console.
>
> One reason I thought using a vq is handy is because this would
> let us get by with a single MSI vector. Currently we need at least 2
> for config changes + a shared one for vqs.
> But I don't insist.

Hmmm, that is true.

>> Here's a table from a quick audit:
>> 
>> Driver          Config       Device changes    Driver writes... after init?
>> net             Y            Y                 N                N
>> block           Y            Y                 Y                Y
>> console         Y            Y                 N                N
>> rng             N            N                 N                N
>> balloon         Y            Y                 Y                Y
>> scsi            Y            N                 Y                N
>> 9p              Y            N                 N                N
>> 
>> For config space reads, I suggest the driver publish a generation count.
>
> You mean device?

Yes, sorry.

>> For writes, the standard seems to be a commit latch.  We could abuse the
>> generation count for this: the driver writes to it to commit config
>> changes.
>
> I think this will work. There are a couple of things that bother me:
>
> This assumes read accesses have no side effects, and these are sometimes handy.
> Also the semantics for write aren't very clear to me.
> I guess device must buffer data until generation count write?
> This assumes the device has a buffer to store writes,
> and it must track each byte written. I kind of dislike this
> tracking of accessed bytes. Also, device would need to resolve conflicts
> if any in some device specific way.

It should be trivial to implement: you keep a scratch copy of the config
space, and copy it to the master copy when they hit the latch.

Implementation of this will show whether I've missed anything here, I
think.

> Maybe it's a good idea to make the buffer accesses explicit instead?
> IOW require driver to declare intent to read/request write of a specific
> config range.  We could for example do it like this:
> 	__le32 config_offset;
> 	__le32 config_len;
> 	__u8 config_cmd; /* write-only: 0 - read, 1 - write
> 			    config_len bytes at config_offset
> 			    from/to config space to/from device memory */
> But maybe this is over-engineering?

Seems overengineering since the config space is quite small in practice.

>> PS.  Let's make all the virtio-device config LE, too...
>
> We'll need some new API for devices then: currently we pass bytes.

Yes, but driver authors expect that anyway.  We can retro-define
virito-mmio to be LE (since all current users are), so this is
v. tempting.

Cheers,
Rusty.
