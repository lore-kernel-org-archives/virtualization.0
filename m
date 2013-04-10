From: Asias He <asias@redhat.com>
Subject: [PATCH v2 1/4] tcm_vhost: Remove double check of response
Date: Wed, 10 Apr 2013 15:06:13 +0800
Message-ID: <1365577576-26183-2-git-send-email-asias@redhat.com>
References: <1365577576-26183-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1365577576-26183-1-git-send-email-asias@redhat.com>
In-Reply-To: <1365564191-20928-1-git-send-email-asias@redhat.com>
References: <1365564191-20928-1-git-send-email-asias@redhat.com>
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

We did the length of response check twice.

Signed-off-by: Asias He <asias@redhat.com>
---
 drivers/vhost/tcm_vhost.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
index c127731..28c112f 100644
--- a/drivers/vhost/tcm_vhost.c
+++ b/drivers/vhost/tcm_vhost.c
@@ -705,15 +705,6 @@ static void vhost_scsi_handle_vq(struct vhost_scsi *vs,
 
 		tv_cmd->tvc_vhost = vs;
 		tv_cmd->tvc_vq = vq;
-
-		if (unlikely(vq->iov[out].iov_len !=
-				sizeof(struct virtio_scsi_cmd_resp))) {
-			vq_err(vq, "Expecting virtio_scsi_cmd_resp, got %zu"
-				" bytes, out: %d, in: %d\n",
-				vq->iov[out].iov_len, out, in);
-			break;
-		}
-
 		tv_cmd->tvc_resp = vq->iov[out].iov_base;
 
 		/*
-- 
1.8.1.4
