From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 1/2] MAINTAINERS: fix virtio file pattern
Date: Thu, 30 Mar 2017 13:13:32 +0200
Message-ID: <20170330111333.47725-2-cornelia.huck@de.ibm.com>
References: <20170330111333.47725-1-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170330111333.47725-1-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The pattern did not catch include/linux/virtio.h.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a9ae6c1..f96b3f9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10902,7 +10902,7 @@ F:	drivers/virtio/
 F:	tools/virtio/
 F:	drivers/net/virtio_net.c
 F:	drivers/block/virtio_blk.c
-F:	include/linux/virtio_*.h
+F:	include/linux/virtio*.h
 F:	include/uapi/linux/virtio_*.h
 
 VIRTIO DRIVERS FOR S390
-- 
2.8.4
