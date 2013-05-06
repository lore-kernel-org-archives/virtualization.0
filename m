From: Asias He <asias@redhat.com>
Subject: [PATCH 1/2] vhost: Export vhost_dev_set_owner
Date: Mon,  6 May 2013 11:15:59 +0800
Message-ID: <1367810160-28178-2-git-send-email-asias@redhat.com>
References: <1367810160-28178-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1367810160-28178-1-git-send-email-asias@redhat.com>
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

Signed-off-by: Asias He <asias@redhat.com>
---
 drivers/vhost/vhost.c | 2 +-
 drivers/vhost/vhost.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 749b5ab..de9441a 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -344,7 +344,7 @@ static int vhost_attach_cgroups(struct vhost_dev *dev)
 }
 
 /* Caller should have device mutex */
-static long vhost_dev_set_owner(struct vhost_dev *dev)
+long vhost_dev_set_owner(struct vhost_dev *dev)
 {
 	struct task_struct *worker;
 	int err;
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index b58f4ae..cc23bc4 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -135,6 +135,7 @@ struct vhost_dev {
 };
 
 long vhost_dev_init(struct vhost_dev *, struct vhost_virtqueue **vqs, int nvqs);
+long vhost_dev_set_owner(struct vhost_dev *dev);
 long vhost_dev_check_owner(struct vhost_dev *);
 struct vhost_memory *vhost_dev_reset_owner_prepare(void);
 void vhost_dev_reset_owner(struct vhost_dev *, struct vhost_memory *);
-- 
1.8.1.4
