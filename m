From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] vhost: Fix compile time error
Date: Sat, 14 Sep 2019 01:44:57 -0700
Message-ID: <1568450697-16775-1-git-send-email-linux__40609.4584775687$1568450714$gmane$org@roeck-us.net>
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
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>
List-Id: virtualization@lists.linuxfoundation.org

Building vhost on 32-bit targets results in the following error.

drivers/vhost/vhost.c: In function 'translate_desc':
include/linux/compiler.h:549:38: error:
	call to '__compiletime_assert_1879' declared with attribute error:
	BUILD_BUG_ON failed: sizeof(_s) > sizeof(long)

Fixes: a89db445fbd7 ("vhost: block speculation of translated descriptors")
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/vhost/vhost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index acabf20b069e..102a0c877007 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2074,7 +2074,7 @@ static int translate_desc(struct vhost_virtqueue *vq, u64 addr, u32 len,
 		_iov->iov_base = (void __user *)
 			((unsigned long)node->userspace_addr +
 			 array_index_nospec((unsigned long)(addr - node->start),
-					    node->size));
+					    (unsigned long)node->size));
 		s += size;
 		addr += size;
 		++ret;
-- 
2.7.4
