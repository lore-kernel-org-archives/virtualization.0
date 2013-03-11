From: Mihnea Dobrescu-Balaur <mihneadb@gmail.com>
Subject: [PATCH] block: replace kmalloc and then memcpy with kmemdup
Date: Mon, 11 Mar 2013 13:23:36 +0200
Message-ID: <1363001016-8439-1-git-send-email-mihneadb__49207.8169518665$1363019838$gmane$org@gmail.com>
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
To: xen-devel@lists.xensource.com
Cc: Mihnea Dobrescu-Balaur <mihneadb@gmail.com>, jeremy@goop.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, konrad.wilk@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Mihnea Dobrescu-Balaur <mihneadb@gmail.com>
---
 drivers/block/xen-blkfront.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index c3dae2e..9620644 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -1203,11 +1203,10 @@ static int blkif_recover(struct blkfront_info *info)
 	int j;
 
 	/* Stage 1: Make a safe copy of the shadow state. */
-	copy = kmalloc(sizeof(info->shadow),
+	copy = kmemdup(info->shadow, sizeof(info->shadow),
 		       GFP_NOIO | __GFP_REPEAT | __GFP_HIGH);
 	if (!copy)
 		return -ENOMEM;
-	memcpy(copy, info->shadow, sizeof(info->shadow));
 
 	/* Stage 2: Set up free list. */
 	memset(&info->shadow, 0, sizeof(info->shadow));
-- 
1.7.10.4
