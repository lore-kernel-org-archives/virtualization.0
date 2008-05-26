From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: virtio_net: another race with virtio_net and enable_cb
Date: Mon, 26 May 2008 11:29:27 +0200
Message-ID: <200805261129.27718.borntraeger__25066.6068205193$1211794465$gmane$org@de.ibm.com>
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
To: Rusty Russell <rusty@rustcorp.com.au>, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Hello Rusty,

seems that we still have a problem with virtio_net and the enable_cb callback. 
During a long running network stress tests with virtio and got the following 
oops:

------------[ cut here ]------------
kernel BUG at drivers/virtio/virtio_ring.c:230!
illegal operation: 0001 [#1] SMP
Modules linked in:
CPU: 0 Not tainted 2.6.26-rc2-kvm-00436-gc94c08b-dirty #34
Process netserver (pid: 2582, task: 000000000fbc4c68, ksp: 000000000f42b990)
Krnl PSW : 0704c00180000000 00000000002d0ec8 (vring_enable_cb+0x1c/0x60)
           R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 EA:3
Krnl GPRS: 0000000000000000 0000000000000000 000000000ef3d000 0000000010009800
           0000000000000000 0000000000419ce0 0000000000000080 000000000000007b
           000000000adb5538 000000000ef40900 000000000ef40000 000000000ef40920
           0000000000000000 0000000000000005 000000000029c1b0 000000000fea7d18
Krnl Code: 00000000002d0ebc: a7110001           tmll    %r1,1
           00000000002d0ec0: a7740004           brc     7,2d0ec8
           00000000002d0ec4: a7f40001           brc     15,2d0ec6
          >00000000002d0ec8: a517fffe           nill    %r1,65534
           00000000002d0ecc: 40103000           sth     %r1,0(%r3)
           00000000002d0ed0: 07f0               bcr     15,%r0
           00000000002d0ed2: e31020380004       lg      %r1,56(%r2)
           00000000002d0ed8: a7480000           lhi     %r4,0
Call Trace:
([<000000000029c0fc>] virtnet_poll+0x290/0x3b8)
 [<0000000000333fb8>] net_rx_action+0x9c/0x1b8
 [<00000000001394bc>] __do_softirq+0x74/0x108
 [<000000000010d16a>] do_softirq+0x92/0xac
 [<0000000000139826>] irq_exit+0x72/0xc8
 [<000000000010a7b6>] do_extint+0xe2/0x104
 [<0000000000110508>] ext_no_vtime+0x16/0x1a
Last Breaking-Event-Address:
 [<00000000002d0ec4>] vring_enable_cb+0x18/0x60


I looked into the virtio_net code for some time and I think the following 
scenario happened. Please look at virtnet_poll:
[...]
        /* Out of packets? */
        if (received < budget) {
                netif_rx_complete(vi->dev, napi);
                if (unlikely(!vi->rvq->vq_ops->enable_cb(vi->rvq))
                    && napi_schedule_prep(napi)) {
                        vi->rvq->vq_ops->disable_cb(vi->rvq);
                        __netif_rx_schedule(vi->dev, napi);
                        goto again;
                }
        }

If an interrupt arrives after netif_rx_complete, a second poll routine can run 
on a different cpu. The second check for napi_schedule_prep would prevent any 
harm in the network stack, but we have called enable_cb possibly after the 
disable_cb in skb_recv_done. 

static void skb_recv_done(struct virtqueue *rvq)
{
        struct virtnet_info *vi = rvq->vdev->priv;
        /* Schedule NAPI, Suppress further interrupts if successful. */
        if (netif_rx_schedule_prep(vi->dev, &vi->napi)) {
                rvq->vq_ops->disable_cb(rvq);
                __netif_rx_schedule(vi->dev, &vi->napi);
        }
}

That means that the second poll routine runs with interrupts enabled, which is 
ok, since we can handle additional interrupts. The problem is now that the 
second poll routine might also call enable_cb, triggering the BUG.

The only solution I can come up with, is to remove the BUG statement in 
enable_cb - similar to disable_cb. Opinions or better ideas where the oops 
could come from?

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

---
 drivers/virtio/virtio_ring.c |    1 -
 1 file changed, 1 deletion(-)

Index: kvm/drivers/virtio/virtio_ring.c
===================================================================
--- kvm.orig/drivers/virtio/virtio_ring.c
+++ kvm/drivers/virtio/virtio_ring.c
@@ -227,7 +227,6 @@ static bool vring_enable_cb(struct virtq
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
 	START_USE(vq);
-	BUG_ON(!(vq->vring.avail->flags & VRING_AVAIL_F_NO_INTERRUPT));
 
 	/* We optimistically turn back on interrupts, then check if there was
 	 * more to do. */
