From: Amos Kong <akong@redhat.com>
Subject: [PATCH 1/2] virtio-rng cleanup: move some code out of mutex protection
Date: Wed, 10 Sep 2014 17:07:06 +0800
Message-ID: <1410340027-15373-2-git-send-email-akong@redhat.com>
References: <1410340027-15373-1-git-send-email-akong@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1410340027-15373-1-git-send-email-akong@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: amit.shah@redhat.com, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

It doesn't save too much cpu time as expected, just a cleanup.

Signed-off-by: Amos Kong <akong@redhat.com>
---
 drivers/char/hw_random/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index aa30a25..c591d7e 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -270,8 +270,8 @@ static ssize_t hwrng_attr_current_show(struct device *dev,
 		return -ERESTARTSYS;
 	if (current_rng)
 		name = current_rng->name;
-	ret = snprintf(buf, PAGE_SIZE, "%s\n", name);
 	mutex_unlock(&rng_mutex);
+	ret = snprintf(buf, PAGE_SIZE, "%s\n", name);
 
 	return ret;
 }
@@ -284,19 +284,19 @@ static ssize_t hwrng_attr_available_show(struct device *dev,
 	ssize_t ret = 0;
 	struct hwrng *rng;
 
+	buf[0] = '\0';
 	err = mutex_lock_interruptible(&rng_mutex);
 	if (err)
 		return -ERESTARTSYS;
-	buf[0] = '\0';
 	list_for_each_entry(rng, &rng_list, list) {
 		strncat(buf, rng->name, PAGE_SIZE - ret - 1);
 		ret += strlen(rng->name);
 		strncat(buf, " ", PAGE_SIZE - ret - 1);
 		ret++;
 	}
+	mutex_unlock(&rng_mutex);
 	strncat(buf, "\n", PAGE_SIZE - ret - 1);
 	ret++;
-	mutex_unlock(&rng_mutex);
 
 	return ret;
 }
-- 
1.9.3
