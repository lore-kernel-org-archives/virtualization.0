From: Carsten Otte <cotte@de.ibm.com>
Subject: Re: [kvm-devel] [PATCH RFC 3/3] virtio infrastructure: example block
 driver
Date: Fri, 01 Jun 2007 09:10:20 +0200
Message-ID: <465FC65C.6020905__45592.1442517594$1180681875$gmane$org@de.ibm.com>
References: <1180613947.11133.58.camel@localhost.localdomain>
	<1180614044.11133.61.camel@localhost.localdomain>
	<1180614091.11133.63.camel@localhost.localdomain>
	<465EC637.7020504@de.ibm.com>
	<1180654765.10999.6.camel@localhost.localdomain>
Reply-To: carsteno@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1180654765.10999.6.camel@localhost.localdomain>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Xen Mailing List <xen-devel@lists.xensource.com>, "jmk@plan9.bell-labs.com" <jmk@plan9.bell-labs.com>, Herbert Xu <herbert@gondor.apana.org.au>, carsteno@de.ibm.com, mschwid2@linux.vnet.ibm.com, virtualization <virtualization@lists.linux-foundation.org>, kvm-devel <kvm-devel@lists.sourceforge.net>, Suzanne McIntosh <skranjac@us.ibm.com>, Jens Axboe <jens.axboe@oracle.com>, Christian Borntraeger <cborntra@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> Now my lack of block-layer knowledge is showing.  I would have thought
> that if we want to do things like ionice(1) to work, we have to do some
> guest scheduling or pass that information down to the host.
Yea that would only work on the host: one can use ionice to set the io 
niceness of the entire guest. Individual processes inside the guest 
are opaque to the host, and thus are opaque to its io scheduler.

>> It seems preferable to do that in the host, especially when requests 
>> of multiple guests end up on the same physical media (shared access, 
>> or partitioned).
> 
> What's the overhead in doing both?
With regard to compute power needed, almost none. The penalty is 
latency, not overhead: A small request may sit on the request queue to 
wait for other work to arrive until the queue gets unplugged. This 
penality is compensated by the benefit of a good chance that more 
requests will be merged during this time period.
If we have this method both in host and guest, we have twice the 
penalty with no added benefit.

On the other hand, if we choose to hook into q->make_request_fn, we do 
end up doing far more hypercalls: bios do not get merged on the guest 
side.  We must do a hypercall per bio in this scenario, or we'll end 
up adding latency again. In contrast, we can submit the entire content 
of the queue with a single hypercall when calling at do_request().

A third way out of that situation is to do queueing between guest and 
host: on the first bio, guest does a hypercall. When the next bio 
arrives, guest sees that the host has not finished processing the 
queue yet and pushes another buffer without doing a notification. 
We've also implemented this, with the result that our host stack was 
quick enough to practically always process the bio before the guest 
had the chance to submit another one. Performance was a nightmare, so 
we discontinued pursuing that idea.

so long,
Carsten
