From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [kvm-devel] [PATCH RFC 3/3] virtio infrastructure: example
	block driver
Date: Fri, 01 Jun 2007 09:39:25 +1000
Message-ID: <1180654765.10999.6.camel__39661.9084095166$1180654819$gmane$org@localhost.localdomain>
References: <1180613947.11133.58.camel@localhost.localdomain>
	<1180614044.11133.61.camel@localhost.localdomain>
	<1180614091.11133.63.camel@localhost.localdomain>
	<465EC637.7020504@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <465EC637.7020504@de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: carsteno@de.ibm.com
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Xen Mailing List <xen-devel@lists.xensource.com>, "jmk@plan9.bell-labs.com" <jmk@plan9.bell-labs.com>, Herbert Xu <herbert@gondor.apana.org.au>, kvm-devel <kvm-devel@lists.sourceforge.net>, mschwid2@linux.vnet.ibm.com, virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <cborntra@de.ibm.com>, Suzanne McIntosh <skranjac@us.ibm.com>, Jens Axboe <jens.axboe@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2007-05-31 at 14:57 +0200, Carsten Otte wrote:
> Rusty Russell wrote:
> > Example block driver using virtio.
> > 
> > The block driver uses outbufs with sg[0] being the request information
> > (struct virtio_blk_outhdr) with the type, sector and inbuf id.  For a
> > write, the rest of the sg will contain the data to be written.
> > 
> > The first segment of the inbuf is a result code (struct
> > virtio_blk_inhdr).  For a read, the rest of the sg points to the input
> > buffer.
> > 
> > TODO:
> > 	1) Ordered tag support.
> Implementing a do_request function has quite a few disadvantages over 
> hooking into q->make_request_fn. This way, we have the device plug 
> (latency), request merging, and I/O scheduling inside the guest.

Now my lack of block-layer knowledge is showing.  I would have thought
that if we want to do things like ionice(1) to work, we have to do some
guest scheduling or pass that information down to the host.

> It seems preferable to do that in the host, especially when requests 
> of multiple guests end up on the same physical media (shared access, 
> or partitioned).

What's the overhead in doing both?

Rusty.
