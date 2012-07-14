From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 01/15] Drivers: hv: Format GUIDS as per MSFT standards
Date: Sat, 14 Jul 2012 13:34:06 -0700
Message-ID: <1342298060-12662-1-git-send-email-kys@microsoft.com>
References: <1342297930-12607-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1342297930-12607-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, olaf@aepfle.de, apw@canonical.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Format GUIDS as per MSFT standard. This makes interacting with MSFT
tool stack easier.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/hv/vmbus_drv.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index a220e57..1f7e54a 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -147,7 +147,7 @@ static ssize_t vmbus_show_device_attr(struct device *dev,
 
 	if (!strcmp(dev_attr->attr.name, "class_id")) {
 		ret = sprintf(buf, "{%02x%02x%02x%02x-%02x%02x-%02x%02x-"
-			       "%02x%02x%02x%02x%02x%02x%02x%02x}\n",
+			       "%02x%02x-%02x%02x%02x%02x%02x%02x}\n",
 			       device_info->chn_type.b[3],
 			       device_info->chn_type.b[2],
 			       device_info->chn_type.b[1],
@@ -166,7 +166,7 @@ static ssize_t vmbus_show_device_attr(struct device *dev,
 			       device_info->chn_type.b[15]);
 	} else if (!strcmp(dev_attr->attr.name, "device_id")) {
 		ret = sprintf(buf, "{%02x%02x%02x%02x-%02x%02x-%02x%02x-"
-			       "%02x%02x%02x%02x%02x%02x%02x%02x}\n",
+			       "%02x%02x-%02x%02x%02x%02x%02x%02x}\n",
 			       device_info->chn_instance.b[3],
 			       device_info->chn_instance.b[2],
 			       device_info->chn_instance.b[1],
-- 
1.7.4.1
