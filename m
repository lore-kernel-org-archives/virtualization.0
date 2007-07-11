From: "Caitlin Bestler" <caitlinb@broadcom.com>
Subject: RE: [PATCH 3/3] Virtio draft IV: the net driver
Date: Wed, 11 Jul 2007 12:27:24 -0700
Message-ID: <1EF1E44200D82B47BD5BA61171E8CE9D0475D2F5@NT-IRVA-0750.brcm.ad.broadcom.com>
References: <1184153201.6005.618.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <1184153201.6005.618.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Carsten Otte <cotte@de.ibm.com>, virtualization@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, Herbert Xu <herbert@gondor.apana.org.au>
List-Id: virtualization@lists.linuxfoundation.org

virtualization-bounces@lists.linux-foundation.org wrote:
> On Wed, 2007-07-11 at 12:28 +0200, Christian Borntraeger wrote:
>> Am Mittwoch, 4. Juli 2007 schrieb Rusty Russell:
>>> +static void try_fill_recv(struct virtnet_info *vi)
> 
>> Hmm, so it allocates skbs until oom or until add_buf fails, right?
> 
> Yep.
> 
>> Do you expect the add_buf call to fail if we have enough buffers? Who
>> defines the amount of buffers we can add via add_buf?
> 
> There will be some internal limit on how many buffers the
> virtio implementation supports, but depends on that
> implementation.  It could be a number of buffers or a total number of
> descriptors. 
> 

I think one of the key tradeoffs here is simplicity versus flexibility.
A QP style interface is very explicit about the size of queues
(requested
and actual) and the size of queue entries (request maximum and actual
maximum), current depths, etc.

My reading of the proposed interface is that is it much much simpler
than all that. This takes flexibility away from the application, that
in theory *could* have adapted its behavior to different queue sizes,
and gives it to the specific implmentation (that can now do things like
variable-length work queue entries if it wants to).

The one thing I'd recommend avoiding is starting with a simple interface
and then tacking on one bell or whistle at a time. We should either keep

it simple or shift to a QP style interface and lean on all the research
and negotiations on what attributes are needed that has already taken
place
for RDMA related networking interfaces. It is also a pain for
implementations
to have to deal with multiple *detailed* queue interface requirements
that
all try to accomplish the same thing but insist on doing it differently.
If things are vague for one interface you have the flexibility to re-use
what another interface forced you to do.

But unless there are *specific* consumers who say they want specific
bells
and whistles my hunch would be to stick with the simple interface. Which
translates as "if you need to add a buffer, add it, let us worry about
it,
if you've gone too far we'll tell you."
