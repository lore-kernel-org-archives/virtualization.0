From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 2/4] lguest: get rid of offset hack in example launcher
Date: Wed, 30 Sep 2009 02:48:23 +0930
Message-ID: <200909300248.24355.rusty__28118.5758453377$1254248700$gmane$org@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: john cooper <john.cooper@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


We never supported the ATA VIRTIO_BLK_F_IDENTIFY anyway, but simply
including it in the struct definition broke us (see commit 8ef562d112
"lguest: fix descriptor corruption in example launcher").

Now we can acknowledge that it's deprecated, and get the struct without it.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 Documentation/lguest/lguest.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/lguest/lguest.c b/Documentation/lguest/lguest.c
--- a/Documentation/lguest/lguest.c
+++ b/Documentation/lguest/lguest.c
@@ -6,6 +6,7 @@
 :*/
 #define _LARGEFILE64_SOURCE
 #define _GNU_SOURCE
+#define VIRTIO_BLK_IDENTIFY_DEPRECATED
 #include <stdio.h>
 #include <string.h>
 #include <unistd.h>
@@ -1750,8 +1751,21 @@ static void setup_block_file(const char 
 	add_feature(dev, VIRTIO_BLK_F_SEG_MAX);
 	conf.seg_max = cpu_to_le32(VIRTQUEUE_NUM - 2);
 
-	/* Don't try to put whole struct: we have 8 bit limit. */
-	set_config(dev, offsetof(struct virtio_blk_config, geometry), &conf);
+	/*
+	 * We only have 8 bits of configuration space for each device.  But a
+	 * new feature for virtio_blk added a 1k 'identify' field to struct
+	 * virtio_blk_config.  We figured that this was a bad idea, but too
+	 * late: the code was already in the wild.
+	 *
+	 * Normally, new features get added to the end of the config struct,
+	 * but that won't do in this case.  So now, if you define
+	 * VIRTIO_BLK_IDENTIFY_DEPRECATED (as we do at the top of this file),
+	 * it pretends that field doesn't exist at all, and we can add new ones
+	 * where it once was.
+	 *
+	 * This way, old code still compiles.  Bit of a mess, though.
+	 */
+	set_config(dev, sizeof(struct virtio_blk_config), &conf);
 
 	verbose("device %u: virtblock %llu sectors\n",
 		++devices.device_num, le64_to_cpu(conf.capacity));
