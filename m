From: "Santos, Jose Renato G" <joserenato.santos@hp.com>
Subject: RE: [Xen-devel] [PATCH RFC 1/3] virtio infrastructure
Date: Mon, 4 Jun 2007 21:14:01 -0000
Message-ID: <08CA2245AFCF444DB3AC415E47CC40AFBD2FD4__41715.5349547558$1180991828$gmane$org@G3W0072.americas.hpqcorp.net>
References: <1180613947.11133.58.camel@localhost.localdomain>
	<08CA2245AFCF444DB3AC415E47CC40AFBD2CCF@G3W0072.americas.hpqcorp.net>
	<1180779167.9228.66.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <1180779167.9228.66.camel@localhost.localdomain>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Xen Mailing List <xen-devel@lists.xensource.com>, jmk@plan9.bell-labs.com, Herbert Xu <herbert@gondor.apana.org.au>, kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <cborntra@de.ibm.com>, Suzanne McIntosh <skranjac@us.ibm.com>, Anthony Liguori <anthony@codemonkey.ws>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

 

> -----Original Message-----
> From: Rusty Russell [mailto:rusty@rustcorp.com.au] 
> Sent: Saturday, June 02, 2007 3:13 AM
> To: Santos, Jose Renato G
> Cc: kvm-devel; Xen Mailing List; virtualization; Jimi 
> Xenidis; Stephen Rothwell; jmk@plan9.bell-labs.com; Herbert 
> Xu; Christian Borntraeger; Suzanne McIntosh; Anthony Liguori; 
> Martin Schwidefsky
> Subject: RE: [Xen-devel] [PATCH RFC 1/3] virtio infrastructure
> 
> 
> Hi Renato!
> 
> 	This is a very good question.  For currently-existing 
> and working devices it just seems like another layer of 
> indirection, and not much code saving.
> 
> 	There are several reasons for having a common layer.  
> The obvious is to reduce the amount of code, but that's the 
> least important.  Slightly more important is that noone wants 
> to maintain and tune 5 different virtual net drivers, 5 
> different virtual block drivers, etc.  In fact, the kernel 
> community will start to rebel at some point, especially if 
> they want different optimization hooks deeper into the kernel.
> 

  Rusty,

  Thanks for clarifying your thinking. This helped me understand
  your goals better.
  I agree it would be nice to reduce the number of drivers as it
  improves mantainability. However I am not convinced that
  adding an IO virtualization layer will remove the need
  for having different drivers for different virtualization
  technologies.
  It seems that we will still need specific devices drivers
  for each different virtualization flavor. For example,
  we will still need to have a specific Xen netfront 
  device that talks to a backend device in dom0, using
  page grants, and other Xen specific mechanisms.
  It looks like  will still need to maintain all the virtual device 
  drivers and in addition we will now have to maintain 
  another virtualization layer. 
  I confess I don't know well any of the other virtualization
  technologies besides Xen. Maybe for some of them there is
  enough similarities that you could benefit from a common
  virtualization layer, but I just can't see it yet. 
  
  Regards

  Renato
  
> 	We expect to see new device types (entropy device, 
> anyone?), and so the
> 5 different drivers becomes the 5 x N different drivers.  
> Eventually we may come up with common bus and probing which 
> everyone loves, but until then we can at least make it simple 
> for each virtualization technology to implement the new XYZZY device.
> 
> 	Finally, virtual I/O techniques are *moving*.  KVM 
> doesn't really have one, XenSource are discussing more 
> changes to theirs (at least for
> networking) and lguest is still looking for an efficient one. 
>  No doubt the others would love to use clean and optimal 
> Linux drivers, too (UML, S/390, Power, VMWare?).
> 
> 	When Linux doesn't provide a model of what it expects 
> from virtual devices, one end of the design process is 
> untethered: we've already seen some fairly random and 
> gratuitously different results.  If we can provide a simple 
> interface which we like it encourages new implementations to 
> produce Linux-friendly interfaces.
> 
> 	Of course, the new interface must not suck.
> 
> I hope that clarifies my thinking?
> Rusty.
> 
> 
