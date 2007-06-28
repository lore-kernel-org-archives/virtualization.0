From: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC 2/3] Virtio draft III: example net driver
Date: Thu, 28 Jun 2007 10:55:59 -0500
Message-ID: <4683DA0F.2010609__1272.57712088085$1183046262$gmane$org@linux.vnet.ibm.com>
References: <1181217762.14054.192.camel@localhost.localdomain>
	<1181999552.6237.255.camel@localhost.localdomain>
	<1181999669.6237.257.camel@localhost.localdomain>
	<1181999825.6237.260.camel@localhost.localdomain>
	<467FDEAD.4030204@linux.vnet.ibm.com>
	<1183029641.12401.36.camel@localhost.localdomain>
Reply-To: brking@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1183029641.12401.36.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Xen Mailing List <xen-devel@lists.xensource.com>, "jmk@plan9.bell-labs.com" <jmk@plan9.bell-labs.com>, Herbert Xu <herbert@gondor.apana.org.au>, kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <cborntra@de.ibm.com>, Latchesar Ionkov <lionkov@lanl.gov>, Suzanne McIntosh <skranjac@us.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> 1. 1500 byte packets will always be 1 sg long (ie. you should BUG_ON()
> if that ever happens).  The issue is MTU > PAGE_SIZE, where I was
> planning to allocate discontig pages.  I can't quite see what your
> maximum supported MTU is, though?

The current maximum supported MTU for ibmveth is 64k. Additionally,
the firmware interface for ibmveth allows for multiple rx "pools" of
different sizes to be allocated and given to the hypervisor. Depending
on the incoming packet size, the smallest buffer is then chosen. Just
something to keep in mind as you look at adding large frame support. I'm
not sure what requirements other users would have...

> 2. The header problem is difficult (I can't resist pointing out that if
> you had sg receive capability, it would be trivial 8).  The two
> possibilities are to have get_buf take a "unsigned long *off" as well,
> or to have ibm_veth do a memmove.
> 
> memmove sounds horrible at first glance, but since the hypervisor has
> just copied the packet I'm not sure we'll notice in practice.
> Benchmarking should tell...

memmove definitely does not sound optimal. I would definitely prefer returning
an offset on get_buf, but when I get something up and running I could
certainly run some benchmarks.

> BTW, after Avi's comments I have a new virtio draft, but still debugging
> my implementation.  It doesn't effect this discussion, but would involve
> churn for an actual implementation if you've gotten that far...

I've started working on some code, but only to get a better handle on the API
and see what issues ibmveth might run into. I was expecting some code churn
yet at this stage..

-Brian


-- 
Brian King
Linux on Power Virtualization
IBM Linux Technology Center
