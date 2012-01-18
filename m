From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 1/1] drivers: hid: hid-hyperv: Properly disconnect the input device
Date: Wed, 18 Jan 2012 08:57:14 -0800
Message-ID: <1326905834-7624-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com, joe@perches.com, dmitry.torokhov@gmail.com, jkosina@suse.cz
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, stable <stable@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

When we unload the mouse driver, properly disconnect the input device.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Reported-by: Fuzhou Chen <fuzhouch@microsoft.com>
Cc: stable <stable@vger.kernel.org>
---
 drivers/hid/hid-hyperv.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
index 0c33ae9..4066324 100644
--- a/drivers/hid/hid-hyperv.c
+++ b/drivers/hid/hid-hyperv.c
@@ -548,6 +548,7 @@ static int mousevsc_remove(struct hv_device *dev)
 	struct mousevsc_dev *input_dev = hv_get_drvdata(dev);
 
 	vmbus_close(dev->channel);
+	hid_hw_stop(input_dev->hid_device);
 	hid_destroy_device(input_dev->hid_device);
 	mousevsc_free_device(input_dev);
 
-- 
1.7.4.1
