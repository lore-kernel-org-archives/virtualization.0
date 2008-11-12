From: "Satoshi UCHIDA" <s-uchida@ap.jp.nec.com>
Subject: [PATCH][cfq-cgroups][Option 1] Introduce a think time valid entry.
Date: Wed, 12 Nov 2008 17:37:24 +0900
Message-ID: <002601c944a1$e3026c20$a9074460$__36341.9841546149$1226481414$gmane$org@jp.nec.com>
References: <000c01c9449e$c5bcdc20$51369460$@jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <000c01c9449e$c5bcdc20$51369460$@jp.nec.com>
Content-Language: ja
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, jens.axboe@oracle.com, 'Ryo Tsuruta' <ryov@valin>
Cc: 'Andrew Morton' <akpm@linux-foundation.org>, 'SUGAWARA Tomoyoshi' <tom-sugawara@ap.jp.nec.com>, menage@google.com, balbir@linux.vnet.ibm.com
List-Id: virtualization@lists.linuxfoundation.org


  This patch introduces a think time valid entry.
 
  A think time is effective when queue is poor I/O requests
  because its queue is handled as idle class and then
  next queue can start to dispatch requests right after it.
  However, if there are many tasks, a value of think time is bigger.
  So, many queue are handled as idle class.
  Many queue will dispatch few requests(one request) and then
  expire slice.
  Namely, ioprio control for their queues is invalid.

  A think time valid entry is decide to check think time.
  The value 0 is always handled as idle class.
  The value 1 is handled as same as traditional CFQ.
  The value 2 make think time invalid.


    Signed-off-by: Satoshi UCHIDA <s-uchida@ap.jp.nec.com>

---
 block/cfq-cgroup.c          |    2 ++
 block/cfq-iosched.c         |    9 ++++++++-
 include/linux/cfq-iosched.h |    1 +
 3 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/block/cfq-cgroup.c b/block/cfq-cgroup.c
index 776874d..b407768 100644
--- a/block/cfq-cgroup.c
+++ b/block/cfq-cgroup.c
@@ -922,6 +922,7 @@ SHOW_FUNCTION(cfq_cgroup_slice_sync_show, cfq_slice[1], 1);
 SHOW_FUNCTION(cfq_cgroup_slice_async_show, cfq_slice[0], 1);
 SHOW_FUNCTION(cfq_cgroup_slice_async_rq_show, cfq_slice_async_rq, 0);
 SHOW_FUNCTION(cfq_cgroup_ioprio_show, ioprio, 0);
+SHOW_FUNCTION(cfq_cgroup_ttime_valid_show, cfq_ttime_valid, 0);
 #undef SHOW_FUNCTION
 
 static ssize_t
@@ -1026,6 +1027,7 @@ STORE_FUNCTION(cfq_cgroup_slice_async_store, cfq_slice[0], 1, UINT_MAX, 1);
 STORE_FUNCTION(cfq_cgroup_slice_async_rq_store, cfq_slice_async_rq, 1,
 		UINT_MAX, 0);
 STORE_FUNCTION(cfq_cgroup_ioprio_store, ioprio, 0, CFQ_CGROUP_MAX_IOPRIO, 0);
+STORE_FUNCTION(cfq_cgroup_ttime_valid_store, cfq_ttime_valid, 0, 2, 0);
 #undef STORE_FUNCTION
 
 static ssize_t
diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index edc23e5..51dccad 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -28,6 +28,8 @@ static const int cfq_slice_sync = HZ / 10;
 static int cfq_slice_async = HZ / 25;
 static const int cfq_slice_async_rq = 2;
 static int cfq_slice_idle = HZ / 125;
+/* think time valid flag */
+static int cfq_ttime_valid = 1;
 
 /*
  * offset from end of service tree
@@ -1731,7 +1733,8 @@ cfq_update_idle_window(struct cfq_data *cfqd, struct cfq_queue *cfqq,
 	    (cfqd->cfqdd->hw_tag && CIC_SEEKY(cic)))
 		enable_idle = 0;
 	else if (sample_valid(cic->ttime_samples)) {
-		if (cic->ttime_mean > cfqd->cfq_slice_idle)
+		if (cic->ttime_mean >
+			cfqd->cfq_slice_idle * cfqd->cfq_ttime_valid)
 			enable_idle = 0;
 		else
 			enable_idle = 1;
@@ -2304,6 +2307,7 @@ struct cfq_data *cfq_init_cfq_data(struct request_queue *q,
 	cfqd->cfq_slice[1] = cfq_slice_sync;
 	cfqd->cfq_slice_async_rq = cfq_slice_async_rq;
 	cfqd->cfq_slice_idle = cfq_slice_idle;
+	cfqd->cfq_ttime_valid = cfq_ttime_valid;
 
 	return cfqd;
 }
@@ -2381,6 +2385,7 @@ SHOW_FUNCTION(cfq_slice_idle_show, cfqd->cfq_slice_idle, 1);
 SHOW_FUNCTION(cfq_slice_sync_show, cfqd->cfq_slice[1], 1);
 SHOW_FUNCTION(cfq_slice_async_show, cfqd->cfq_slice[0], 1);
 SHOW_FUNCTION(cfq_slice_async_rq_show, cfqd->cfq_slice_async_rq, 0);
+SHOW_FUNCTION(cfq_ttime_valid_show, cfqd->cfq_ttime_valid, 0);
 #undef SHOW_FUNCTION
 
 #define STORE_FUNCTION(__FUNC, __PTR, MIN, MAX, __CONV)			\
@@ -2412,6 +2417,7 @@ STORE_FUNCTION(cfq_slice_sync_store, &cfqd->cfq_slice[1], 1, UINT_MAX, 1);
 STORE_FUNCTION(cfq_slice_async_store, &cfqd->cfq_slice[0], 1, UINT_MAX, 1);
 STORE_FUNCTION(cfq_slice_async_rq_store, &cfqd->cfq_slice_async_rq, 1,
 		UINT_MAX, 0);
+STORE_FUNCTION(cfq_ttime_valid_store, &cfqd->cfq_ttime_valid, 0, 2, 0);
 #undef STORE_FUNCTION
 
 #define CFQ_ATTR(name) \
@@ -2427,6 +2433,7 @@ static struct elv_fs_entry cfq_attrs[] = {
 	CFQ_ATTR(slice_async),
 	CFQ_ATTR(slice_async_rq),
 	CFQ_ATTR(slice_idle),
+	CFQ_ATTR(ttime_valid),
 	__ATTR_NULL
 };
 
diff --git a/include/linux/cfq-iosched.h b/include/linux/cfq-iosched.h
index 920bcb5..8fd4b59 100644
--- a/include/linux/cfq-iosched.h
+++ b/include/linux/cfq-iosched.h
@@ -95,6 +95,7 @@ struct cfq_data {
 	unsigned int cfq_slice[2];
 	unsigned int cfq_slice_async_rq;
 	unsigned int cfq_slice_idle;
+	unsigned int cfq_ttime_valid;
 
 	struct list_head cic_list;
 
-- 
1.5.6.5
