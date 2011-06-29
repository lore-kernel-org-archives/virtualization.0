From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 18/40] Staging: hv: netvsc: Prevent outgoing traffic when
	netvsc dev is destroyed
Date: Wed, 29 Jun 2011 07:39:15 -0700
Message-ID: <1309358377-8537-18-git-send-email-kys@microsoft.com>
References: <1309358301-8488-1-git-send-email-kys@microsoft.com>
	<1309358377-8537-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1309358377-8537-1-git-send-email-kys@microsoft.com>
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
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Prevent outgoing traffic when netvsc dev is destroyed.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/netvsc.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/hv/netvsc.c b/drivers/staging/hv/netvsc.c
index 531de63..3ac0e17 100644
--- a/drivers/staging/hv/netvsc.c
+++ b/drivers/staging/hv/netvsc.c
@@ -60,7 +60,8 @@ static struct netvsc_device *get_outbound_net_device(struct hv_device *device)
 
 	spin_lock_irqsave(&device->ext_lock, flags);
 	net_device = device->ext;
-	if (net_device && atomic_read(&net_device->refcnt) > 1)
+	if (net_device && (atomic_read(&net_device->refcnt) > 1) &&
+		!net_device->destroy)
 		atomic_inc(&net_device->refcnt);
 	else
 		net_device = NULL;
-- 
1.7.4.1
