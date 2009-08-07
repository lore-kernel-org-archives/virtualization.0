From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [Qemu-devel] Re: virtio-serial: An interface for host-guest
	communication
Date: Fri, 7 Aug 2009 12:08:00 +0530
Message-ID: <20090807063800.GA16769__42466.3931284615$1249627244$gmane$org@amit-x200.redhat.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090806173740.GA1178@shareable.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jamie Lokier <jamie@shareable.org>
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

On (Thu) Aug 06 2009 [18:37:40], Jamie Lokier wrote:
> Amit Shah wrote:
> > On (Thu) Aug 06 2009 [08:58:01], Anthony Liguori wrote:
> > > Amit Shah wrote:
> > >> On (Thu) Aug 06 2009 [08:29:40], Anthony Liguori wrote:
> > >>   
> > >>> Amit Shah wrote:
> > >>>     
> > >>>> Sure; but there's been no resistance from anyone from including the
> > >>>> virtio-serial device driver so maybe we don't need to discuss that.
> > >>>>         
> > >>> There certainly is from me.  The userspace interface is not 
> > >>> reasonable  for guest applications to use.
> > >>>     
> > >>
> > >> One example that would readily come to mind is dbus. A daemon running on
> > >> the guest that reads data off the port and interacts with the desktop by
> > >> appropriate dbus commands. All that's needed is a stream of bytes and
> > >> virtio-serial provides just that.
> > >>   
> > >
> > > dbus runs as an unprivileged user, how does dbus know which  
> > > virtio-serial port to open and who sets the permissions on that port?
> > 
> > The permission part can be handled by package maintainers and sysadmins
> > via udev policies.
> > 
> > So all data destined for dbus consumption gets to a daemon and that
> > daemon then sends it over to dbus.
> 
> virtio-serial is nice, easy, simple and versatile.  We like that; it
> should stay that way.
> 
> dbus isn't a good match for this.
> 
> dbus is not intended for communication between hosts, by design.

Oh; I don't mean to say dbus on the host will communicate directly with
dbus on the guest via virtio-serial. I'm just saying there'll be some
daemon on the guest and if there's a request for, say, updating guest
clipboard with some contents, it can be passed on to dbus on the guest.

> It depends on per-app configuration files in
> /etc/dbus/{session,system}.d/, which are expected to match the
> installed services.
> 
> For this, the guest's files in /etc/dbus/ would have to match the QEMU
> host host services in detail.  dbus doesn't have a good mechanism for
> copying with version skew between both of them, because normally
> everything resides on the same machine and the config and service are
> updated at the same time.  This is hard to guarantee with a VM.

Right. Not proposing this at all.

> Apart from dbus, hard-coded meanings of small N in /dev/vmchN are
> asking for trouble.  It is bound to break when widely deployed and

It's no different from the way major-minor numbering works on the Linux
kernel: they uniquely identify a device. Or the way tcp port number
works. In the same way, /dev/vmchN will uniquely identify some function
over a port. You idea of introducing a symlink to /dev/clipboard is a
good one and it takes one udev rule to generate that link.

> guest/host configs don't match.  It also doesn't fit comfortably when
> you have, say, bob and alice both logged in with desktops on separate
> VTs.  Clashes are inevitable, as third-party apps pick N values for
> themselves then get distributed - unless N values can be large
> (/dev/vmch44324 == kernelstats...).

Hm, so there can be one daemon on the guest handling all clipboard
events. There's some work done already by the fast-user-switch support
and that can be extended to daemons that talk over virtio-serial.

> Sysadmins shouldn't have to hand-configure each app, and shouldn't
> have to repair clashes in defaults.  Just Work is better.

No; they shouldn't need to.

> virtio-serial is nice.  The only ugly part is _finding_ the right
> /dev/vmchN.
> 
> Fortunately, _any_ out-of-band id string or id number makes it perfect.
> 
> An option to specify PCI vendor/product ids in the QEMU host
> configuration is good enough.
> 
> An option to specify one or more id strings is nicer.
> 
> Finally, Anthony hit on an interesting idea with USB.  Emulating USB
> sucks.  But USB's _descriptors_ are quite effective, and the USB basic
> protocol is quite reasonable too.
> 
> Descriptors are just a binary blob in a particular format, which
> describe a device and also say what it supports, and what standard
> interfaces can be used with it too.  Bluetooth is similar; they might
> even use the same byte format, I'm not sure.

And doing something similar is akin to populating some files in /sys.

> All the code for parsing USB descriptors is already present in guest
> kernels, and the code for making appropriate device nodes and
> launching apps is already in udev.  libusb also allows devices to be
> used without a kernel driver, and is cross-platform.  There are plenty
> of examples of creating USB descriptors in QEMU, and may be the code
> can be reused.
> 
> The only down side of USB is that emulating it sucks :-)  That's mainly
> due to the host controllers, and the way interrupts use polling.
> 
> So here's a couple of ideas:
> 
>    - virtio-usb, using virtio instead of a hardware USB host
>      controller.  That would provide all the features of USB
>      naturally, like hotplug, device binding, access from userspace,
>      but with high performance, low overhead, and no interrupt polling.

I wonder how that's any different or less complex that virtio-serial.
Essentially the idea is the same. It's just the name that's different,
the way I see it.

>      You'd even have the option of cross-platform guest apps, as well
>      as working on all Linux versions, by emulating a host controller
>      when the guest doesn't have virtio-usb.
> 
>      As a bonus, existing USB support would be accelerated.
> 
>    - virtio-serial providing a binary id blob, whose format is the
>      same as USB descriptors.  Reuse the guest's USB parsing and
>      binding to find and identify, but the actual device functionality
>      would just be a byte pipe.
> 
>      That might be simple, as all it involves is a blob passed to the
>      guest from QEMU.  QEMU would build the id blob, maybe reusing
>      existing USB code, and the guest would parse the blob as it
>      already does for USB devices, with udev creating devices as it
>      already does.

Hm, making a very simple transport into something complicated involving
a few more subsystems just to expose a usb device which functions as a
char device in the end. I don't see a big benefit. People are deploying
virtio anyway for block and net. I don't see why using the same
transport for a char device would be an impediment.

		Amit
