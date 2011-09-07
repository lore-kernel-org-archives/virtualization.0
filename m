From: Yong Zhang <yong.zhang0@gmail.com>
Subject: [PATCH 59/62] xen: irq: Remove IRQF_DISABLED
Date: Wed,  7 Sep 2011 16:10:56 +0800
Message-ID: <1315383059-3673-60-git-send-email-yong.zhang0@gmail.com>
References: <1315383059-3673-1-git-send-email-yong.zhang0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1315383059-3673-1-git-send-email-yong.zhang0@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, virtualization@lists.linux-foundation.org, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, tglx@linutronix.de, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

This flag is a NOOP and can be removed now.

Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
---
 drivers/xen/evtchn.c       |    2 +-
 drivers/xen/platform-pci.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/evtchn.c b/drivers/xen/evtchn.c
index dbc13e9..95e2507 100644
--- a/drivers/xen/evtchn.c
+++ b/drivers/xen/evtchn.c
@@ -265,7 +265,7 @@ static int evtchn_bind_to_user(struct per_user_data *u, int port)
 	set_port_user(port, u);
 	set_port_enabled(port, true); /* start enabled */
 
-	rc = bind_evtchn_to_irqhandler(port, evtchn_interrupt, IRQF_DISABLED,
+	rc = bind_evtchn_to_irqhandler(port, evtchn_interrupt, 0,
 				       u->name, (void *)(unsigned long)port);
 	if (rc >= 0)
 		rc = 0;
diff --git a/drivers/xen/platform-pci.c b/drivers/xen/platform-pci.c
index 319dd0a..482beff 100644
--- a/drivers/xen/platform-pci.c
+++ b/drivers/xen/platform-pci.c
@@ -84,7 +84,7 @@ static irqreturn_t do_hvm_evtchn_intr(int irq, void *dev_id)
 static int xen_allocate_irq(struct pci_dev *pdev)
 {
 	return request_irq(pdev->irq, do_hvm_evtchn_intr,
-			IRQF_DISABLED | IRQF_NOBALANCING | IRQF_TRIGGER_RISING,
+			IRQF_NOBALANCING | IRQF_TRIGGER_RISING,
 			"xen-platform-pci", pdev);
 }
 
-- 
1.7.4.1
