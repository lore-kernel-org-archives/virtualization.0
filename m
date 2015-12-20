From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: new barrier type for paravirt (was Re: [PATCH] virtio_ring: use
	smp_store_mb)
Date: Sun, 20 Dec 2015 11:25:58 +0200
Message-ID: <20151220105146-mutt-send-email-mst@redhat.com>
References: <1450347932-16325-1-git-send-email-mst@redhat.com>
	<20151217105238.GA6375@twins.programming.kicks-ass.net>
	<20151217131554-mutt-send-email-mst@redhat.com>
	<20151217135726.GA6344@twins.programming.kicks-ass.net>
	<20151217161124-mutt-send-email-mst@redhat.com>
	<20151217143910.GD6344@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20151217143910.GD6344@twins.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, qemu-devel@nongnu.org, Alexander Duyck <alexander.duyck@gmail.com>, linux-kernel@vger.kernel.org, David Vrabel <david.vrabel@citrix.com>, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Dec 17, 2015 at 03:39:10PM +0100, Peter Zijlstra wrote:
> On Thu, Dec 17, 2015 at 04:33:44PM +0200, Michael S. Tsirkin wrote:
> > On Thu, Dec 17, 2015 at 02:57:26PM +0100, Peter Zijlstra wrote:
> > > 
> > > You could of course go fix that instead of mutilating things into
> > > sort-of functional state.
> > 
> > Yes, we'd just need to touch all architectures, all for
> > the sake of UP which almost no one uses.
> > Basically, we need APIs that explicitly are
> > for talking to another kernel on a different CPU on
> > the same SMP system, and implemented identically
> > between CONFIG_SMP and !CONFIG_SMP on all architectures.
> > 
> > Do you think this is something of general usefulness,
> > outside virtio?
> 
> I'm not aware of any other case, but if there are more parts of virt
> that need this then I see no problem adding it.

When I wrote this, I assumed there are no other users, and I'm still not
sure there are other users at the moment. Do you see a problem then?

> That is, virt in general is the only use-case that I can think of,
> because this really is an artifact of interfacing with an SMP host while
> running an UP kernel.

Or another guest kernel on an SMP host.

> But I'm really not familiar with virt, so I do not know if there's more
> sites outside of virtio that could use this.
> Touching all archs is a tad tedious, but its fairly straight forward.

So I looked and I was only able to find other another possible user in Xen.

Cc Xen folks.

I noticed that drivers/xen/xenbus/xenbus_comms.c uses
full memory barriers to communicate with the other side.
For example:

                /* Must write data /after/ reading the consumer index.  * */
                mb();

                memcpy(dst, data, avail);
                data += avail;
                len -= avail;
        
                /* Other side must not see new producer until data is * there. */
                wmb();
                intf->req_prod += avail;
                
                /* Implies mb(): other side will see the updated producer. */
                notify_remote_via_evtchn(xen_store_evtchn);

To me, it looks like for guests compiled with CONFIG_SMP, smp_wmb and smp_mb
would be sufficient, so mb() and wmb() here are only needed if
a non-SMP guest runs on an SMP host.

Is my analysis correct?

So what I'm suggesting is something like the below patch,
except instead of using virtio directly, a new set of barriers
that behaves identically for SMP and non-SMP guests will be introduced.

And of course the weak barriers flag is not needed for Xen -
that's a virtio only thing.

For example:

smp_pv_wmb()
smp_pv_rmb()
smp_pv_mb()

I'd like to get confirmation from Xen folks before posting
this patchset.

Comments/suggestions?

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

--

compile-tested only.

diff --git a/drivers/xen/xenbus/xenbus_comms.c b/drivers/xen/xenbus/xenbus_comms.c
index fdb0f33..a28f049 100644
--- a/drivers/xen/xenbus/xenbus_comms.c
+++ b/drivers/xen/xenbus/xenbus_comms.c
@@ -36,6 +36,7 @@
 #include <linux/interrupt.h>
 #include <linux/sched.h>
 #include <linux/err.h>
+#include <linux/virtio_ring.h>
 #include <xen/xenbus.h>
 #include <asm/xen/hypervisor.h>
 #include <xen/events.h>
@@ -123,14 +124,14 @@ int xb_write(const void *data, unsigned len)
 			avail = len;
 
 		/* Must write data /after/ reading the consumer index. */
-		mb();
+		virtio_mb(true);
 
 		memcpy(dst, data, avail);
 		data += avail;
 		len -= avail;
 
 		/* Other side must not see new producer until data is there. */
-		wmb();
+		virtio_wmb(true);
 		intf->req_prod += avail;
 
 		/* Implies mb(): other side will see the updated producer. */
@@ -180,14 +181,14 @@ int xb_read(void *data, unsigned len)
 			avail = len;
 
 		/* Must read data /after/ reading the producer index. */
-		rmb();
+		virtio_rmb(true);
 
 		memcpy(data, src, avail);
 		data += avail;
 		len -= avail;
 
 		/* Other side must not see free space until we've copied out */
-		mb();
+		virtio_mb(true);
 		intf->rsp_cons += avail;
 
 		pr_debug("Finished read of %i bytes (%i to go)\n", avail, len);

-- 
MST
