From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [Xen-devel] Re: [kvm-devel] [PATCH RFC 1/3] virtio
	infrastructure
Date: Mon, 04 Jun 2007 09:53:56 +1000
Message-ID: <1180914836.17442.104.camel__38634.8673179329$1180914932$gmane$org@localhost.localdomain>
References: <1180613947.11133.58.camel@localhost.localdomain>
	<46610E8D.10706@qumranet.com>
	<1180777836.9228.44.camel@localhost.localdomain>
	<46625192.5020108@qumranet.com>
	<1180866540.17442.74.camel@localhost.localdomain>
	<4662A86A.7010706@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4662A86A.7010706@qumranet.com>
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

On Sun, 2007-06-03 at 14:39 +0300, Avi Kivity wrote:
> Rusty Russell wrote:
> > Hmm... Perhaps I should move the used arrays into the "struct
> > virtio_device" and guarantee that the id (returned by add_*buf) is an
> > index into that.  Then we can trivially add a corresponding bit array. 
> 
> That may force the virtio backend to do things it doesn't want to.

Well, I have two implementations, and both ids already fit this model so
I have some confidence.  I just need to add the set_bit/clear_bit to the
read/write one, and use sync_clear_bit to the descriptor-based one
(which I suspect will actually get a little cleaner).

So I think this constraint is a reasonable thing to add anyway.

> > This also makes the "id" easier to use from the driver side: if we add a
> > "max_id" field it can size its own arrays if it wants to.  Gets rid of
> > the linked-list in the block driver...
> >   
> 
> How about
> 
>     struct virtio_completion {
>         unsigned long length;
>         void *data;
>     };
> 
>     int virtio_complete(struct virtio_completion *completions, int nr);
> 
> where 'data' is an opaque pointer passed by the device during add_*buf()?

Other than the fact that the driver will look less like a normal driver,
it's actually harder to write the net driver if that complete call can
happen off an interrupt: we can't free skbs in interrupt context, which
is why the used-outbuf cleanup is currently done (inefficiently, but
that's orthogonal) in the xmit routine.

I'll code up the modifications now and check if I'm right about the
impact on the code.  I might have to come up with something else...

Cheers,
Rusty.
