From: Asias He <asias@redhat.com>
Subject: [PATCH v2 07/11] vhost-scsi: Remove unnecessary forward struct
	vhost_scsi declaration
Date: Mon,  6 May 2013 16:38:25 +0800
Message-ID: <1367829509-5371-8-git-send-email-asias__1287.0525978089$1367829605$gmane$org@redhat.com>
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

It was needed when struct tcm_vhost_tpg is in tcm_vhost.h

Signed-off-by: Asias He <asias@redhat.com>
---
 drivers/vhost/scsi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 2dcb94a..02ddedd 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -115,7 +115,6 @@ struct tcm_vhost_nacl {
 	struct se_node_acl se_node_acl;
 };
 
-struct vhost_scsi;
 struct tcm_vhost_tpg {
 	/* Vhost port target portal group tag for TCM */
 	u16 tport_tpgt;
-- 
1.8.1.4
