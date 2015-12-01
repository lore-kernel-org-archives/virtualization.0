From: Michal Hocko <mhocko@kernel.org>
Subject: [PATCH] virtio: Do not drop __GFP_HIGH in alloc_indirect
Date: Tue,  1 Dec 2015 15:32:49 +0100
Message-ID: <1448980369-27130-1-git-send-email-mhocko__17851.8904293471$1449075497$gmane$org@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>, Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Michal Hocko <mhocko@suse.com>

b92b1b89a33c ("virtio: force vring descriptors to be allocated from
lowmem") tried to exclude highmem pages for descriptors so it cleared
__GFP_HIGHMEM from a given gfp mask. The patch also cleared __GFP_HIGH
which doesn't make much sense for this fix because __GFP_HIGH only
controls access to memory reserves and it doesn't have any influence
on the zone selection. Some of the call paths use GFP_ATOMIC and
dropping __GFP_HIGH will reduce their changes for success because the
lack of access to memory reserves.

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
Hi,
I have stumbled over this code while looking at other issue [1]. I think
that using __GFP_HIGH simply got there because of its confusing name. It
doesn't have anything to do with the highmem zone.

The patch is based on the current linux-next. 

I think that clearing __GFP_HIGHMEM is bogus in the current code because
all code paths either use GFP_KERNEL or GFP_ATOMIC and those do not fall
back to the highmem zone but I have kept it because clearing the flag
cannot be harmful.

[1] http://lkml.kernel.org/r/87h9k4kzcv.fsf%40yhuang-dev.intel.com

 drivers/virtio/virtio_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 14e7ce9b3e96..734de927c89d 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -110,7 +110,7 @@ static struct vring_desc *alloc_indirect(struct virtqueue *_vq,
 	 * otherwise virt_to_phys will give us bogus addresses in the
 	 * virtqueue.
 	 */
-	gfp &= ~(__GFP_HIGHMEM | __GFP_HIGH);
+	gfp &= ~__GFP_HIGHMEM;
 
 	desc = kmalloc(total_sg * sizeof(struct vring_desc), gfp);
 	if (!desc)
-- 
2.6.2
