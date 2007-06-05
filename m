From: Rusty Russell <rusty@rustcorp.com.au>
Subject: RE: [Xen-devel] [PATCH RFC 1/3] virtio infrastructure
Date: Tue, 05 Jun 2007 12:27:08 +1000
Message-ID: <1181010428.25878.137.camel__42866.3607723594$1181010495$gmane$org@localhost.localdomain>
References: <1180613947.11133.58.camel@localhost.localdomain>
	<08CA2245AFCF444DB3AC415E47CC40AFBD2CCF@G3W0072.americas.hpqcorp.net>
	<1180779167.9228.66.camel@localhost.localdomain>
	<08CA2245AFCF444DB3AC415E47CC40AFBD2FD4@G3W0072.americas.hpqcorp.net>
	<466481ED.8050209@goop.org>
	<08CA2245AFCF444DB3AC415E47CC40AFBD30B4@G3W0072.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <08CA2245AFCF444DB3AC415E47CC40AFBD30B4@G3W0072.americas.hpqcorp.net>
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

On Tue, 2007-06-05 at 02:05 +0000, Santos, Jose Renato G wrote:

> > From: Jeremy Fitzhardinge [mailto:jeremy@goop.org] 
> > The hope is that the Xen-specific elements of the driver will 
> > be restricted to Xen-specific things like grant tables, and 
> > the bulk of the driver and its logic can be common.  Whether 
> > that can be achieved and still retain the full 
> > performance/features of the entirely Xen-specific netfront 
> > driver remains to be seen.  I haven't had a chance to look at 
> > doing any Xen-virtio glue yet, so I'm not really sure how it 
> > will work out.
> > 
> >     J
> > 
> 
>   Ok, if you share some common code this could be beneficial, but
>   in the specific case of Xen networking I believe most of netfront
>   code is Xen specific.  I think that a generic "virtual-IO" layer 
>   would not be beneficial in this case, but instead it would 
>   only add extra complexity to glue the layers.

This is precisely the plan: to code it up and look hard at it.  If
performance gets hurt, it's a lose.  If performance is equal and the
code is clearer, it's a win, and this is my goal.

Perhaps you underestimate how much of the Xen netfront driver is
actually dealing with things which *any* efficient virtio I/O netdriver
will have to wrestle with.

Thanks!
Rusty.
