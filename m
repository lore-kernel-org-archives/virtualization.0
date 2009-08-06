From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [Qemu-devel] Re: virtio-serial: An interface for host-guest
	communication
Date: Thu, 6 Aug 2009 16:08:43 +0530
Message-ID: <20090806103843.GC9222__38453.1571333811$1249555182$gmane$org@amit-x200.redhat.com>
References: <1248717876-17630-1-git-send-email-amit.shah@redhat.com>
	<4A6E0C9E.10908@codemonkey.ws> <20090727203214.GG15020@redhat.com>
	<20090727204627.GA32432@shareable.org>
	<4A6E3BDC.8050101@codemonkey.ws>
	<20090728140029.GA16067@amd.home.annexia.org>
	<4A77410D.4090804@codemonkey.ws>
	<20090805175713.GB28738@shareable.org>
	<4A79C8D9.5030606@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4A79C8D9.5030606@codemonkey.ws>
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
Cc: qemu-devel@nongnu.org, Jamie Lokier <jamie@shareable.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Wed) Aug 05 2009 [13:00:57], Anthony Liguori wrote:
> Jamie Lokier wrote:
>> Anthony Liguori wrote:
>>   
>>> Richard W.M. Jones wrote:
>>> Have you considered using a usb serial device?  Something attractive  
>>> about it is that a productid/vendorid can be specified which means 
>>> that you can use that as a method of enumerating devices.
>>>
>>> Hot add/remove is supported automagically.
>>>     
>>
>> The same applies to PCI: productid/vendorid (and subids);
>> PCI hotplug is possible though not as native as USB.
>>   
>
> What's nice about USB is that HID specifies quite a few functional  
> generic devices that can be extended to increase functionality.  This  
> means you can implement a more sophisticated usb device that satisfies  
> the serial interface, provide a special more featureful driver for  
> Linux, and just use normal serial for Windows.
>
> The downside is that USB emulation stinks.

And the virtio code is pretty simple and self-contained. I don't see why
we'd restrict us more to use something else.

>> Here's another idea: Many devices these days have a serial number or
>> id string.  E.g. USB storage, ATA drives, media cards, etc.  Linux
>> these days creates alias device nodes which include the id string in
>> the device name.  E.g. /dev/disks/by-id/ata-FUJITSU_MHV2100BH_NWAQT662615H
>>
>> So in addition to (or instead of) /dev/vmch0, /dev/vmch1 etc.,
>> Linux guests could easily generate:
>>
>>     /dev/vmchannel/by-role/clipboard-0
>>     /dev/vmchannel/by-role/gueststats-0
>>     /dev/vmchannel/by-role/vmmanager-0
>>
>> It's not necessary to do this at the beginning.  All that is needed is
>> to provide enough id information that will appear in /sys/..., so that
>> that a udev policy for naming devices can be created at some later date.
>
> Well my thinking is that the "clipboard" device actually becomes a USB  
> serial device.  It's easy to enumerate and detect via the existing Linux  
> infrastructure.  Plus usb drivers can be implemented in userspace which  
> is a nice plus (cross platform too via libusb).

Sure; but there's been no resistance from anyone from including the
virtio-serial device driver so maybe we don't need to discuss that.

		Amit
