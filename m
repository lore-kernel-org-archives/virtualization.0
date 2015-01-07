From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] vhost/net: length miscalculation
Date: Wed, 7 Jan 2015 10:55:55 +0200
Message-ID: <1420620847-24477-1-git-send-email-mst__46762.9837956794$1420621198$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

commit 8b38694a2dc8b18374310df50174f1e4376d6824
    vhost/net: virtio 1.0 byte swap
had this chunk:
-       heads[headcount - 1].len += datalen;
+       heads[headcount - 1].len = cpu_to_vhost32(vq, len - datalen);

This adds datalen with the wrong sign, causing guest panics.

Fixes: 8b38694a2dc8b18374310df50174f1e4376d6824
Reported-by: Alex Williamson <alex.williamson@redhat.com>
Suggested-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Alex, could you please confirm this fixes the crash for you?

 drivers/vhost/net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 14419a8..d415d69 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -538,7 +538,7 @@ static int get_rx_bufs(struct vhost_virtqueue *vq,
 		++headcount;
 		seg += in;
 	}
-	heads[headcount - 1].len = cpu_to_vhost32(vq, len - datalen);
+	heads[headcount - 1].len = cpu_to_vhost32(vq, len + datalen);
 	*iovcount = seg;
 	if (unlikely(log))
 		*log_num = nlogs;
-- 
MST
