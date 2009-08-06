From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [Qemu-devel] Re: virtio-serial: An interface for host-guest
	communication
Date: Thu, 6 Aug 2009 16:05:53 +0530
Message-ID: <20090806103553.GB9222__48242.8138763227$1249555015$gmane$org@amit-x200.redhat.com>
References: <1248717876-17630-1-git-send-email-amit.shah@redhat.com>
	<4A6E0C9E.10908@codemonkey.ws> <20090727203214.GG15020@redhat.com>
	<20090727204627.GA32432@shareable.org>
	<4A6E3BDC.8050101@codemonkey.ws>
	<20090728140029.GA16067@amd.home.annexia.org>
	<4A77410D.4090804@codemonkey.ws>
	<20090805175713.GB28738@shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090805175713.GB28738@shareable.org>
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
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Anthony Liguori <anthony@codemonkey.ws>, qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

On (Wed) Aug 05 2009 [18:57:13], Jamie Lokier wrote:
> Anthony Liguori wrote:
> > Richard W.M. Jones wrote:
> > Have you considered using a usb serial device?  Something attractive 
> > about it is that a productid/vendorid can be specified which means that 
> > you can use that as a method of enumerating devices.
> > 
> > Hot add/remove is supported automagically.
> 
> The same applies to PCI: productid/vendorid (and subids);
> PCI hotplug is possible though not as native as USB.
> 
> Here's another idea: Many devices these days have a serial number or
> id string.  E.g. USB storage, ATA drives, media cards, etc.  Linux
> these days creates alias device nodes which include the id string in
> the device name.  E.g. /dev/disks/by-id/ata-FUJITSU_MHV2100BH_NWAQT662615H
> 
> So in addition to (or instead of) /dev/vmch0, /dev/vmch1 etc.,
> Linux guests could easily generate:
> 
>     /dev/vmchannel/by-role/clipboard-0
>     /dev/vmchannel/by-role/gueststats-0
>     /dev/vmchannel/by-role/vmmanager-0

That's interesting; worth a thought. When we actually have all the
parties together (libvirt, libguestfs, qemu) to decide which ports need
to act as which transports, we'll be able to add this.

> It's not necessary to do this at the beginning.  All that is needed is
> to provide enough id information that will appear in /sys/..., so that
> that a udev policy for naming devices can be created at some later date.

True.

		Amit
