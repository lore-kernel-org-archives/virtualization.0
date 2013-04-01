From: Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH 3/8] virtio: do not export "u16" and "u64" to userspace
Date: Mon, 01 Apr 2013 19:59:16 +0200
Message-ID: <1364839156.21627.65.camel@x61.thuisdomein>
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
To: Rusty Russell <rusty@rustcorp.com.au>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

virtio_balloon.h exports "u16" and "u64" to userspace. Use "__u16" and
"__u64" instead.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
0) Tested with a kernel build.

1) Both types are used in this header for quite some time now. So is my
patch flawed or doesn't userspace actually use virtio_balloon.h?

 include/uapi/linux/virtio_balloon.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index 652dc8b..5e26f61 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -52,8 +52,8 @@ struct virtio_balloon_config
 #define VIRTIO_BALLOON_S_NR       6
 
 struct virtio_balloon_stat {
-	u16 tag;
-	u64 val;
+	__u16 tag;
+	__u64 val;
 } __attribute__((packed));
 
 #endif /* _LINUX_VIRTIO_BALLOON_H */
-- 
1.7.11.7
