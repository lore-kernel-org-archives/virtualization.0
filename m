Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B2E2E041D
	for <virtualization@lists.linux.dev>; Thu, 15 Jan 2026 09:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768469589; cv=none; b=TEdHXxRi4/NR75RLfjuLGOfPjJqC1BY69Ln9YRKtV7so91YsoYEfRXTVWLM52JhBilCJymxO5xpS/ZfO/vrfiV0e5EAFrCLHD3OZKdyZ3ZnQ6rqA6lu95BURkk0DsMp8eD172Wv0pqQaBLG+AYtP9PxIA/tQrO5a5GMY4NlcAcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768469589; c=relaxed/simple;
	bh=5S/eCr84IqvxFoOtD38rMw+D2s1EBwWgY6WhDrkn7+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=L/nCGXPMmKil7ikGfyVx4FjiC0Ec1GLjpouGkuaIYrKO+Jr3/WI3zSv974phA18/iWuASDP8SEUT1MrKoxFZUGVit+2QkNwCiHS13JaawicJoF205/Os4tcghLBEszc03XrTnY1uwX2Qa8FlN4dPcW67LLiqxaaslVZEowDHPRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gSV3IiK2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gSV3IiK2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768469586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E3+emnN/FUkaljXR8TzqIDHk76UR0X2pbJSmye/ZyuY=;
	b=gSV3IiK2NPwSJeXUSu3Q7nbfyUJNem6KtptfMSHBSOfeKfX9v/NqX3jVpKVzcmgbzJJNAF
	tE9nJpxDhsBlOHpUxEXUbYjaq3IOrXmSx+boFn/HM+iWrbOS+XaiZn7RIWaSQkfPlM7tuB
	b83GglLGXvVxSVocTbTGQZorC0TdANw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-N_IgsVdWO620PMdsqS_aVQ-1; Thu, 15 Jan 2026 04:33:04 -0500
X-MC-Unique: N_IgsVdWO620PMdsqS_aVQ-1
X-Mimecast-MFC-AGG-ID: N_IgsVdWO620PMdsqS_aVQ_1768469584
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47ee056e5cfso4418515e9.1
        for <virtualization@lists.linux.dev>; Thu, 15 Jan 2026 01:33:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768469583; x=1769074383;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E3+emnN/FUkaljXR8TzqIDHk76UR0X2pbJSmye/ZyuY=;
        b=fWJQ+GajSdbT5NUfkRg10W1xaDo1HfOdQ+UTZaQ3T8qsviBWt7ZazMlJ8SlpFbRKTK
         Ghrx1Lm3s9Fe0KJzafPSmasqqTCQPgRG7WIFmABQtwvQGsZu2Hscb4Y/EWq0HTtEhu9x
         nxuEtYMZGgaEaFOv6JFkpxB+Q3F7n7PUz6GYNXbHmvXdoOCkXyFdoKdPsCa4HPKaaLnV
         kshux6ati6oRV1NA66JslMe4p3oBDxNkGpwNdkr/k7b74scfV8HT81On/M6P7TAsDeVo
         g94iJwF8uibMN6USGm193ODP/mcSwg9MaHJBYTAXfd2MM5CMPmcj7rri5QGLxXDv9+MZ
         oUfA==
X-Forwarded-Encrypted: i=1; AJvYcCXTG9OZW++NgZPOT5rzPZ0QS/aFPTPEFiDQDpV4sLVYHowIwaaDoedCXRuGMyKsmNfrhQrCZbJ0ERHR7zUSlg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzkfVdOVzADrzS00kKuwUfpKyTW5f37IVpRFR+vzcvb+eH+u69n
	N7S8FBzPnbDG83JsV+NLAiK+KvD3o7E2aLNwiGMujC9tOa1JG5NvyzxJMQc6P+zk/fyopA3EjGT
	PkD37jzLKxVCDaM259xVyCp1DEsUEbwReTR++Pi/LYGbIGZiqFIvARSwuIX6AKec161Qm2Nn/SL
	DA
X-Gm-Gg: AY/fxX7twnPUZ4z7K0Xpp4+EX5d9yhWh0ZmfU6Dt/OOPfqbnqKOgXh9vMDbRlD2dBRe
	UBdXoQJrsIkWTP9yLXIpE9AAOxXd3UM1Tzspa48huaeI9EL5pR67/WDxSSSKR7Et23lI4P2QTLk
	5e6M96vL7uAdk0dXylUYzaDNEIgodIHQQZqd6ziAH3j49eolpyJv6RYwGtOAazpuNIQL1RDGyo1
	Bm8aZH0/tR9aDeCgmcTSVTTbzJ4iGz1rpGVqgCAnt3f8TmyrUaiJS25LEGuyf7I87ZSLv1a32Pu
	t1lBlCCL6AZOOX0w69LCqj0EkjyuZMenVXdT6PX3/N/ZadxfE11TfA7URPdkXxJrsGK0UOHKaIW
	JHth1Tmdw3YfrgFFRJT+Kt2ZVLpFXgg==
X-Received: by 2002:a05:600c:6610:b0:477:b642:9dc9 with SMTP id 5b1f17b1804b1-47ee48271b8mr47954445e9.28.1768469583367;
        Thu, 15 Jan 2026 01:33:03 -0800 (PST)
X-Received: by 2002:a05:600c:6610:b0:477:b642:9dc9 with SMTP id 5b1f17b1804b1-47ee48271b8mr47953965e9.28.1768469582848;
        Thu, 15 Jan 2026 01:33:02 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee97b2bebsm19745355e9.18.2026.01.15.01.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 01:33:02 -0800 (PST)
