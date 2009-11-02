From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv4 2/6] qemu/net: routines to get tap fd
Date: Tue, 3 Nov 2009 00:23:40 +0200
Message-ID: <20091102222340.GC15153__36942.5645717003$1257200919$gmane$org@redhat.com>
References: <cover.1257200517.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1257200517.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: avi@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

vhost need tap fd, add API to get it from vlan client

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net.c |   10 ++++++++++
 net.h |    1 +
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/net.c b/net.c
index 6a7f1c2..8ac639b 100644
--- a/net.c
+++ b/net.c
@@ -1472,6 +1472,16 @@ static int tap_set_sndbuf(TAPState *s, QemuOpts *opts)
 }
 #endif /* TUNSETSNDBUF */
 
+int tap_get_fd(VLANClientState *vc)
+{
+    TAPState *s = vc->opaque;
+
+    if (vc->receive != tap_receive)
+        return -1;
+
+    return s->fd;
+}
+
 int tap_has_vnet_hdr(void *opaque)
 {
     VLANClientState *vc = opaque;
diff --git a/net.h b/net.h
index d1ba23b..7246d16 100644
--- a/net.h
+++ b/net.h
@@ -92,6 +92,7 @@ void do_set_link(Monitor *mon, const QDict *qdict);
 
 void do_info_usernet(Monitor *mon);
 
+int tap_get_fd(VLANClientState *vc);
 int tap_has_vnet_hdr(void *opaque);
 void tap_using_vnet_hdr(void *opaque, int using_vnet_hdr);
 
-- 
1.6.5.2.143.g8cc62
