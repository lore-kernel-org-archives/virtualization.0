From: Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v2 2/2] virtio-balloon: improve update_balloon_size_func
Date: Fri,  4 Jan 2019 15:11:53 +0800
Message-ID: <1546585913-34804-3-git-send-email-wei.w.wang__31978.9668814794$1546587905$gmane$org@intel.com>
References: <1546585913-34804-1-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1546585913-34804-1-git-send-email-wei.w.wang@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, mst@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com
Cc: pbonzini@redhat.com, dgilbert@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

There is no need to update the balloon actual register when there is no
ballooning request. This patch avoids update_balloon_size when diff is 0.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
---
 drivers/virtio/virtio_balloon.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 35ee762..af1e6d9 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -453,9 +453,12 @@ static void update_balloon_size_func(struct work_struct *work)
 			  update_balloon_size_work);
 	diff = towards_target(vb);
 
+	if (!diff)
+		return;
+
 	if (diff > 0)
 		diff -= fill_balloon(vb, diff);
-	else if (diff < 0)
+	else
 		diff += leak_balloon(vb, -diff);
 	update_balloon_size(vb);
 
-- 
2.7.4
