From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 24/40] Staging: hv: storvsc: On I/O get the correct IDE device
Date: Wed, 29 Jun 2011 07:39:21 -0700
Message-ID: <1309358377-8537-24-git-send-email-kys@microsoft.com>
References: <1309358301-8488-1-git-send-email-kys@microsoft.com>
	<1309358377-8537-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1309358377-8537-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

We use the channel number to distinguish an IDE device managed by the
storvsc driver from scsi devices. Add code to get the correct
device pointer based on the channel number.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/storvsc_drv.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index cf659d7..fcc3f5d 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -517,6 +517,16 @@ static int storvsc_queuecommand_lck(struct scsi_cmnd *scmnd,
 	unsigned int sg_count = 0;
 	struct vmscsi_request *vm_srb;
 
+	if (scmnd->device->channel >= HV_IDE_BASE_CHANNEL) {
+		int channel = scmnd->device->channel;
+
+		/*
+		 * This is an IDE device; get the right dev.
+		 */
+
+		dev = ide_devices[channel - HV_IDE_BASE_CHANNEL];
+	}
+
 	/* If retrying, no need to prep the cmd */
 	if (scmnd->host_scribble) {
 
-- 
1.7.4.1
