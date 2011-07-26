From: ruslanpisarev@gmail.com
Subject: [PATCH 4/7] Xen: fix whitespaces,
	tabs coding style issue in drivers/xen/pci.c
Date: Tue, 26 Jul 2011 14:16:38 +0300
Message-ID: <1311678998-16630-1-git-send-email-ruslan@rpisarev.org.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jeremy.fitzhardinge@citrix.com
Cc: Ruslan Pisarev <ruslan@rpisarev.org.ua>, xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org, konrad.wilk@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

From: Ruslan Pisarev <ruslan@rpisarev.org.ua>

This is a patch to the pci.c file that fixed up whitespaces, tabs warnings found by the checkpatch.pl tools.

Signed-off-by: Ruslan Pisarev <ruslan@rpisarev.org.ua>
---
 drivers/xen/pci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/pci.c b/drivers/xen/pci.c
index cef4baf..c4448ee 100644
--- a/drivers/xen/pci.c
+++ b/drivers/xen/pci.c
@@ -36,7 +36,7 @@ static int xen_add_device(struct device *dev)
 		struct physdev_manage_pci_ext manage_pci_ext = {
 			.bus		= pci_dev->bus->number,
 			.devfn		= pci_dev->devfn,
-			.is_virtfn 	= 1,
+			.is_virtfn	= 1,
 			.physfn.bus	= pci_dev->physfn->bus->number,
 			.physfn.devfn	= pci_dev->physfn->devfn,
 		};
@@ -56,7 +56,7 @@ static int xen_add_device(struct device *dev)
 			&manage_pci_ext);
 	} else {
 		struct physdev_manage_pci manage_pci = {
-			.bus 	= pci_dev->bus->number,
+			.bus	= pci_dev->bus->number,
 			.devfn	= pci_dev->devfn,
 		};
 
-- 
1.7.4.1
