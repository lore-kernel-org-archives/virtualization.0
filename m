From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 5/6] Staging: hv: mousevsc: Add a new line to a debug string
Date: Tue, 25 Oct 2011 17:19:51 -0700
Message-ID: <1319588392-9982-5-git-send-email-kys@microsoft.com>
References: <1319588311-9935-1-git-send-email-kys@microsoft.com>
	<1319588392-9982-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1319588392-9982-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com, dmitry.torokhov@gmail.com, joe@perches.com
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Add a new line to a debug string.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/hv_mouse.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/hv/hv_mouse.c b/drivers/staging/hv/hv_mouse.c
index b10466f..21cd050 100644
--- a/drivers/staging/hv/hv_mouse.c
+++ b/drivers/staging/hv/hv_mouse.c
@@ -411,7 +411,7 @@ static int mousevsc_connect_to_vsp(struct hv_device *device)
 	response = &input_dev->protocol_resp;
 
 	if (!response->response.approved) {
-		pr_err("synthhid protocol request failed (version %d)",
+		pr_err("synthhid protocol request failed (version %d)\n",
 		       SYNTHHID_INPUT_VERSION);
 		ret = -ENODEV;
 		goto cleanup;
-- 
1.7.4.1
