From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [Qemu-devel] Re: virtio: Add memory statistics reporting to the
	balloon driver
Date: Wed, 11 Nov 2009 10:29:13 +1030
Message-ID: <200911111029.13791.rusty__18303.5182454207$1257897604$gmane$org@rustcorp.com.au>
References: <1257782838.2835.5.camel@aglitke>
	<200911101312.02650.rusty@rustcorp.com.au>
	<4AF97A5E.1070801@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4AF97A5E.1070801@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Anthony Liguori <aliguori@us.ibm.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 11 Nov 2009 01:06:14 am Anthony Liguori wrote:
> Rusty Russell wrote:
> > On Tue, 10 Nov 2009 03:02:06 am Adam Litke wrote:
> >   
> >> A simpler approach is to collect memory statistics in the virtio
> >> balloon driver and communicate them to the host via the device config space.
> >>     
> >
> > There are two issues I see with this.  First, there's an atomicity problem
> > since you can't tell when the stats are consistent.
> 
> Actually, config writes always require notification from the guest to 
> the host.  This means the host knows when they config space is changed 
> so atomicity isn't a problem.

I think you missed my point: the stats are inter-related, so they should be
served together.

> In fact, if it were a problem, then the balloon driver would be 
> fundamentally broken because target and actual are stored in the config 
> space.

No, one is written by the host, the other the guest.  Still works.

> If you recall, we had this discussion originally wrt the balloon driver :-)

And I never did get around to the lguest implementation, which would have
seen if this really is an issue.

> >   Second, polling is ugly.
> 
> As opposed to?

As opposed to giving the stats whenever asked by the host.

> > A stats vq might solve this more cleanly?
> >   
> 
> actual and target are both really just stats.  Had we implemented those 
> with a vq, I'd be inclined to agree with you but since they're 
> implemented in the config space, it seems natural to extend the config 
> space with other stats.

It does, *if* we don't need accuracy.  Otherwise, it seems like we need
something else.

Cheers,
Rusty.
