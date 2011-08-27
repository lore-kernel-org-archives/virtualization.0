From: Wang Sheng-Hui <shhuiw@gmail.com>
Subject: [PATCH] virtio: fix size computation according to the definition
	of struct vring_used in vring_size
Date: Sat, 27 Aug 2011 09:07:49 +0800
Message-ID: <4E584365.1010806__42180.3694953725$1314409944$gmane$org@gmail.com>
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
To: rusty@rustcorp.com.au, mst@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

The patch is against 3.1-rc3.

struct vring_used has two __u16 fields plus array of struct vring_used_elem.
Current vring_size counts the __u16 fields to 3. Fix it to 2 in the patch.

Signed-off-by: Wang Sheng-Hui <shhuiw@gmail.com>
---
 include/linux/virtio_ring.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index 4a32cb6..fcda152 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -143,7 +143,7 @@ static inline unsigned vring_size(unsigned int num, unsigned long align)
 {
 	return ((sizeof(struct vring_desc) * num + sizeof(__u16) * (2 + num)
 		 + align - 1) & ~(align - 1))
-		+ sizeof(__u16) * 3 + sizeof(struct vring_used_elem) * num;
+		+ sizeof(__u16) * 2 + sizeof(struct vring_used_elem) * num;
 }
 
 /* The following is used with USED_EVENT_IDX and AVAIL_EVENT_IDX */
-- 
1.7.1

crossover@crossover-plinux:~/dev/patchwork$ 
