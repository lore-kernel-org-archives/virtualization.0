From: "Fischer, Anna" <anna.fischer@hp.com>
Subject: [PATCH] bridge-utils: fix sysfs path for setting bridge
	configuration parameters
Date: Mon, 15 Jun 2009 17:33:35 +0000
Message-ID: <0199E0D51A61344794750DC57738F58E67D2DCECBC__21322.9656139903$1245088000$gmane$org@GVW1118EXC.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@v>
Cc: Arnd Bergmann <arnd@arndb.de>, "davem@davemloft.net" <davem@davemloft.net>, "Paul Congdon (UC Davis)" <ptcongdon@ucdavis.edu>, "shemminger@linux-foundation.org" <shemminger@linux-foundation.org>, "adobriyan@gmail.com" <adobriyan@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

Under newer kernels the bridge configuration parameters 
are located under /sys/class/net/$bridgename/bridge/$param,
while the current bridge-utils code is trying to access
them under /sys/class/net/$bridgename/$param. This patch
fixes this issue in the bridge-utils code and so allows 
setting of bridge configuration parameters using sysfs 
under newer kernel versions.

Signed-off-by: Anna Fischer <anna.fischer@hp.com>

---

 libbridge/libbridge_devif.c   |   25 +++++++++++++++++++++----
 libbridge/libbridge_private.h |    1 +
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/libbridge/libbridge_devif.c b/libbridge/libbridge_devif.c
index 34e3cc8..547bb86 100644
--- a/libbridge/libbridge_devif.c
+++ b/libbridge/libbridge_devif.c
@@ -73,6 +73,26 @@ static void fetch_tv(const char *dev, const char *name,
 	__jiffies_to_tv(tv, fetch_int(dev, name));
 }
 
+/* Open sysfs path for writing bridge properties. */
+static FILE *br_sysfs_open(const char *bridge, const char *name)
+{
+	char path[SYSFS_PATH_MAX];
+
+	/* Try accessing /sys/class/net/$bridge/bridge/$name. */
+	snprintf(path, SYSFS_PATH_MAX, SYSFS_CLASS_NET "%s"
+		 SYSFS_BRIDGE_DIR "/%s", bridge, name);
+	if (!access(path, F_OK))
+		return fopen(path, "w+");
+
+	/* Try using old-style of accessing bridge sysfs properties. */
+	snprintf(path, SYSFS_PATH_MAX, SYSFS_CLASS_NET "%s/%s",
+		 bridge, name);
+	if (!access(path, F_OK))
+		return fopen(path, "w+");
+
+	return NULL;
+}
+
 /*
  * Convert device name to an index in the list of ports in bridge.
  *
@@ -283,12 +303,9 @@ static int br_set(const char *bridge, const char *name,
 		  unsigned long value, unsigned long oldcode)
 {
 	int ret;
-	char path[SYSFS_PATH_MAX];
 	FILE *f;
 
-	snprintf(path, SYSFS_PATH_MAX, SYSFS_CLASS_NET "%s/%s", bridge, name);
-
-	f = fopen(path, "w");
+	f = br_sysfs_open(bridge, name);
 	if (f) {
 		ret = fprintf(f, "%ld\n", value);
 		fclose(f);
diff --git a/libbridge/libbridge_private.h b/libbridge/libbridge_private.h
index 99a511d..1e1a0c6 100644
--- a/libbridge/libbridge_private.h
+++ b/libbridge/libbridge_private.h
@@ -31,6 +31,7 @@
 
 #define SYSFS_CLASS_NET "/sys/class/net/"
 #define SYSFS_PATH_MAX	256
+#define SYSFS_BRIDGE_DIR "/bridge"
 
 #define dprintf(fmt,arg...)
