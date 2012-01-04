From: Ian Campbell <ian.campbell@citrix.com>
Subject: [PATCH 2/2] xen/xenbus: don't reimplement kvasprintf via a fixed size
	buffer
Date: Wed, 4 Jan 2012 11:39:52 +0000
Message-ID: <1325677192-10459-2-git-send-email-ian.campbell@citrix.com>
References: <1325677158.25206.244.camel@zakaz.uk.xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1325677158.25206.244.camel@zakaz.uk.xensource.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Ian Campbell <ian.campbell@citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Haogang Chen <haogangchen@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
Cc: Haogang Chen <haogangchen@gmail.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: xen-devel@lists.xensource.com
Cc: virtualization@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/xen/xenbus/xenbus_xs.c |   17 +++++++----------
 1 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
index 6f0121e..226d1ac 100644
--- a/drivers/xen/xenbus/xenbus_xs.c
+++ b/drivers/xen/xenbus/xenbus_xs.c
@@ -532,21 +532,18 @@ int xenbus_printf(struct xenbus_transaction t,
 {
 	va_list ap;
 	int ret;
-#define PRINTF_BUFFER_SIZE 4096
-	char *printf_buffer;
-
-	printf_buffer = kmalloc(PRINTF_BUFFER_SIZE, GFP_NOIO | __GFP_HIGH);
-	if (printf_buffer == NULL)
-		return -ENOMEM;
+	char *buf;
 
 	va_start(ap, fmt);
-	ret = vsnprintf(printf_buffer, PRINTF_BUFFER_SIZE, fmt, ap);
+	buf = kvasprintf(GFP_NOIO | __GFP_HIGH, fmt, ap);
 	va_end(ap);
 
-	BUG_ON(ret > PRINTF_BUFFER_SIZE-1);
-	ret = xenbus_write(t, dir, node, printf_buffer);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = xenbus_write(t, dir, node, buf);
 
-	kfree(printf_buffer);
+	kfree(buf);
 
 	return ret;
 }
-- 
1.7.2.5
