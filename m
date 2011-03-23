From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 01/16] Staging: hv: Add the inclusion guard for vstorage.h
Date: Wed, 23 Mar 2011 10:50:19 -0700
Message-ID: <1300902635-1347-1-git-send-email-kys@microsoft.com>
References: <1300902537-1290-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1300902537-1290-1-git-send-email-kys@microsoft.com>
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
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

In preparation for getting rid of the inclusion of storvsc.c from
blkvsc.c, add inclusion guard to vstorage.h

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/vstorage.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/hv/vstorage.h b/drivers/staging/hv/vstorage.h
index ebb4d67..83060cd 100644
--- a/drivers/staging/hv/vstorage.h
+++ b/drivers/staging/hv/vstorage.h
@@ -25,6 +25,9 @@
 /* to alert the user that structure sizes may be mismatched even though the */
 /* protocol versions match. */
 
+#ifndef _VSTORAGE_H_
+#define _VSTORAGE_H_
+
 #define REVISION_STRING(REVISION_) #REVISION_
 #define FILL_VMSTOR_REVISION(RESULT_LVALUE_)				\
 	do {								\
@@ -190,3 +193,5 @@ struct vstor_packet {
 
 /*  This is the set of flags that the vsc can set in any packets it sends */
 #define VSC_LEGAL_FLAGS		(REQUEST_COMPLETION_FLAG)
+
+#endif /* _VSTORAGE_H_ */
-- 
1.7.4.1
