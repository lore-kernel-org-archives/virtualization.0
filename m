From: Tushar Behera <tushar.behera@linaro.org>
Subject: [PATCH 09/14] xen: events: Remove redundant check on unsigned variable
Date: Fri, 16 Nov 2012 12:20:41 +0530
Message-ID: <1353048646-10935-10-git-send-email-tushar.behera__41715.8034084879$1353091984$gmane$org@linaro.org>
References: <1353048646-10935-1-git-send-email-tushar.behera@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1353048646-10935-1-git-send-email-tushar.behera@linaro.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, virtualization@lists.linux-foundation.org, xen-devel@lists.xensource.com, patches@linaro.org
List-Id: virtualization@lists.linuxfoundation.org

No need to check whether unsigned variable is less than 0.

CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
CC: Jeremy Fitzhardinge <jeremy@goop.org>
CC: xen-devel@lists.xensource.com
CC: virtualization@lists.linux-foundation.org
Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 drivers/xen/events.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/xen/events.c b/drivers/xen/events.c
index 4293c57..cadd7d1 100644
--- a/drivers/xen/events.c
+++ b/drivers/xen/events.c
@@ -216,7 +216,7 @@ static void xen_irq_info_pirq_init(unsigned irq,
  */
 static unsigned int evtchn_from_irq(unsigned irq)
 {
-	if (unlikely(WARN(irq < 0 || irq >= nr_irqs, "Invalid irq %d!\n", irq)))
+	if (unlikely(WARN(irq >= nr_irqs, "Invalid irq %d!\n", irq)))
 		return 0;
 
 	return info_for_irq(irq)->evtchn;
-- 
1.7.4.1
