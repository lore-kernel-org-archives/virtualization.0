From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: virtio_net and SMP guests
Date: Thu, 10 Jan 2008 13:37:40 +0100
Message-ID: <200801101337.40433.borntraeger__15503.3037801788$1199968838$gmane$org@de.ibm.com>
References: <200712141312.05562.borntraeger@de.ibm.com>
	<200712181751.24692.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200712181751.24692.rusty@rustcorp.com.au>
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
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Anthony Liguori <aliguori@us.ibm.com>, Dor Laor <dor.laor@qumranet.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Am Dienstag, 18. Dezember 2007 schrieb Rusty Russell:
> To me this points to doing interrupt suppression a different way.  If we
> have a ->disable_cb() virtio function, and call it before we call
> netif_rx_schedule, does that fix it?

The fix looks good and I agree with it.

There is one problem that I try to find for some days, but the following 
BUG_ON triggers:

static void vring_disable_cb(struct virtqueue *_vq)
{
        struct vring_virtqueue *vq = to_vvq(_vq);

        START_USE(vq);
---->   BUG_ON(vq->vring.avail->flags & VRING_AVAIL_F_NO_INTERRUPT);
        vq->vring.avail->flags |= VRING_AVAIL_F_NO_INTERRUPT;
        END_USE(vq);
}

The funny thing is, that this bit is correct during probe but changes later 
before open. It seems that there is still something fishy on s390 and 
virtio. 
I looked several times at the virtio_ring code and it really seems to be ok.
Any ideas?
Christian

-------- the oops that I cannot explain -------------

kernel BUG at /space/kvm/drivers/virtio/virtio_ring.c:232!
illegal operation: 0001 [#1]
Modules linked in:
CPU:    0    Not tainted
Process ip (pid: 1583, task: 000000000eee7038, ksp: 000000000ec4beb8)
Krnl PSW : 0704300180000000 000000000045dcd4 (vring_disable_cb+0x30/0x34)
           R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:0 CC:3 PM:0 EA:3
Krnl GPRS: 000003ff00000002 0000000000000001 0000000010001800 
000000000045dca4
           000000000f054800 0000000000595a80 0000000000000000 
0000000000000000
           0000000000897768 000003ff00001002 000000000f09c920 
000000000ec4bbf8
           000000000f09c900 0000000000596b20 000000000045c9c6 
000000000ec4bbf8
Krnl Code: 000000000045dcc8: e3b0b0700004       lg      %r11,112(%r11)
           000000000045dcce: 07fe               bcr     15,%r14
           000000000045dcd0: a7f40001           brc     15,45dcd2
          >000000000045dcd4: a7f4fff6           brc     15,45dcc0
           000000000045dcd8: eb7ff0500024       stmg    %r7,%r15,80(%r15)
           000000000045dcde: a7f13e00           tmll    %r15,15872
           000000000045dce2: b90400ef           lgr     %r14,%r15
           000000000045dce6: a7840001           brc     8,45dce8
Call Trace:
([<000000000045c95e>] virtnet_open+0x32/0x114)
 [<000000000048cbac>] dev_open+0xb0/0xe8
 [<000000000048b6a2>] dev_change_flags+0x156/0x1cc
 [<00000000004ead02>] devinet_ioctl+0x5ae/0x728
 [<00000000004eb564>] inet_ioctl+0xa4/0xf0
 [<00000000004798dc>] sock_ioctl+0x90/0x2e4
 [<00000000001b8bd2>] do_ioctl+0x4a/0xd4
 [<00000000001b8cda>] vfs_ioctl+0x7e/0x3c8
 [<00000000001b90b6>] sys_ioctl+0x92/0xa4
 [<0000000000112e7c>] sysc_noemu+0x10/0x16
 [<000002000012c7e6>] 0x2000012c7e6
