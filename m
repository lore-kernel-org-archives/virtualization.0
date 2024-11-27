Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com [209.85.161.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4703F1482E3
	for <virtualization@lists.linux.dev>; Wed, 27 Nov 2024 02:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732676281; cv=none; b=LGsoEEtRw2oxeoTqc+sJo74SCbrgUt+6CsG94Yg4Pg+wOS0uJZHnuBB9jWMCKCN6XwLloyenspZglCcJL1KUE9NMM+GShnrVrloyw4Bx+f202Oe/HISKSHXsEFc2jX/89PYiuu9UWKNPluXybwLN5b2VoMpuLyqlSWCEyzgt4sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732676281; c=relaxed/simple;
	bh=n3v2ZTKy4XayzWP8FCTYHWj0NyVizXv/4ojexhsmJFw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nIQIBoqYwg6KMdKq4SACpA+SQRQdZo2mBwV+xt9rmAN+0DmPYqwgdU55vt2ZBhBKMS4ED3fRz7XUmqOxOUP+wIqzK6ap6JwoAKJQf5AeRB+EWKBwuXK9ogqFdaRQOqIqRwMHyzrRXlNUuKXRqGqhIUVdPkFTMCQvPY+k+v6fNBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QRkEPT65; arc=none smtp.client-ip=209.85.161.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QRkEPT65"
Received: by mail-oo1-f73.google.com with SMTP id 006d021491bc7-5f1e906e2c7so1694850eaf.2
        for <virtualization@lists.linux.dev>; Tue, 26 Nov 2024 18:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732676278; x=1733281078; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PZpBMHL8IdsZHMO87vdTflNT6N6icPZfEjrZz1n0oFE=;
        b=QRkEPT65Cil/OjxLTu5RLl+J8dh37BpMyWzwpokQBFy4jr7vNlZ908qXuWZ92Vyvgt
         LJLmtm3eMIMEch1wmTVwe9GQcU0XXlN7tfVNgfSYu27uQ1K6MuVzQJooudVrII+p6hV9
         sWjxLCzU+XZjnAPfskWMwuaf5jlg4Sy0FCi0jecw8RT8x2WDKJ3y4t9JOGp0JG5faZou
         5IM6XPMzF5B1/ZgMLIVStFSXiVEBeFvbqE+qxArpLBs0RMTr5aXBIwRb5bW9BRpf+K2o
         l2Gjg2G7a7mxc+fItuMm4dH91sEw0FMfPCLX8y6uHcWZqxdrnUiCSJZEns6cqWtwRf/6
         383g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732676278; x=1733281078;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PZpBMHL8IdsZHMO87vdTflNT6N6icPZfEjrZz1n0oFE=;
        b=WgE/NpmXyXi8jlyRr2o5yg7Pt6lrO/+nNj4OuWssS6LqjxGQYcrMeBfc/K7a8Z2EZZ
         H7oyM6DUz3iZF7Kh7kY0nFlAE9JPNBLLx78bc2trupuXDAl5BQmD5f8azH/+xINluJoo
         R9aKM/km8JJd/8/BF8/3plRhlQjmq1q5GNi0fYXezxe8CwQMcQ2g6fhWjmgr50Q4dTVv
         cS7+4HOxaI4A9SHtZfEDvuGtAM8FQHDpGTEzyO5Is3WZ4aWyQij95MYx6TrLTueJuQ8I
         vH8fpTWd356x+wYXAmIeNMp9xH4UzGEgB8CYR2HomlpZ5BuXB0r/WwU/IIiuZ3VtYQl6
         GXKA==
X-Forwarded-Encrypted: i=1; AJvYcCXIpVnDqrZquS52mwo8VpyOMRfsGxlfy1jN3AWCF9VUSbStGAO9vmhyVZV+SuuRONKpzNKNfZjw3zolROtZ4Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx6XnMCOl7UQSSF8uAZDZA47QhRagIPq9Jqkryfm5j8/jqt8UpF
	fGNj6LVJ50c66ov7ljnlp84Wdss/DF+xkgSnf+1hClsd61ghYpG0/DiQWbwDVUUcxsXLKeyzUEi
	yj2qRMw==
X-Google-Smtp-Source: AGHT+IFKHf2rAZNzRLIYi5pyoUxBdmbZ99C2meBLNg4KMzGEhTQ6C34gvUg4FAtRwQPJnnGabMdsTk0k6Rq/
X-Received: from oabuz16.prod.google.com ([2002:a05:6870:af90:b0:295:ebc2:deb2])
 (user=yuanchu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:5d8f:b0:297:270c:575
 with SMTP id 586e51a60fabf-29dc40097dbmr1170968fac.16.1732676278453; Tue, 26
 Nov 2024 18:57:58 -0800 (PST)
Date: Tue, 26 Nov 2024 18:57:27 -0800
In-Reply-To: <20241127025728.3689245-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20241127025728.3689245-1-yuanchu@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241127025728.3689245-9-yuanchu@google.com>
Subject: [PATCH v4 8/9] Docs/admin-guide/cgroup-v2: document workingset reporting
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

Add workingset reporting documentation for better discoverability of
its memcg interfaces. Point the memcg documentation to
Documentation/admin-guide/mm/workingset_report.rst for more details.

Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 35 +++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 2cb58daf3089..67a183f08245 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1784,6 +1784,41 @@ The following nested keys are defined.
 	Shows pressure stall information for memory. See
 	:ref:`Documentation/accounting/psi.rst <psi>` for details.
 
+  memory.workingset.page_age
+	A read-only histogram which exists on non-root cgroups.
+
+	This breaks down the cgroup's memory footprint into different
+	types of memory and groups them per-node into user-defined coldness
+	bins.
+
+	The output format of memory.workingset.page_age is::
+
+	  N0
+	  <interval 0 of node 0> type=<type bytes in interval 0 of node 0>
+	  <interval 1 of node 0> type=<type bytes in interval 1 of node 0>
+	  ...
+	  18446744073709551615 type=<the rest of type bytes of node 0>
+
+	The type of memory can be anon, file, or new types added later.
+	Don't rely on the types remaining fixed.  See
+	:ref:`Documentation/admin-guide/mm/workingset_report.rst <workingset_report>`
+	for details.
+
+  memory.workingset.refresh_interval
+	A read-write nested-keyed file which exists on non-root cgroups.
+
+	Setting it to a non-zero value for any node enables working set
+	reporting for that node.  The default is 0 for each node.   See
+	:ref:`Documentation/admin-guide/mm/workingset_report.rst <workingset_report>`
+	for details.
+
+  memory.workingset.report_threshold
+	A read-write nested-keyed file which exists on non-root cgroups.
+
+	The amount of milliseconds to wait before reporting the working
+	set again.  The default is 0 for each node.  See
+	:ref:`Documentation/admin-guide/mm/workingset_report.rst <workingset_report>`
+	for details.
 
 Usage Guidelines
 ~~~~~~~~~~~~~~~~
-- 
2.47.0.338.g60cca15819-goog

