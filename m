Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC32235C1E
	for <virtualization@lists.linux.dev>; Wed,  2 Jul 2025 08:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751443912; cv=none; b=rSjXKYdk2R1ZUBoXYwsWMm0/ubi1XZFPLPzLPOhCyE9kN0LwSvl0oBw0SucrV64Tjq0mvC4l2xo4qP8OaJ+DbPCW6z6FfsnY/hR6qU2TXzvrIhuMXzmC2Z4bSUVxWqwBhfJltPtrvntT4Sniut+LUbECFjNvJx/RI1YbF8CiYN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751443912; c=relaxed/simple;
	bh=QG1iZiP+R2rzXaTe56gOjHC0fYF3d/JOXWrEX8czvSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzKULMpIbkB/2mx/pi/vwn35G3PqxlsHh7h0ouUjFFidVCkWg9p3vqPx/ORPGuP9Xv0z6pTOxGqRaebriapYwrxkAuOXlOqyr254e9DkoncyYI0FpLlcwhDjqq4LUPlLKXjC5JnSzr1MXzW/zD1d0ENxavK3WfwJXKF6Ui2288s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gZZGigR/; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gZZGigR/"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-235ef62066eso82086775ad.3
        for <virtualization@lists.linux.dev>; Wed, 02 Jul 2025 01:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1751443910; x=1752048710; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ndb+JaIMrjzxA+tCLX6/GeFttkCVzpWqjwe11W0C+PU=;
        b=gZZGigR/L4YS36C6dnYAxIgmLnuLEwkU9eK26VRbe3oUthtQq+qjJfO94720YT76Jo
         iDvSAkbjQJu6431bZLf5a5Xm77JR65t7uciZQ4aL/f6rr78iy6eVOPOe84RonBXVD0os
         8g2XwrhDNWq6zKq/tLZenW+KfLECaSa+WDjbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751443910; x=1752048710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ndb+JaIMrjzxA+tCLX6/GeFttkCVzpWqjwe11W0C+PU=;
        b=t+O8o2tEYFZTkNI1R+48xTCjMWI69DII5QhewV55ffyCIKwTlZi5XAl3rujNCpeoql
         E3sEwsnNwjDYFue8KstKrFyZRaXguD1clyXi/jO6P+vIaqeFcWhLnBEuI+o+kIDPYSz3
         S5gymDl7ftJ40R2FJZISLKSJu/h/FBtK5JOgzGpJ4MjRu3lto1SMh4gS7P0pUq1KaPzT
         qgeGuTcoEME+GWrhCnObVyrJZua42LnMeh5nLGMu8w2L2oQuzPPf8EctmckFg86J614F
         LD1+zNhDX9+txCt24QK6bLwFUzORGdvqMxgU2xZ0LRa9+MHqw4hFmiMYmfXJPS57Gcol
         QwcA==
X-Forwarded-Encrypted: i=1; AJvYcCUiJA1ZT9C9HMdX5M8ocNVdnh5Kj5L8Q0nVglukpmUlEGOZYrKveQdsCurbDBTCCWiuJrI/rsSd5gbn5ZNIhA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwcUPAGhb01+o+zcStdOI1rP07mRBlTE2zpYs0exzX7/aQce4X2
	f31lUu24OOiiw3HYP7B5RO/thaZ1Io1EnLb7tjpTktWSqgQ5JWsrNpzH9YG0iJBkFw==
X-Gm-Gg: ASbGncsCY3eyxJM9MjIfrM6BhOvDZpQUyFBnjuYluIoBgD/SXQHu3mw6pi+GgjELVye
	QRvpLTx7AOFYlb5O7QdaszLR8Zr9ZI76k9g91ukaSVyDe3pBjf8htUV2erDdbe/vcCTjsKpBywS
	N0EeVEsJHc9+aKxmKXagABAX3ZIPX0W8tltdDXA3VDOgUAo5tPNlxpg0IsguWAI72cGpU0S4GUA
	B7Img1sutjLvlfJ5DZT4Oc9AflVIOS2B9N7+9FgjwkZJDEaslyrl42begNBuVm/PRgR+1TrTGHx
	TI7xhJoAJHvaVcjGVnfVDUqv10qnpsoESZQK4FgpDQxE4VhgeHvqmCmZ4kCjUwYH1Q==
X-Google-Smtp-Source: AGHT+IFyaxLPiNw4RnMZfl9Tf3kKU0bVL2nwN672ya66HP6pYgxM8O8hDYVQs76FVVGhmt0dmGwu+w==
X-Received: by 2002:a17:903:320b:b0:234:f1ac:c036 with SMTP id d9443c01a7336-23c6e5e23d7mr21917615ad.50.1751443910448;
        Wed, 02 Jul 2025 01:11:50 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:8825:8cdb:cb6b:8e71])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e3013d7csm12080632a12.11.2025.07.02.01.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 01:11:49 -0700 (PDT)
Date: Wed, 2 Jul 2025 17:11:38 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Jerrin Shaji George <jerrin.shaji-george@broadcom.com>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v1 12/29] mm/zsmalloc: stop using __ClearPageMovable()
Message-ID: <zmsay3nrpmjec5n7v44svfa7iwl6vklqan4dgjn4wpvsr5hqt7@cqfwdvhncgrg>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-13-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630130011.330477-13-david@redhat.com>

On (25/06/30 14:59), David Hildenbrand wrote:
[..]
>  static int zs_page_migrate(struct page *newpage, struct page *page,
> @@ -1736,6 +1736,13 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
>  	unsigned long old_obj, new_obj;
>  	unsigned int obj_idx;
>  
> +	/*
> +	 * TODO: nothing prevents a zspage from getting destroyed while
> +	 * isolated: we should disallow that and defer it.
> +	 */

Can you elaborate?
