From: Asias He <asias@redhat.com>
Subject: [PATCH V2 3/6] tcm_vhost: Introduce tcm_vhost_check_endpoint()
Date: Fri,  8 Mar 2013 10:21:44 +0800
Message-ID: <1362709307-12554-4-git-send-email-asias__32656.1453556225$1362709374$gmane$org@redhat.com>
References: <1362709307-12554-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1362709307-12554-1-git-send-email-asias@redhat.com>
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

This helper is useful to check if vs->vs_endpoint is setup by
vhost_scsi_set_endpoint()

Signed-off-by: Asias He <asias@redhat.com>
---
 drivers/vhost/tcm_vhost.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
index 39654f4..b71e946 100644
--- a/drivers/vhost/tcm_vhost.c
+++ b/drivers/vhost/tcm_vhost.c
@@ -103,6 +103,18 @@ static bool tcm_vhost_check_feature(struct vhost_scsi *vs, int feature)
 	return ret;
 }
 
+static bool tcm_vhost_check_endpoint(struct vhost_scsi *vs)
+{
+	bool ret = false;
+
+	mutex_lock(&vs->dev.mutex);
+	if (vs->vs_endpoint)
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
