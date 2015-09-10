From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 3/4] tools/virtio: propagate V=X to kernel build
Date: Thu, 10 Sep 2015 10:23:47 +0300
Message-ID: <1441869802-15847-4-git-send-email-mst__33289.1404083513$1441869878$gmane$org@redhat.com>
References: <1441869802-15847-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1441869802-15847-1-git-send-email-mst@redhat.com>
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
Cc: "Xie, Huawei" <huawei.xie@intel.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/virtio/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile
index 505ad51..39c89a5 100644
--- a/tools/virtio/Makefile
+++ b/tools/virtio/Makefile
@@ -6,7 +6,7 @@ vringh_test: vringh_test.o vringh.o virtio_ring.o
 CFLAGS += -g -O2 -Werror -Wall -I. -I../include/ -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE
 vpath %.c ../../drivers/virtio ../../drivers/vhost
 mod:
-	${MAKE} -C `pwd`/../.. M=`pwd`/vhost_test
+	${MAKE} -C `pwd`/../.. M=`pwd`/vhost_test V=${V}
 .PHONY: all test mod clean
 clean:
 	${RM} *.o vringh_test virtio_test vhost_test/*.o vhost_test/.*.cmd \
-- 
MST
