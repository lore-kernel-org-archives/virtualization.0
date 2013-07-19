From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] xen: replace strict_strtoul() with kstrtoul()
Date: Fri, 19 Jul 2013 16:20:15 +0900
Message-ID: <001701ce8450$6a607700$3f216500$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-language: ko
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: 'Konrad Rzeszutek Wilk' <konrad.wilk@oracle.com>
Cc: Jingoo Han <jg1.han@samsung.com>, 'Jeremy Fitzhardinge' <jeremy@goop.org>, xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The usage of strict_strtoul() is not preferred, because
strict_strtoul() is obsolete. Thus, kstrtoul() should be
used.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/xen/xen-selfballoon.c |   54 +++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 18 deletions(-)

diff --git a/drivers/xen/xen-selfballoon.c b/drivers/xen/xen-selfballoon.c
index 02817a8..21e18c1 100644
--- a/drivers/xen/xen-selfballoon.c
+++ b/drivers/xen/xen-selfballoon.c
@@ -265,8 +265,10 @@ static ssize_t store_selfballooning(struct device *dev,
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	err = strict_strtoul(buf, 10, &tmp);
-	if (err || ((tmp != 0) && (tmp != 1)))
+	err = kstrtoul(buf, 10, &tmp);
+	if (err)
+		return err;
+	if ((tmp != 0) && (tmp != 1))
 		return -EINVAL;
 
 	xen_selfballooning_enabled = !!tmp;
@@ -292,8 +294,10 @@ static ssize_t store_selfballoon_interval(struct device *dev,
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
-	err = strict_strtoul(buf, 10, &val);
-	if (err || val == 0)
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+	if (val == 0)
 		return -EINVAL;
 	selfballoon_interval = val;
 	return count;
@@ -314,8 +318,10 @@ static ssize_t store_selfballoon_downhys(struct device *dev,
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
-	err = strict_strtoul(buf, 10, &val);
-	if (err || val == 0)
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+	if (val == 0)
 		return -EINVAL;
 	selfballoon_downhysteresis = val;
 	return count;
@@ -337,8 +343,10 @@ static ssize_t store_selfballoon_uphys(struct device *dev,
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
-	err = strict_strtoul(buf, 10, &val);
-	if (err || val == 0)
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+	if (val == 0)
 		return -EINVAL;
 	selfballoon_uphysteresis = val;
 	return count;
@@ -360,8 +368,10 @@ static ssize_t store_selfballoon_min_usable_mb(struct device *dev,
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
-	err = strict_strtoul(buf, 10, &val);
-	if (err || val == 0)
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+	if (val == 0)
 		return -EINVAL;
 	selfballoon_min_usable_mb = val;
 	return count;
@@ -384,8 +394,10 @@ static ssize_t store_selfballoon_reserved_mb(struct device *dev,
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
-	err = strict_strtoul(buf, 10, &val);
-	if (err || val == 0)
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+	if (val == 0)
 		return -EINVAL;
 	selfballoon_reserved_mb = val;
 	return count;
@@ -410,8 +422,10 @@ static ssize_t store_frontswap_selfshrinking(struct device *dev,
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
-	err = strict_strtoul(buf, 10, &tmp);
-	if (err || ((tmp != 0) && (tmp != 1)))
+	err = kstrtoul(buf, 10, &tmp);
+	if (err)
+		return err;
+	if ((tmp != 0) && (tmp != 1))
 		return -EINVAL;
 	frontswap_selfshrinking = !!tmp;
 	if (!was_enabled && !xen_selfballooning_enabled &&
@@ -437,8 +451,10 @@ static ssize_t store_frontswap_inertia(struct device *dev,
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
-	err = strict_strtoul(buf, 10, &val);
-	if (err || val == 0)
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+	if (val == 0)
 		return -EINVAL;
 	frontswap_inertia = val;
 	frontswap_inertia_counter = val;
@@ -460,8 +476,10 @@ static ssize_t store_frontswap_hysteresis(struct device *dev,
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
-	err = strict_strtoul(buf, 10, &val);
-	if (err || val == 0)
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+	if (val == 0)
 		return -EINVAL;
 	frontswap_hysteresis = val;
 	return count;
-- 
1.7.10.4
