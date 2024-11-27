Received: from mail-ot1-f74.google.com (mail-ot1-f74.google.com [209.85.210.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD6B13C906
	for <virtualization@lists.linux.dev>; Wed, 27 Nov 2024 02:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732676273; cv=none; b=lIDuxthtKkVxrDMlkS5Vrwb8miZ/mC33Qzq2L0IWJVPX0DuAp0Z4QVmRDpp5we6t88olSzTKzbry7ta4Wqr/zMxk9OwT1poBrr4Uh6Jx+q8RVk34mJkBFMcpsmaJnOWCuJs0Sbaaw/AcScS5cKejvX/hirm4WNv0a1qUikrJ3bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732676273; c=relaxed/simple;
	bh=V6k0txrQlFv9KlwsPqEDYN3s9mdMxMCtyYB6v1OxMUM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UImmggY0LcWvOBsnilS1otSMtzUQ3a9V2AAorGYhKyMBZiyIKQam0IDQwAXEoayeNsWdI2Jj+S8peqexbMSVaV++wNaSJ1F1webZiZtj4PYn48nNnDmBCspwUVBwrnaJN3/YbSCDFUO7KxW3st6KRWGGQWdK4R5ypryW41oS6cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OJkXfrp2; arc=none smtp.client-ip=209.85.210.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OJkXfrp2"
Received: by mail-ot1-f74.google.com with SMTP id 46e09a7af769-71d63a6ce62so748261a34.2
        for <virtualization@lists.linux.dev>; Tue, 26 Nov 2024 18:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732676271; x=1733281071; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nc9u6Gr3t/eex7ob4WWy8qTSgpDGth3PA2eslkY0ahg=;
        b=OJkXfrp2n6q76+BvpaHskPoVO8/SeKG/mvaApImo5+6RKnEuoTONh2wUHkbtZMxRui
         sDnU1bAj2oD8cfnWqOkCQCupEXXc+2B36u43VduTIzaMjqd8VZKBLWAUaBX4xEHEVWIk
         sMEwW1uWhGuhRWruoRic2igeEF6kDqePr6po/YpBY0gzMfUNvfSTjdp8NOFE1mZQLA2o
         H7aghRD+BlPoAJ/PzF3QUR3ac1qGXM4RbsTh8zMbYIvrEs1Mn8pwtSZkKeDWVZIUBYNi
         XbVImt8ZoWj9xrzoWiU6NQaGvPegu6CYsbjwSa/3b8XzjyKFlG1tmQgPgF8PnM62TVEw
         9L4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732676271; x=1733281071;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nc9u6Gr3t/eex7ob4WWy8qTSgpDGth3PA2eslkY0ahg=;
        b=WV7d3o+wh4OcnN3GhAuEyDiK60E5rgUyNKko16VuCd99OJTDzb+ezS/2m2FdKS1BjM
         8KGYrXDDx0d3A2IkcihX21HcxTkhfbbRW5aZyTYpHYpHacweSvY/G3LL7SB8vqt9NBaQ
         Tu5hs643VPfXLxQ66wORCJx2x9ek1B7CYNS9rcUtgot59mYpAifqjn2XA/AR/w47aiRF
         ZOvdcxFiUQYalBbwlIPYPLRMYJJXo73uRb4N5HBQ8gE+2P2rwd13Himh+ezPTEwMQUwx
         fTIT8li2arUX2bzC2d/rpygsgL2E9O1H1LveBDcX8VWjUHil0eNvymVpnpVqTB77eSM8
         3ykg==
X-Forwarded-Encrypted: i=1; AJvYcCW149ugsYQOX232Ph05wsC98fo8ZwTCuJYsrX4UyMB6UfFwr9jbDd6b375j6VKmtMBbV2bsIBq5fT2USHmgEg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyBno+ZFf1+5drU5a3WduMp8++HB2y+6nupFToOyNaVCuiEoMXP
	3NuXqwCTPzRqa+jkOxVfQMQLTzLpSxgJOtMK13nVcDqwO05lallUK8A/YamgcxKTlYyMWlZ8hQN
	4t/RzKw==
X-Google-Smtp-Source: AGHT+IHgj0Am4IyS+M4OwpOyz4MtxJ9EoZ2BKJ1SYuM2EnZPBNIt4U8MU/D28Yi7V0kFKazRJu4A5wWgVUd3
X-Received: from pgbcz4.prod.google.com ([2002:a05:6a02:2304:b0:7fc:26c4:ff6c])
 (user=yuanchu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6359:4ca0:b0:1ca:9e4a:d06
 with SMTP id e5c5f4694b2df-1cab15f4bd5mr150435955d.13.1732676270571; Tue, 26
 Nov 2024 18:57:50 -0800 (PST)
Date: Tue, 26 Nov 2024 18:57:23 -0800
In-Reply-To: <20241127025728.3689245-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20241127025728.3689245-1-yuanchu@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241127025728.3689245-5-yuanchu@google.com>
Subject: [PATCH v4 4/9] mm: extend workingset reporting to memcgs
From: Yuanchu Xie <yuanchu@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Khalid Aziz <khalid.aziz@oracle.com>, 
	Henry Huang <henry.hj@antgroup.com>, Yu Zhao <yuzhao@google.com>, 
	Dan Williams <dan.j.williams@intel.com>, Gregory Price <gregory.price@memverge.com>, 
	Huang Ying <ying.huang@intel.com>, Lance Yang <ioworker0@gmail.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Mike Rapoport <rppt@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Daniel Watson <ozzloy@each.do>, Yuanchu Xie <yuanchu@google.com>, 
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Break down the system-wide workingset report into per-memcg reports,
which aggregages its children hierarchically.

The per-node workingset reporting histograms and refresh/report
threshold files are presented as memcg files, showing a report
containing all the nodes.

The per-node page age interval is configurable in sysfs and not
available per-memcg, while the refresh interval and report threshold are
configured per-memcg.

Memcg interface:
/sys/fs/cgroup/.../memory.workingset.page_age
	The memcg equivalent of the sysfs workingset page age histogram
	breaks down the workingset of this memcg and its children into
	page age intervals. Each node is prefixed with a node header and
	a newline. Non-proactive direct reclaim on this memcg can also
	wake up userspace agents that are waiting on this file.
	e.g.
	N0
	1000 anon=0 file=0
	2000 anon=0 file=0
	3000 anon=0 file=0
	4000 anon=0 file=0
	5000 anon=0 file=0
	18446744073709551615 anon=0 file=0

/sys/fs/cgroup/.../memory.workingset.refresh_interval
	The memcg equivalent of the sysfs refresh interval. A per-node
	number of how much time a page age histogram is valid for, in
	milliseconds.
	e.g.
	echo N0=2000 > memory.workingset.refresh_interval

/sys/fs/cgroup/.../memory.workingset.report_threshold
	The memcg equivalent of the sysfs report threshold. A per-node
	number of how often userspace agent waiting on the page age
	histogram can be woken up, in milliseconds.
	e.g.
	echo N0=1000 > memory.workingset.report_threshold

Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 include/linux/memcontrol.h        |  21 ++++
 include/linux/workingset_report.h |  15 ++-
 mm/internal.h                     |   2 +
 mm/memcontrol.c                   | 160 +++++++++++++++++++++++++++++-
 mm/workingset_report.c            |  50 +++++++---
 5 files changed, 230 insertions(+), 18 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e1b41554a5fb..fd595b33a54d 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -323,6 +323,11 @@ struct mem_cgroup {
 	spinlock_t event_list_lock;
 #endif /* CONFIG_MEMCG_V1 */
 
+#ifdef CONFIG_WORKINGSET_REPORT
+	/* memory.workingset.page_age file */
+	struct cgroup_file workingset_page_age_file;
+#endif
+
 	struct mem_cgroup_per_node *nodeinfo[];
 };
 
@@ -1094,6 +1099,16 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
 
 void split_page_memcg(struct page *head, int old_order, int new_order);
 
+static inline struct cgroup_file *
+mem_cgroup_page_age_file(struct mem_cgroup *memcg)
+{
+#ifdef CONFIG_WORKINGSET_REPORT
+	return &memcg->workingset_page_age_file;
+#else
+	return NULL;
+#endif
+}
+
 #else /* CONFIG_MEMCG */
 
 #define MEM_CGROUP_ID_SHIFT	0
@@ -1511,6 +1526,12 @@ void count_memcg_event_mm(struct mm_struct *mm, enum vm_event_item idx)
 static inline void split_page_memcg(struct page *head, int old_order, int new_order)
 {
 }
+
+static inline struct cgroup_file *
+mem_cgroup_page_age_file(struct mem_cgroup *memcg)
+{
+	return NULL;
+}
 #endif /* CONFIG_MEMCG */
 
 /*
diff --git a/include/linux/workingset_report.h b/include/linux/workingset_report.h
index 2ec8b927b200..616be6469768 100644
--- a/include/linux/workingset_report.h
+++ b/include/linux/workingset_report.h
@@ -9,6 +9,8 @@ struct mem_cgroup;
 struct pglist_data;
 struct node;
 struct lruvec;
+struct cgroup_file;
+struct wsr_state;
 
 #ifdef CONFIG_WORKINGSET_REPORT
 
@@ -40,7 +42,10 @@ struct wsr_state {
 	unsigned long report_threshold;
 	unsigned long refresh_interval;
 
-	struct kernfs_node *page_age_sys_file;
+	union {
+		struct kernfs_node *page_age_sys_file;
+		struct cgroup_file *page_age_cgroup_file;
+	};
 
 	/* breakdown of workingset by page age */
 	struct mutex page_age_lock;
@@ -60,6 +65,9 @@ void wsr_remove_sysfs(struct node *node);
  */
 bool wsr_refresh_report(struct wsr_state *wsr, struct mem_cgroup *root,
 			struct pglist_data *pgdat);
+
+int wsr_set_refresh_interval(struct wsr_state *wsr,
+			     unsigned long refresh_interval);
 #else
 static inline void wsr_init_lruvec(struct lruvec *lruvec)
 {
@@ -79,6 +87,11 @@ static inline void wsr_init_sysfs(struct node *node)
 static inline void wsr_remove_sysfs(struct node *node)
 {
 }
+static inline int wsr_set_refresh_interval(struct wsr_state *wsr,
+					   unsigned long refresh_interval)
+{
+	return 0;
+}
 #endif /* CONFIG_WORKINGSET_REPORT */
 
 #endif /* _LINUX_WORKINGSET_REPORT_H */
diff --git a/mm/internal.h b/mm/internal.h
index 508b7d9937d6..50ca0c6e651c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -484,6 +484,8 @@ void set_task_reclaim_state(struct task_struct *task, struct reclaim_state *rs);
  * in mm/wsr.c
  */
 void notify_workingset(struct mem_cgroup *memcg, struct pglist_data *pgdat);
+int workingset_report_intervals_parse(char *src,
+				      struct wsr_report_bins *bins);
 #else
 static inline void notify_workingset(struct mem_cgroup *memcg,
 				     struct pglist_data *pgdat)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 096856b35fbc..d1032c6efc66 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4348,6 +4348,144 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 	return nbytes;
 }
 
+#ifdef CONFIG_WORKINGSET_REPORT
+static int memory_ws_refresh_interval_show(struct seq_file *m, void *v)
+{
+	int nid;
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+
+	for_each_node_state(nid, N_MEMORY) {
+		struct wsr_state *wsr =
+			&mem_cgroup_lruvec(memcg, NODE_DATA(nid))->wsr;
+
+		seq_printf(m, "N%d=%u ", nid,
+			   jiffies_to_msecs(READ_ONCE(wsr->refresh_interval)));
+	}
+	seq_putc(m, '\n');
+
+	return 0;
+}
+
+static ssize_t memory_wsr_threshold_parse(char *buf, size_t nbytes,
+					  unsigned int *nid_out,
+					  unsigned int *msecs)
+{
+	char *node, *threshold;
+	unsigned int nid;
+	int err;
+
+	buf = strstrip(buf);
+	threshold = buf;
+	node = strsep(&threshold, "=");
+
+	if (*node != 'N')
+		return -EINVAL;
+
+	err = kstrtouint(node + 1, 0, &nid);
+	if (err)
+		return err;
+
+	if (nid >= nr_node_ids || !node_state(nid, N_MEMORY))
+		return -EINVAL;
+
+	err = kstrtouint(threshold, 0, msecs);
+	if (err)
+		return err;
+
+	*nid_out = nid;
+
+	return nbytes;
+}
+
+static ssize_t memory_ws_refresh_interval_write(struct kernfs_open_file *of,
+						 char *buf, size_t nbytes,
+						 loff_t off)
+{
+	unsigned int nid, msecs;
+	struct wsr_state *wsr;
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	ssize_t ret = memory_wsr_threshold_parse(buf, nbytes, &nid, &msecs);
+
+	if (ret < 0)
+		return ret;
+
+	wsr = &mem_cgroup_lruvec(memcg, NODE_DATA(nid))->wsr;
+
+	ret = wsr_set_refresh_interval(wsr, msecs);
+	return ret ?: nbytes;
+}
+
+static int memory_ws_report_threshold_show(struct seq_file *m, void *v)
+{
+	int nid;
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+
+	for_each_node_state(nid, N_MEMORY) {
+		struct wsr_state *wsr =
+			&mem_cgroup_lruvec(memcg, NODE_DATA(nid))->wsr;
+
+		seq_printf(m, "N%d=%u ", nid,
+			   jiffies_to_msecs(READ_ONCE(wsr->report_threshold)));
+	}
+	seq_putc(m, '\n');
+
+	return 0;
+}
+
+static ssize_t memory_ws_report_threshold_write(struct kernfs_open_file *of,
+						 char *buf, size_t nbytes,
+						 loff_t off)
+{
+	unsigned int nid, msecs;
+	struct wsr_state *wsr;
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	ssize_t ret = memory_wsr_threshold_parse(buf, nbytes, &nid, &msecs);
+
+	if (ret < 0)
+		return ret;
+
+	wsr = &mem_cgroup_lruvec(memcg, NODE_DATA(nid))->wsr;
+	WRITE_ONCE(wsr->report_threshold, msecs_to_jiffies(msecs));
+	return ret;
+}
+
+static int memory_ws_page_age_show(struct seq_file *m, void *v)
+{
+	int nid;
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+
+	for_each_node_state(nid, N_MEMORY) {
+		struct wsr_state *wsr =
+			&mem_cgroup_lruvec(memcg, NODE_DATA(nid))->wsr;
+		struct wsr_report_bin *bin;
+
+		if (!READ_ONCE(wsr->page_age))
+			continue;
+
+		wsr_refresh_report(wsr, memcg, NODE_DATA(nid));
+		mutex_lock(&wsr->page_age_lock);
+		if (!wsr->page_age)
+			goto unlock;
+		seq_printf(m, "N%d\n", nid);
+		for (bin = wsr->page_age->bins;
+		     bin->idle_age != WORKINGSET_INTERVAL_MAX; bin++)
+			seq_printf(m, "%u anon=%lu file=%lu\n",
+				   jiffies_to_msecs(bin->idle_age),
+				   bin->nr_pages[0] * PAGE_SIZE,
+				   bin->nr_pages[1] * PAGE_SIZE);
+
+		seq_printf(m, "%lu anon=%lu file=%lu\n", WORKINGSET_INTERVAL_MAX,
+			   bin->nr_pages[0] * PAGE_SIZE,
+			   bin->nr_pages[1] * PAGE_SIZE);
+
+unlock:
+		mutex_unlock(&wsr->page_age_lock);
+	}
+
+	return 0;
+}
+#endif
+
 static struct cftype memory_files[] = {
 	{
 		.name = "current",
@@ -4419,7 +4557,27 @@ static struct cftype memory_files[] = {
 		.flags = CFTYPE_NS_DELEGATABLE,
 		.write = memory_reclaim,
 	},
-	{ }	/* terminate */
+#ifdef CONFIG_WORKINGSET_REPORT
+	{
+		.name = "workingset.refresh_interval",
+		.flags = CFTYPE_NOT_ON_ROOT | CFTYPE_NS_DELEGATABLE,
+		.seq_show = memory_ws_refresh_interval_show,
+		.write = memory_ws_refresh_interval_write,
+	},
+	{
+		.name = "workingset.report_threshold",
+		.flags = CFTYPE_NOT_ON_ROOT | CFTYPE_NS_DELEGATABLE,
+		.seq_show = memory_ws_report_threshold_show,
+		.write = memory_ws_report_threshold_write,
+	},
+	{
+		.name = "workingset.page_age",
+		.flags = CFTYPE_NOT_ON_ROOT | CFTYPE_NS_DELEGATABLE,
+		.file_offset = offsetof(struct mem_cgroup, workingset_page_age_file),
+		.seq_show = memory_ws_page_age_show,
+	},
+#endif
+	{} /* terminate */
 };
 
 struct cgroup_subsys memory_cgrp_subsys = {
diff --git a/mm/workingset_report.c b/mm/workingset_report.c
index bbefb0046669..1e1bdb8bf75b 100644
--- a/mm/workingset_report.c
+++ b/mm/workingset_report.c
@@ -37,9 +37,12 @@ void wsr_destroy_pgdat(struct pglist_data *pgdat)
 void wsr_init_lruvec(struct lruvec *lruvec)
 {
 	struct wsr_state *wsr = &lruvec->wsr;
+	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 
 	memset(wsr, 0, sizeof(*wsr));
 	mutex_init(&wsr->page_age_lock);
+	if (memcg && !mem_cgroup_is_root(memcg))
+		wsr->page_age_cgroup_file = mem_cgroup_page_age_file(memcg);
 }
 
 void wsr_destroy_lruvec(struct lruvec *lruvec)
@@ -51,8 +54,8 @@ void wsr_destroy_lruvec(struct lruvec *lruvec)
 	memset(wsr, 0, sizeof(*wsr));
 }
 
-static int workingset_report_intervals_parse(char *src,
-					     struct wsr_report_bins *bins)
+int workingset_report_intervals_parse(char *src,
+				      struct wsr_report_bins *bins)
 {
 	int err = 0, i = 0;
 	char *cur, *next = strim(src);
@@ -356,20 +359,14 @@ static ssize_t refresh_interval_show(struct kobject *kobj,
 	return sysfs_emit(buf, "%u\n", jiffies_to_msecs(interval));
 }
 
-static ssize_t refresh_interval_store(struct kobject *kobj,
-				      struct kobj_attribute *attr,
-				      const char *buf, size_t len)
+int wsr_set_refresh_interval(struct wsr_state *wsr,
+			     unsigned long refresh_interval)
 {
-	unsigned int interval;
-	int err;
-	struct wsr_state *wsr = kobj_to_wsr(kobj);
-
-	err = kstrtouint(buf, 0, &interval);
-	if (err)
-		return err;
+	int err = 0;
+	unsigned long old_interval = 0;
 
 	mutex_lock(&wsr->page_age_lock);
-	if (interval && !wsr->page_age) {
+	if (refresh_interval && !wsr->page_age) {
 		struct wsr_page_age_histo *page_age =
 			kzalloc(sizeof(struct wsr_page_age_histo), GFP_KERNEL);
 
@@ -377,16 +374,34 @@ static ssize_t refresh_interval_store(struct kobject *kobj,
 			err = -ENOMEM;
 			goto unlock;
 		}
+		page_age->bins[0].idle_age = WORKINGSET_INTERVAL_MAX;
 		wsr->page_age = page_age;
 	}
-	if (!interval && wsr->page_age) {
+	if (!refresh_interval && wsr->page_age) {
 		kfree(wsr->page_age);
 		wsr->page_age = NULL;
 	}
 
-	WRITE_ONCE(wsr->refresh_interval, msecs_to_jiffies(interval));
+	old_interval = READ_ONCE(wsr->refresh_interval);
+	WRITE_ONCE(wsr->refresh_interval, msecs_to_jiffies(refresh_interval));
 unlock:
 	mutex_unlock(&wsr->page_age_lock);
+	return err;
+}
+
+static ssize_t refresh_interval_store(struct kobject *kobj,
+				      struct kobj_attribute *attr,
+				      const char *buf, size_t len)
+{
+	unsigned int interval;
+	int err;
+	struct wsr_state *wsr = kobj_to_wsr(kobj);
+
+	err = kstrtouint(buf, 0, &interval);
+	if (err)
+		return err;
+
+	err = wsr_set_refresh_interval(wsr, interval);
 	return err ?: len;
 }
 
@@ -551,5 +566,8 @@ void notify_workingset(struct mem_cgroup *memcg, struct pglist_data *pgdat)
 {
 	struct wsr_state *wsr = &mem_cgroup_lruvec(memcg, pgdat)->wsr;
 
-	kernfs_notify(wsr->page_age_sys_file);
+	if (mem_cgroup_is_root(memcg))
+		kernfs_notify(wsr->page_age_sys_file);
+	else
+		cgroup_file_notify(wsr->page_age_cgroup_file);
 }
-- 
2.47.0.338.g60cca15819-goog

