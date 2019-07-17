From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH V3 07/15] vhost_net: calculate last used length once for
	mergeable buffer
Date: Wed, 17 Jul 2019 06:52:47 -0400
Message-ID: <20190717105255.63488-8-jasowang__29152.1509921708$1563360874$gmane$org@redhat.com>
References: <20190717105255.63488-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190717105255.63488-1-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, jasowang@redhat.com
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, maxime.coquelin@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

This patch tries to calculate last used length once instead of
twice. This can help to convert to use shadow used ring API for
RX.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index cf47e6e348f4..1a67f889cbc1 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1065,12 +1065,12 @@ static int get_rx_bufs(struct vhost_virtqueue *vq,
 		}
 		heads[headcount].id = cpu_to_vhost32(vq, d);
 		len = iov_length(vq->iov + seg, in);
-		heads[headcount].len = cpu_to_vhost32(vq, len);
 		datalen -= len;
+		heads[headcount].len = cpu_to_vhost32(vq,
+				       datalen >= 0 ? len : len + datalen);
 		++headcount;
 		seg += in;
 	}
-	heads[headcount - 1].len = cpu_to_vhost32(vq, len + datalen);
 	*iovcount = seg;
 	if (unlikely(log))
 		*log_num = nlogs;
-- 
2.18.1
