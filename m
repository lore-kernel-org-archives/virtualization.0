From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 2/4] virtio: Fix typo in virtio_net_hdr comments
Date: Sun, 8 Jun 2008 20:49:59 +1000
Message-ID: <200806082050.00149.rusty__31555.1714077175$1212922579$gmane$org@rustcorp.com.au>
References: <200806082049.00641.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200806082049.00641.rusty@rustcorp.com.au>
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
To: Jeff Garzik <jeff@garzik.org>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Mark McLoughlin <markmc@redhat.com>

Signed-off-by: Mark McLoughlin <markmc@redhat.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 include/linux/virtio_net.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 9405aa6..38c0571 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -38,7 +38,7 @@ struct virtio_net_hdr
 #define VIRTIO_NET_HDR_GSO_ECN		0x80	// TCP has ECN set
 	__u8 gso_type;
 	__u16 hdr_len;		/* Ethernet + IP + tcp/udp hdrs */
-	__u16 gso_size;		/* Bytes to append to gso_hdr_len per frame */
+	__u16 gso_size;		/* Bytes to append to hdr_len per frame */
 	__u16 csum_start;	/* Position to start checksumming from */
 	__u16 csum_offset;	/* Offset after that to place checksum */
 };
