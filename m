From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Qemu-devel] Re: virtio-serial: An interface for
	host-guest	communication
Date: Mon, 10 Aug 2009 12:27:03 -0500
Message-ID: <4A805867.503__42460.3740954355$1249925371$gmane$org@codemonkey.ws>
References: <20090805175713.GB28738@shareable.org>	<4A79C8D9.5030606@codemonkey.ws>	<20090806103843.GC9222@amit-x200.redhat.com>	<4A7ADAC4.70902@codemonkey.ws>	<20090806134103.GC11733@amit-x200.redhat.com>	<4A7AE169.4000606@codemonkey.ws>	<20090806140404.GA12083@amit-x200.redhat.com>	<20090806173740.GA1178@shareable.org>	<20090807063800.GA16769@amit-x200.redhat.com>	<4A7C36D3.3040305@codemonkey.ws>
	<20090810065508.GA4499@amit-x200.redhat.com>
	<4A7FECCA.8080804@redhat.com> <4A801A7B.1020208@codemonkey.ws>
	<4A80287C.7050400@redhat.com> <4A802CA7.9020701@codemonkey.ws>
	<4A803E07.7080407@redhat.com> <4A8051F3.7040400@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4A8051F3.7040400@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori wrote:
>
> There is nothing sane about vmchannel.  It's just an attempt to bypass 
> QEMU which is going to introduce all sorts of complexities wrt 
> migration, guest compatibility, etc.
>
> However, as I've mentioned repeatedly, the reason I won't merge 
> virtio-serial is that it duplicates functionality with 
> virtio-console.  If the two are converged, I'm happy to merge it.  I'm 
> not opposed to having more functionality.

NB: the userspace interface for these devices should be a tty, not a new 
character device.

If you want to add a new bustype for these devices, and then have an 
entry in sysfs that had some sort of identification string, that's 
perfectly acceptable.

Also note though that this is exactly what usb-serial is today.  
/sys/bus/usbserial contains all the usb serial devices and you can get a 
vendor id/device id to uniquely identify the device type.

Using virtio vs. usb has it's advantage but the userspace interface 
model should be roughly equivalent.

Regards,

Anthony Liguori
