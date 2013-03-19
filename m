From: Asias He <asias@redhat.com>
Subject: [PATCH V3 WIP 3/3] disable vhost_verify_ring_mappings check
Date: Tue, 19 Mar 2013 08:34:45 +0800
Message-ID: <1363653285-23776-4-git-send-email-asias__31342.2355255627$1363653355$gmane$org@redhat.com>
References: <1363653285-23776-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1363653285-23776-1-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

---
 hw/vhost.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/vhost.c b/hw/vhost.c
index 4d6aee3..0c52ec4 100644
--- a/hw/vhost.c
+++ b/hw/vhost.c
@@ -421,10 +421,12 @@ static void vhost_set_memory(MemoryListener *listener,
         return;
     }
 
+#if 0
     if (dev->started) {
         r = vhost_verify_ring_mappings(dev, start_addr, size);
         assert(r >= 0);
     }
+#endif
 
     if (!dev->log_enabled) {
         r = ioctl(dev->control, VHOST_SET_MEM_TABLE, dev->mem);
-- 
1.8.1.4
