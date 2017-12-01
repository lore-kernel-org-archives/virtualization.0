From: Jan Stancek <jstancek@redhat.com>
Subject: [PATCH] virtio_balloon: fix increment of vb->num_pfns in
	fill_balloon()
Date: Fri,  1 Dec 2017 10:50:28 +0100
Message-ID: <65e5cdb45d2532f9b99e2f412d9169322f778239.1512121454.git.jstancek__31921.2645445534$1512195575$gmane$org@redhat.com>
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
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org
Cc: penguin-kernel@I-love.SAKURA.ne.jp, mhocko@suse.com, linux-kernel@vger.kernel.org, jstancek@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

commit c7cdff0e8647 ("virtio_balloon: fix deadlock on OOM")
changed code to increment vb->num_pfns before call to
set_page_pfns(), which used to happen only after.

This patch fixes boot hang for me on ppc64le KVM guests.

Fixes: c7cdff0e8647 ("virtio_balloon: fix deadlock on OOM")
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Wei Wang <wei.w.wang@intel.com>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 drivers/virtio/virtio_balloon.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 7960746f7597..a1fb52cb3f0a 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -174,13 +174,12 @@ static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
 	while ((page = balloon_page_pop(&pages))) {
 		balloon_page_enqueue(&vb->vb_dev_info, page);
 
-		vb->num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE;
-
 		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
 		vb->num_pages += VIRTIO_BALLOON_PAGES_PER_PAGE;
 		if (!virtio_has_feature(vb->vdev,
 					VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
 			adjust_managed_page_count(page, -1);
+		vb->num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE;
 	}
 
 	num_allocated_pages = vb->num_pfns;
-- 
1.8.3.1
