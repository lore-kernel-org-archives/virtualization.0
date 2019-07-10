From: Pankaj Gupta <pagupta@redhat.com>
Subject: [PATCH] virtio_pmem: fix sparse warning
Date: Wed, 10 Jul 2019 19:57:00 +0530
Message-ID: <20190710142700.10215-1-pagupta__20066.2350443721$1562769369$gmane$org@redhat.com>
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
To: virtualization@lists.linux-foundation.org, dan.j.williams@intel.com
Cc: pagupta@redhat.com, mst@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, yuval.shaia@oracle.com, lcapitulino@redhat.com, linux-nvdimm@lists.01.org
List-Id: virtualization@lists.linuxfoundation.org

This patch fixes below sparse warning related to __virtio 
type in virtio pmem driver. This is reported by Intel test
bot on linux-next tree.

nd_virtio.c:56:28: warning: incorrect type in assignment (different base types)
nd_virtio.c:56:28:    expected unsigned int [unsigned] [usertype] type
nd_virtio.c:56:28:    got restricted __virtio32
nd_virtio.c:93:59: warning: incorrect type in argument 2 (different base types)
nd_virtio.c:93:59:    expected restricted __virtio32 [usertype] val
nd_virtio.c:93:59:    got unsigned int [unsigned] [usertype] ret

Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
Reported-by: kbuild test robot <lkp@intel.com>
---

This fixes a warning, so submitting it as a separate
patch on top of virtio pmem series. 
 
 include/uapi/linux/virtio_pmem.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/virtio_pmem.h b/include/uapi/linux/virtio_pmem.h
index efcd72f2d20d..f89129bf1f84 100644
--- a/include/uapi/linux/virtio_pmem.h
+++ b/include/uapi/linux/virtio_pmem.h
@@ -23,12 +23,12 @@ struct virtio_pmem_config {
 
 struct virtio_pmem_resp {
 	/* Host return status corresponding to flush request */
-	__u32 ret;
+	__virtio32 ret;
 };
 
 struct virtio_pmem_req {
 	/* command type */
-	__u32 type;
+	__virtio32 type;
 };
 
 #endif
-- 
2.20.1
