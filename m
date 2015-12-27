From: Minchan Kim <minchan@kernel.org>
Subject: [PATCH 1/2] virtio_balloon: fix race by fill and leak
Date: Mon, 28 Dec 2015 08:35:12 +0900
Message-ID: <1451259313-26353-1-git-send-email-minchan__14450.5856711932$1451260169$gmane$org@kernel.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Rafael Aquini <aquini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Konstantin Khlebnikov <koct9i@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

During my compaction-related stuff, I encountered a bug
with ballooning.

With repeated inflating and deflating cycle, guest memory(
ie, cat /proc/meminfo | grep MemTotal) is decreased and
couldn't be recovered.

The reason is balloon_lock doesn't cover release_pages_balloon
so struct virtio_balloon fields could be overwritten by race
of fill_balloon(e,g, vb->*pfns could be critical).

This patch fixes it in my test.

Cc: <stable@vger.kernel.org>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 drivers/virtio/virtio_balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 7efc32945810..7d3e5d0e9aa4 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -209,8 +209,8 @@ static unsigned leak_balloon(struct virtio_balloon *vb, size_t num)
 	 */
 	if (vb->num_pfns != 0)
 		tell_host(vb, vb->deflate_vq);
-	mutex_unlock(&vb->balloon_lock);
 	release_pages_balloon(vb);
+	mutex_unlock(&vb->balloon_lock);
 	return num_freed_pages;
 }
 
-- 
1.9.1
