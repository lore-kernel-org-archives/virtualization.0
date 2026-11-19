Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795089791;
	b=lWkgZCA5UkwxKzzJO1TXuG1zicVmayA+GhTf4qwGyeK1+cKMTO1GBk0Uej3BXu62MOY1
	 uvDdsOCworELVgzWb5RX8I9hV9Kv0or+VRORv/arqObDSNKyheCosYgL+Zqr33gegV8AV
	 w8HiwlpkB9v6TE272DcXzJ3+Jti5VcbwiQopAcBxB/W7fMPlMwDvxYprejuyoDq7oPvaC
	 NbgzEjhPxw6Dy2p1XUBjtHCEadS6bmDGNTy2r+bs/sc2iG0bJslWxmyHNrESnmRgjzn/T
	 nRjdywo5DEp0oSL4eEhNfzqy5iDXfp5yWxaxCPfKGSwvPsTn8rLOYid5ClZtuTblICw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795089791;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mailer:X-Mutt-Fcc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition;
	bh=zApCp1xwVg9dKanzxdxazWSeTQXz+Vf+a7PGogJltFw=;
	b=tvQuyE2ysJIEhm0YvlN8Z2kWWO4sITwp24A1sGH9NC5MnPztu8Q1n0Rc8NhBjjF2AKej
	 KLEP+qLs+k2FrY9166YKYtn89kzpA03tNsc9/T6gyMSYNR9drXZdQzvA/JNzvFeEgy/uT
	 l5JNQJb/9YfArMF9rb6Z24gfHlR9yBMnznvhTwFS2Rt9mUUSu7n9KsoJz+iwiRopXhEkI
	 i2/Kf0NM7j2Jyws6It8Lzj0UMGJgpemGYkGYwaRzfuzSQCHCKmSIOzeTs6qs0IwTFNHdC
	 oXytzQGbLIZMwQ7HherJSwC5/gLmjGOw6wDVfHPNM8oMPkcF6eq4M0cUZ+oJHEauwSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GONRuns4;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68158606A326
	for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 12:03:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68158606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GONRuns4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795089790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zApCp1xwVg9dKanzxdxazWSeTQXz+Vf+a7PGogJltFw=;
	b=GONRuns4tcJQPVGpoDG2p2zXYyihcoVRpfizk0Gq4iqlG4T8XUoYmf+//JZ2ZWYEbd9Zb/
	Oyf0d/HfMs5k+/uxpPkdQQeJUMJGbaqljBcwRAzr6BTbpBNIz5tCodBRTFX8qnQq1knfRV
	DnHjm/Ts/IVRxjOE6JUp56K2Ap2XERI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-w5aO4KZAPHqTv-rGyaxr_Q-1; Thu, 19 Nov 2026 12:03:09 +0000
X-MC-Unique: w5aO4KZAPHqTv-rGyaxr_Q-1
X-Mimecast-MFC-AGG-ID: w5aO4KZAPHqTv-rGyaxr_Q_1795089788
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a17741243eso12092175e9.0
        for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 04:03:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795089788; x=1795694588;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zApCp1xwVg9dKanzxdxazWSeTQXz+Vf+a7PGogJltFw=;
        b=P23/qcCL6AHHiYdKYEjvXQ4oQmirvMF0vPQA3UAlt/klSKX4MkjAffd2vw/OTVBiOi
         qJvYoIV7ionpSwkG5u13FGeTfSf2Y+lCSgoqS2EzXdwn+BfqjoT/GKePW+DcJKKhv9m6
         BDj1trAsusS2HnM3pvrDcFl+ehEbhK1Cf8/VHWZ6xtyaItW7X8p4BYsgciI+R5R/olzI
         1MJBap8R3N9F+p6qG9XQcogbQoj4rHoe5PL1DuYcfFh7URTJWG47V6zaYZHWOx2sNzpq
         MZpHCa+2PqERHbYwyiazWAiPOi74mmL1qaTxM1vglVMDKEfcJhJJU7RgQlpDrmwk7zbN
         dvBA==
