From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] vhost-blk: Add vhost-blk support v2
Date: Tue, 23 Oct 2012 10:37:29 +1030
Message-ID: <87mwzehwzi.fsf@rustcorp.com.au>
References: <1349769918-8611-1-git-send-email-asias@redhat.com>
	<20121011124125.GA8074@redhat.com>
	<507818BE.7060404@redhat.com> <87d30go1g7.fsf@rustcorp.com.au>
	<20121018063040.GA15676@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20121018063040.GA15676@redhat.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
> On Thu, Oct 18, 2012 at 02:50:56PM +1030, Rusty Russell wrote:
>> Asias He <asias@redhat.com> writes:
>> >>> +#define BLK_HDR	0
>> >> 
>> >> What's this for, exactly? Please add a comment.
>> >
>> > The block headr is in the first and separate buffer.
>> 
>> Please don't assume this!  We're trying to fix all the assumptions in
>> qemu at the moment.
>> 
>> vhost_net handles this correctly, taking bytes off the descriptor chain
>> as required.
>> 
>> Thanks,
>> Rusty.
>
> BTW are we agreed on the spec update that makes cmd 32 bytes?

vhost-blk doesn't handle scsi requests, does it?

But since we're forced to use a feature bit, we could just put the cmd
size in explicitly.  Though Paulo seems convinced that 32 is always
sufficient.  Whoever implements it gets to decide...

Here's my TODO list:
1) Create qemu helpers to efficiently handle iovecs.
2) Switch all the qemu devices to use them.
3) ... except a special hack for virtio-blk in old-layout mode.
4) Implement pci capability layout RFC for qemu.
   - Detect whether guest uses capabilities.
   - Device config in new mode is le.
   - Add strict checking mode for extra compliance checks?
5) Add explicit size-based accessors to virtio_config in kernel.
6) Update pci capability RFC patches for linux to match.
   - Use explicit accessors to allow for endian conversion.
6) Push virtio torture patch to test variable boundaries.
7) Update spec.

That should keep me amused for a while...

Cheers,
Rusty.
