From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 08/77] Staging: hv: vmbus: Introduce vmbus ID space in struct
	hv_driver
Date: Thu, 16 Jun 2011 13:16:41 -0700
Message-ID: <1308255470-3826-8-git-send-email-kys@microsoft.com>
References: <1308255393-3785-1-git-send-email-kys@microsoft.com>
	<1308255470-3826-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1308255470-3826-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

To support autoloading of vmbus drivers, introduce vmbus ID space in
struct hv_driver.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/hyperv.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/hv/hyperv.h b/drivers/staging/hv/hyperv.h
index 21d9c73..84f60a3 100644
--- a/drivers/staging/hv/hyperv.h
+++ b/drivers/staging/hv/hyperv.h
@@ -801,12 +801,17 @@ struct hv_device_info {
 	struct hv_dev_port_info outbound;
 };
 
+struct hv_vmbus_device_id {
+	char device_type[32];
+};
+
 /* Base driver object */
 struct hv_driver {
 	const char *name;
 
 	/* the device type supported by this driver */
 	struct hv_guid dev_type;
+	const struct hv_vmbus_device_id *id_table;
 
 	struct device_driver driver;
 
-- 
1.7.4.1
