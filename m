From: Asias He <asias@redhat.com>
Subject: [PATCH 1/3] tcm_vhost: Introduce iov_num_pages
Date: Mon, 21 Jan 2013 16:05:26 +0800
Message-ID: <1358755528-31421-2-git-send-email-asias@redhat.com>
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

Add a helper to calculate the number of pages needed for a iov entry.

Signed-off-by: Asias He <asias@redhat.com>
---
 drivers/vhost/tcm_vhost.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
index 3720604..ca35c16 100644
--- a/drivers/vhost/tcm_vhost.c
+++ b/drivers/vhost/tcm_vhost.c
@@ -77,6 +77,12 @@ static struct workqueue_struct *tcm_vhost_workqueue;
 static DEFINE_MUTEX(tcm_vhost_mutex);
 static LIST_HEAD(tcm_vhost_list);
 
+static inline int iov_num_pages(struct iovec *iov)
+{
+	return (PAGE_ALIGN((unsigned long)iov->iov_base + iov->iov_len) -
+	       ((unsigned long)iov->iov_base & PAGE_MASK)) >> PAGE_SHIFT;
+}
+
 static int tcm_vhost_check_true(struct se_portal_group *se_tpg)
 {
 	return 1;
-- 
1.8.1
