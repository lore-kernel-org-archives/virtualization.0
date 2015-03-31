From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] virtio: drop a useless config read
Date: Tue, 31 Mar 2015 13:55:42 +0200
Message-ID: <1427802906-7743-1-git-send-email-mst__9447.77793852172$1427802979$gmane$org@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

commit d71de9ec6ba806104439d3a669befda84757b5af
    "virtio: core support for config generation"
fixed reading up 64 bit values, adding generation
checks for such reads.

By mistake, it left an explicit get call in place
as well. the result is that the value is read twice,
the first result is discarded.

Not a big deal since this only happens with virtio
blk and only on boot ATM, so performance isn't
affected, but let's clean it up.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_config.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index ca3ed78..ed1e0d5 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -374,7 +374,6 @@ static inline u64 virtio_cread64(struct virtio_device *vdev,
 				 unsigned int offset)
 {
 	u64 ret;
-	vdev->config->get(vdev, offset, &ret, sizeof(ret));
 	__virtio_cread_many(vdev, offset, &ret, 1, sizeof(ret));
 	return virtio64_to_cpu(vdev, (__force __virtio64)ret);
 }
-- 
MST
