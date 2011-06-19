From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC] virtio: Support releasing lock during kick
Date: Sun, 19 Jun 2011 10:48:41 +0300
Message-ID: <20110619074841.GA8613__28427.6081285954$1308469759$gmane$org@redhat.com>
References: <1277328242-10685-1-git-send-email-stefanha@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1277328242-10685-1-git-send-email-stefanha@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
Cc: axboe@kernel.dk, hch@infradead.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jun 23, 2010 at 10:24:02PM +0100, Stefan Hajnoczi wrote:
> The virtio block device holds a lock during I/O request processing.
> Kicking the virtqueue while the lock is held results in long lock hold
> times and increases contention for the lock.

As you point out the problem with dropping
and getting this lock in the request function is
that we double the number of atomics here.

How about we teach the block core to call a separate
function with spinlock not held? This way we don't need
to do extra lock/unlock operations, and kick can be
done with lock not held and interrupts enabled.


diff --git a/block/blk-core.c b/block/blk-core.c
index 4ce953f..a8672ec 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -433,6 +433,8 @@ void blk_run_queue(struct request_queue *q)
 	spin_lock_irqsave(q->queue_lock, flags);
 	__blk_run_queue(q);
 	spin_unlock_irqrestore(q->queue_lock, flags);
+	if (q->request_done)
+		q->request_done(q);
 }
 EXPORT_SYMBOL(blk_run_queue);
 

-- 
MST
