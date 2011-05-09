From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 163/206] Staging: hv: Include asm/hyperv.h
Date: Mon,  9 May 2011 14:57:25 -0700
Message-ID: <1304978288-22999-163-git-send-email-kys@microsoft.com>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com>
 <1304978288-22999-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1304978288-22999-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

The subject line says it all.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 include/linux/hyperv.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index f91e3a4..92369b9 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -32,6 +32,7 @@
 #include <linux/completion.h>
 #include <linux/scatterlist.h>
 #include <linux/device.h>
+#include <asm/hyperv.h>
 
 #define MAX_PAGE_BUFFER_COUNT				16
 #define MAX_MULTIPAGE_BUFFER_COUNT			32 /* 128K */
-- 
1.7.4.1
