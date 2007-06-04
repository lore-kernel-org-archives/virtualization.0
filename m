From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [Xen-devel] Re: [kvm-devel] [PATCH RFC 1/3]
	virtio	infrastructure
Date: Mon, 4 Jun 2007 20:32:15 +1000
Message-ID: <20070604103215.GA31704__38181.8984555595$1180953258$gmane$org@gondor.apana.org.au>
References: <1180613947.11133.58.camel@localhost.localdomain>
	<46610E8D.10706@qumranet.com>
	<1180777836.9228.44.camel@localhost.localdomain>
	<46625192.5020108@qumranet.com>
	<1180866540.17442.74.camel@localhost.localdomain>
	<4662A86A.7010706@qumranet.com>
	<1180914836.17442.104.camel@localhost.localdomain>
	<4663E18D.4030007@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4663E18D.4030007@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@qumranet.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Xen Mailing List <xen-devel@lists.xensource.com>, "jmk@plan9.bell-labs.com" <jmk@plan9.bell-labs.com>, kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <cborntra@de.ibm.com>, Suzanne McIntosh <skranjac@us.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 04, 2007 at 12:55:25PM +0300, Avi Kivity wrote:
> 
> Networking hardware generally services descriptors in a FIFO manner.  
> virtio may not (for example, it may offload copies of larger packets to 
> a dma engine such as I/OAT, resulting in a delay, but copy smaller 
> packets immediately).  that means that there will be some mismatch 
> between virtio drivers and real hardware drivers.

You're free to do that in the process but before your packets leave
the backend you've got to make sure that they haven't been reordered.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
