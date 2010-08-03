From: Hank Janssen <hjanssen@microsoft.com>
Subject: [PATCH 1/6] staging: hv: Fixed bounce kmap problem by using correct
	index
Date: Tue, 3 Aug 2010 17:31:51 +0000
Message-ID: <8AFC7968D54FB448A30D8F38F259C56223FD0D21@TK5EX14MBXC114.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Language: en-US
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'devel@driverdev.osuosl.org'" <devel@driverdev.osuosl.org>, "'virtualization@lists.osdl.org'" <virtualization@lists.osdl.org>
Cc: Haiyang Zhang <haiyangz@microsoft.com>, "'gregkh@suse.de'" <gregkh@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

From: Hank Janssen <hjanssen@microsoft.com> 

Fixed bounce offset kmap problem by using correct index

Signed-off-by:Hank Janssen <hjanssen@microsoft.com>
Signed-off-by:Haiyang Zhang <haiyangz@microsoft.com>

---
 drivers/staging/hv/storvsc_drv.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index 075b61b..3b9ccb0 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -495,7 +495,7 @@ static unsigned int copy_to_bounce_buffer(struct scatterlist *orig_sgl,
 
 		/* ASSERT(orig_sgl[i].offset + orig_sgl[i].length <= PAGE_SIZE); */
 
-		if (j == 0)
+		if (bounce_addr == 0)
 			bounce_addr = (unsigned long)kmap_atomic(sg_page((&bounce_sgl[j])), KM_IRQ0);
 
 		while (srclen) {
@@ -556,7 +556,7 @@ static unsigned int copy_from_bounce_buffer(struct scatterlist *orig_sgl,
 		destlen = orig_sgl[i].length;
 		/* ASSERT(orig_sgl[i].offset + orig_sgl[i].length <= PAGE_SIZE); */
 
-		if (j == 0)
+		if (bounce_addr == 0)
 			bounce_addr = (unsigned long)kmap_atomic(sg_page((&bounce_sgl[j])), KM_IRQ0);
 
 		while (destlen) {
--
1.6.0.2