X-Forwarded-Encrypted: i=1; AL+hErEON32DuUXvgB6QsLDBlEKfL+aH/ZqUmKVoKW9/ZkcVAr+Nkp7wyBjenY4y2Eb7hZ595IQTyth44pot7neF1g==@lists.linux.dev
X-Gm-Message-State: APuU4Z82kIOBgpEjMzDcjDxdQa2vAgPX3IZ3JODGdEorFUImvo0D+F9m
	K41PhzlPb8nMk6A4DCz4MjixsgzYzqtFFZ7pnpCKwLjWuE5NQzQ4FjidAknWTZf0C63/Uu6yrUu
	i2wSRz4HVqM84Xk8qJwOHzmr4C/Rij4BOS5vwj5jLyaEdcN42JNYVTPsbOXfsbhmk4tXR
X-Gm-Gg: AYBFou2kRgeRJsL646cGPmjIjpJ5s1fBXEEAO0UZFz0YpcbkSxpQXkrLApp7Ywd231c
	ZJRhZebbz+JE1EloXD7G2Snxk0VR2w2RmIDb+uRmvoO0nS8+ZtAGnJ5Q3j0Zrkbh7KGiuVhyrWe
	mkZ311bT1wcNRt/kjAoOSe6wl6v187qqHneFHVv9lCt79N5CVKiPCImcwqx7x/kJzzJPP+TFg/D
	Ik81PVXGq1E9i8EkrAzQgRywYcwloGTPXyKL4HI8g4AxaSZxQIyzYvc1hQhHmSDTtmOO7Z4WOVH
	6drhKHmnoxsronKRTyphLCP8ukmYA3lte6EeLGY7cPyhlykYDAqyjD5viBaAxatWIRSVH4FNGtl
	8H3Xu/WF8J2xgtnyKefe74tRv1UBDZZW9gYxJJlCdCE0=
X-Received: by 2002:a05:600c:a303:b0:4a2:84c:52f3 with SMTP id 5b1f17b1804b1-4bb7da13acdmr100152965e9.6.1795089788021;
        Thu, 19 Nov 2026 04:03:08 -0800 (PST)
X-Received: by 2002:a05:600c:a303:b0:4a2:84c:52f3 with SMTP id 5b1f17b1804b1-4bb7da13acdmr100152535e9.6.1795089787463;
        Thu, 19 Nov 2026 04:03:07 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1520:4400:d78d:7b2d:2f5d:e08f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853b216esm32981455e9.12.2026.11.19.04.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 04:03:03 -0800 (PST)
Date: Thu, 19 Nov 2026 07:03:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>, Dev Jain <dev.jain@arm.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Gregory Price <gourry@gourry.net>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Lance Yang <lance.yang@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Miaohe Lin <linmiaohe@huawei.com>, Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org, virtualization@lists.linux.dev,
	Johannes Weiner <hannes@cmpxchg.org>,
	Brendan Jackman <brendan.jackman@linux.dev>
Subject: [PATCH v11 7/7] mm: page_reporting: add flush parameter with page
 budget
Message-ID: <2d518dd7b8f7be147b9a957ad94f6c6641e4b5ef.1795089715.git.mst@redhat.com>
References: <cover.1795089715.git.mst@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <cover.1795089715.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zfYMOtF7mZRK983SWcY8xCtWe13KwDTZCgVnMMGRZyE_1795089788
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add a write-only module parameter "flush" that triggers immediate
page reporting.  The value specifies approximately how many pages
(at page_reporting_order) to report.  And I mean, very approximately.
The flush loops through reporting cycles until the budget is exhausted,
all pages are reported, or a signal is pending.

  echo 512 > /sys/module/page_reporting/parameters/flush

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: LLM
---
 mm/page_reporting.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index 841dcd64777d1..74c03844fc3e9 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -360,6 +360,46 @@ static void page_reporting_process(struct work_struct *work)
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
+		while (budget) {
+			budget -= min(budget, PAGE_REPORTING_CAPACITY);
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

