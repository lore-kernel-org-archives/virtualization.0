From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 1/4] Drivers: hv: Fix a memory leak
Date: Mon, 12 Dec 2011 09:29:16 -0800
Message-ID: <1323710959-29655-1-git-send-email-kys@microsoft.com>
References: <1323710931-29616-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1323710931-29616-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

There was a memory leak in a failure path in vmbus_process_offer().
Fix it.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/hv/channel_mgmt.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 12b85ff..b91af50 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -287,6 +287,7 @@ static void vmbus_process_offer(struct work_struct *work)
 		spin_lock_irqsave(&vmbus_connection.channel_lock, flags);
 		list_del(&newchannel->listentry);
 		spin_unlock_irqrestore(&vmbus_connection.channel_lock, flags);
+		kfree(newchannel->device_obj);
 
 		free_channel(newchannel);
 	} else {
-- 
1.7.4.1
