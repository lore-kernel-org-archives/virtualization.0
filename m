Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247593A3838
	for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 12:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776689471; cv=none; b=rGcGELYlX1HBt9uVlI2Xla1EAyonoW4pJLGtqmNxAwv1FBDEaxAti73IzMG+KUwSV3ItTVunLeSmPy0uQgu7Qrt4idqO3upcUrh6lDUyl5/Bty+3vuHg6JZKxjA+BF6DqPMVd2bGd60MTYb6xc0wwe3uqjstr36rPtBnLXv/gr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776689471; c=relaxed/simple;
	bh=c6CKf7gF4h4nqs4xEImrB5ycxqiLXbgiLtERzixLHo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=fBXyN5em4mDEiIBrQhzKOXzyE+ajBkM0e/3V73QIMDXz4KMf7HeCKqhWNjM/8yf6Y/OcRgN4KS4k/IqAOSIXh6LBADsfhtdCDKX+hyzJUJV3cV3KfeWP5UpxUYYWJjHH9u49S+g/5H/7Nn6hhjEijtl/6YHpXvGAA8kgwgs0OUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gaGfakVB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gaGfakVB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776689469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SikkYlL1M+gibhFkMnOOpJ+LH2O2BXdI5hRy13pqHRY=;
	b=gaGfakVBS/rWGd0XlGSDz4QY5/SIgU+LXEVaMSILExrQDKKPmzt8GNBi/eectWsA/ErLc0
	fGYkToddKqCkByiNfJ8XZXWjXsBT3AOj6Pt1u25ybT1JpCfafKvxXT5SquLqwaO+I6Yl90
	79LtjnTNmsbShdTNiXI93Y6r/oHDGQs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-NsaxFXZUN4OfKBTPlqUqQg-1; Mon, 20 Apr 2026 08:51:08 -0400
X-MC-Unique: NsaxFXZUN4OfKBTPlqUqQg-1
X-Mimecast-MFC-AGG-ID: NsaxFXZUN4OfKBTPlqUqQg_1776689467
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43cfedb10a8so2039765f8f.1
        for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 05:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776689467; x=1777294267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SikkYlL1M+gibhFkMnOOpJ+LH2O2BXdI5hRy13pqHRY=;
        b=dEdeGjHR1t5vDFa06ogaebSFUakMIh4TaUJc3hNeBK4iMRJT9o35b0my2WgKWCsyMm
         Mz6aa3mRqLIOwA188LxDhnMojliumkBmJAMgpmItbbbIWGw7VXGH+kDzawlige2Ttw/r
         Ckk7gZk9ai8mOX8HagBC9Fa28YgSMhUReMUWIXXN7ZBcz5f1kZa7EDIdOxRQMrHw6dgS
         3nGouPQoHApBGYYov6BHaL5+Tc5jZbgwTvQH5eNUm4e81bsBLHLClH3RA7zkxLCAfbT+
         r4OipPDlv9F+lrD92G/u4mb6EIA00Z2wQNZqf+7UQ3XRju1t5n8gh2lc1ag5i9U9Wtfl
         YRsA==
X-Forwarded-Encrypted: i=1; AFNElJ/RzF33k3v1mlMj0l/g/4Y0AoLXVJTfJmvlJWfdvKck5l6D6GCme65z1dQzkLa5zETGBFdjJsw05TadLcnFBg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzDg/Sp/Mhdz1yARsDbQn4hEtbCxrsgDAysNduCaokNQ1JQ7iG0
	P7LQ5hEsP1eWw/Q5YB6zAKZGsYa9OkYSkr8h1XExUdma+delr3wSFHFoGpvXioblP+Z7zzBWLml
	A9ZYRId23yORZlJgbVk2DHdjVQoAwhtf6kkehfubsrFTbMO1i2UaR1plJXqRHibTrLZBB
