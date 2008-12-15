From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [PATCH] AF_VMCHANNEL address family
	for	guest<->host	communication.
Date: Mon, 15 Dec 2008 17:08:29 -0600
Message-ID: <4946E36D.8060503__35766.2882809111$1229382728$gmane$org@codemonkey.ws>
References: <20081214115054.4066.14557.stgit@dhcp-1-237.tlv.redhat.com>	<20081214.224436.55256593.davem@davemloft.net>	<4946717F.2090809@codemonkey.ws>
	<494697D4.6080300@goop.org> <4946A5E0.5080303@codemonkey.ws>
	<4946DF97.7070600@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4946DF97.7070600@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: netdev@vger.kernel.org, David Miller <davem@davemloft.net>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Anthony Liguori wrote:
>>
>> That seems unnecessarily complex.
>>   
>
> Well, the simplest thing is to let the host TCP stack do TCP.  Could 
> you go into more detail about why you'd want to avoid that?

The KVM model is that a guest is a process.  Any IO operations original 
from the process (QEMU).  The advantage to this is that you get very 
good security because you can use things like SELinux and simply treat 
the QEMU process as you would the guest.  In fact, in general, I think 
we want to assume that QEMU is guest code from a security perspective.

By passing up the network traffic to the host kernel, we now face a 
problem when we try to get the data back.  We could setup a tun device 
to send traffic to the kernel but then the rest of the system can see 
that traffic too.  If that traffic is sensitive, it's potentially unsafe.

You can use iptables to restrict who can receive traffic and possibly 
use SELinux packet tagging or whatever.  This gets extremely complex though.

It's far easier to avoid the host kernel entirely and implement the 
backends in QEMU.  Then any actions the backend takes will be on behalf 
of the guest.  You never have to worry about transport data leakage.

>> This is why I've been pushing for the backends to be implemented in 
>> QEMU.  Then QEMU can marshal the backend-specific state and transfer 
>> it during live migration.  For something like copy/paste, this is 
>> obvious (the clipboard state).  A general command interface is 
>> probably stateless so it's a nop.
>>   
>
> Copy/paste seems like a particularly bogus example.  Surely this isn't 
> a sensible way to implement it?

I think it's the most sensible way to implement it.  Would you suggest 
something different?

>> I'm not a fan of having external backends to QEMU for the very 
>> reasons you outline above.  You cannot marshal the state of a channel 
>> we know nothing about.  We're really just talking about extending 
>> virtio in a guest down to userspace so that we can implement 
>> paravirtual device drivers in guest userspace.  This may be an X 
>> graphics driver, a mouse driver, copy/paste, remote shutdown, etc.
>>   A socket seems like a natural choice.  If that's wrong, then we can 
>> explore other options (like a char device, virtual fs, etc.).
>
> I think a socket is a pretty poor choice.  It's too low level, and it 
> only really makes sense for streaming data, not for data storage 
> (name/value pairs).  It means that everyone ends up making up their 
> own serializations.  A filesystem view with notifications seems to be 
> a better match for the use-cases you mention (aside from cut/paste), 
> with a single well-defined way to serialize onto any given channel.  
> Each "file" may well have an application-specific content, but in 
> general that's going to be something pretty simple.

I had suggested a virtual file system at first and was thoroughly 
ridiculed for it :-)  There is a 9p virtio transport already so we could 
even just use that.

The main issue with a virtual file system is that it does map well to 
other guests.  It's actually easier to implement a socket interface for 
Windows than it is to implement a new file system.

But we could find ways around this with libraries.  If we used 9p as a 
transport, we could just provide a char device in Windows that received 
it in userspace.

>>   This shouldn't be confused with networking though and all the talk 
>> of doing silly things like streaming fence traffic through it just 
>> encourages the confusion.
>
> I'm not sure what you're referring to here.

I'm just ranting, it's not important.

Regards,

Anthony Liguori

>    J
