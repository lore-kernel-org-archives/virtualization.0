From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCHv2 10/14] virtio_net: limit xmit polling
Date: Thu, 26 May 2011 12:58:23 +0930
Message-ID: <87vcwyjg2w.fsf__9757.61188096858$1306542302$gmane$org@rustcorp.com.au>
References: <cover.1305846412.git.mst@redhat.com>
	<aced8619c07018b5495f9ceb2c02d4fbf897a098.1305846412.git.mst@redhat.com>
	<877h9kvlps.fsf@rustcorp.com.au>
	<20110522121008.GA12155@redhat.com>
	<87boyutbjg.fsf@rustcorp.com.au>
	<20110523111900.GB27212@redhat.com>
	<8739k3k1fb.fsf@rustcorp.com.au>
	<20110525060759.GC26352@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110525060759.GC26352@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Krishna Kumar <krkumar2@in.ibm.com>, Carsten Otte <cotte@de.ibm.com>, lguest@lists.ozlabs.org, Shirley Ma <xma@us.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org, habanero@linux.vnet.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, steved@us.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, Tom Lendacky <tahm@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 25 May 2011 09:07:59 +0300, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Wed, May 25, 2011 at 11:05:04AM +0930, Rusty Russell wrote:
> Hmm I'm not sure I got it, need to think about this.
> I'd like to go back and document how my design was supposed to work.
> This really should have been in commit log or even a comment.
> I thought we need a min, not a max.
> We start with this:
> 
> 	while ((c = (virtqueue_get_capacity(vq) < 2 + MAX_SKB_FRAGS) &&
> 		(skb = get_buf)))
> 		kfree_skb(skb);
> 	return !c;
> 
> This is clean and simple, right? And it's exactly asking for what we need.

No, I started from the other direction:

        for (i = 0; i < 2; i++) {
                skb = get_buf();
                if (!skb)
                        break;
                kfree_skb(skb);
        }

ie. free two packets for every one we're about to add.  For steady state
that would work really well.  Then we hit the case where the ring seems
full after we do the add: at that point, screw latency, and just try to
free all the buffers we can.

> on the normal path min == 2 so we're low latency but we keep ahead on
> average. min == 0 for the "we're out of capacity, we may have to stop
> the queue".
> 
> Does the above make sense at all?

It makes sense, but I think it's a classic case where incremental
improvements aren't as good as starting from scratch.

Cheers,
Rusty.
