From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 3/6] tools/virtio: 64 bit features
Date: Mon, 15 Dec 2014 00:04:28 +0200
Message-ID: <1418594542-22623-4-git-send-email-mst@redhat.com>
References: <1418594542-22623-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1418594542-22623-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Missed one place where vringh_test used
long to pass features. Fix it up to u64.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/virtio/vringh_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
index 13e0a76..51d922f 100644
--- a/tools/virtio/vringh_test.c
+++ b/tools/virtio/vringh_test.c
@@ -132,7 +132,7 @@ static inline int vringh_get_head(struct vringh *vrh, u16 *head)
 	return 1;
 }
 
-static int parallel_test(unsigned long features,
+static int parallel_test(u64 features,
 			 bool (*getrange)(struct vringh *vrh,
 					  u64 addr, struct vringh_range *r),
 			 bool fast_vringh)
-- 
MST
