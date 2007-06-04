From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [kvm-devel] [PATCH RFC 1/3] virtio	infrastructure
Date: Mon, 04 Jun 2007 21:19:24 +1000
Message-ID: <1180955964.25878.27.camel__5460.3974022486$1180956165$gmane$org@localhost.localdomain>
References: <1180613947.11133.58.camel@localhost.localdomain>
	<46610E8D.10706@qumranet.com>
	<1180777836.9228.44.camel@localhost.localdomain>
	<46625192.5020108@qumranet.com>
	<1180866540.17442.74.camel@localhost.localdomain>
	<4662A86A.7010706@qumranet.com>
	<1180914836.17442.104.camel@localhost.localdomain>
	<4663E18D.4030007@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Xen Mailing List <xen-devel@lists.xensource.com>, "jmk@plan9.bell-labs.com" <jmk@plan9.bell-labs.com>, Herbert Xu <herbert@gondor.apana.org.au>, kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <cborntra@de.ibm.com>, Suzanne McIntosh <skranjac@us.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2007-06-04 at 12:55 +0300, Avi Kivity wrote:
> Rusty Russell wrote:
> > On Sun, 2007-06-03 at 14:39 +0300, Avi Kivity wrote:
> >   
> >> Rusty Russell wrote:
> >>     
> >>> Hmm... Perhaps I should move the used arrays into the "struct
> >>> virtio_device" and guarantee that the id (returned by add_*buf) is an
> >>> index into that.  Then we can trivially add a corresponding bit array. 
> >>>       
> >> That may force the virtio backend to do things it doesn't want to.
> >>     
> >
> > Well, I have two implementations, and both ids already fit this model so
> > I have some confidence.  I just need to add the set_bit/clear_bit to the
> > read/write one, and use sync_clear_bit to the descriptor-based one
> > (which I suspect will actually get a little cleaner).
> >
> > So I think this constraint is a reasonable thing to add anyway.
> 
> Some hardware (tulip IIRC, but long time ago) allows linked list based 
> descriptors.  If a virtio implementation takes a similar approach, it 
> may not have an array of descriptors.

Sure, but the mapping becomes non-trivial only if you have no ceiling on
the number in flight at any time.  OTOH, it's a very nice property for
driver authors.  I'll send the diffs once debugging is done...

> Networking hardware generally services descriptors in a FIFO manner.

Well, ethernet guarantees order.  Not sure about others tho...

> virtio may not (for example, it may offload copies of larger packets to 
> a dma engine such as I/OAT, resulting in a delay, but copy smaller 
> packets immediately).  that means that there will be some mismatch 
> between virtio drivers and real hardware drivers.

I think your point is that the completion bitmap (or indeed, the current
approach) does not maintain order?  Hmm, this is more convincing to me
than cache arguments, since some devices might want ordering and want
more than a single io in flight.

I shall ponder this more deeply...

Thanks!
Rusty.
