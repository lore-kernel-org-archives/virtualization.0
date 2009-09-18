From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] virtio_console: Add support for multiple ports for generic
	guest and host communication
Date: Fri, 18 Sep 2009 22:11:17 +0200
Message-ID: <4AB3E965.10300__32505.5056986914$1253304776$gmane$org@redhat.com>
References: <1252678386-17404-1-git-send-email-amit.shah@redhat.com>	<1252678386-17404-2-git-send-email-amit.shah@redhat.com>	<20090911170010.34c80f2d@linux.intel.com>	<20090911163806.GB25535@amit-x200.redhat.com>	<4AAA8838.1080106@codemonkey.ws>	<20090911173307.GB27046@amit-x200.redhat.com>	<4AAA8A56.3040707@codemonkey.ws>	<20090916112332.6bf981a5@linux.intel.com>	<4AB164A0.8000402@codemonkey.ws>
	<20090918170048.53ba8cf6@linux.intel.com>
	<4AB3C988.2040303@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4AB3C988.2040303@codemonkey.ws>
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
Cc: Amit Shah <amit.shah@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On 09/18/09 19:55, Anthony Liguori wrote:
>> So you need break, parity ... no be serious please
>
> Sure, why not?
>
> In QEMU, we have the ability to hook our devices directly to a physical
> serial device and we pass through break, parity, and the other serial
> device properties.

Yes for a emulated 16550.
No for virtio-console.

If you want the guest drive some silly piece of hardware which wants a 
serial mode != 8N1 or needs breaks you can't use virtio-console.

> Again, this is paravirtual serial device and I think it's entirely
> reasonable for people to hook up these ports in the guest directly to
> physical serial devices in the host.

Except that the paravirtual device named 'virtio-console' simply doesn't 
allow to set serial parameters such as parity, data bits and stop bits.

It is *really* just a (single) byte stream piped over a virtio ring.

The guest side happens to be connected to hvc, so you can use that as 
console, thus the name 'virtio-console'.

The plan is to extend that to multiple byte streams.  The streams can be 
hooked up to hvc (and one stream allways will be for backward 
compatibility reasons), giving you a text console.  Or they can be 
linked to a character device with a name tag (aka sysfs attribute), 
providing a named bidirectional byte stream for guest<->host communication.

>  From my perspective, this is a paravirtual serial device and nothing
> more.

It simply isn't, see above.

> All the discussion of things like guest copy/paste support is a
> bit silly.

Implementing transparent copy/paste support needs some communication 
channel between guest and host.  The multiport virtio console driver 
provides just that.

> This is the wrong way to approach that sort of thing because
> it's not something that belongs in the kernel at all.

Who claimed the copy/paste bits should go into the kernel?
They will not of course.

> Furthermore, the
> current proposal doesn't handle anything like save/restore which is
> needed for live migration.

That is something the host side (i.e. qemu) has to solve.
The guest will not care about it at all ;)

cheers,
   Gerd
