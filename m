From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 50/54] MAINTAINERS: Add file patterns for virtio device tree
	bindings
Date: Sun, 22 May 2016 11:06:27 +0200
Message-ID: <1463907991-7916-51-git-send-email-geert@linux-m68k.org>
References: <1463907991-7916-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1463907991-7916-1-git-send-email-geert@linux-m68k.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, Geert Uytterhoeven <geert@linux-m68k.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Submitters of device tree binding documentation may forget to CC
the subsystem maintainer if this is missing.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org
---
Please apply this patch directly if you want to be involved in device
tree binding documentation for your subsystem.
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d79cedf604642ee4..28829bfa140c47b2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12168,6 +12168,7 @@ VIRTIO CORE, NET AND BLOCK DRIVERS
 M:	"Michael S. Tsirkin" <mst@redhat.com>
 L:	virtualization@lists.linux-foundation.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/virtio/
 F:	drivers/virtio/
 F:	tools/virtio/
 F:	drivers/net/virtio_net.c
-- 
1.9.1
