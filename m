From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv4 4/6] qemu/net: move typedef to qemu-common.h
Date: Tue, 3 Nov 2009 00:24:00 +0200
Message-ID: <20091102222400.GE15153__47130.1114805557$1257200915$gmane$org@redhat.com>
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

Move typedef VLANClientState to qemu-common.h so that users
can use forward-declared type without pulling in net.h

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net.h         |    2 --
 qemu-common.h |    1 +
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/net.h b/net.h
index 7246d16..00485e2 100644
--- a/net.h
+++ b/net.h
@@ -8,8 +8,6 @@
 
 /* VLANs support */
 
-typedef struct VLANClientState VLANClientState;
-
 typedef int (NetCanReceive)(VLANClientState *);
 typedef ssize_t (NetReceive)(VLANClientState *, const uint8_t *, size_t);
 typedef ssize_t (NetReceiveIOV)(VLANClientState *, const struct iovec *, int);
diff --git a/qemu-common.h b/qemu-common.h
index 875010b..704796e 100644
--- a/qemu-common.h
+++ b/qemu-common.h
@@ -193,6 +193,7 @@ typedef struct uWireSlave uWireSlave;
 typedef struct I2SCodec I2SCodec;
 typedef struct DeviceState DeviceState;
 typedef struct SSIBus SSIBus;
+typedef struct VLANClientState VLANClientState;
 
 /* CPU save/load.  */
 void cpu_save(QEMUFile *f, void *opaque);
-- 
1.6.5.2.143.g8cc62
