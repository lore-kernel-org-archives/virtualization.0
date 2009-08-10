From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Qemu-devel] Re: virtio-serial: An interface for host-guest
	communication
Date: Mon, 10 Aug 2009 09:27:01 -0500
Message-ID: <4A802E35.1040308@codemonkey.ws>
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
	<20090810065508.GA4499@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090810065508.GA4499@amit-x200.redhat.com>
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
> Let me explain how we came to this numbering: we first had support for
> 'naming' ports and the names were obtained by userspace programs by an
> ioctl. Rusty suggested to use some numbering scheme where some ports
> could exist at predefined locations so that we wouldn't need the naming
> and the ioctls around it.
>   

Fortunately, if you implement the naming scheme in userspace you get the 
best of both worlds ;-)

>>> Hm, so there can be one daemon on the guest handling all clipboard
>>> events. There's some work done already by the fast-user-switch support
>>> and that can be extended to daemons that talk over virtio-serial.
>>>   
>>>       
>> You could have one daemon that manages all vmchannel sessions.  It can  
>> then expose channels to apps via whatever mechanism is best.  It could  
>> use unix domain sockets, sys v ipc, whatever floats your boat.
>>
>> And, you can build this daemon today using the existing vmchannel over  
>> TCP/IP.  You could also make it support serial devices.  We could also  
>> introduce a custom usb device and use libusb.  libusb is portable to  
>> Windows and Linux.
>>     
>
> There are some other problems with usb too: It's not transparent to
> users. Any hotplug event could alert users and that's not desired.

I don't think this is true in practice.  Our goal is not to circumvent 
an OS's policy decisions either.

>  It's
> a system-only thing and should also remain that way.
>   

I don't buy this argument at all.  If you exposed a new usb device that 
no OS had a kernel driver, and you had a daemon running that watched for 
insertions of that device, what OS would that not work transparently on?

I think my fundamental argument boils down to two points.  1) we should 
not require new guest drivers unless we absolutely have to 2) we should 
always do things in userspace unless we absolutely have to do things in 
the kernel.

Adding new kernel drivers breaks support for enterprise Linux distros.  
Adding a userspace daemon does not.  Windows device drivers require 
signing which is very difficult to do.  There's a huge practical 
advantage in not requiring guest drivers.

Regards,

Anthony Liguori

> 		Amit
>   
