From: Rusty Russell <rusty@rustcorp.com.au>
Subject: RE: [Xen-devel] [PATCH RFC 1/3] virtio infrastructure
Date: Tue, 05 Jun 2007 11:44:52 +1000
Message-ID: <1181007892.25878.112.camel__37086.9403043345$1181008007$gmane$org@localhost.localdomain>
References: <1180613947.11133.58.camel@localhost.localdomain>
	<08CA2245AFCF444DB3AC415E47CC40AFBD2CCF@G3W0072.americas.hpqcorp.net>
	<1180779167.9228.66.camel@localhost.localdomain>
	<08CA2245AFCF444DB3AC415E47CC40AFBD2FD4@G3W0072.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <08CA2245AFCF444DB3AC415E47CC40AFBD2FD4@G3W0072.americas.hpqcorp.net>
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

On Mon, 2007-06-04 at 21:14 +0000, Santos, Jose Renato G wrote:
>   Thanks for clarifying your thinking. This helped me understand
>   your goals better.
>   I agree it would be nice to reduce the number of drivers as it
>   improves mantainability. However I am not convinced that
>   adding an IO virtualization layer will remove the need
>   for having different drivers for different virtualization
>   technologies.

>   It seems that we will still need specific devices drivers
>   for each different virtualization flavor. For example,
>   we will still need to have a specific Xen netfront 
>   device that talks to a backend device in dom0, using
>   page grants, and other Xen specific mechanisms.

Hi Renato,

	That definitely should be implementable as a virtio layer; it was one
of the design points.  I consulted with Herbert Xu early on in the
process, and I don't think it would be too painful.  The devil, of
course, is in the details.

>   It looks like  will still need to maintain all the virtual device 
>   drivers and in addition we will now have to maintain 
>   another virtualization layer. 

	That would be silly, yes.

>   I confess I don't know well any of the other virtualization
>   technologies besides Xen. Maybe for some of them there is
>   enough similarities that you could benefit from a common
>   virtualization layer, but I just can't see it yet. 

Well, S/390, PowerPC and UML both have virtual I/O already in the kernel
tree, as does Xen.  I believe VMWare have out-of-tree drivers.  KVM is
in tree, but currently doesn't have paravirtualized drivers. 
lguest is sitting in the -mm tree for merging in 2.6.23 with its own
drivers.

None of these drivers is optimal.  The Xen ones are closest, and they're
very Xen-specific and quite complex.  This is good, and as it gives
virtio drivers a target to beat 8)

Cheers,
Rusty.
