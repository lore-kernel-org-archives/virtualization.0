From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Qemu-devel] Guest bridge setup variations
Date: Thu, 10 Dec 2009 17:53:52 -0600
Message-ID: <4B218A10.6000904@codemonkey.ws>
References: <200912081707.42660.arnd@arndb.de> <4B1FFC30.40904@codemonkey.ws>
	<200912101019.58555.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200912101019.58555.arnd@arndb.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Arnd Bergmann wrote:
>> 3) given an fd, treat a vhost-style interface
>>     
>
> This could mean two things, not sure which one you mean. Either the
> file descriptor could be the vhost file descriptor, or the socket or tap file
> descriptor from above, with qemu operating on the vhost interface itself.
>
> Either option has its advantages, but I guess we should only implement
> one of the two to keep it simple.
>   

I was thinking the socket/tap descriptor.

>> I believe we should continue supporting the mechanisms we support 
>> today.  However, for people that invoke qemu directly from the command 
>> line, I believe we should provide a mechanism like the tap helper that 
>> can be used to call out to a separate program to create these initial 
>> file descriptors.  We'll have to think about how we can make this 
>> integrate well so that the syntax isn't clumsy.
>>     
>
> Right. I wonder if this helper should integrate with netcf as an abstraction,
> or if we should rather do something generic. It may also be a good idea
> to let the helper decide which of the three options you listed to use
> and pass that back to qemu unless the user overrides it. The decision
> probably needs to be host specific, depending e.g. on the availability
> and version of tools (brctl, iproute, maybe tunctl, ...), the respective
> kernel modules (vhost, macvlan, bridge, tun, ...) and policy (VEPA, vlan,
> ebtables). Ideally the approach should be generic enough to work on
> other platforms (BSD, Solaris, Windows, ...).
>   

For helpers, I think I'd like to stick with what we currently support, 
and then allow for a robust way for there to be independent projects 
that implement their own helpers.   For instance, I would love it if 
netcf had a qemu network "plugin" helper.

There's just too much in the networking space all wrapped up in layers 
of policy decisions.  I think it's time to move it out of qemu.

> One thing I realized the last time we discussed the helper approach is
> that qemu should not need to know or care about the arguments passed
> to the helper, otherwise you get all the complexity back in qemu that
> you're trying to avoid. Maybe for 0.13 we can convert -net socket and
> -net tap to just pass all their options to the helper and move that code
> out of qemu, along with introducting the new syntax.
>   

Yes, I was thinking the same thing.  New syntax may need exploring.

> Another unrelated issue that I think needs to be addressed in a
> network code cleanup is adding better support for multi-queue
> transmit and receive. I've prepared macvtap for that by letting you
> open the chardev multiple times to get one queue per guest CPU,
> but that needs to be supported by qemu and virtio-net as well
> to actually parallelize network operation. Ideally, two guest CPUs
> should be able to transmit and receive on separate queues of the
> adapter without ever having to access any shared resources.
>   

Multiqueue adds another dimension but I think your approach is pretty 
much right on the money.  Have multiple fds for each queue and we would 
support a mechanism with helpers to receive multiple fds as appropriate.

Regards,

Anthony Liguori
