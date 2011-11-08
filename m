From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 09/11] Staging: hv: storvsc: Upgrade the vmstor protocol
	version
Date: Tue,  8 Nov 2011 09:01:48 -0800
Message-ID: <1320771710-29139-9-git-send-email-kys@microsoft.com>
References: <1320771677-29095-1-git-send-email-kys@microsoft.com>
	<1320771710-29139-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1320771710-29139-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com, James.Bottomley@HansenPartnership.com, hch@infradead.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

In preparation for supporting hot add/remove of scsi devices,
upgrade the vmstor protocol version.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/storvsc_drv.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index 4cdb417..9153641 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -80,7 +80,7 @@ MODULE_PARM_DESC(storvsc_ringbuffer_size, "Ring buffer size (bytes)");
 /* V1 Beta                    0.1 */
 /* V1 RC < 2008/1/31          1.0 */
 /* V1 RC > 2008/1/31          2.0 */
-#define VMSTOR_PROTOCOL_VERSION_CURRENT VMSTOR_PROTOCOL_VERSION(2, 0)
+#define VMSTOR_PROTOCOL_VERSION_CURRENT VMSTOR_PROTOCOL_VERSION(4, 2)
 
 
 
@@ -106,7 +106,8 @@ enum vstor_packet_operation {
 	VSTOR_OPERATION_END_INITIALIZATION	= 8,
 	VSTOR_OPERATION_QUERY_PROTOCOL_VERSION	= 9,
 	VSTOR_OPERATION_QUERY_PROPERTIES	= 10,
-	VSTOR_OPERATION_MAXIMUM			= 10
+	VSTOR_OPERATION_ENUMERATE_BUS		= 11,
+	VSTOR_OPERATION_MAXIMUM			= 11
 };
 
 /*
-- 
1.7.4.1
