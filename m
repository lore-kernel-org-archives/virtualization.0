From: Wenchao Xia <wenchaolinux@gmail.com>
Subject: [PATCH] vhost-scsi: return -ENOENT when no matching tcm_vhost_tpg
	found
Date: Tue, 28 May 2013 16:54:44 +0800
Message-ID: <1369731284-4139-1-git-send-email-wenchaolinux__13875.2285660759$1369958592$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-next@vger.kernel.org
Cc: kvm@vger.kernel.org, mst@redhat.com, virtualization@lists.linux-foundation.org, wenchaolinuxkvm@gmail.com, Wenchao Xia <wenchaolinux@gmail.com>, pbonzini@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

ioctl for VHOST_SCSI_SET_ENDPOINT report file exist errori, when I forget
to set it correctly in configfs, make user confused. Actually it fail
to find a matching one, so change the error value.

Signed-off-by: Wenchao Xia <wenchaolinux@gmail.com>
---
 drivers/vhost/scsi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 7014202..6325b1d 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1219,7 +1219,7 @@ static int vhost_scsi_set_endpoint(
 		}
 		ret = 0;
 	} else {
-		ret = -EEXIST;
+		ret = -ENOENT;
 	}
 
 	/*
-- 
1.7.1
