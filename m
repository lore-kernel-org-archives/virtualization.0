Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3670E3074B1
	for <virtualization@lists.linux.dev>; Sun, 12 Apr 2026 22:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776034274; cv=none; b=P7nDhcWVzIzKBtSi2Jq8DybTnRLZdtimgYXk1TsyodLgM0+v5czwRoA/SPfhfU1WmI9ESqZko2/a2MJ/9Epa4nCcoCDpdM1U1EnLvCvSco07clMZ1l4oaWsyOCm5V67bpW84tbdIOAmP+GjFFoDbVH2i6H9+7MvDRoo4RH/un9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776034274; c=relaxed/simple;
	bh=ZK/q59+MUDzl0Cfw/xbz4x9B1+Xq5fYWSD8aWczQweY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UC1Cl3zRD88Gz8La65O4YPVx5x8XlAtAA193aJGBBXbKveWn+E8aKjw990mqGMNng/1SPgHusOm8WqDrUrlwJI1F2FUb/VlmPIdRRkzRHDg2PWj0p/Be9rWQ6xkuYV/huQLVdtNrOjnorSZLJrMoIjh5HCuVTtIWbyMf9nDZmfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MLD5SKkM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MLD5SKkM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776034272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i6fKfkMPTLST/NSxam2u+fhT/53Q+wPZCVCtdXXmORc=;
	b=MLD5SKkMzIcQK7eh7QFEVa3prqbkbZrkZq96uocaSxx0kWKsdFQN4MirGhjzK6HNkzZBhM
	L0dB2/j+7I0KsiajRHbu0gD+IYSMNWfRcOLEWamMwbZI3smbpyXtDbzaKOK0BPS8OCPH6M
	hQUGM4XFy8mUfxwhKK+udeL2ybcJe/o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-BxF66PB7OWKOL5mOZR7lUw-1; Sun, 12 Apr 2026 18:51:09 -0400
X-MC-Unique: BxF66PB7OWKOL5mOZR7lUw-1
X-Mimecast-MFC-AGG-ID: BxF66PB7OWKOL5mOZR7lUw_1776034268
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43cfb72377bso3007242f8f.2
        for <virtualization@lists.linux.dev>; Sun, 12 Apr 2026 15:51:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776034268; x=1776639068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i6fKfkMPTLST/NSxam2u+fhT/53Q+wPZCVCtdXXmORc=;
        b=psRAfv3ClwusPc8BmAScBFl+wZYuvmI/5/c/YZpzsr3gobgFtwdzkAzRX5tsh+mndl
         ucGQn+pGCkhK5x2YOjw043XEd5uYSOhGtKWFWpBeUJ3kgaAiY13SMegGj1onH8HK9ufH
         gFojH8lOMM+KqsBj83/zaP8OkXpIwIDo5B6mrRErgxqyafNFnKITVU8C4UJz8GYklN/c
         f5JxoskV3Y8RXc6PurP9YMLMRvhK2whAECNBQGT3gDHWIKzJB6JEeP43KFfXJ5aHvVPc
         M4dGIrZ5aEac3nahXHL1P9wwc5dWmUowpVL2kPynL71R5tA2c04498bwgAqiW9wmMhwH
         0ceg==
X-Forwarded-Encrypted: i=1; AFNElJ+DVHVGej/2ZK+S8UbKGA3D4LnCriiQWJ5pnYxe1F+SGO3fRLX+/+2/ya0opg4sYGrN2lw8Svt8GCQkWyfoeg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwjDN4e7JTEGF/PVqOr+WOxk+rHMM/MLyHD7Ii52NCuv/qyXeLz
	a0WQnjpF+viqOMPE0Fo1aDBfD3XJvL4O5dA2KbPv/k/l0YcZ+UnJNTVFgylc68hKfBdj39P9Afw
	iSjAKHejNssN0sQFXmSOfXz2bIcWzLo9pZIzmx4ZwgLIES96bjxu7n96pT9l+DdIXdt1H
