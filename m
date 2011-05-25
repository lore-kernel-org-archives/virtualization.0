From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv2 10/14] virtio_net: limit xmit polling
Date: Wed, 25 May 2011 09:07:59 +0300
Message-ID: <20110525060759.GC26352__24104.7230236747$1306303720$gmane$org@redhat.com>
References: <cover.1305846412.git.mst@redhat.com>
	<aced8619c07018b5495f9ceb2c02d4fbf897a098.1305846412.git.mst@redhat.com>
	<877h9kvlps.fsf@rustcorp.com.au>
	<20110522121008.GA12155@redhat.com>
	<87boyutbjg.fsf@rustcorp.com.au>
	<20110523111900.GB27212@redhat.com>
	<8739k3k1fb.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <8739k3k1fb.fsf@rustcorp.com.au>
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
Cc: Krishna Kumar <krkumar2@in.ibm.com>, Carsten Otte <cotte@de.ibm.com>, lguest@lists.ozlabs.org, Shirley Ma <xma@us.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org, habanero@linux.vnet.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, steved@us.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, Tom Lendacky <tahm@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 25, 2011 at 11:05:04AM +0930, Rusty Russell wrote:
> On Mon, 23 May 2011 14:19:00 +0300, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > I do understand how it seems a waste to leave direct space
> > in the ring while we might in practice have space
> > due to indirect. Didn't come up with a nice way to
> > solve this yet - but 'no worse than now :)'
> 
> Let's just make it "bool free_old_xmit_skbs(unsigned int max)".  max ==
> 2 for the normal xmit path, so we're low latency but we keep ahead on
> average.  max == -1 for the "we're out of capacity, we may have to stop
> the queue".
> 
> That keeps it simple and probably the right thing...
> 
> Thanks,
> Rusty.

Hmm I'm not sure I got it, need to think about this.
I'd like to go back and document how my design was supposed to work.
This really should have been in commit log or even a comment.
I thought we need a min, not a max.
We start with this:

	while ((c = (virtqueue_get_capacity(vq) < 2 + MAX_SKB_FRAGS) &&
		(skb = get_buf)))
		kfree_skb(skb);
	return !c;

This is clean and simple, right? And it's exactly asking for what we need.

But this way we always keep a lot of memory in skbs even when rate of
communication is low.

So we add the min parameter:

	int n = 0;

	while ((((c = (virtqueue_get_capacity(vq) < 2 + MAX_SKB_FRAGS)) ||
		 n++ < min) && (skb = get_buf)))
		kfree_skb(skb);
	return !c;


on the normal path min == 2 so we're low latency but we keep ahead on
average. min == 0 for the "we're out of capacity, we may have to stop
the queue".

Does the above make sense at all?

-- 
MST
