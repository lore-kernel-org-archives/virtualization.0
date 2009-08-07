From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Qemu-devel] Re: virtio-serial: An interface for host-guest
	communication
Date: Fri, 07 Aug 2009 09:14:43 -0500
Message-ID: <4A7C36D3.3040305@codemonkey.ws>
References: <20090728140029.GA16067@amd.home.annexia.org>
	<4A77410D.4090804@codemonkey.ws>
	<20090805175713.GB28738@shareable.org>
	<4A79C8D9.5030606@codemonkey.ws>
	<20090806103843.GC9222@amit-x200.redhat.com>
	<4A7ADAC4.70902@codemonkey.ws>
	<20090806134103.GC11733@amit-x200.redhat.com>
	<4A7AE169.4000606@codemonkey.ws>
	<20090806140404.GA12083@amit-x200.redhat.com>
	<20090806173740.GA1178@shareable.org>
	<20090807063800.GA16769@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090807063800.GA16769@amit-x200.redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, Jamie Lokier <jamie@shareable.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Amit Shah wrote:
> On (Thu) Aug 06 2009 [18:37:40], Jamie Lokier wrote:
>   
>> Apart from dbus, hard-coded meanings of small N in /dev/vmchN are
>> asking for trouble.  It is bound to break when widely deployed and
>>     
>
> It's no different from the way major-minor numbering works on the Linux
> kernel: they uniquely identify a device.

Bad example.  Quite a lot of modern devices drivers are using dynamic 
major/minor numbers because they have proven to be such a pain in the 
butt.  That's why we have more sophisticated mechanisms like udev for 
userspace to make use of.

We'll definitely need some way to support dynamic vmchannels.  Static 
allocation of ports is just not going to work.  If we did a userspace 
daemon, I'd suggest using some sort of universal identifier that's easy 
to manage in a distributed fashion.  Like a reverse fqdn.

So for instance, I could have an "com.ibm.my-awesome-channel" and never 
have to worry about conflicts.

>> guest/host configs don't match.  It also doesn't fit comfortably when
>> you have, say, bob and alice both logged in with desktops on separate
>> VTs.  Clashes are inevitable, as third-party apps pick N values for
>> themselves then get distributed - unless N values can be large
>> (/dev/vmch44324 == kernelstats...).
>>     
>
> Hm, so there can be one daemon on the guest handling all clipboard
> events. There's some work done already by the fast-user-switch support
> and that can be extended to daemons that talk over virtio-serial.
>   

You could have one daemon that manages all vmchannel sessions.  It can 
then expose channels to apps via whatever mechanism is best.  It could 
use unix domain sockets, sys v ipc, whatever floats your boat.

And, you can build this daemon today using the existing vmchannel over 
TCP/IP.  You could also make it support serial devices.  We could also 
introduce a custom usb device and use libusb.  libusb is portable to 
Windows and Linux.

So we get backwards compatibility, and the Just Works experience with no 
funky kernel drivers.  What's there not to like?

Regards,

Anthony Liguori
