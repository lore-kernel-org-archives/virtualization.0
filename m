From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH RFC 2/3] Virtio draft III: example net driver
Date: Thu, 28 Jun 2007 21:20:40 +1000
Message-ID: <1183029641.12401.36.camel__5672.15270498327$1183029771$gmane$org@localhost.localdomain>
References: <1181217762.14054.192.camel@localhost.localdomain>
	<1181999552.6237.255.camel@localhost.localdomain>
	<1181999669.6237.257.camel@localhost.localdomain>
	<1181999825.6237.260.camel@localhost.localdomain>
	<467FDEAD.4030204@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <467FDEAD.4030204@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: brking@linux.vnet.ibm.com
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Xen Mailing List <xen-devel@lists.xensource.com>, "jmk@plan9.bell-labs.com" <jmk@plan9.bell-labs.com>, Herbert Xu <herbert@gondor.apana.org.au>, kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <cborntra@de.ibm.com>, Latchesar Ionkov <lionkov@lanl.gov>, Suzanne McIntosh <skranjac@us.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2007-06-25 at 10:26 -0500, Brian King wrote: 
> I've started to look at these patches to figure out how easily I
> could convert the ibmveth driver to use this new infrastructure
> and have ran into a few issues. So far the two biggest issues I've
> encountered are:

Hi Brian,

	Thanks for looking at this!  Sorry for the slow reply, I've been
travelling.

> 1. The add_inbuf interface passes an sg list. This causes problems for
>    ibmveth since its rx buffers cannot be scatterlists.
> 2. The user of this API does not have access to the sk_buf. This causes
>    issues for ibmveth since it needs to reserve the first 8 bytes of the
>    rx buffer for use by the firmware. It currently uses skb_reserve to do this.
> 
> Would it be simpler to just pass an sk_buf rather than the scatterlist
> on these interfaces for virtio_net users?

It would be easier, but not suitable for block and other devices which
use the same interface.  Fortunately, I think there are solutions to
your issues.

1. 1500 byte packets will always be 1 sg long (ie. you should BUG_ON()
if that ever happens).  The issue is MTU > PAGE_SIZE, where I was
planning to allocate discontig pages.  I can't quite see what your
maximum supported MTU is, though?

2. The header problem is difficult (I can't resist pointing out that if
you had sg receive capability, it would be trivial 8).  The two
possibilities are to have get_buf take a "unsigned long *off" as well,
or to have ibm_veth do a memmove.

memmove sounds horrible at first glance, but since the hypervisor has
just copied the packet I'm not sure we'll notice in practice.
Benchmarking should tell...

BTW, after Avi's comments I have a new virtio draft, but still debugging
my implementation.  It doesn't effect this discussion, but would involve
churn for an actual implementation if you've gotten that far...

Thanks,
Rusty.
