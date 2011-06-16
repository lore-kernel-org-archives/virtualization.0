From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 43/77] Staging: hv: vmbus: Get rid of unnecessay comments in connection.c
Date: Thu, 16 Jun 2011 13:17:16 -0700
Message-ID: <1308255470-3826-43-git-send-email-kys@microsoft.com>
References: <1308255393-3785-1-git-send-email-kys@microsoft.com>
 <1308255470-3826-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308255470-3826-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Get rid of unnecessay comments in connection.c.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/connection.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hv/connection.c b/drivers/staging/hv/connection.c
index e6b4039..0e7efce 100644
--- a/drivers/staging/hv/connection.c
+++ b/drivers/staging/hv/connection.c
@@ -215,8 +215,6 @@ static void process_chn_event(u32 relid)
 {
 	struct vmbus_channel *channel;
 
-	/* ASSERT(relId > 0); */
-
 	/*
 	 * Find the channel based on this relid and invokes the
 	 * channel callback to process the event
-- 
1.7.4.1
