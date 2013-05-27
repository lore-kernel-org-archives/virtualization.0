From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Qemu-devel] [PATCH v2 00/11] qemu: use virtio linux headers in
	portable code
Date: Mon, 27 May 2013 11:14:47 -0500
Message-ID: <87bo7wflhk.fsf@codemonkey.ws>
References: <CAFEAcA9HW6=F7QKpuof02hGTaAnLsZmoZ_-Yo98wKzeELi_zvA@mail.gmail.com>
	<20130526181017.GB3115@redhat.com> <51A253C6.7060303@redhat.com>
	<20130526183747.GB3427@redhat.com> <51A25A2D.8030700@redhat.com>
	<20130526200251.GA4305@redhat.com>
	<51A26E95.5000207@redhat.com> <878v314gb2.fsf@codemonkey.ws>
	<20130526214213.GB4828@redhat.com> <87txlp1bsy.fsf@codemonkey.ws>
	<20130527150217.GA16852@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130527150217.GA16852@redhat.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, virtualization <virtualization@lists.linux-foundation.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Sun, May 26, 2013 at 07:55:25PM -0500, Anthony Liguori wrote:
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>> 
>> > On Sun, May 26, 2013 at 03:49:53PM -0500, Anthony Liguori wrote:
>> >> Paolo Bonzini <pbonzini@redhat.com> writes:
>> >> 
>> >> > Il 26/05/2013 22:02, Michael S. Tsirkin ha scritto:
>> >> >> > My fault.  I should have looked at linux/types.h (actually asm-generic/).
>> >> >> 
>> >> >> Not really, __uX appear in the headers that were posted.
>> >> 
>> >> Which is a problem because this is a reserved namespace in C99.
>> >> 
>> >> >> What I'm saying is - a chance of a conflict is very remote,
>> >> >> if it happens it's a build failure so easy to debug.
>> >> >
>> >> > I'm sure that others will complain, :) but you can go ahead.
>> >> 
>> >> I think we should clean up the virtio headers in the kernel first.
>> >> Seems like a good thing to do given the standardization effort too.
>> >> There are lots of headers in uapi that use the C99 int types
>> >
>> > I found 4:
>> > $ grep -l uint include/uapi/linux/*h
>> > include/uapi/linux/dm-log-userspace.h
>> > include/uapi/linux/fuse.h
>> > include/uapi/linux/jffs2.h
>> > include/uapi/linux/pps.h
>> > include/uapi/linux/rds.h
>> > include/uapi/linux/sctp.h
>> >
>> > That's not really lots.
>> >
>> >> so there
>> >> doesn't seem to be a reason they couldn't be used in virtio.  fuse.h
>> >> even has a:
>> >> 
>> >>     #ifdef __KERNEL__
>> >>     #include <linux/types.h>
>> >>     #else
>> >>     #include <stdint.h>
>> >>     #endif
>> >> 
>> >> Which seems like a reasonable thing to do.
>> >
>> > In kernel, we really want to use things like endian-ness
>> > checks (and, we really should have them in userspace too!).
>> > So we want __le32 and other kernel goodies
>> > like that. stdint.h won't cut it.
>> 
>> With the spec being standardized, I think having a stand alone set of
>> headers is a good thing.
>
> Sure, that's possible. We'll have to find some way to
> preserve the endian-ness annotations, I think.
> And then import them into kernel/qemu with some script, converting
> to kernel/qemu style and annotations?

See below.

>>  Licensing is problematic here too.
>> 
>> If virtio headers depend on other Linux headers, then it really doesn't
>> matter if they are BSD licensed if you need a GPL header (like
>> linux/if_ether.h).
>> 
>> Now, we can certainly debate the copyrightability of these defines and
>> what have you but if the headers are meant to be 1) consumed outside the
>> kernel 2) licensed under a different license than the general kernel
>> then depending on kernel goodies is the wrong strategy.
>
> Well specifically if_ether.h says GPLv2+ so it's OK for QEMU.
> Do you mean for some other non GPL app?

Ignore QEMU for the moment.

The headers say they are BSD licensed... but they include a GPLv2+
header.  Doesn't make a lot of sense, does it?

Again, I think it's something pretty basic here.  Either (1) these are
kernel/userspace headers that are meant to be consumed through libc or
whatever (2) these are kernel-private headers not to be consumed outside
of the kernel (3) these are headers meant to be copied widely and used
as a reference implementation of virtio.

If (1) or (2), copying them into QEMU via a magic sanitizing script is
wrong.  We should just keep doing what we're doing.

If (3), then we should clean up the virtio headers to be license clean
and usable outside of the kernel.  We shouldn't try to solve this
problem in QEMU (via scripts) if we can just solve it in the kernel.

Regards,

Anthony Liguori

>
>> >> The only other kernel dependency is linux/if_ether.h to define
>> >> ETH_ALEN.  But it seems completely reasonable to define a
>> >> VIRTIO_NET_MAC_ALEN or something like that.
>> >
>> > Ugh. Not really reasonable IMO. We also use ETH_P_IP in code,
>> > would like to get rid of redefining that too.
>> > But we can have our own linux/if_ether.h for non-linux hosts,
>> > just with a
>> > couple of macros like that, it's not a big deal.
>> 
>> See above.
>> 
>> Regards,
>> 
>> Anthony Liguori
>> 
>> >
>> >> This would make the virtio headers completely stand alone and includable
>> >> in userspace (without violating C99).
>> >> 
>> >> Perhaps it's even worth moving the headers from uapi/linux to
>> >> uapi/virtio.  Rusty, what do you think?
>> >> 
>> >> Regards,
>> >> 
>> >> Anhtony Liguori
>> >> 
>> >> >
>> >> > Paolo
