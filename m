From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv4 5/6] qemu/raw: add API to get raw socket
Date: Tue, 3 Nov 2009 00:24:09 +0200
Message-ID: <20091102222409.GF15153__15254.4593009681$1257200916$gmane$org@redhat.com>
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

Add API to get raw socket from vlanclient,
so that we can connect it to frontend such as vhost.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net.c |    8 ++++++++
 net.h |    2 ++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/net.c b/net.c
index 1fb2f2f..9168460 100644
--- a/net.c
+++ b/net.c
@@ -2025,6 +2025,14 @@ static int net_raw_init(Monitor *mon, VLANState *vlan, const char *model,
 	return 0;
 }
 
+int raw_get_fd(VLANClientState *vc)
+{
+	RAWState *s = vc->opaque;
+	if (vc->receive != raw_receive)
+		return -1;
+	return s->fd;
+}
+
 #if defined(CONFIG_VDE)
 typedef struct VDEState {
     VLANClientState *vc;
diff --git a/net.h b/net.h
index 00485e2..932b50d 100644
--- a/net.h
+++ b/net.h
@@ -94,6 +94,8 @@ int tap_get_fd(VLANClientState *vc);
 int tap_has_vnet_hdr(void *opaque);
 void tap_using_vnet_hdr(void *opaque, int using_vnet_hdr);
 
+int raw_get_fd(VLANClientState *vc);
+
 /* NIC info */
 
 #define MAX_NICS 8
-- 
1.6.5.2.143.g8cc62
