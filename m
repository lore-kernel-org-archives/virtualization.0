Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795089757;
	b=ovX2jQKs/d4Fj/27hH8LqLlq+3KIjQFdoz+gYAoWLh6P2/U3ik2bIe7keg/Zy+VGFwDi
	 6qQZuJ7zBDsFqi4uCH5ECaOer4XWFID0Y/7XehbEdqpcnSkEb6FZrbCOwIufhLZEajxY4
	 pVUnXaa8Ut3HFIAytXvn2IQQ3Tbu7FmOKAumAmm61zTbVFqyPD0YmepTxIXrcAyh3Edf/
	 jrLH1tg0/deAxO1gwZkA8ZJ/LWJZI2/FiilGYq7HRykVOLE/W8t+GO/SH63rELJCJCGcj
	 N6mVeRDrHCGoPW4KGJATBIS1CscnS6AIEwIqwkpblhnUOOHzvfoonNnjRsWM9dq9WIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795089757;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
	 X-Mailer:X-Mutt-Fcc:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=8HieDkcA9JIiulz3WEd2PXLQt0iI0kOA0dL+f71dJzo=;
	b=h08S5Q8u5VuTs3l75NOUCkfPdPjJGcnoOlPHcAnN2ClurvacM2HDglFRYr1WhLWT7KKC
	 Hi0CMB5smrl7jEoQms7qGVM9SA/RxM4JhAbjSbnVdIGvTSIeJ7weK+wtiosnqwDO9MQpw
	 tP6tSNh34+hB4AkYjKNkAm7JqVSbILVF9rRbCQ2cm224pfOZgh+fFkxtHgIuVE2up5nCg
	 OusvMxS9m6bz8BG30oXHSkhsGQ0Di8H8CpVURVzRq0qNMA6kaZ/jKA5vZYIBRM/xqnSii
	 nh5qugouxBN64HeZZ3DzIBeffkG2ZiuoTP47arIqlb4+4RvejJYvrMqmmBnvDvF/uFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=huqiLopD;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B3B606A320
	for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 12:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94B3B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=huqiLopD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795089755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=8HieDkcA9JIiulz3WEd2PXLQt0iI0kOA0dL+f71dJzo=;
	b=huqiLopDdcjqyzGk+TvsvjYqSHrntAfhigeaRyHU7k157VE8l6w9d/dITvH+rEAGelk6XP
	4RGorsUxajaE0AhryEBvOYK8VQtTnLLUKsEBi0TWRzk2EKVgtsKps69+KF/xCfkQbmKMRU
	4zGIHRTjWHFZ8ysDLjk7DKLIhZOUckc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-FWOIgkd6OrKJhz67iPhlXw-1; Thu, 19 Nov 2026 07:02:34 -0500
X-MC-Unique: FWOIgkd6OrKJhz67iPhlXw-1
X-Mimecast-MFC-AGG-ID: FWOIgkd6OrKJhz67iPhlXw_1795089753
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4bb68a5e792so5979595e9.0
        for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 04:02:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795089753; x=1795694553;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8HieDkcA9JIiulz3WEd2PXLQt0iI0kOA0dL+f71dJzo=;
        b=apreUdpZzAya8r/BVjkniVpDxLs9kuImEhVzsMd2CqNASL8tYRY7OFZNbP3bTn9V1o
         p6ewqeslQbzfp7UXurcRA1bH5fNcwUtSnt2rkWL7BGq4YYXz8HmZvmk9PqRivth0KIRI
         RmX/o0/rO0cud1S2vGV5ToHHNzlgA92VOjNH4PHdEaUfshKakuFYq0aHUOL9qLGtlLI4
         1cuRez83VxJk6mlZbhCVrHHnqaYb74WqtN3raMSV5G/fh/rmdL+4b5vsG7bLsqZoatoQ
         Pmsv32EwSsdaINRGpftQy2WWSCf3iRbXJls+Os9WMhU6sVPeQRc61AR08prwxCpQBJWR
         HpIA==
X-Forwarded-Encrypted: i=1; AL+hErFtz1XtbVgIxQ2pEZFNo8L70WmVYnvlGVASnr0Z67JgQ66gyXOr8J+KeMM02JT22TNHuPcy3dPibqhpefT7KQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/Umqd02LEOexiI3vTpj1V7cnjE4rqLf2FpyLqT6/LnTsm5yf7Z
	MjDjssdBR4IvgveYSpFZrb9lLmyTHv6oF+xa2gcf37kQTmrq1H0T0b4JsauA+NDGQ+AlXBGBFdG
	sfa5JfZFrN3IzKspD5kTVtzkXKuJC4FovYLmvPvHOv9Ld0SK0pZv6QOJEmVEz6QVkNRco
