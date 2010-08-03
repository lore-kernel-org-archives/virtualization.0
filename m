From: Hank Janssen <hjanssen@microsoft.com>
Subject: [PATCH 5/6] staging: hv: Increased storvsc ringbuffer and
 max_io_requests
Date: Tue, 3 Aug 2010 17:31:55 +0000
Message-ID: <8AFC7968D54FB448A30D8F38F259C56223FD1D36@TK5EX14MBXC114.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'devel@driverdev.osuosl.org'" <devel@driverdev.osuosl.org>, "'virtualization@lists.osdl.org'" <virtualization@lists.osdl.org>
Cc: Haiyang Zhang <haiyangz@microsoft.com>, "'gregkh@suse.de'" <gregkh@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

From: Hank Janssen <hjanssen@microsoft.com>

Increased storvsc ringbuffer and max_io_requests. This now more closely mimics 
the numbers on Hyper-V. And will allow more IO requests to take place for the SCSI driver.

Signed-off-by:Hank Janssen <hjanssen@microsoft.com>
Signed-off-by:Haiyang Zhang <haiyangz@microsoft.com> 

---
 drivers/staging/hv/storvsc_api.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hv/storvsc_api.h b/drivers/staging/hv/storvsc_api.h
index 0063bde..8505a1c 100644
--- a/drivers/staging/hv/storvsc_api.h
+++ b/drivers/staging/hv/storvsc_api.h
@@ -28,10 +28,10 @@
 #include "vmbus_api.h"
 
 /* Defines */
-#define STORVSC_RING_BUFFER_SIZE			(10*PAGE_SIZE)
+#define STORVSC_RING_BUFFER_SIZE			(20*PAGE_SIZE)
 #define BLKVSC_RING_BUFFER_SIZE				(20*PAGE_SIZE)
 
-#define STORVSC_MAX_IO_REQUESTS				64
+#define STORVSC_MAX_IO_REQUESTS				128
 
 /*
  * In Hyper-V, each port/path/target maps to 1 scsi host adapter.  In
--
1.6.0.2
