From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] virtio_balloon: unlock on error in fill_balloon()
Date: Tue, 13 Nov 2012 10:43:03 +0300
Message-ID: <20121113074303.GA13198@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, Rafael Aquini <aquini@redhat.com>
Cc: virtualization@lists.linux-foundation.org, kernel-janitors@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

We recently added locking in fill_balloon() but there was one error path
which was missed.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Only needed in linux-next.

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index f70151b..1c50e98 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -153,9 +153,10 @@ static void fill_balloon(struct virtio_balloon *vb, size_t num)
 
 	/* Didn't get any?  Oh well. */
 	if (vb->num_pfns == 0)
-		return;
+		goto unlock;
 
 	tell_host(vb, vb->inflate_vq);
+unlock:
 	mutex_unlock(&vb->balloon_lock);
 }
