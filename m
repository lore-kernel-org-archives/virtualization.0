From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 14/16] Staging: hv: Move the definition of the function
	put_stor_device()
Date: Wed, 23 Mar 2011 10:50:32 -0700
Message-ID: <1300902635-1347-14-git-send-email-kys@microsoft.com>
References: <1300902537-1290-1-git-send-email-kys@microsoft.com>
	<1300902635-1347-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1300902635-1347-1-git-send-email-kys@microsoft.com>
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

In preparation for further cleaning up storvsc.c move the definition
of the inline function put_stor_device() from storvsc.c to
storvsc_api.h.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/storvsc.c     |    9 ---------
 drivers/staging/hv/storvsc_api.h |   10 ++++++++++
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/hv/storvsc.c b/drivers/staging/hv/storvsc.c
index 357f5dd..c576e7b 100644
--- a/drivers/staging/hv/storvsc.c
+++ b/drivers/staging/hv/storvsc.c
@@ -71,15 +71,6 @@ static inline struct storvsc_device *must_get_stor_device(
 	return stor_device;
 }
 
-static inline void put_stor_device(struct hv_device *device)
-{
-	struct storvsc_device *stor_device;
-
-	stor_device = (struct storvsc_device *)device->ext;
-
-	atomic_dec(&stor_device->ref_count);
-}
-
 /* Drop ref count to 1 to effectively disable get_stor_device() */
 static inline struct storvsc_device *release_stor_device(
 					struct hv_device *device)
diff --git a/drivers/staging/hv/storvsc_api.h b/drivers/staging/hv/storvsc_api.h
index 4e66507..d46b4de 100644
--- a/drivers/staging/hv/storvsc_api.h
+++ b/drivers/staging/hv/storvsc_api.h
@@ -152,6 +152,16 @@ static inline struct storvsc_device *get_stor_device(struct hv_device *device)
 	return stor_device;
 }
 
+
+static inline void put_stor_device(struct hv_device *device)
+{
+	struct storvsc_device *stor_device;
+
+	stor_device = (struct storvsc_device *)device->ext;
+
+	atomic_dec(&stor_device->ref_count);
+}
+
 /* Interface */
 int stor_vsc_on_host_reset(struct hv_device *device);
 
-- 
1.7.4.1