Date: Thu, 15 Jan 2026 04:32:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v2 00/23] mm: balloon infrastructure cleanups
Message-ID: <20260115043240-mutt-send-email-mst@kernel.org>
References: <20260115092015.3928975-1-david@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260115092015.3928975-1-david@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xPy02F2R45fJiH1CCO6kNjQCfq78Olel8XulZPqOK4I_1768469584
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Jan 15, 2026 at 10:19:50AM +0100, David Hildenbrand (Red Hat) wrote:
> I started with wanting to remove the dependency of the balloon
> infrastructure on the page lock, but ended up performing various other
> cleanups, some of which I had on my todo list for years.
> 
> This series heavily cleans up and simplifies our balloon infrastructure,
> including our balloon page migration functionality.
> 
> With this series, we no longer make use of the page lock for PageOffline
> pages as part of the balloon infrastructure (preparing for memdescs
> where PageOffline pages won't have any such lock), and simplifies
> migration handling such that refcounting can more easily be adjusted
> later (long-term focus is for PageOffline pages to not have a refcount
> either).
> 
> Plenty of related cleanups.
> 
> Heavily compile-tested and heavily runtime-tested with virtio-balloon.
> PPC CMM and the VMware balloon are untested and I'd appreciate a helping
> hand from people that have suitable environments.
> 
> Not CCing maintainers for the vmscan.c and migrate.c change as they
> are rather trivial and I don't want to patchbomb them.

besides MAINTAINERS thing:

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> --
> 
> This is based on mm/mm-unstable.
> 
> v1 -> v2:
> * Rebased to latest mm/mm-unstable without any conflicts
> * Minor patch description/subject and comment fixups
> * Retested
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jerrin Shaji George <jerrin.shaji-george@broadcom.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Cc: "Eugenio Pérez" <eperezma@redhat.com>
> Cc: Zi Yan <ziy@nvidia.com>
> 
> David Hildenbrand (Red Hat) (23):
>   vmw_balloon: adjust BALLOON_DEFLATE when deflating while migrating
>   vmw_balloon: remove vmballoon_compaction_init()
>   powerpc/pseries/cmm: remove cmm_balloon_compaction_init()
>   mm/balloon_compaction: centralize basic page migration handling
>   mm/balloon_compaction: centralize adjust_managed_page_count() handling
>   vmw_balloon: stop using the balloon_dev_info lock
>   mm/balloon_compaction: use a device-independent balloon (list) lock
>   mm/balloon_compaction: remove dependency on page lock
>   mm/balloon_compaction: make balloon_mops static
>   mm/balloon_compaction: drop fs.h include from balloon_compaction.h
>   drivers/virtio/virtio_balloon: stop using balloon_page_push/pop()
>   mm/balloon_compaction: remove balloon_page_push/pop()
>   mm/balloon_compaction: fold balloon_mapping_gfp_mask() into
>     balloon_page_alloc()
>   mm/balloon_compaction: move internal helpers to balloon_compaction.c
>   mm/balloon_compaction: assert that the balloon_pages_lock is held
>   mm/balloon_compaction: mark remaining functions for having proper
>     kerneldoc
>   mm/balloon_compaction: remove "extern" from functions
>   mm/vmscan: drop inclusion of balloon_compaction.h
>   mm: rename balloon_compaction.(c|h) to balloon.(c|h)
>   mm/kconfig: make BALLOON_COMPACTION depend on MIGRATION
>   mm: rename CONFIG_BALLOON_COMPACTION to CONFIG_BALLOON_MIGRATION
>   mm: rename CONFIG_MEMORY_BALLOON -> CONFIG_BALLOON
>   MAINTAINERS: move memory balloon infrastructure to "MEMORY MANAGEMENT
>     - BALLOON"
> 
>  .../admin-guide/mm/memory-hotplug.rst         |   8 +-
>  Documentation/core-api/mm-api.rst             |   2 +-
>  MAINTAINERS                                   |  12 +-
>  arch/powerpc/platforms/pseries/Kconfig        |   2 +-
>  arch/powerpc/platforms/pseries/cmm.c          |  53 +----
>  drivers/misc/Kconfig                          |   2 +-
>  drivers/misc/vmw_balloon.c                    | 105 +++-------
>  drivers/virtio/Kconfig                        |   2 +-
>  drivers/virtio/virtio_balloon.c               |  64 ++----
>  include/linux/balloon.h                       |  77 +++++++
>  include/linux/balloon_compaction.h            | 160 ---------------
>  include/linux/vm_event_item.h                 |   8 +-
>  mm/Kconfig                                    |  23 +--
>  mm/Makefile                                   |   2 +-
>  mm/{balloon_compaction.c => balloon.c}        | 194 +++++++++++++-----
>  mm/memory_hotplug.c                           |   4 +-
>  mm/migrate.c                                  |   2 +-
>  mm/vmscan.c                                   |   1 -
>  mm/vmstat.c                                   |   8 +-
>  19 files changed, 314 insertions(+), 415 deletions(-)
>  create mode 100644 include/linux/balloon.h
>  delete mode 100644 include/linux/balloon_compaction.h
>  rename mm/{balloon_compaction.c => balloon.c} (59%)
> 
> 
> base-commit: f8ed52ac0cfbddff992bb9600941bfe51e1e385a
> -- 
> 2.52.0

