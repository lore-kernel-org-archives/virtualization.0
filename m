From: "Santos, Jose Renato G" <joserenato.santos@hp.com>
Subject: RE: [Xen-devel] [PATCH RFC 1/3] virtio infrastructure
Date: Tue, 5 Jun 2007 02:05:31 -0000
Message-ID: <08CA2245AFCF444DB3AC415E47CC40AFBD30B4__49315.9231999472$1181009205$gmane$org@G3W0072.americas.hpqcorp.net>
References: <1180613947.11133.58.camel@localhost.localdomain>	<08CA2245AFCF444DB3AC415E47CC40AFBD2CCF@G3W0072.americas.hpqcorp.net>	<1180779167.9228.66.camel@localhost.localdomain>
	<08CA2245AFCF444DB3AC415E47CC40AFBD2FD4@G3W0072.americas.hpqcorp.net>
	<466481ED.8050209@goop.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <466481ED.8050209@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Xen Mailing List <xen-devel@lists.xensource.com>, jmk@plan9.bell-labs.com, Herbert Xu <herbert@gondor.apana.org.au>, kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <cborntra@de.ibm.com>, Suzanne McIntosh <skranjac@us.ibm.com>, Anthony Liguori <anthony@codemonkey.ws>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

 

> -----Original Message-----
> From: Jeremy Fitzhardinge [mailto:jeremy@goop.org] 
> Sent: Monday, June 04, 2007 2:20 PM
> To: Santos, Jose Renato G
> Cc: Rusty Russell; Jimi Xenidis; Stephen Rothwell; Xen 
> Mailing List; jmk@plan9.bell-labs.com; Herbert Xu; kvm-devel; 
> virtualization; Christian Borntraeger; Suzanne McIntosh; 
> Anthony Liguori; Martin Schwidefsky
> Subject: Re: [Xen-devel] [PATCH RFC 1/3] virtio infrastructure
> 
> Santos, Jose Renato G wrote:
> >   It seems that we will still need specific devices drivers
> >   for each different virtualization flavor. For example,
> >   we will still need to have a specific Xen netfront 
> >   device that talks to a backend device in dom0, using
> >   page grants, and other Xen specific mechanisms.
> >   It looks like  will still need to maintain all the virtual device 
> >   drivers and in addition we will now have to maintain 
> >   another virtualization layer. 
> >   
> 
> The hope is that the Xen-specific elements of the driver will 
> be restricted to Xen-specific things like grant tables, and 
> the bulk of the driver and its logic can be common.  Whether 
> that can be achieved and still retain the full 
> performance/features of the entirely Xen-specific netfront 
> driver remains to be seen.  I haven't had a chance to look at 
> doing any Xen-virtio glue yet, so I'm not really sure how it 
> will work out.
> 
>     J
> 

  Ok, if you share some common code this could be beneficial, but
  in the specific case of Xen networking I believe most of netfront
  code is Xen specific.  I think that a generic "virtual-IO" layer 
  would not be beneficial in this case, but instead it would 
  only add extra complexity to glue the layers.
  I don't know if this will be the case for other
  virtualization technologies, but I think it would be useful to  
  have a better understanding of exactly which code could
  be shared before proposing something like this to the linux 
  mantainers.
  I think it will probably not be accepted upstream if
  there is no clear evidence of code sharing. And if the sharing
  is not uniform across all virtualization technologies, 
  we should keep an option of bypassing the virtio layer when
  it does not help or when it makes code more complex (which
  I suspect will be the case for Xen networking).

  Just my 2 cents,

  Regards
  Renato
