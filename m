From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC v4 5/5] vhost: last descriptor must have NEXT clear
Date: Sun, 13 Oct 2019 07:42:22 -0400
Message-ID: <20191013113940.2863-6-mst__6630.45596318028$1570967706$gmane$org@redhat.com>
References: <20191013113940.2863-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20191013113940.2863-1-mst@redhat.com>
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
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

fetch_buf already guarantees we exit on a descriptor without a NEXT
flag.  Add a BUG_ON statement to make sure we don't overflow the buffer
in case of a bug.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/vhost.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index d46c28149f6f..09f594bb069a 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2656,6 +2656,8 @@ int vhost_get_vq_desc_batch(struct vhost_virtqueue *vq,
 			break;
 	}
 
+	BUG_ON(i >= vq->ndescs);
+
 	vq->first_desc = i + 1;
 
 	return ret;
-- 
MST
