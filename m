From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [Qemu-devel] Re: virtio-serial: An interface for
	host-guest	communication
Date: Mon, 10 Aug 2009 17:57:25 +0200
Message-ID: <4A804365.6010106__22629.9230162569$1249919895$gmane$org@redhat.com>
References: <20090805175713.GB28738@shareable.org>	<4A79C8D9.5030606@codemonkey.ws>	<20090806103843.GC9222@amit-x200.redhat.com>	<4A7ADAC4.70902@codemonkey.ws>	<20090806134103.GC11733@amit-x200.redhat.com>	<4A7AE169.4000606@codemonkey.ws>	<20090806140404.GA12083@amit-x200.redhat.com>	<20090806173740.GA1178@shareable.org>	<20090807063800.GA16769@amit-x200.redhat.com>	<4A7C36D3.3040305@codemonkey.ws>	<20090810065508.GA4499@amit-x200.redhat.com>
	<4A802E35.1040308@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4A802E35.1040308@codemonkey.ws>
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
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 08/10/09 16:27, Anthony Liguori wrote:

> I think my fundamental argument boils down to two points. 1) we should
> not require new guest drivers unless we absolutely have to

Allow guest drivers is fine though I guess?

> 2) we should
> always do things in userspace unless we absolutely have to do things in
> the kernel.

Wrong.  There are often good reasons to do stuff in kernel, even if you 
can do it in userspace too.

> Adding new kernel drivers breaks support for enterprise Linux distros.
> Adding a userspace daemon does not. Windows device drivers require
> signing which is very difficult to do. There's a huge practical
> advantage in not requiring guest drivers.

Ok, so the virtio-serial + usbserial combo should work well then I think.

If you have guest drivers you'll go the virtio-serial route.
If you don't have guest drivers you can go the usbserial route, either 
via /dev/ttyUSB or via libusb.

We can also have a libvmchannel as abstraction layer on top of this.

cheers,
   Gerd
