From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] xen-pciback: fix error return code in
	pcistub_irq_handler_switch()
Date: Fri, 31 May 2013 19:59:20 +0800
Message-ID: <CAPgLHd89ByaKLsvu=C-im9cg=7X7jNANuS+BaHt_EGotc-8hmA@mail.gmail.com>
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
To: konrad.wilk@oracle.com, jeremy@goop.org, jbeulich@suse.com, shemminger@vyatta.com, gregkh@linuxfoundation.org, jkosina@suse.cz
Cc: yongjun_wei@trendmicro.com.cn, xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fix to return -ENOENT in the pcistub_device_find() and pci_get_drvdata()
error handling case instead of 0(overwrite to 0 by str_to_slot()), as done
elsewhere in this function.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/xen/xen-pciback/pci_stub.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
index 4e8ba38..0020899 100644
--- a/drivers/xen/xen-pciback/pci_stub.c
+++ b/drivers/xen/xen-pciback/pci_stub.c
@@ -1196,19 +1196,23 @@ static ssize_t pcistub_irq_handler_switch(struct device_driver *drv,
 	struct pcistub_device *psdev;
 	struct xen_pcibk_dev_data *dev_data;
 	int domain, bus, slot, func;
-	int err = -ENOENT;
+	int err;
 
 	err = str_to_slot(buf, &domain, &bus, &slot, &func);
 	if (err)
 		return err;
 
 	psdev = pcistub_device_find(domain, bus, slot, func);
-	if (!psdev)
+	if (!psdev) {
+		err = -ENOENT;
 		goto out;
+	}
 
 	dev_data = pci_get_drvdata(psdev->dev);
-	if (!dev_data)
+	if (!dev_data) {
+		err = -ENOENT;
 		goto out;
+	}
 
 	dev_dbg(&psdev->dev->dev, "%s fake irq handler: %d->%d\n",
 		dev_data->irq_name, dev_data->isr_on,
