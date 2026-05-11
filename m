Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A793C0611
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 09:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490243; cv=none; b=fftlWVAx3gjYLUDyP7d6s+FwbdqlPwrlQQnJMsHjJ1CjPVjBxTYTSLgTCYv2htJkfPPB85ktKn7DX6estmyp/vbaTx52APSeqhnDN8FG8p8fckrcGl9c1sT3BGn8cXOriPISS9aR132kDWfq96IPsE9WjR8C/L3sVwYNmX75arw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490243; c=relaxed/simple;
	bh=gA+GhqYvwNlglcAAc+7safd3uN5pLfpD+OD4nI/Ceeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=OLsTB58lX4kn6qlDr36sEGHJV97VnsdEkY+jvxpH0iGNUZZ1xO2D5sgykVgQuHMLSz0zNq00fnsDVB0z8UpgI2GzyQcp06SoYACY+LVQdO4Z0zyWXbeKY0g/kvbdFRZURP2dyzYA/LfZQLIF4kt7L6R2YnXezdvivgl/VadZMEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zh8DoXtC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zh8DoXtC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778490241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RuTcBXOBEgIcnIT/SeHSDJKAZ2vX9yg2mawsRplntmg=;
	b=Zh8DoXtC/jRvrfbtlKO13LO014yMiZEayKUUBEP0Ng3ZIqaUiMyrU92WFfc/e1WUFEV+9o
	QCY3UPzsY16Xt+1NfBFdOViuKCcph7hx8I024TWr3EuzWro2me0NYfDj55QQkmBH+FYyn5
	X8NGMWBnH1kSvVRxAhq4OG5W+u0u3EI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-JlFzdr_BOEqiy1ZmPO3rmA-1; Mon, 11 May 2026 05:03:59 -0400
X-MC-Unique: JlFzdr_BOEqiy1ZmPO3rmA-1
X-Mimecast-MFC-AGG-ID: JlFzdr_BOEqiy1ZmPO3rmA_1778490239
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-447f2ce5556so2528356f8f.2
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 02:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778490238; x=1779095038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RuTcBXOBEgIcnIT/SeHSDJKAZ2vX9yg2mawsRplntmg=;
        b=foa5nRxBp1LLMTdXL/hwNiP+7teGaVV4ZNALcZr/Lj5oKGJ6EWWKG2I8x5lZbTFfUi
         MbE9DOLH6GVDc7Q0lIbuBkcr05GQFxCQVsgcrjjReRpYWzVP0CLm3kQrw4xfWvIgvqk1
         2ZLFtEi70JG9xDxNiekGNUmpIm4uL3SeBYg8D4jbjcJfqd0TL8mUx3VDDcEHxXDDFRMM
         +wsbX3a1IavJA0PDyvc5ws++wBroIg1sN0vf1ecZBQ/Et++AwDO5CyfdJsRAox+cR2Zz
         Nw815yu37+IYkr1n8T5a3/PlmoiMYxI08SbNO2vDv1vAXryTFEmqWa3Ouj1LAvVaEIH4
         OLGg==
X-Forwarded-Encrypted: i=1; AFNElJ9C8UrOgsOhemYEbYb/G4fpTC6yMJIVZ4I0gnwsZ57NH8h760Ytgori68bmDeWtqkqO2SQMilhyvWDaFhX2lw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxsnh2J8ZjtxnTtXzQhLYWf1w0AWk8TwsURGu6KKR7Wx1BvCtTP
	FZiE0JldIH9D+0NhNqWNtG8hSnJYraAQLSSinE0nywSAMZN2WbQM21ccEzA63/RiXBsCwpxX5+d
	K5SoeolGjuTO1ZtD6IsUC+IwJEBQk3qD3I5eNV6ehKUXzY/ghXqKr9f1Y6R+L/TFGTLd5
X-Gm-Gg: Acq92OHY3wAS+sg1lQytZdm/FVKc80AxhV9jYLSQ/7OoHHYmoMHp6QKzMGRm93pVPWm
	BUeF1AKlWSvjPL55awjCuum/kPQP7QHLM3tEjRVzQN9OmXIJPJGm9/yhnAs+f/FX/nT+ZUFLCy3
	Y2M1jptvyfyPuOwEeqC3e3KQY01+pQQd0fvqkJnAxcPYgeSaFyYA8xuGXA/2paGps9wOzl0GmFa
	nS2ROKFUxKXWOLqfqyFGnYuzg0HEzsEOF1vJfuzvS7hbF6177eFP2UJ4mz4UU+e3JdA2nti+wT/
	fjcHN9jgCtSf7E85XZM8RFkpX9HWDFmkGAR0c/PusDLtF8F0hTqi0A94QqTqplhTPz042dmMTdS
	O5wQo7Grd32ZqA6pBtbnYwdfkKRnIt7by8tfsqvsmeMtBteUZjfw=
X-Received: by 2002:a05:6000:4006:b0:454:1e65:32f0 with SMTP id ffacd0b85a97d-4541e65332dmr22769398f8f.10.1778490238381;
        Mon, 11 May 2026 02:03:58 -0700 (PDT)
X-Received: by 2002:a05:6000:4006:b0:454:1e65:32f0 with SMTP id ffacd0b85a97d-4541e65332dmr22769308f8f.10.1778490237654;
        Mon, 11 May 2026 02:03:57 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a5b65sm25227071f8f.8.2026.05.11.02.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:03:57 -0700 (PDT)
Date: Mon, 11 May 2026 05:03:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	virtualization@lists.linux.dev, linux-mm@kvack.org,
	Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH resend v6 23/30] mm: page_reporting: add flush parameter with
 page budget
Message-ID: <4e2e1015d22d5aeb3a60d74cc08b56e49363d3d8.1778489843.git.mst@redhat.com>
References: <cover.1778489843.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1778489843.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nmMP1UsnrlT_Mw72M6EKrhcy0YiCm5eFnZZLo_QOGBA_1778490239
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add a write-only module parameter 'flush' that triggers immediate
page reporting.  The value specifies a page budget: at least
this many pages (at page_reporting_order) will be reported,
or all unreported pages if fewer remain.  The actual number
reported may exceed the budget since each reporting pass
processes a full cycle across all zones.

This is helpful when there is a lot of memory freed quickly,
and a single cycle may not process all free pages due to
internal budget limits.

  echo 512 > /sys/module/page_reporting/parameters/flush

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 mm/page_reporting.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index 6c957a9daeef..f4a0e27ac7fb 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -358,6 +358,48 @@ static void page_reporting_process(struct work_struct *work)
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
+		     reported += prdev->capacity) {
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
+MODULE_PARM_DESC(flush, "Report at least N pages at page_reporting_order, or until all reported");
+
 int page_reporting_register(struct page_reporting_dev_info *prdev)
 {
 	int err = 0;
-- 
MST

