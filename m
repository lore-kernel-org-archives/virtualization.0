From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH V2 18/18] Tools: hv: Properly manage open streams
Date: Mon, 13 Aug 2012 10:07:07 -0700
Message-ID: <1344877627-21779-18-git-send-email-kys@microsoft.com>
References: <1344877584-21738-1-git-send-email-kys@microsoft.com>
 <1344877627-21779-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1344877627-21779-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, olaf@aepfle.de, apw@canonical.com, ben@decadent.org.uk
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Close the open streams properly.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Olaf Hering <olaf@aepfle.de>
Reviewed-by: Ben Hutchings <ben@decadent.org.uk>
---
 tools/hv/hv_kvp_daemon.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index c8e1013..ca6424f 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -160,7 +160,7 @@ static void kvp_update_file(int pool)
 				sizeof(struct kvp_record),
 				kvp_file_info[pool].num_records, filep);
 
-	fflush(filep);
+	fclose(filep);
 	kvp_release_lock(pool);
 }
 
@@ -206,7 +206,7 @@ static void kvp_update_mem_state(int pool)
 	kvp_file_info[pool].num_blocks = num_blocks;
 	kvp_file_info[pool].records = record;
 	kvp_file_info[pool].num_records = records_read;
-
+	fclose(filep);
 	kvp_release_lock(pool);
 }
 static int kvp_file_init(void)
-- 
1.7.4.1
