Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4D42F547A
	for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268436; cv=none; b=E8vFIc5jrYE5pQ3wncdEiDGgx3fZPBmGw0p3hvh8HBrE2Z4iwPv7gsKHzf1RCMnjQtynNoo3q5nHTiK+TgIAdnCdukXtSn7bRTj5TJiv4GAedoCYTWVze89/ELeJCWOY7GL5VEWkosaDooJXK2VwH9yBs9HWl/X+WsV7PViQqYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268436; c=relaxed/simple;
	bh=/qlovm8p0zMtgfIRyfEk2trttNuw5S14EvQzs1QPFl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=J4+PeiocUo4xu68/Gu4pHifMORBQFAsHymDEzwpj/s4cZzduhxj2jlduM05DQv2iGzdYsKrucUksQFkOx/PBiJM1Er2/RapbwrP3l7ILx3WrikByO1dzbiITNYeo74cO3G+CmeOJ//vSvg155rxSW9/gBghO+RIi07f4JQl3WQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AwnDMHL6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AwnDMHL6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750268430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nTkPO9qqkPL3+EL3rvp7Awl5YkqXAjOFp3B2ZpZgv4c=;
	b=AwnDMHL6xchlzQlJrfwmUSqHvN4ip8tsz3nf5BHhjjQYPlleqsFdvNaxv7f9TY8l2CkfsU
	+HPV/eo3trc+au0XdI76GgnkED/8RqumGwrny1qlkyP8I032xwaqDWyKZh5lwiCLe4y/wM
	56VnrKV1RVx6JoEQ9KRrdKKk6+V9ha0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-dixtsR6vNqaliHtk3Trkvw-1; Wed, 18 Jun 2025 13:40:29 -0400
X-MC-Unique: dixtsR6vNqaliHtk3Trkvw-1
X-Mimecast-MFC-AGG-ID: dixtsR6vNqaliHtk3Trkvw_1750268428
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-450de98b28eso4956685e9.0
        for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 10:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750268428; x=1750873228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nTkPO9qqkPL3+EL3rvp7Awl5YkqXAjOFp3B2ZpZgv4c=;
        b=qwh+XkvJjDCJjcQ5ntT99e8C6/zP5oamlNtm+LzMcMRNACMCoGEeRnQQU1Ln411taj
         mg31zY2Us4fpnsu0nBSYWQQAj/WpbKxJ16H/KUOQ4nafq2BD7vaFQAoJcImvoZ9UCiXy
         7avtliYJRJXrP7hChYuaY08VJpFGwqZdIppuVE70ZcaoOuS1jWWW4VsdUXH2khvKtNWE
         bu8Z4xrOCW5BJuFenakAbCIoegXSAr9FKnK48EJj1qQyHJu1G5EXLZaXJwrqs7Bn8bRF
         7WiqIngIIrAVFFKjZJkWdUoR8cJG+pZV6GqyKNr01Ns1bAdM0haZs9nSK3c6kbtvf1X0
         BKQw==
X-Forwarded-Encrypted: i=1; AJvYcCVIpNLe7+3vIvW/7VrneJJs1pQRkX68AzG1+L3Uu+9xfoJBSaYv+QBUySn5pyuwRI+6w25XqISBuz1i11Il1Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzFBAK3F5qCrR7hrP3TvVF4llD7gUfOK75Mnd+YPbj0SFFGisgW
	Qx13qwrdPHroifBzY80zwMI1Tb4C9a93qGjcAVOASXrz1F8SdcRYs7UADQ4I5IzKjSA0QG4SlC6
	HOu+FedsOaQQI1g6XOvrdFfLOGTwgVEykZQByU5P8OQhb3DKBLYrroiVE9qzN0vF+OQE2
X-Gm-Gg: ASbGncvOSIc+Q3u7DIBqwbeHlI24nG6Gpnww+LlZNfXuBypVPcYRFbCziBOLwM1v9RR
	0Neh/GGKV6PXiw7svIHY2H+lvFAPKFtq9xvHTBigyVDHZ+P8MB7QD/5b2xlILn8icooxFBczZHu
	Gca810J5sq+JZCwp8OVfrIqmikrlM9yAcyGREbFRJIkYz9JDvOclv+inaS4w4SuaN2SSNTK+sox
	GZbQ1uYK3REVAwGqwy++nzFBvPSZ7EurONRJZyzr6lUCoEwr42hGf4rz1LlYr3rpzyaRFBXzsx/
	/ZrdsxQaPok0W0d+5SXoGK7cHlb6/xqVyUMZkU/ai5A7yJl/1GB35wW249YYyheFMYzUZgU4mPw
	cOekQUw==
X-Received: by 2002:a05:600c:4b16:b0:453:92e:a459 with SMTP id 5b1f17b1804b1-4535ec85c23mr3139565e9.16.1750268427766;
        Wed, 18 Jun 2025 10:40:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkzVO1ODwNAxaNuTK2n5Qmy81cmyi9pmESLWNLzISSPT37JEqPUHdRyxt0ThuYLp1iDunnjA==
X-Received: by 2002:a05:600c:4b16:b0:453:92e:a459 with SMTP id 5b1f17b1804b1-4535ec85c23mr3139385e9.16.1750268427286;
        Wed, 18 Jun 2025 10:40:27 -0700 (PDT)
Received: from localhost (p200300d82f2d2400405203b5fff94ed0.dip0.t-ipconnect.de. [2003:d8:2f2d:2400:4052:3b5:fff9:4ed0])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a568a5407csm17710458f8f.12.2025.06.18.10.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 10:40:26 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: [PATCH RFC 04/29] mm/page_alloc: allow for making page types sticky until freed
Date: Wed, 18 Jun 2025 19:39:47 +0200
Message-ID: <20250618174014.1168640-5-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250618174014.1168640-1-david@redhat.com>
References: <20250618174014.1168640-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HAUDsL1QNkBXsuPvdth3Dy_UzNWBFlC7bQkbjCUrxS8_1750268428
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Let's allow for not clearing a page type before freeing a page to the
buddy.

We'll focus on having a type set on the first page of a larger
allocation only.

With this change, we can reliably identify typed folios even though
they might be in the process of getting freed, which will come in handy
in migration code (at least in the transition phase).

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_alloc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 858bc17653af9..44e56d31cfeb1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1380,6 +1380,9 @@ __always_inline bool free_pages_prepare(struct page *page,
 			mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
 		page->mapping = NULL;
 	}
+	if (unlikely(page_has_type(page)))
+		page->page_type = UINT_MAX;
+
 	if (is_check_pages_enabled()) {
 		if (free_page_is_bad(page))
 			bad++;
-- 
2.49.0

