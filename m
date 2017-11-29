From: Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v18 10/10] virtio-balloon: don't report free pages when page
	poisoning is enabled
Date: Wed, 29 Nov 2017 21:55:26 +0800
Message-ID: <1511963726-34070-11-git-send-email-wei.w.wang__47130.3780250766$1511964832$gmane$org@intel.com>
References: <1511963726-34070-1-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1511963726-34070-1-git-send-email-wei.w.wang@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com
Cc: aarcange@redhat.com, yang.zhang.wz@gmail.com, riel@redhat.com, penguin-kernel@I-love.SAKURA.ne.jp, liliang.opensource@gmail.com, willy@infradead.org, amit.shah@redhat.com, quan.xu@aliyun.com, cornelia.huck@de.ibm.com, pbonzini@redhat.com, nilal@redhat.com, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

The guest free pages should not be discarded by the live migration thread
when page poisoning is enabled with PAGE_POISONING_NO_SANITY=n, because
skipping the transfer of such poisoned free pages will trigger false
positive when new pages are allocated and checked on the destination.
This patch skips the reporting of free pages in the above case.

Reported-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Cc: Michal Hocko <mhocko@suse.com>
---
 drivers/virtio/virtio_balloon.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 035bd3a..6ac4cff 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -652,7 +652,9 @@ static void report_free_page(struct work_struct *work)
 	/* Start by sending the obtained cmd id to the host with an outbuf */
 	send_one_desc(vb, vb->free_page_vq, virt_to_phys(&vb->start_cmd_id),
 		      sizeof(uint32_t), false, true, false);
-	walk_free_mem_block(vb, 0, &virtio_balloon_send_free_pages);
+	if (!(page_poisoning_enabled() &&
+	    !IS_ENABLED(CONFIG_PAGE_POISONING_NO_SANITY)))
+		walk_free_mem_block(vb, 0, &virtio_balloon_send_free_pages);
 	/*
 	 * End by sending the stop id to the host with an outbuf. Use the
 	 * non-batching mode here to trigger a kick after adding the stop id.
-- 
2.7.4
