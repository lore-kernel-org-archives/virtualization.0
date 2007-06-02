From: Rusty Russell <rusty@rustcorp.com.au>
Subject: RE: [Xen-devel] [PATCH RFC 1/3] virtio infrastructure
Date: Sat, 02 Jun 2007 20:12:47 +1000
Message-ID: <1180779167.9228.66.camel__742.768371901725$1180779242$gmane$org@localhost.localdomain>
References: <1180613947.11133.58.camel@localhost.localdomain>
	<08CA2245AFCF444DB3AC415E47CC40AFBD2CCF@G3W0072.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <08CA2245AFCF444DB3AC415E47CC40AFBD2CCF@G3W0072.americas.hpqcorp.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Santos, Jose Renato G" <joserenato.santos@hp.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Xen Mailing List <xen-devel@lists.xensource.com>, jmk@plan9.bell-labs.com, Herbert Xu <herbert@gondor.apana.org.au>, kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <cborntra@de.ibm.com>, Suzanne McIntosh <skranjac@us.ibm.com>, Anthony Liguori <anthony@codemonkey.ws>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2007-06-01 at 23:35 +0000, Santos, Jose Renato G wrote:
> 
> > -----Original Message-----
> > From: xen-devel-bounces@lists.xensource.com 
> > [mailto:xen-devel-bounces@lists.xensource.com] On Behalf Of 
> > Rusty Russell
> > Sent: Thursday, May 31, 2007 5:19 AM
> > To: kvm-devel; Xen Mailing List; virtualization
> > Cc: Jimi Xenidis; Stephen Rothwell; jmk@plan9.bell-labs.com; 
> > Herbert Xu; Christian Borntraeger; Suzanne McIntosh; Anthony 
> > Liguori; Martin Schwidefsky
> > Subject: [Xen-devel] [PATCH RFC 1/3] virtio infrastructure
> > 
> > This attempts to implement a "virtual I/O" layer which should 
> > allow common drivers to be efficiently used across most 
> > virtual I/O mechanisms.  It will no-doubt need further enhancement.
> 
> Rusty
> 
> Could you please clarify what is the purpose of this "virtual I/O"
> layer?
> At least for networking, why isn't the current linux net device
> abstraction sufficient for hiding the details of different virtual
> devices implementations? What am I missing?

Hi Renato!

	This is a very good question.  For currently-existing and working
devices it just seems like another layer of indirection, and not much
code saving.

	There are several reasons for having a common layer.  The obvious is to
reduce the amount of code, but that's the least important.  Slightly
more important is that noone wants to maintain and tune 5 different
virtual net drivers, 5 different virtual block drivers, etc.  In fact,
the kernel community will start to rebel at some point, especially if
they want different optimization hooks deeper into the kernel.

	We expect to see new device types (entropy device, anyone?), and so the
5 different drivers becomes the 5 x N different drivers.  Eventually we
may come up with common bus and probing which everyone loves, but until
then we can at least make it simple for each virtualization technology
to implement the new XYZZY device.

	Finally, virtual I/O techniques are *moving*.  KVM doesn't really have
one, XenSource are discussing more changes to theirs (at least for
networking) and lguest is still looking for an efficient one.  No doubt
the others would love to use clean and optimal Linux drivers, too (UML,
S/390, Power, VMWare?).

	When Linux doesn't provide a model of what it expects from virtual
devices, one end of the design process is untethered: we've already seen
some fairly random and gratuitously different results.  If we can
provide a simple interface which we like it encourages new
implementations to produce Linux-friendly interfaces.

	Of course, the new interface must not suck.

I hope that clarifies my thinking?
Rusty.
