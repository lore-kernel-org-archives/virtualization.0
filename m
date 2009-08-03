From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Qemu-devel] Re: virtio-serial: An interface for host-guest
	communication
Date: Mon, 03 Aug 2009 14:57:01 -0500
Message-ID: <4A77410D.4090804__19391.6074735627$1249329507$gmane$org@codemonkey.ws>
References: <1248717876-17630-1-git-send-email-amit.shah@redhat.com>
	<4A6E0C9E.10908@codemonkey.ws> <20090727203214.GG15020@redhat.com>
	<20090727204627.GA32432@shareable.org>
	<4A6E3BDC.8050101@codemonkey.ws>
	<20090728140029.GA16067@amd.home.annexia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090728140029.GA16067@amd.home.annexia.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Amit Shah <amit.shah@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Richard W.M. Jones wrote:
> On Mon, Jul 27, 2009 at 06:44:28PM -0500, Anthony Liguori wrote:
>   
>> It really suggests that you need _one_ vmchannel that's exposed to  
>> userspace with a single userspace daemon that consumes it.
>>     
>
> ... or a more flexible API.  I don't like having fixed /dev/vmch*
> devices either.
>   

Have you considered using a usb serial device?  Something attractive 
about it is that a productid/vendorid can be specified which means that 
you can use that as a method of enumerating devices.

Hot add/remove is supported automagically.

Regards,

Anthony Liguori
