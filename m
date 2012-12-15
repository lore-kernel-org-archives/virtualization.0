From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Subject: [PATCH 2/2] Document VIRTIO_BLK_T_GET_ID
Date: Sat, 15 Dec 2012 23:32:11 +0200
Message-ID: <1355607131-17698-2-git-send-email-alexey.zaytsev@gmail.com>
References: <CAJSP0QUEwmd3ZPpzPFO6AN+gqUqD4bCfZwyTo0StwQzoB7+VgA@mail.gmail.com>
	<1355607131-17698-1-git-send-email-alexey.zaytsev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1355607131-17698-1-git-send-email-alexey.zaytsev@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Linux Virtualization <virtualization@lists.linux-foundation.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 virtio-spec.lyx |   42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/virtio-spec.lyx b/virtio-spec.lyx
index a20aa77..3fe3d0f 100644
--- a/virtio-spec.lyx
+++ b/virtio-spec.lyx
@@ -59,6 +59,7 @@
 \author -608949062 "Rusty Russell,,," 
 \author -385801441 "Cornelia Huck" cornelia.huck@de.ibm.com
 \author 1531152142 "Paolo Bonzini,,," 
+\author 1717892615 "Alexey Zaytsev,,," 
 \author 1986246365 "Michael S. Tsirkin" 
 \end_header
 
@@ -6161,7 +6162,11 @@ the SCSI_CMD and SCSI_CMD_OUT types are equivalent, the device does not
 
 \end_inset
 
-) or a flush (VIRTIO_BLK_T_FLUSH or VIRTIO_BLK_T_FLUSH_OUT
+)
+\change_inserted 1717892615 1355313186
+, device ID (serial number) inquiry (VIRTIO_BLK_T_GET_ID)
+\change_unchanged
+ or a flush (VIRTIO_BLK_T_FLUSH or VIRTIO_BLK_T_FLUSH_OUT
 \begin_inset Foot
 status open
 
@@ -6192,6 +6197,19 @@ status open
 
 \begin_layout Plain Layout
 
+\change_inserted 1717892615 1355312081
+
+#define VIRTIO_BLK_ID_BYTES       20
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 1717892615 1355310507
+
+\end_layout
+
+\begin_layout Plain Layout
+
 #define VIRTIO_BLK_T_IN           0
 \end_layout
 
@@ -6218,6 +6236,17 @@ status open
 \begin_layout Plain Layout
 
 #define VIRTIO_BLK_T_FLUSH_OUT    5
+\change_inserted 1717892615 1355310422
+
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 1717892615 1355310087
+
+#define VIRTIO_BLK_T_GET_ID       8
+\change_unchanged
+
 \end_layout
 
 \begin_layout Plain Layout
@@ -6347,6 +6376,17 @@ status open
 \end_layout
 
 \begin_layout Standard
+
+\change_inserted 1717892615 1355312551
+When VIRTIO_BLK_T_GET_ID is issued, the device identifier, up to 20 bytes,
+ is written to the buffer.
+ The identifier should be interpreted as an ascii string.
+ It is terminated with 
+\backslash
+0, unless it is exactly 20 bytes long.
+\end_layout
+
+\begin_layout Standard
 Historically, devices assumed that the fields 
 \emph on
 type
-- 
1.7.10.4
