From: Hank Janssen <hjanssen@microsoft.com>
Subject: [PATCH 1/1] Stage: hv: Remove Ringbuffer from TODO line
Date: Thu, 4 Mar 2010 17:46:28 +0000
Message-ID: <8AFC7968D54FB448A30D8F38F259C56217DBFDEA@TK5EX14MBXC116.redmond.corp.microsoft.com>
References: <1FB5E1D5CA062146B38059374562DF725A908A11@TK5EX14MBXC126.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Hashir Abdi <habdi@microsoft.com>, Greg KH <greg@kroah.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Hank Janssen <hjanssen@microsoft.com>

Remove Ringbuffer work line item from TODO file. 

The ring buffer in the Hyper-V Linux drivers is used to communicate with 
the parent partition running Windows Server 2008 Hyper-V. The ring buffer functionality 
on the Hyper-V Linux drivers is written to be functionally compatible with 
the ring buffer functionality on the Hyper-V Server. Consequently, it is not 
possible to make any changes that might break the compatibility with server 
side ring buffer implementation.

Cc: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

---
 drivers/staging/hv/TODO |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/hv/TODO b/drivers/staging/hv/TODO index dbfbde9..efe8ce9 100644
--- a/drivers/staging/hv/TODO
+++ b/drivers/staging/hv/TODO
@@ -1,7 +1,6 @@
 TODO:
 	- fix remaining checkpatch warnings and errors
 	- use of /** when it is not a kerneldoc header
-	- remove RingBuffer.c to us in-kernel ringbuffer functions instead.
 	- audit the vmbus to verify it is working properly with the
 	  driver model
 	- convert vmbus driver interface function pointer tables
