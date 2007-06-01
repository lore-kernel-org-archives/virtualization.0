From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [kvm-devel] [PATCH RFC 3/3] virtio infrastructure: example
	block driver
Date: Fri, 1 Jun 2007 15:13:16 +0200
Message-ID: <20070601131315.GW32105__8436.19939773834$1180705827$gmane$org@kernel.dk>
References: <1180613947.11133.58.camel@localhost.localdomain>
	<1180614044.11133.61.camel@localhost.localdomain>
	<1180614091.11133.63.camel@localhost.localdomain>
	<465EC637.7020504@de.ibm.com>
	<1180654765.10999.6.camel@localhost.localdomain>
	<465FC65C.6020905@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <465FC65C.6020905@de.ibm.com>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Xen Mailing List <xen-devel@lists.xensource.com>, "jmk@plan9.bell-labs.com" <jmk@plan9.bell-labs.com>, Herbert Xu <herbert@gondor.apana.org.au>, kvm-devel <kvm-devel@lists.sourceforge.net>, mschwid2@linux.vnet.ibm.com, virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <cborntra@de.ibm.com>, Suzanne McIntosh <skranjac@us.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jun 01 2007, Carsten Otte wrote:
> Rusty Russell wrote:
> >Now my lack of block-layer knowledge is showing.  I would have thought
> >that if we want to do things like ionice(1) to work, we have to do some
> >guest scheduling or pass that information down to the host.
> Yea that would only work on the host: one can use ionice to set the io 
> niceness of the entire guest. Individual processes inside the guest 
> are opaque to the host, and thus are opaque to its io scheduler.
> 
> >>It seems preferable to do that in the host, especially when requests 
> >>of multiple guests end up on the same physical media (shared access, 
> >>or partitioned).
> >
> >What's the overhead in doing both?
> With regard to compute power needed, almost none. The penalty is 
> latency, not overhead: A small request may sit on the request queue to 
> wait for other work to arrive until the queue gets unplugged. This 
> penality is compensated by the benefit of a good chance that more 
> requests will be merged during this time period.
> If we have this method both in host and guest, we have twice the 
> penalty with no added benefit.

I don't buy that argument. We can easily expose the unplug delay, so you
can kill it at what ever level you want. Or you could just do it in the
driver right now, but that is a bit hackish.

> On the other hand, if we choose to hook into q->make_request_fn, we do 
> end up doing far more hypercalls: bios do not get merged on the guest 
> side.  We must do a hypercall per bio in this scenario, or we'll end 
> up adding latency again. In contrast, we can submit the entire content 
> of the queue with a single hypercall when calling at do_request().
> 
> A third way out of that situation is to do queueing between guest and 
> host: on the first bio, guest does a hypercall. When the next bio 
> arrives, guest sees that the host has not finished processing the 
> queue yet and pushes another buffer without doing a notification. 
> We've also implemented this, with the result that our host stack was 
> quick enough to practically always process the bio before the guest 
> had the chance to submit another one. Performance was a nightmare, so 
> we discontinued pursuing that idea.

I'd greatly prefer maintaing a request_fn interface for this. The
make_request_fn/request_fn call ratio is at least 1, and typically a lot
larger (4kb blocks, 128kb request not uncommon -> 32).

-- 
Jens Axboe
