From: Asias He <asias@redhat.com>
Subject: [PATCH 3/3] tcm_vhost: Use iov_num_pages to calculate sgl_count
Date: Mon, 21 Jan 2013 16:05:28 +0800
Message-ID: <1358755528-31421-4-git-send-email-asias@redhat.com>
References: <1358755528-31421-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1358755528-31421-1-git-send-email-asias@redhat.com>
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
Cc: target-devel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Asias He <asias@redhat.com>
---
 drivers/vhost/tcm_vhost.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
index 59be442..5b77469 100644
--- a/drivers/vhost/tcm_vhost.c
+++ b/drivers/vhost/tcm_vhost.c
@@ -487,11 +487,9 @@ static int vhost_scsi_map_iov_to_sgl(struct tcm_vhost_cmd *tv_cmd,
 	 * Find out how long sglist needs to be
 	 */
 	sgl_count = 0;
-	for (i = 0; i < niov; i++) {
-		sgl_count += (((uintptr_t)iov[i].iov_base + iov[i].iov_len +
-				PAGE_SIZE - 1) >> PAGE_SHIFT) -
-				((uintptr_t)iov[i].iov_base >> PAGE_SHIFT);
-	}
+	for (i = 0; i < niov; i++)
+		sgl_count += iov_num_pages(&iov[i]);
+
 	/* TODO overflow checking */
 
 	sg = kmalloc(sizeof(tv_cmd->tvc_sgl[0]) * sgl_count, GFP_ATOMIC);
-- 
1.8.1
