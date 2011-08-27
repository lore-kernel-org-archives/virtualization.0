From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 39/46] Staging: hv: vmbus: Fixup indentation in
	vmbus_acpi_add()
Date: Sat, 27 Aug 2011 11:31:38 -0700
Message-ID: <1314469905-7058-39-git-send-email-kys@microsoft.com>
References: <1314469874-7017-1-git-send-email-kys@microsoft.com>
	<1314469905-7058-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1314469905-7058-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Fixup indentation in vmbus_acpi_add().

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/vmbus_drv.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index 4e07d4f..d50fa89 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -678,9 +678,8 @@ static int vmbus_acpi_add(struct acpi_device *device)
 
 	hv_acpi_dev = device;
 
-	result =
-	acpi_walk_resources(device->handle, METHOD_NAME__CRS,
-			vmbus_walk_resources, &irq);
+	result = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
+					vmbus_walk_resources, &irq);
 
 	if (ACPI_FAILURE(result)) {
 		complete(&probe_event);
-- 
1.7.4.1
