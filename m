From: Anthony Liguori <aliguori@us.ibm.com>
Subject: [PATCH] virtio_balloon: fix towards_target when deflating balloon
Date: Mon, 18 Aug 2008 17:15:31 -0500
Message-ID: <1219097731-1224-1-git-send-email-aliguori__49424.6798255064$1219098010$gmane$org@us.ibm.com>
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
To: linux-kernel@vger.kernel.org
Cc: Anthony Liguori <aliguori@us.ibm.com>, virtualization@lists.linux-foundation.org, Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Both v and vb->num_pages are u32 and unsigned int respectively.  If v is less
than vb->num_pages (and it is, when deflating the balloon), the result is a
very large 32-bit number.  Since we're returning a s64, instead of getting the
same negative number we desire, we get a very large positive number.

This handles the case where v < vb->num_pages and ensures we get a small,
negative, s64 as the result.

Rusty: please push this for 2.6.27-rc4.  It's probably appropriate for the
stable tree too as it will cause an unexpected OOM when ballooning.

Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index bfef604..bd3c384 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -158,7 +158,10 @@ static inline s64 towards_target(struct virtio_balloon *vb)
 	vb->vdev->config->get(vb->vdev,
 			      offsetof(struct virtio_balloon_config, num_pages),
 			      &v, sizeof(v));
-	return v - vb->num_pages;
+	if (v < vb->num_pages)
+		return -(s64)(vb->num_pages - v);
+	else
+		return v - vb->num_pages;
 }
 
 static void update_balloon_size(struct virtio_balloon *vb)
