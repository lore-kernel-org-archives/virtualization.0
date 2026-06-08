Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782B43B0AE4
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 08:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780908026; cv=none; b=kl15mY+Klt4VQhxfI0iDRAqSuVJOiC0flrFwTMcMBHLYACU1dnrp+bdQkhksjB5sxaW1VOj1wjvpr/3n6WpAvGYozd6RJtxFVN93XYYJGkgSffalOgNPhAprfubesKerAwIz37Lj3w5Qe7eR0kpsKi1BWxJYEyGm+geGqmhpgqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780908026; c=relaxed/simple;
	bh=lBJ4LLu1g6y3CucnwB/F1BfG3upMe4x3Hxcooku9Cnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Tl8gxg5PhaU0r/cvhrCP7G8nPz9ZwUL4J8brS/FZ7pyt1MQsRTGRKqL7/WDvENk/DpkLbBhdiA1A7TeVDK/h/Pb3v0gBKuk9PnBuF3bA1Zw5gYwFQapDDPq+u3Wc2y0xKoOIyyACOMqT97WDR6LnokYGZ/CiZEShJ5j8f7Zjt6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z11GtX6W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z11GtX6W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780908024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=71/5gV60k4yG26aCAIxd/scVyaKUto/kd/wMt0/Zjmg=;
	b=Z11GtX6Wa3L/mhVNq2UoDXcYEB1Eo0ZQEYh861HYCA5g0IeP8iQAEVir3s3hbiiXLViHrE
	Pw4dOUspS+i+l/XwGlvBgFi+bjoa//GOOJhA7WrWQpudxgjc9bANCB7Un6+CIEyVIcgmU1
	Gcjn9J9oOTqakBIj9rF/Tiu3uvR130g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-ploc2aUSPM-BKfwTl2DlvQ-1; Mon, 08 Jun 2026 04:40:23 -0400
X-MC-Unique: ploc2aUSPM-BKfwTl2DlvQ-1
X-Mimecast-MFC-AGG-ID: ploc2aUSPM-BKfwTl2DlvQ_1780908022
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4600cf05f07so1851542f8f.2
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 01:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780908022; x=1781512822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71/5gV60k4yG26aCAIxd/scVyaKUto/kd/wMt0/Zjmg=;
        b=EozFSvUA/NatWU755LSEB/D2CAb8hU1epI3Ef60Q3LAsPaaXKsLhA7OGP8XvKdpQBF
         viwZdSZVBvkOCujLpHy5i1zC2XzB90bJEJtFeADyG0Sq/zFRqCMj14UV5lrQn2Dx3Q/d
         T0PP7zij4Mv9frOH/fMs7tUvJxlu3DJYudcAkb6njsz4IDooyCBJgNLeB3d4arf2STXy
         ALFrCr8blYcRFIfPMjCTTVlOOa9oQfNszoEJP+x9Ecl6L0HPU8K4Cgddi35Kx7WbCvNi
         sGyfWeL5Qgnme8ceu+TsT5KXLQzPWFH6vAGJ+nwMrlOEz6DcPgwTAePmJ3hqOfz7yus7
         RPNQ==
X-Forwarded-Encrypted: i=1; AFNElJ/+Dr2AV+AO5+/ZaEEDtnUk9OWvrMwjuyXkcOveH4jxbBeUb6P1GBvUZ8yPQD6xqPQ/Zv3ElxPVcl6JP5GtFA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2yvtbOkNijOqxOnIqHbpmWQiTYGilVHrPxqk2dVwbkK2kxf+n
	fhpj1y9du7jFXnnGAf7IEiicy4Mr3auTyonS44VDg0hDAAeuR3hI/7qraFU9dx/tvQ46XLg0MPy
	JF/n96kGfUG+lmOOw3ryZWPi+ReXsMqykUp8TVXYNfhm2lXzP6L6VYghr7ZiltV0PIus+
X-Gm-Gg: Acq92OE77BgPo59sWztSHhvukz/7FyzZvaWFqVN87caHNHQrv+fD8pO3LvstuSZDLP+
	37Anptir2jyO9Audwq2hSb1B/oxdSl6+qhTgAncAdZ2jAuWhjFXoqsPNhvKUQ4uAPOFgGWFIMya
	Qtf58Sra4t1mim6mk2DLYjRl0xeLc+0atjutLxQm6AiInU+7pUPgDI3/lIqUFOTlqlFC11zBH1m
	QApG9u90P7e4BH+9IhuiaDv9/TSZ1L3AOSPf5O6YjttJpVqlWxfn+TfcD/TFDJ1ezTK0GWBqJNP
	Xy4UWTHJ+1XW/fCItmGQvr9w/FCHY5Iio+kh48cHYbNUZbFjZ1cBM9mdIWSdUi8eLbh1h/NE5my
	Blja6nV3yDX7+w/R4lpKhjK0=
X-Received: by 2002:adf:ec0f:0:b0:45e:db3b:921d with SMTP id ffacd0b85a97d-460307563f0mr16344564f8f.31.1780908022116;
        Mon, 08 Jun 2026 01:40:22 -0700 (PDT)
X-Received: by 2002:adf:ec0f:0:b0:45e:db3b:921d with SMTP id ffacd0b85a97d-460307563f0mr16344502f8f.31.1780908021651;
        Mon, 08 Jun 2026 01:40:21 -0700 (PDT)
Received: from redhat.com ([31.152.37.159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2f2710sm39846375f8f.14.2026.06.08.01.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:40:21 -0700 (PDT)
Date: Mon, 8 Jun 2026 04:40:14 -0400
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
	"Liam R. Howlett" <liam@infradead.org>,
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
Subject: [PATCH v10 33/37] mm: page_reporting: add flush parameter with page
 budget
Message-ID: <f9b2dc2d4d7036e354282596674bd70e4c4946e7.1780906288.git.mst@redhat.com>
References: <cover.1780906288.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1780906288.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CCkpYlb5Ljt9_iBYBISIMKFnIQerDsXdkbLGfLNl8tI_1780908022
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

Note: the set callback runs under kernel param_lock,
so writing this parameter blocks other built-in parameter
writes until the flush loop completes.  This is acceptable
for a privileged debug/test parameter.
Note: flush_delayed_work is called twice (once before the
main loop, once after). The first call ensures any pending
work completes before we submit new budget. The race with
__page_reporting_request is benign: if a concurrent request
arrives between our flushes, it queues new delayed work that
will run on its own schedule.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 mm/page_reporting.c | 54 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index 9c39448e758b..400150a2aa15 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -358,6 +358,60 @@ static void page_reporting_process(struct work_struct *work)
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
+		bool interrupted = false;
+
+		for (reported = 0; reported < budget;
+		     reported += min(prdev->capacity, budget - reported)) {
+			/*
+			 * First flush completes any previously scheduled
+			 * reporting work.  Then request a new reporting
+			 * cycle and flush again to execute it.
+			 */
+			flush_delayed_work(&prdev->work);
+			__page_reporting_request(prdev);
+			flush_delayed_work(&prdev->work);
+			if (atomic_read(&prdev->state) == PAGE_REPORTING_IDLE)
+				break;
+			if (signal_pending(current)) {
+				interrupted = true;
+				break;
+			}
+		}
+		if (interrupted) {
+			mutex_unlock(&page_reporting_mutex);
+			return -EINTR;
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

