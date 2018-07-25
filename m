From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 2/2] tools/virtio: add kmalloc_array stub
Date: Wed, 25 Jul 2018 16:45:27 +0300
Message-ID: <20180725134057.113423-2-mst__47496.2647226222$1532526218$gmane$org@redhat.com>
References: <20180725134057.113423-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180725134057.113423-1-mst@redhat.com>
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
Cc: virtualization@lists.linux-foundation.org, khandual@linux.vnet.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Fixes: 6da2ec56059 ("treewide: kmalloc() -> kmalloc_array()")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/virtio/linux/kernel.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
index fca8381bbe04..fb22bccfbc8a 100644
--- a/tools/virtio/linux/kernel.h
+++ b/tools/virtio/linux/kernel.h
@@ -52,6 +52,11 @@ static inline void *kmalloc(size_t s, gfp_t gfp)
 		return __kmalloc_fake;
 	return malloc(s);
 }
+static inline void *kmalloc_array(unsigned n, size_t s, gfp_t gfp)
+{
+	return kmalloc(n * s, gfp);
+}
+
 static inline void *kzalloc(size_t s, gfp_t gfp)
 {
 	void *p = kmalloc(s, gfp);
-- 
MST