X-Gm-Gg: AYBFou0uNYb2iOyEQM3Pp+fv0BldR5mty9zLq/uL24Yzc/MxUC19DdmiMKPPpW1KkxI
	1T2RsJW51kpZnNEPvwIMJ2ARyfvzFZZv3+/Kly7q3BqV6yNuxgNI8KGmleN0NqRBzOXvJhQ9F6I
	x+4+Savt3bqtrB1VTLL3b9ysvbcDsbhWJhcfGucC1LBYIymlhE7OWCgbTqw0HCoUDkRn9YpLBOg
	cnuz8fWT0WpsDQFd4KvOAPx/lQ7+h8FKxaFe6sOKPzTHzExTrcXCawm4YOpjNqiinpI76ZcP2JG
	bDI7Jm/zQKfk/SMtqnGmDQjE1/N67i1jcB6Vh8IgN5pnGXjLrVVoVhNWC8xBTl9l224tlwarc7B
	UXLNOylwpeyOWkgunV4tIn2uYR8l4Ulic3fJ6SB2l/so=
X-Received: by 2002:a05:600c:37c4:b0:4a1:88df:8a2a with SMTP id 5b1f17b1804b1-4bb8611ac9bmr19486905e9.13.1795089752527;
        Thu, 19 Nov 2026 04:02:32 -0800 (PST)
X-Received: by 2002:a05:600c:37c4:b0:4a1:88df:8a2a with SMTP id 5b1f17b1804b1-4bb8611ac9bmr19486165e9.13.1795089751833;
        Thu, 19 Nov 2026 04:02:31 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1520:4400:d78d:7b2d:2f5d:e08f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a9846sm37547505e9.11.2026.11.19.04.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 04:02:31 -0800 (PST)
Date: Thu, 19 Nov 2026 07:02:28 -0500
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
	linux-mm@kvack.org, virtualization@lists.linux.dev
Subject: [PATCH v11 0/7] mm/virtio: skip redundant zeroing of host-zeroed
 reported pages
Message-ID: <cover.1795089715.git.mst@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pCoc_g78gULrzDhGZpXTXXnB8XCYmzC4d78a4LI3Eec_1795089753
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Many hosts immediately discard each free page guest reports.
This means that re-zeroing them in the guest after allocation
is redundant.

This series lets a page reporting device advertise that its completed
reports guarantee zero contents. It tracks that state through the buddy
allocator and uses it to skip clearing freshly allocated user folios.

The series is based on Linux 7.4-rc3, commit 666539eecdf4d.

This is the first part of the project. Further hugepage support, along with
the init_on_free and FPI_ZEROED additions suggested by Matthew Wilcox,
is left for follow-up work if this series is merged.

Patches 1-2 add PG_zeroed tracking and the page reporting device's zeroing
guarantee.

Patches 3-5 skip redundant zeroing in the PMD THP, order-0 (including
x86), and mTHP anonymous allocation paths.

Patch 6 adds VIRTIO_BALLOON_F_DEVICE_INIT_REPORTED to negotiate this
with host.

Patch 7 adds a flush parameter with an approximate reporting budget for
deterministic testing.

For a 512 MiB anonymous allocation using MADV_POPULATE_WRITE in a 2 GiB,
one-vCPU KVM guest, ten samples per mode gave:

  task-clock              feature off          feature on
  PMD THP                 229.0 +/- 20.0 ms     74.7 +/- 35.8 ms
  order-0                 336.1 +/-  6.5 ms     99.2 +/- 19.3 ms

Assisted-by: LLM

Changes since v10:
- Rewritten along the lines suggested by Matthew Wilcox [1].

[1] https://lore.kernel.org/all/aiePVsiV-w-IZ8A4@casper.infradead.org/

Michael S. Tsirkin (7):
  mm: add PG_zeroed page flag and buddy merge tracking
  mm: page_reporting: support host-zeroed reported pages
  mm: skip zeroing in vma_alloc_anon_folio_pmd for pre-zeroed pages
  mm: skip zeroing of pre-zeroed order-0 user pages
  mm: skip zeroing in alloc_anon_folio for pre-zeroed pages
  virtio_balloon: add DEVICE_INIT_REPORTED feature
  mm: page_reporting: add flush parameter with page budget

 drivers/virtio/virtio_balloon.c     | 33 ++++++++++++++++++++--
 include/linux/highmem.h             | 29 +++++++++++++++++--
 include/linux/mm.h                  | 32 +++++++++++++++++----
 include/linux/page-flags.h          | 15 +++++++++-
 include/linux/page_reporting.h      |  8 ++++++
 include/uapi/linux/virtio_balloon.h |  1 +
 mm/huge_memory.c                    | 11 ++------
 mm/memory.c                         | 10 +------
 mm/page_alloc.c                     | 43 ++++++++++++++++++++++++-----
 mm/page_reporting.c                 | 43 +++++++++++++++++++++++++++++
 10 files changed, 189 insertions(+), 36 deletions(-)


base-commit: 666539eecdf4db623f5e3c3e55cf9f2dfad24aa4
-- 
MST

