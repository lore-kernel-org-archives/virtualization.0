From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Qemu-devel] [PATCH v2 00/11] qemu: use virtio linux headers in
	portable code
Date: Wed, 29 May 2013 09:58:03 -0500
Message-ID: <87hahlkf44.fsf@codemonkey.ws>
References: <51A25A2D.8030700@redhat.com> <20130526200251.GA4305@redhat.com>
	<51A26E95.5000207@redhat.com> <878v314gb2.fsf@codemonkey.ws>
	<20130526214213.GB4828@redhat.com> <87txlp1bsy.fsf@codemonkey.ws>
	<20130527150217.GA16852@redhat.com>
	<87bo7wflhk.fsf@codemonkey.ws> <87ip22od5f.fsf@rustcorp.com.au>
	<87hahmq6li.fsf@codemonkey.ws> <20130529140900.GA10347@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130529140900.GA10347@redhat.com>
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

> On Wed, May 29, 2013 at 08:05:29AM -0500, Anthony Liguori wrote:
>> Rusty Russell <rusty@rustcorp.com.au> writes:
>> 
>> > Anthony Liguori <anthony@codemonkey.ws> writes:
>> >> The headers say they are BSD licensed... but they include a GPLv2+
>> >> header.  Doesn't make a lot of sense, does it?
>> >
>> > It makes perfect sense: you're overthinking it.  It just means that
>> > copying the BSD headers outside Linux is encouraged.
>> 
>> Copying by hand and modifying.  This patch series attempts to do it
>> automatically within QEMU.
>> 
>> > And it's clearly nonsensical to claim the GPL on kernel headers means
>> > that userspace needs to be GPL.  So please ignore this licensing
>> > red-herring.
>> 
>> You're missing context, I suspect.  This series is trying to
>> automatically copy the headers from Linux.  We currently have a manually
>> copied version.
>> 
>> The headers are not currently well suited for automatic copying because
>> (1) they use kernel types (2) they pull in dependencies from throughout
>> the kernel.
>> 
>> This discussion comes down to whether we want to make it easier to
>> automatically copy the headers or do we maintain the status quo and
>> require manual munging to pull in the headers.
>> 
>> Regards,
>> 
>> Anthony Liguori
>
> Okay, what if I
>
> 1. add a stub if_ether.h with a couple of macros we want
> 2. replace the types during copying
>
> Would this address all concerns?

If Rusty doesn't like the idea of making the headers usable directly,
then I don't object to having stubs/scripts to sanitize them in QEMU.

Regards,

Anthony Liguori

>
>> >
>> > And we'll bikeshed the headers in the standard when we have to :)  They
>> > certainly don't need to be cut&paste into the kernel sources.
>> >
>> > Cheers,
>> > Rusty.
