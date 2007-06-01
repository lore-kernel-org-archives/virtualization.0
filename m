From: "Santos, Jose Renato G" <joserenato.santos@hp.com>
Subject: RE: [Xen-devel] [PATCH RFC 1/3] virtio infrastructure
Date: Fri, 1 Jun 2007 23:35:26 -0000
Message-ID: <08CA2245AFCF444DB3AC415E47CC40AFBD2CCF__24791.9008056217$1180741066$gmane$org@G3W0072.americas.hpqcorp.net>
References: <1180613947.11133.58.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <1180613947.11133.58.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, kvm-devel <kvm-devel@lists.sourceforge.net>, Xen Mailing List <xen-devel@lists.xensource.com>, virtualization <virtualization@lists.linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, jmk@plan9.bell-labs.com, Herbert Xu <herbert@gondor.apana.org.au>, Christian Borntraeger <cborntra@de.ibm.com>, Suzanne McIntosh <skranjac@us.ibm.com>, Anthony Liguori <anthony@codemonkey.ws>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

 

> -----Original Message-----
> From: xen-devel-bounces@lists.xensource.com 
> [mailto:xen-devel-bounces@lists.xensource.com] On Behalf Of 
> Rusty Russell
> Sent: Thursday, May 31, 2007 5:19 AM
> To: kvm-devel; Xen Mailing List; virtualization
> Cc: Jimi Xenidis; Stephen Rothwell; jmk@plan9.bell-labs.com; 
> Herbert Xu; Christian Borntraeger; Suzanne McIntosh; Anthony 
> Liguori; Martin Schwidefsky
> Subject: [Xen-devel] [PATCH RFC 1/3] virtio infrastructure
> 
> This attempts to implement a "virtual I/O" layer which should 
> allow common drivers to be efficiently used across most 
> virtual I/O mechanisms.  It will no-doubt need further enhancement.
> 
>

Rusty

Could you please clarify what is the purpose of this "virtual I/O"
layer?
At least for networking, why isn't the current linux net device
abstraction sufficient for hiding the details of different virtual
devices implementations? What am I missing?

Thanks

Renato