X-Gm-Gg: AeBDietA7TPm1xzq1PnXaOH4mRDqm+A5wC6cEqEUfn43FceKVFLW0TZZEMozxdeDcvV
	COBuiXzAySLvdpxhW3kDE+Crc30IrFv/LbhMtispea7xKy8OxBSVkmHDN4mkTcDPx2Km9uby3To
	LFoNj+92D/iI89swS7oJc2io6hrC0QpR76bwtjazK/KS2s4nNxLyHOuGGwvm6TY73+7ob9W5j/A
	cSxy8w6Rv7LMD833Arggdm/Pk5wcdalpGt3HMSuUsHrWRHYACBCGxBdMV1jAHKQoF4d8Xw0CHrR
	Ek+GZkILbK+iXq6l0qIjK0MaHXabNeFfTgJ7Q+i7fG50V6aoaHQZyHAV5FeYKtQmTQLqT/2/+lS
	qwEK+HrOUkZW6YkxeCSXqcd07gkbribs51GUDtXYpgtXwVOxZ7BvvIg==
X-Received: by 2002:a05:6000:2511:b0:43e:b0b0:629a with SMTP id ffacd0b85a97d-43fe3e0a1bemr20301773f8f.34.1776689466833;
        Mon, 20 Apr 2026 05:51:06 -0700 (PDT)
X-Received: by 2002:a05:6000:2511:b0:43e:b0b0:629a with SMTP id ffacd0b85a97d-43fe3e0a1bemr20301696f8f.34.1776689466326;
        Mon, 20 Apr 2026 05:51:06 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a7b4sm27168068f8f.22.2026.04.20.05.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 05:51:05 -0700 (PDT)
Date: Mon, 20 Apr 2026 08:51:03 -0400
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
Subject: [PATCH RFC v2 16/18] mm: page_reporting: add flush parameter with
 page budget
Message-ID: <23f8d36128771ded02b426cf71b840500004ca52.1776689093.git.mst@redhat.com>
References: <cover.1776689093.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1776689093.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nRROers8vNUkCIru23xDqCbdzAVGSuQIEsxV17OB_bY_1776689467
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add a write-only module parameter "flush" that triggers immediate
page reporting.  The value specifies approximately how many pages
(at page_reporting_order) to report.  The flush loops through
reporting cycles until the budget is exhausted, all pages are
reported, or a signal is pending.

  echo 512 > /sys/module/page_reporting/parameters/flush

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 mm/page_reporting.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index 5e1e1a924b0c..3560f272ab70 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -354,6 +354,48 @@ static void page_reporting_process(struct work_struct *work)
 static DEFINE_MUTEX(page_reporting_mutex);
 DEFINE_STATIC_KEY_FALSE(page_reporting_enabled);
 
+static int page_reporting_flush_set(const char *val,
+				    const struct kernel_param *kp)
+{
+	struct page_reporting_dev_info *prdev;
+	unsigned int budget;
+	int err;
+
+	err = kstrtouint(val, 0, &budget);
+	if (err)
+		return err;
+	if (!budget)
+		return 0;
+
+	mutex_lock(&page_reporting_mutex);
+	prdev = rcu_dereference_protected(pr_dev_info,
+				lockdep_is_held(&page_reporting_mutex));
+	if (prdev) {
+		unsigned int reported;
+
+		for (reported = 0; reported < budget;
+		     reported += PAGE_REPORTING_CAPACITY) {
+			flush_delayed_work(&prdev->work);
+			__page_reporting_request(prdev);
+			flush_delayed_work(&prdev->work);
+			if (atomic_read(&prdev->state) == PAGE_REPORTING_IDLE)
+				break;
+			if (signal_pending(current))
+				break;
+		}
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
+MODULE_PARM_DESC(flush, "Report up to N pages at page_reporting_order");
+
 int page_reporting_register(struct page_reporting_dev_info *prdev)
 {
 	int err = 0;
-- 
MST

