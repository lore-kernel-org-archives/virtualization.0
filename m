From: Kent Overstreet <koverstreet@google.com>
Subject: Re: [PATCH] virtio-blk: Fix kconfig option
Date: Sun, 2 Sep 2012 21:46:45 -0700
Message-ID: <20120903044645.GF20060__33293.3925711133$1346779822$gmane$org@moria.home.lan>
References: <20120903044133.GA9980@moria.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120903044133.GA9980@moria.home.lan>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au, mst@redhat.com
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Whoops, need VIRTIO_RING too

From 79dc9ae40e40cefd6079e4197cac858a1d59e1d8 Mon Sep 17 00:00:00 2001
From: Kent Overstreet <koverstreet@google.com>
Date: Sun, 2 Sep 2012 21:44:37 -0700
Subject: [PATCH] virtio-blk: Fix kconfig option

CONFIG_VIRTIO isn't exposed, everything else is supposed to select it
instead.

Signed-off-by: Kent Overstreet <koverstreet@google.com>
---
 drivers/block/Kconfig |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index a796407..40532b8 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -521,7 +521,9 @@ config XEN_BLKDEV_BACKEND
 
 config VIRTIO_BLK
 	tristate "Virtio block driver (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && VIRTIO
+	select VIRTIO
+	select VIRTIO_RING
+	depends on EXPERIMENTAL
 	---help---
 	  This is the virtual block driver for virtio.  It can be used with
           lguest or QEMU based VMMs (like KVM or Xen).  Say Y or M.
-- 
1.7.10.4
