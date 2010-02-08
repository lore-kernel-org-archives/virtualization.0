From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] virtio: fix balloon without VIRTIO_BALLOON_F_STATS_VQ
Date: Mon, 8 Feb 2010 21:02:42 +1030
Message-ID: <201002082102.42331.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

When running under qemu-kvm-0.11.0:

	BUG: unable to handle kernel paging request at 56e58955
	...
	Process vballoon (pid: 1297, ti=c7976000 task=c70a6ca0 task.ti=c7
	...
	Call Trace:
	 [<c88253a3>] ? balloon+0x1b3/0x440 [virtio_balloon]
	 [<c041c2d7>] ? schedule+0x327/0x9d0
	 [<c88251f0>] ? balloon+0x0/0x440 [virtio_balloon]
	 [<c014a2d4>] ? kthread+0x74/0x80
	 [<c014a260>] ? kthread+0x0/0x80
	 [<c0103b36>] ? kernel_thread_helper+0x6/0x30

need_stats_update should be zero-initialized.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Cc: Adam Litke <agl@us.ibm.com>

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -292,6 +292,7 @@ static int virtballoon_probe(struct virt
 	vb->num_pages = 0;
 	init_waitqueue_head(&vb->config_change);
 	vb->vdev = vdev;
+	vb->need_stats_update = 0;
 
 	/* We expect two virtqueues: inflate and deflate,
 	 * and optionally stat. */
