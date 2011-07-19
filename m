From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC] vhost: fix zcopy reference counting
Date: Tue, 19 Jul 2011 13:33:16 +0300
Message-ID: <20110719103316.GA5376__17816.7297425263$1311071635$gmane$org@redhat.com>
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
To: mashirle@us.ibm.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Fix get/put refcount imbalance with zero copy,
which caused qemu to hang forever on guest driver unload.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Dave, I've put this on my tree so no need for you to bother.

 drivers/vhost/vhost.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 46822c0..c16d225 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1578,7 +1578,6 @@ struct vhost_ubuf_ref *vhost_ubuf_alloc(struct vhost_virtqueue *vq,
 	if (!ubufs)
 		return ERR_PTR(-ENOMEM);
 	kref_init(&ubufs->kref);
-	kref_get(&ubufs->kref);
 	init_waitqueue_head(&ubufs->wait);
 	ubufs->vq = vq;
 	return ubufs;
-- 
1.7.5.53.gc233e
