From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 27/49] Staging: hv: vmbus: Fix the memory barrier in
	hv_ringbuffer_read()
Date: Mon,  6 Jun 2011 15:49:51 -0700
Message-ID: <1307400613-13234-27-git-send-email-kys@microsoft.com>
References: <1307400540-13193-1-git-send-email-kys@microsoft.com>
	<1307400613-13234-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1307400613-13234-1-git-send-email-kys@microsoft.com>
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

Use the correct barrier interface.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
---
 drivers/staging/hv/ring_buffer.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/hv/ring_buffer.c b/drivers/staging/hv/ring_buffer.c
index 3da3330..932af1a 100644
--- a/drivers/staging/hv/ring_buffer.c
+++ b/drivers/staging/hv/ring_buffer.c
@@ -513,7 +513,7 @@ int hv_ringbuffer_read(struct hv_ring_buffer_info *inring_info, void *buffer,
 	/* Make sure all reads are done before we update the read index since */
 	/* the writer may start writing to the read area once the read index */
 	/*is updated */
-	mb();
+	smp_mb();
 
 	/* Update the read index */
 	hv_set_next_read_location(inring_info, next_read_location);
-- 
1.7.4.1
