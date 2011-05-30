From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCHv2 10/14] virtio_net: limit xmit polling
Date: Mon, 30 May 2011 15:57:39 +0930
Message-ID: <8739jwk8is.fsf__46492.4401989721$1306737176$gmane$org@rustcorp.com.au>
References: <cover.1305846412.git.mst@redhat.com>
	<aced8619c07018b5495f9ceb2c02d4fbf897a098.1305846412.git.mst@redhat.com>
	<877h9kvlps.fsf@rustcorp.com.au>
	<20110522121008.GA12155@redhat.com>
	<87boyutbjg.fsf@rustcorp.com.au>
	<20110523111900.GB27212@redhat.com>
	<8739k3k1fb.fsf@rustcorp.com.au>
	<20110525060759.GC26352@redhat.com>
	<87vcwyjg2w.fsf@rustcorp.com.au> <20110528200204.GB7046@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110528200204.GB7046@redhat.com>
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

On Sat, 28 May 2011 23:02:04 +0300, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Thu, May 26, 2011 at 12:58:23PM +0930, Rusty Russell wrote:
> > ie. free two packets for every one we're about to add.  For steady state
> > that would work really well.
> 
> Sure, with indirect buffers, but if we
> don't use indirect (and we discussed switching indirect off
> dynamically in the past) this becomes harder to
> be sure about. I think I understand why but
> does not a simple capacity check make it more obvious?

...

> >  Then we hit the case where the ring
> > seems full after we do the add: at that point, screw latency, and just
> > try to free all the buffers we can.
> 
> I see. But the code currently does this:
> 
> 	for(..)
> 		get_buf
> 	add_buf
> 	if (capacity < max_sk_frags+2) {
> 		if (!enable_cb)
> 			for(..)
> 				get_buf
> 	}
> 
> 
> In other words the second get_buf is only called
> in the unlikely case of race condition.
> 
> So we'll need to add *another* call to get_buf.
> Is it just me or is this becoming messy?

Yes, good point.  I really wonder if anyone would be able to measure the
difference between simply freeing 2 every time (with possible extra
stalls for strange cases) and the more complete version.

But it runs against my grain to implement heuristics when one more call
would make it provably reliable.

Please find a way to make that for loop less ugly though!

Thanks,
Rusty.
