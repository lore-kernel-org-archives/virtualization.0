From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] vhost: make msg padding explicit
Date: Fri, 27 Apr 2018 19:02:05 +0300
Message-ID: <1524844881-178524-1-git-send-email-mst__48602.4255901158$1524844809$gmane$org@redhat.com>
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
Cc: netdev@vger.kernel.org, Kevin Easton <kevin@guarana.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

There's a 32 bit hole just after type. It's best to
give it a name, this way compiler is forced to initialize
it with rest of the structure.

Reported-by: Kevin Easton <kevin@guarana.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/uapi/linux/vhost.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index c51f8e5..5a8ad06 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -68,6 +68,7 @@ struct vhost_iotlb_msg {
 
 struct vhost_msg {
 	int type;
+	int padding0;
 	union {
 		struct vhost_iotlb_msg iotlb;
 		__u8 padding[64];
-- 
MST
