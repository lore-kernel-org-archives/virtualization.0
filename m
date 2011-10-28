From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 2/3] Staging: hv: mousevsc: Add a check to prevent memory corruption
Date: Fri, 28 Oct 2011 15:11:27 -0700
Message-ID: <1319839888-29000-2-git-send-email-kys@microsoft.com>
References: <1319839847-28959-1-git-send-email-kys@microsoft.com>
 <1319839888-29000-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1319839888-29000-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com, joe@perches.com, dmitry.torokhov@gmail.com, jkosina@suse.cz
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Add a check to prevent memory corruption.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/staging/hv/hv_mouse.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/hv/hv_mouse.c b/drivers/staging/hv/hv_mouse.c
index 7c7449b..c22f729 100644
--- a/drivers/staging/hv/hv_mouse.c
+++ b/drivers/staging/hv/hv_mouse.c
@@ -274,6 +274,18 @@ static void mousevsc_on_receive(struct hv_device *device,
 
 	switch (hid_msg->header.type) {
 	case SYNTH_HID_PROTOCOL_RESPONSE:
+		/*
+		 * While it will be impossible for us to protect against
+		 * malicious/buggy hypervisor/host, add a check here to
+		 * ensure we don't corrupt memory.
+		 */
+		if ((pipe_msg->size + sizeof(struct pipe_prt_msg)
+			- sizeof(unsigned char))
+			> sizeof(struct mousevsc_prt_msg)) {
+			WARN_ON(1);
+			break;
+		}
+
 		memcpy(&input_dev->protocol_resp, pipe_msg,
 		       pipe_msg->size + sizeof(struct pipe_prt_msg) -
 		       sizeof(unsigned char));
-- 
1.7.4.1
