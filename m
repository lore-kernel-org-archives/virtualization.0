From: Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH] MAINTAINERS: add virtio-ccw.h to virtio/s390 section
Date: Fri, 10 Nov 2017 15:56:11 +0100
Message-ID: <20171110145611.15306-1-cohuck__42743.2974255227$1510325777$gmane$org@redhat.com>
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
To: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pasic@linux.vnet.ibm.com
Cc: linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The file arch/s390/include/uapi/asm/virtio-ccw.h belongs to the
s390 virtio drivers as well.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---

Martin, Heiko: It's probably best to take this through your tree.

---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6671f375f7fc..48c6f1179b9b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14312,6 +14312,7 @@ L:	virtualization@lists.linux-foundation.org
 L:	kvm@vger.kernel.org
 S:	Supported
 F:	drivers/s390/virtio/
+F:	arch/s390/include/uapi/asm/virtio-ccw.h
 
 VIRTIO GPU DRIVER
 M:	David Airlie <airlied@linux.ie>
-- 
2.13.6
