From: Asias He <asias@redhat.com>
Subject: [PATCH v5 1/3] tcm_vhost: Introduce tcm_vhost_check_feature()
Date: Tue,  9 Apr 2013 16:51:37 +0800
Message-ID: <1365497499-9172-2-git-send-email-asias@redhat.com>
References: <1365497499-9172-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1365497499-9172-1-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Nicholas Bellinger <nab@linux-iscsi.org>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

This helper is useful to check if a feature is supported.

Signed-off-by: Asias He <asias@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 drivers/vhost/tcm_vhost.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
index c127731..f0189bc 100644
--- a/drivers/vhost/tcm_vhost.c
+++ b/drivers/vhost/tcm_vhost.c
@@ -99,6 +99,18 @@ static int iov_num_pages(struct iovec *iov)
 	       ((unsigned long)iov->iov_base & PAGE_MASK)) >> PAGE_SHIFT;
 }
 
+static bool tcm_vhost_check_feature(struct vhost_scsi *vs, int feature)
+{
+	bool ret = false;
+
+	mutex_lock(&vs->dev.mutex);
+	if (vhost_has_feature(&vs->dev, feature))
+		ret = true;
+	mutex_unlock(&vs->dev.mutex);
+
+	return ret;
+}
+
 static int tcm_vhost_check_true(struct se_portal_group *se_tpg)
 {
 	return 1;
-- 
1.8.1.4
