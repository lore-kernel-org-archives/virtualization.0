From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 153/493] xen: remove use of __devinit
Date: Mon, 19 Nov 2012 13:21:42 -0500
Message-ID: <1353349642-3677-153-git-send-email-wfp5p__27811.5125759088$1353350245$gmane$org@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: gregkh@linuxfoundation.org
Cc: xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

CONFIG_HOTPLUG is going away as an option so __devinit is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: xen-devel@lists.xensource.com 
Cc: virtualization@lists.linux-foundation.org 
---
 drivers/xen/grant-table.c          |  2 +-
 drivers/xen/platform-pci.c         |  2 +-
 drivers/xen/xen-pciback/pci_stub.c | 10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index 043bf07..a4982a3 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -1205,7 +1205,7 @@ int gnttab_init(void)
 }
 EXPORT_SYMBOL_GPL(gnttab_init);
 
-static int __devinit __gnttab_init(void)
+static int __gnttab_init(void)
 {
 	/* Delay grant-table initialization in the PV on HVM case */
 	if (xen_hvm_domain())
diff --git a/drivers/xen/platform-pci.c b/drivers/xen/platform-pci.c
index 97ca359..017f66d 100644
--- a/drivers/xen/platform-pci.c
+++ b/drivers/xen/platform-pci.c
@@ -101,7 +101,7 @@ static int platform_pci_resume(struct pci_dev *pdev)
 	return 0;
 }
 
-static int __devinit platform_pci_init(struct pci_dev *pdev,
+static int platform_pci_init(struct pci_dev *pdev,
 				       const struct pci_device_id *ent)
 {
 	int i, ret;
diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
index 961d664..4ac9da7 100644
--- a/drivers/xen/xen-pciback/pci_stub.c
+++ b/drivers/xen/xen-pciback/pci_stub.c
@@ -270,7 +270,7 @@ void pcistub_put_pci_dev(struct pci_dev *dev)
 	up_write(&pcistub_sem);
 }
 
-static int __devinit pcistub_match_one(struct pci_dev *dev,
+static int pcistub_match_one(struct pci_dev *dev,
 				       struct pcistub_device_id *pdev_id)
 {
 	/* Match the specified device by domain, bus, slot, func and also if
@@ -290,7 +290,7 @@ static int __devinit pcistub_match_one(struct pci_dev *dev,
 	return 0;
 }
 
-static int __devinit pcistub_match(struct pci_dev *dev)
+static int pcistub_match(struct pci_dev *dev)
 {
 	struct pcistub_device_id *pdev_id;
 	unsigned long flags;
@@ -308,7 +308,7 @@ static int __devinit pcistub_match(struct pci_dev *dev)
 	return found;
 }
 
-static int __devinit pcistub_init_device(struct pci_dev *dev)
+static int pcistub_init_device(struct pci_dev *dev)
 {
 	struct xen_pcibk_dev_data *dev_data;
 	int err = 0;
@@ -426,7 +426,7 @@ static int __init pcistub_init_devices_late(void)
 	return 0;
 }
 
-static int __devinit pcistub_seize(struct pci_dev *dev)
+static int pcistub_seize(struct pci_dev *dev)
 {
 	struct pcistub_device *psdev;
 	unsigned long flags;
@@ -461,7 +461,7 @@ static int __devinit pcistub_seize(struct pci_dev *dev)
 	return err;
 }
 
-static int __devinit pcistub_probe(struct pci_dev *dev,
+static int pcistub_probe(struct pci_dev *dev,
 				   const struct pci_device_id *id)
 {
 	int err = 0;
-- 
1.8.0
