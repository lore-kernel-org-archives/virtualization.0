From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCHv2] virtio: use smp_XX barriers on SMP
Date: Sat, 30 Jan 2010 15:22:44 +1030
Message-ID: <201001301522.45118.rusty@rustcorp.com.au>
References: <20100127224222.GA31545@redhat.com>
	<201001290744.59324.rusty@rustcorp.com.au>
	<20100129112718.GC6548@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20100129112718.GC6548@redhat.com>
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 29 Jan 2010 09:57:18 pm Michael S. Tsirkin wrote:
> On Fri, Jan 29, 2010 at 07:44:59AM +1030, Rusty Russell wrote:
> > These barriers are actually trying to make sure in_use is set in a timely
> > manner (this is debug code).  They're bogus AFAICT:
> 
> So .. let's just drop these barriers, and replace in_use with an atomic?

Nope, just deleted them.  See below.

Thanks!
Rusty.

virtio: remove bogus barriers from DEBUG version of virtio_ring.c

With DEBUG defined, we add an ->in_use flag to detect if the caller
invokes two virtio methods in parallel.  The barriers attempt to ensure
timely update of the ->in_use flag.

But they're voodoo: if we need these barriers it implies that the
calling code doesn't have sufficient synchronization to ensure the
code paths aren't invoked at the same time anyway, and we want to
detect it.

Also, adding barriers changes timing, so turning on debug has more
chance of hiding real problems.

Thanks to MST for drawing my attention to this code...

CC: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/virtio/virtio_ring.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -36,10 +36,9 @@
 			panic("%s:in_use = %i\n",		\
 			      (_vq)->vq.name, (_vq)->in_use);	\
 		(_vq)->in_use = __LINE__;			\
-		mb();						\
 	} while (0)
 #define END_USE(_vq) \
-	do { BUG_ON(!(_vq)->in_use); (_vq)->in_use = 0; mb(); } while(0)
+	do { BUG_ON(!(_vq)->in_use); (_vq)->in_use = 0; } while(0)
 #else
 #define BAD_RING(_vq, fmt, args...)				\
 	do {							\
