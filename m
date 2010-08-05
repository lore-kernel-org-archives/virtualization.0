From: Hank Janssen <hjanssen@microsoft.com>
Subject: [PATCH 3/5] staging: hv: Fixed the value of the 64bit-hole inside
 ring buffer
Date: Thu, 5 Aug 2010 19:30:01 +0000
Message-ID: <8AFC7968D54FB448A30D8F38F259C56223FEC892@TK5EX14MBXC114.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'devel@driverdev.osuosl.org'" <devel@driverdev.osuosl.org>, "'virtualization@lists.osdl.org'" <virtualization@lists.osdl.org>
Cc: Haiyang Zhang <haiyangz@microsoft.com>, "'gregkh@suse.de'" <gregkh@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

From: Haiyang Zhang <haiyangz@microsoft.com>

Fixed the value of the 64bit-hole inside ring buffer, this
caused a problem on Hyper-V when running checked Windows builds.

Checked builds of Windows are used internally and given to external system
integrators at times. They are builds that for example that all elements in a
structure follow the definition of that Structure. The bug this fixed was for a
field that we did not fill in at all (Because we do Not use it on the Linux side),
and the checked build of windows gives errors on it internally to the Windows logs.

This fixes that error.

Signed-off-by:Hank Janssen <hjanssen@microsoft.com>
Signed-off-by:Haiyang Zhang <haiyangz@microsoft.com>
Cc: stable <stable@kernel.org>
---
 drivers/staging/hv/ring_buffer.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hv/ring_buffer.c b/drivers/staging/hv/ring_buffer.c
index 66a4974..133f909 100644
--- a/drivers/staging/hv/ring_buffer.c
+++ b/drivers/staging/hv/ring_buffer.c
@@ -192,8 +192,7 @@ Description:
 static inline u64
 GetRingBufferIndices(RING_BUFFER_INFO *RingInfo)  {
-	return ((u64)RingInfo->RingBuffer->WriteIndex << 32)
-	|| RingInfo->RingBuffer->ReadIndex;
+	return (u64)RingInfo->RingBuffer->WriteIndex << 32;
 }
 
 
--
1.6.0.2
