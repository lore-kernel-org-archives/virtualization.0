From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [Qemu-devel] Re: virtio-serial: An interface for host-guest
	communication
Date: Mon, 10 Aug 2009 12:25:08 +0530
Message-ID: <20090810065508.GA4499@amit-x200.redhat.com>
References: <20090805175713.GB28738@shareable.org>
	<4A79C8D9.5030606@codemonkey.ws>
	<20090806103843.GC9222@amit-x200.redhat.com>
	<4A7ADAC4.70902@codemonkey.ws>
	<20090806134103.GC11733@amit-x200.redhat.com>
	<4A7AE169.4000606@codemonkey.ws>
	<20090806140404.GA12083@amit-x200.redhat.com>
	<20090806173740.GA1178@shareable.org>
	<20090807063800.GA16769@amit-x200.redhat.com>
	<4A7C36D3.3040305@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4A7C36D3.3040305@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, Jamie Lokier <jamie@shareable.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Fri) Aug 07 2009 [09:14:43], Anthony Liguori wrote:
> Amit Shah wrote:
>> On (Thu) Aug 06 2009 [18:37:40], Jamie Lokier wrote:
>>   
>>> Apart from dbus, hard-coded meanings of small N in /dev/vmchN are
>>> asking for trouble.  It is bound to break when widely deployed and
>>>     
>>
>> It's no different from the way major-minor numbering works on the Linux
>> kernel: they uniquely identify a device.
>
> Bad example.  Quite a lot of modern devices drivers are using dynamic  
> major/minor numbers because they have proven to be such a pain in the  
> butt.  That's why we have more sophisticated mechanisms like udev for  
> userspace to make use of.

Let me explain how we came to this numbering: we first had support for
'naming' ports and the names were obtained by userspace programs by an
ioctl. Rusty suggested to use some numbering scheme where some ports
could exist at predefined locations so that we wouldn't need the naming
and the ioctls around it.

> We'll definitely need some way to support dynamic vmchannels.  Static  
> allocation of ports is just not going to work.  If we did a userspace  
> daemon, I'd suggest using some sort of universal identifier that's easy  
> to manage in a distributed fashion.  Like a reverse fqdn.
>
> So for instance, I could have an "com.ibm.my-awesome-channel" and never  
> have to worry about conflicts.

Hm, we could have something like a "class" of ports instead of the
current minor-number scheme: each port exposes what class it belongs to,
like

-virtioserial unix:/tmp/foo,class=stream -virtioserial
unix:/tmp/bar,class=console

>>> guest/host configs don't match.  It also doesn't fit comfortably when
>>> you have, say, bob and alice both logged in with desktops on separate
>>> VTs.  Clashes are inevitable, as third-party apps pick N values for
>>> themselves then get distributed - unless N values can be large
>>> (/dev/vmch44324 == kernelstats...).
>>>     
>>
>> Hm, so there can be one daemon on the guest handling all clipboard
>> events. There's some work done already by the fast-user-switch support
>> and that can be extended to daemons that talk over virtio-serial.
>>   
>
> You could have one daemon that manages all vmchannel sessions.  It can  
> then expose channels to apps via whatever mechanism is best.  It could  
> use unix domain sockets, sys v ipc, whatever floats your boat.
>
> And, you can build this daemon today using the existing vmchannel over  
> TCP/IP.  You could also make it support serial devices.  We could also  
> introduce a custom usb device and use libusb.  libusb is portable to  
> Windows and Linux.

There are some other problems with usb too: It's not transparent to
users. Any hotplug event could alert users and that's not desired. It's
a system-only thing and should also remain that way.

		Amit
