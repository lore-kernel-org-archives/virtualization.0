From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 4/4] lguest: GET_ID "support"
Date: Wed, 30 Sep 2009 02:48:54 +0930
Message-ID: <200909300248.55485.rusty__10390.2334267788$1254248969$gmane$org@rustcorp.com.au>
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


We advertise the feature for testing, then promptly fail when the guest
uses it.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 Documentation/lguest/lguest.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/lguest/lguest.c b/Documentation/lguest/lguest.c
--- a/Documentation/lguest/lguest.c
+++ b/Documentation/lguest/lguest.c
@@ -1654,7 +1654,11 @@ static void blk_request(struct virtqueue
 	 * In general the virtio block driver is allowed to try SCSI commands.
 	 * It'd be nice if we supported eject, for example, but we don't.
 	 */
-	if (out->type & VIRTIO_BLK_T_SCSI_CMD) {
+	if (out->type == VIRTIO_BLK_T_GET_ID) {
+		fprintf(stderr, "GET ID command unsupported\n");
+		*in = VIRTIO_BLK_S_UNSUPP;
+		wlen = sizeof(*in);
+	} else if (out->type & VIRTIO_BLK_T_SCSI_CMD) {
 		fprintf(stderr, "Scsi commands unsupported\n");
 		*in = VIRTIO_BLK_S_UNSUPP;
 		wlen = sizeof(*in);
@@ -1751,6 +1755,9 @@ static void setup_block_file(const char 
 	add_feature(dev, VIRTIO_BLK_F_SEG_MAX);
 	conf.seg_max = cpu_to_le32(VIRTQUEUE_NUM - 2);
 
+	/* We have GET_ID, at least for testing! */
+	add_feature(dev, VIRTIO_BLK_F_GET_ID);
+
 	/*
 	 * We only have 8 bits of configuration space for each device.  But a
 	 * new feature for virtio_blk added a 1k 'identify' field to struct
