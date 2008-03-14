From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH] virtio_net/virtio_ring: fix race in enable_cb
Date: Fri, 14 Mar 2008 14:17:05 +0100
Message-ID: <200803141417.05696.borntraeger__30307.4194620878$1205500900$gmane$org@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

There is a race in virtio_net, dealing with disabling/enabling the callback.
I saw the following oops:

kernel BUG at /space/kvm/drivers/virtio/virtio_ring.c:218!
illegal operation: 0001 [#1] SMP
Modules linked in: sunrpc dm_mod
CPU: 2 Not tainted 2.6.25-rc1zlive-host-10623-gd358142-dirty #99
Process swapper (pid: 0, task: 000000000f85a610, ksp: 000000000f873c60)
Krnl PSW : 0404300180000000 00000000002b81a6 (vring_disable_cb+0x16/0x20)
           R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:0 CC:3 PM:0 EA:3
Krnl GPRS: 0000000000000001 0000000000000001 0000000010005800 0000000000000001
           000000000f3a0900 000000000f85a610 0000000000000000 0000000000000000
           0000000000000000 000000000f870000 0000000000000000 0000000000001237
           000000000f3a0920 000000000010ff74 00000000002846f6 000000000fa0bcd8
Krnl Code: 00000000002b819a: a7110001           tmll    %r1,1
           00000000002b819e: a7840004           brc     8,2b81a6
           00000000002b81a2: a7f40001           brc     15,2b81a4
          >00000000002b81a6: a51b0001           oill    %r1,1
           00000000002b81aa: 40102000           sth     %r1,0(%r2)
           00000000002b81ae: 07fe               bcr     15,%r14
           00000000002b81b0: eb7ff0380024       stmg    %r7,%r15,56(%r15)
           00000000002b81b6: a7f13e00           tmll    %r15,15872
Call Trace:
([<000000000fa0bcd0>] 0xfa0bcd0)
 [<00000000002b8350>] vring_interrupt+0x5c/0x6c
 [<000000000010ab08>] do_extint+0xb8/0xf0
 [<0000000000110716>] ext_no_vtime+0x16/0x1a
 [<0000000000107e72>] cpu_idle+0x1c2/0x1e0

The problem can be triggered with a high amount of host->guest traffic.
I think its the following race:

poll says netif_rx_complete
poll calls enable_cb
enable_cb opens the interrupt mask
a new packet comes, an interrupt is triggered----\
enable_cb sees that there is more work           |
enable_cb disables the interrupt                 |
       .                                         V
       .                            interrupt is delivered
       .                            skb_recv_done does atomic napi test, ok
 some waiting                       disable_cb is called->check fails->bang!
       .					
poll would do napi check
poll would do disable_cb

The fix is to let enable_cb not disable the interrupt again, but expect the
caller to do the cleanup if it returns false. In that case, the interrupt is
only disabled, if the napi test_set_bit was successful.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

---
 drivers/net/virtio_net.c     |    6 +++++-
 drivers/virtio/virtio_ring.c |    1 -
 2 files changed, 5 insertions(+), 2 deletions(-)

Index: kvm/drivers/net/virtio_net.c
===================================================================
--- kvm.orig/drivers/net/virtio_net.c
+++ kvm/drivers/net/virtio_net.c
@@ -203,8 +203,11 @@ again:
 	if (received < budget) {
 		netif_rx_complete(vi->dev, napi);
 		if (unlikely(!vi->rvq->vq_ops->enable_cb(vi->rvq))
-		    && netif_rx_reschedule(vi->dev, napi))
+		    && napi_schedule_prep(napi)) {
+			vi->rvq->vq_ops->disable_cb(vi->rvq);
+			__netif_rx_schedule(vi->dev, napi);
 			goto again;
+		}
 	}
 
 	return received;
@@ -282,6 +285,7 @@ again:
 		 * means some were used in the meantime. */
 		if (unlikely(!vi->svq->vq_ops->enable_cb(vi->svq))) {
 			printk("Unlikely: restart svq failed\n");
+			vi->svq->vq_ops->disable_cb(vi->svq);
 			netif_start_queue(dev);
 			goto again;
 		}
Index: kvm/drivers/virtio/virtio_ring.c
===================================================================
--- kvm.orig/drivers/virtio/virtio_ring.c
+++ kvm/drivers/virtio/virtio_ring.c
@@ -232,7 +232,6 @@ static bool vring_enable_cb(struct virtq
 	vq->vring.avail->flags &= ~VRING_AVAIL_F_NO_INTERRUPT;
 	mb();
 	if (unlikely(more_used(vq))) {
-		vq->vring.avail->flags |= VRING_AVAIL_F_NO_INTERRUPT;
 		END_USE(vq);
 		return false;
 	}
