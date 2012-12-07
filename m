From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 0/1] virtio: console: regression in virtqueue_add_buf() change
Date: Fri,  7 Dec 2012 11:34:37 +0530
Message-ID: <cover.1354859479.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Amit Shah <amit.shah@redhat.com>, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Rusty,

The linux-next kernel was failing my virtio-console test suite for a
while.  I looked into it today, and it's due to the
virtqueue_add_buf() change that doesn't return > 0 values anymore.  I
found your commit that adjusts virtio_console.c, but you missed one
instance where the return value mattered, and as a result not enough
buffers were queued for the host to send in data.

This resulted in the port's name to be not populated in sysfs, which
meant udev didn't create any symlinks in /dev/virtio-ports/.

I've just updated your commit with the small diff (attached below).
Please put this commit after 

commit e794093a52cdfef09b3fdb6294b75ab8cacb30a8
Author: Rusty Russell <rusty@rustcorp.com.au>
Date:   Tue Oct 16 23:56:14 2012 +1030

    virtio_net: don't rely on virtqueue_add_buf() returning capacity.
    
and before

commit 08d088e8357b3c031db7de006247f613c7f136ab
Author: Rusty Russell <rusty@rustcorp.com.au>
Date:   Tue Oct 16 23:56:15 2012 +1030

    virtio: make virtqueue_add_buf() returning 0 on success, not capacity.
    
in the pull request you send so that there's no regression in
virtio_console on bisection.

(commit ids from linux-next/master).

I didn't see your linux-next commit

commit 80162488188c239733433cff98ece5cde18b8b3b
Author: Rusty Russell <rusty@rustcorp.com.au>
Date:   Tue Oct 16 23:56:15 2012 +1030

    virtio: console: make it clear that virtqueue_add_buf() no longer returns > 0

on a mailing list (please CC me!), and I missed reviewing the virtio
changes, but glad that the testsuite caught this :)

Diff relative to your patch:

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 82ebe02..6a36994 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -396,6 +396,8 @@ static int add_inbuf(struct virtqueue *vq, struct port_buffer *buf)
 
 	ret = virtqueue_add_buf(vq, sg, 0, 1, buf, GFP_ATOMIC);
 	virtqueue_kick(vq);
+	if (!ret)
+		ret = vq->num_free;
 	return ret;
 }
 

Please apply.


Rusty Russell (1):
  virtio: console: virtqueue_add_buf() no longer returns > 0

 drivers/char/virtio_console.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

-- 
1.8.0.1
