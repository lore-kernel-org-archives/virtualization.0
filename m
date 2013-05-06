From: Asias He <asias@redhat.com>
Subject: [PATCH v2 04/11] vhost: Remove comments for hdr in vhost.h
Date: Mon,  6 May 2013 16:38:22 +0800
Message-ID: <1367829509-5371-5-git-send-email-asias__14626.0994523347$1367829572$gmane$org@redhat.com>
References: <1367829509-5371-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1367829509-5371-1-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

It is supposed to be removed when hdr is moved into vhost_net_virtqueue.

Signed-off-by: Asias He <asias@redhat.com>
---
 drivers/vhost/vhost.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 94a80eb..51aeb5f 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -101,9 +101,6 @@ struct vhost_virtqueue {
 	u64 log_addr;
 
 	struct iovec iov[UIO_MAXIOV];
-	/* hdr is used to store the virtio header.
-	 * Since each iovec has >= 1 byte length, we never need more than
-	 * header length entries to store the header. */
 	struct iovec *indirect;
 	struct vring_used_elem *heads;
 	/* We use a kind of RCU to access private pointer.
-- 
1.8.1.4
