From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.9 41/59] tools/virtio: fix READ_ONCE()
Date: Fri, 13 Jan 2017 13:01:48 +0100
Message-ID: <20170113113840.930471458__28482.6946015984$1484309039$gmane$org@linuxfoundation.org>
References: <20170113113839.364876751@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170113113839.364876751@linuxfoundation.org>
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
Cc: Mark Rutland <mark.rutland@arm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>

commit 5da889c795b1fbefc9d8f058b54717ab8ab17891 upstream.

The virtio tools implementation of READ_ONCE() has a single parameter called
'var', but erroneously refers to 'val' for its cast, and thus won't work unless
there's a variable of the correct type that happens to be called 'var'.

Fix this with s/var/val/, making READ_ONCE() work as expected regardless.

Fixes: a7c490333df3cff5 ("tools/virtio: use virt_xxx barriers")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/virtio/linux/compiler.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/virtio/linux/compiler.h
+++ b/tools/virtio/linux/compiler.h
@@ -4,6 +4,6 @@
 #define WRITE_ONCE(var, val) \
 	(*((volatile typeof(val) *)(&(var))) = (val))
 
-#define READ_ONCE(var) (*((volatile typeof(val) *)(&(var))))
+#define READ_ONCE(var) (*((volatile typeof(var) *)(&(var))))
 
 #endif
