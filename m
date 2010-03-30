From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 3/4] virtio: console makes incorrect assumption about virtio
	API
Date: Tue, 30 Mar 2010 15:49:22 +1030
Message-ID: <201003301549.22395.rusty@rustcorp.com.au>
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
To: Amit Shah <amit.shah@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The get_buf() API sets the second arg to the number of bytes *written*
by the other side; in this case it should be zero as these are output buffers.

lguest gets this right (obviously kvm's console doesn't), resulting in
continual buildup of console writes.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
To: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -415,20 +415,16 @@ static ssize_t send_buf(struct port *por
 	out_vq->vq_ops->kick(out_vq);
 
 	if (ret < 0) {
-		len = 0;
+		in_count = 0;
 		goto fail;
 	}
 
-	/*
-	 * Wait till the host acknowledges it pushed out the data we
-	 * sent. Also ensure we return to userspace the number of
-	 * bytes that were successfully consumed by the host.
-	 */
+	/* Wait till the host acknowledges it pushed out the data we sent. */
 	while (!out_vq->vq_ops->get_buf(out_vq, &len))
 		cpu_relax();
 fail:
 	/* We're expected to return the amount of data we wrote */
-	return len;
+	return in_count;
 }
 
 /*