X-Gm-Gg: AeBDieuckIcrWwDsroNZ7T2aeu9CxkHXfQ2hprHq30IK3K5Q85Fnzpa9F4nsMfIcJLr
	5YPNFqetNxys+YrNzcD3EMghY5JNKFb2pMhAGSLgcZ2/CAMW67xpZEcZh/b6HSDMh7AMd3aLAif
	DeyhyuTsQdknN3gcPATRSE8mziIerxCP3L8dKoFg0Q1SMd04OYbp6HmGLP84L6cfLuOwkRdVFGG
	QiL1M/aGk57to5BfmWorS0efaCqt2khpakKCSwI8AyOXDlX6uZ51ppirl+NN5dBtCx44jxrOanj
	K36X27ERmqmxkXqYEpbocYwlce7WapOLZ1R3Uc8KqxgLKCNMvraR/rR7bpAHMvJ5rvksMsxt9Xx
	v3Nm3GvK2dH9CxnfhAqVBs4UE6Ba5QF1t9P+WU3DD6XM=
X-Received: by 2002:a05:6000:220b:b0:43c:fdd:ea96 with SMTP id ffacd0b85a97d-43d642b6e75mr15170209f8f.26.1776034268104;
        Sun, 12 Apr 2026 15:51:08 -0700 (PDT)
X-Received: by 2002:a05:6000:220b:b0:43c:fdd:ea96 with SMTP id ffacd0b85a97d-43d642b6e75mr15170178f8f.26.1776034267683;
        Sun, 12 Apr 2026 15:51:07 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d7794cce5sm4876502f8f.9.2026.04.12.15.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 15:51:07 -0700 (PDT)
Date: Sun, 12 Apr 2026 18:51:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
Subject: [PATCH RFC 8/9] mm: page_reporting: add flush parameter to trigger
 immediate reporting
Message-ID: <73acb39342827bfb09f5fd717a07c9a58e41ec91.1776033771.git.mst@redhat.com>
References: <cover.1776033471.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1776033471.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gEZ18qAUbmx5KaoVu5woZrWb0zgG0e02s9wXTw43Jxw_1776034268
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add a write-only module parameter 'flush' that triggers an immediate
page reporting cycle.  Writing any value flushes pending work and
runs one cycle synchronously.

This is useful for testing and benchmarking the pre-zeroed page
optimization, where the reporting delay (2 seconds) makes it hard
to ensure pages are reported before measuring allocation performance.

  echo 1 > /sys/module/page_reporting/parameters/flush

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 mm/page_reporting.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index cb24832bdf4e..e9a2186e4c48 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -351,6 +351,31 @@ static void page_reporting_process(struct work_struct *work)
 static DEFINE_MUTEX(page_reporting_mutex);
 DEFINE_STATIC_KEY_FALSE(page_reporting_enabled);
 
+static int page_reporting_flush_set(const char *val,
+				    const struct kernel_param *kp)
+{
+	struct page_reporting_dev_info *prdev;
+
+	mutex_lock(&page_reporting_mutex);
+	prdev = rcu_dereference_protected(pr_dev_info,
+				lockdep_is_held(&page_reporting_mutex));
+	if (prdev) {
+		flush_delayed_work(&prdev->work);
+		__page_reporting_request(prdev);
+		flush_delayed_work(&prdev->work);
+	}
+	mutex_unlock(&page_reporting_mutex);
+	return 0;
+}
+
+static const struct kernel_param_ops flush_ops = {
+	.set = page_reporting_flush_set,
+	.get = param_get_uint,
+};
+static unsigned int page_reporting_flush;
+module_param_cb(flush, &flush_ops, &page_reporting_flush, 0200);
+MODULE_PARM_DESC(flush, "Trigger immediate page reporting cycle");
+
 int page_reporting_register(struct page_reporting_dev_info *prdev)
 {
 	int err = 0;
-- 
MST

