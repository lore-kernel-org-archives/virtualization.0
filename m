From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Xen-devel] new barrier type for paravirt (was Re: [PATCH]
	virtio_ring: use smp_store_mb)
Date: Mon, 21 Dec 2015 13:52:44 +0200
Message-ID: <20151221134325-mutt-send-email-mst@redhat.com>
References: <1450347932-16325-1-git-send-email-mst@redhat.com>
	<20151217105238.GA6375@twins.programming.kicks-ass.net>
	<20151217131554-mutt-send-email-mst@redhat.com>
	<20151217135726.GA6344@twins.programming.kicks-ass.net>
	<20151217161124-mutt-send-email-mst@redhat.com>
	<20151217143910.GD6344@twins.programming.kicks-ass.net>
	<20151220105146-mutt-send-email-mst@redhat.com>
	<5677D8D5.7080700@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5677D8D5.7080700@citrix.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Vrabel <david.vrabel@citrix.com>
Cc: Ian Campbell <ian.campbell@citrix.com>, Peter Zijlstra <peterz@infradead.org>, qemu-devel@nongnu.org, Alexander Duyck <alexander.duyck@gmail.com>, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Dec 21, 2015 at 10:47:49AM +0000, David Vrabel wrote:
> On 20/12/15 09:25, Michael S. Tsirkin wrote:
> > 
> > I noticed that drivers/xen/xenbus/xenbus_comms.c uses
> > full memory barriers to communicate with the other side.
> > For example:
> > 
> >                 /* Must write data /after/ reading the consumer index.  * */
> >                 mb();
> > 
> >                 memcpy(dst, data, avail);
> >                 data += avail;
> >                 len -= avail;
> >         
> >                 /* Other side must not see new producer until data is * there. */
> >                 wmb();
> >                 intf->req_prod += avail;
> >                 
> >                 /* Implies mb(): other side will see the updated producer. */
> >                 notify_remote_via_evtchn(xen_store_evtchn);
> > 
> > To me, it looks like for guests compiled with CONFIG_SMP, smp_wmb and smp_mb
> > would be sufficient, so mb() and wmb() here are only needed if
> > a non-SMP guest runs on an SMP host.
> > 
> > Is my analysis correct?
> 
> For x86, yes.
> 
> For arm/arm64 I think so, but would prefer one of the Xen arm
> maintainers to confirm.  In particular, whether inner-shareable barriers
> are sufficient for memory shared with the hypervisor.
> 
> > So what I'm suggesting is something like the below patch,
> > except instead of using virtio directly, a new set of barriers
> > that behaves identically for SMP and non-SMP guests will be introduced.
> > 
> > And of course the weak barriers flag is not needed for Xen -
> > that's a virtio only thing.
> > 
> > For example:
> > 
> > smp_pv_wmb()
> > smp_pv_rmb()
> > smp_pv_mb()
> 
> The smp_ prefix doesn't make a lot of sense to me here since these
> barriers are going to be the same whether the kernel is SMP or not.
> 
> David

Guest kernel - yes. But it's only needed because you
are running on an SMP host.

-- 
MST
