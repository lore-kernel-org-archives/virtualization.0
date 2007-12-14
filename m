From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: virtio_net and SMP guests
Date: Fri, 14 Dec 2007 13:12:05 +0100
Message-ID: <200712141312.05562.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
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
To: Rusty Russell <rusty@rustcorp.com.au>, Dor Laor <dor.laor@qumranet.com>, Anthony Liguori <aliguori@us.ibm.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty, Anthony, Dor,

I need your brain power :-)

On smp guests I have seen a problem with virtio (the version in curent Avi's
git) which do not occur on single processor guests:

kernel BUG at /space/kvm/drivers/virtio/virtio_ring.c:228!
illegal operation: 0001 [#1]
Modules linked in: ipv6
CPU:    2    Not tainted
Process swapper (pid: 0, task: 000000000f83e038, ksp: 000000000f877d70)
Krnl PSW : 0704000180000000 000000000045df2a (vring_restart+0x5a/0x70)
           R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:0 CC:0 PM:0 EA:3
Krnl GPRS: 00000000c0a80101 0000000000000000 000000000eb35000 0000000010005800
           000000000045ded0 000000000000192f 000000000eb21000 000000000eb21000
           000000000000000e 000000000eb21900 000000000eb21920 000000000f867cb8
           0700000000d9b058 0000000000000010 000000000045c06a 000000000f867cb8
Krnl Code: 000000000045df1e: e3b0b0700004       lg      %r11,112(%r11)
           000000000045df24: 07fe               bcr     15,%r14
           000000000045df26: a7f40001           brc     15,45df28
          >000000000045df2a: a7f4ffe1           brc     15,45deec
           000000000045df2e: e31020300004       lg      %r1,48(%r2)
           000000000045df34: a7480000           lhi     %r4,0
           000000000045df38: 96011001           oi      1(%r1),1
           000000000045df3c: a7f4ffef           brc     15,45df1a
Call Trace:
([<000000000045c016>] virtnet_poll+0x96/0x42c)
 [<000000000048cda2>] net_rx_action+0xca/0x150
 [<0000000000137f7a>] __do_softirq+0x9e/0x130
 [<00000000001105d6>] do_softirq+0xae/0xb4
 [<0000000000138182>] irq_exit+0x96/0x9c
 [<000000000010d710>] do_extint+0xcc/0xf8
 [<00000000001135d0>] ext_no_vtime+0x16/0x1a
 [<000000000010a57e>] cpu_idle+0x216/0x238


I think there is a valid code path, triggering this bug:

	CPU1						CPU2
-----------------------				-----------------------
- virtnet_poll found no
  more packets on queue
- netif_rx_complete allow
  poll to be called
- vq_ops->restart is called
- vq Interrupts are enabled	
	.		     <new packets arrive>
<vcpu is scheduled away>
	.					- interrupt is delivered
	.					- poll is called
	.					- poll work is done
	.					- netif_rx_complete
	.					- vq_ops->restart is called
	.					- check if vq interrupts are
	.					  enable --> BUG


The first idea was to remove this check? (See patch below). I am not sure
if the proper fix also requires to change vring.avail->flags to be only
changed by atomic bitops. Any ideas, comments?

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
CC: Anthony Liguori <aliguori@us.ibm.com>
CC: Dor Laor <dor.laor@qumranet.com>
CC: Rusty Russell <rusty@rustcorp.com.au>

---
 drivers/virtio/virtio_ring.c |    2 --
 1 file changed, 2 deletions(-)

Index: kvm/drivers/virtio/virtio_ring.c
===================================================================
--- kvm.orig/drivers/virtio/virtio_ring.c
+++ kvm/drivers/virtio/virtio_ring.c
@@ -225,8 +225,6 @@ static bool vring_restart(struct virtque
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
 	START_USE(vq);
-	BUG_ON(!(vq->vring.avail->flags & VRING_AVAIL_F_NO_INTERRUPT));
-
 	/* We optimistically turn back on interrupts, then check if there was
 	 * more to do. */
 	vq->vring.avail->flags &= ~VRING_AVAIL_F_NO_INTERRUPT;
