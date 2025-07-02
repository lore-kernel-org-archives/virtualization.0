Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0F923817F
	for <virtualization@lists.linux.dev>; Wed,  2 Jul 2025 10:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751451049; cv=none; b=tiV4Pi7Xl0u4m9Cg4bX+rNy87tfAo6FAbWuGrUyHU7LYdwVy+KrVcxmjf8k/xIdgS2B+c8iM69Aub+9hDcP62lPUV6G7X4mMAu7gBHssaVOB2j5ljN58aXo99Kdb+wZWAdJQdGdQ5YjVE+tzZP8SP2p0hIa5IzdxkDuxFhB34vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751451049; c=relaxed/simple;
	bh=X/8cCALWl6B46verGcMgk1pVS/SO1QUX5EH6YbyQquQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OiPx6vTghmqwnbnuSprQX3zLDGaf61gYM3mpE3pWW41hyFZ4wSFm4SRjw0RISKpP4jinmMsq+RdleVcyGql1SkbkxyoeL0AXxD+donopp/UpbtHO1BSqNHgU69fCm4YbrQEkdJYD6Eufc/CkactwZdPT8A48XFqT/P+yF8DKyVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fz3Ju7Pt; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fz3Ju7Pt"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-237311f5a54so38560745ad.2
        for <virtualization@lists.linux.dev>; Wed, 02 Jul 2025 03:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1751451047; x=1752055847; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ld1XwWyA21yaiRgsO+RmuHJahSek4BWAE0bK6K3RNA8=;
        b=fz3Ju7PtDF+SbGgg0icniOdTRi/VXSE/FaRTPzQAkqM8fQlvqXktEnaRG2+7MiTh4L
         Igw2DpaJbKNZdz7RSpqUkWXJErXwztSStgfn9yGQVE+a1xaFg5mGLrduCkWGiOr8PzB4
         xc9m3y3wHZMu1wrjjkBxUoES08GCP3BFv3RFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751451047; x=1752055847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ld1XwWyA21yaiRgsO+RmuHJahSek4BWAE0bK6K3RNA8=;
        b=qWMsL1XaAdE8hYpUUuDuGWRIZ+xq8iiSB2kJ2AkIrBLQANf6hdmd20KjTQLgVn43sy
         pWnWpOfF/1mQouOcSvlEO7ukcuOm3rOPRjJ4dfkQnyXb+8hJlQMAdtPEj6LbnD68Yr9j
         QY+J9aF/Xi4vSfZQdQ3xxkKTwPsuidVAAKxWNKq2o/+hhqU3UqM8eTadHo+AVasTdNbx
         9CMUIxzIDiSZn5VOTeYB2TUzBEUb36i0BQYfhWl0Bn1WJyh2d1Y2Og2qlO4mOv/4O311
         jOp70RALnofshmO6+G1HVa5phIbkHp5ps1+uQpv3+ifJjUkMBbH5kg1atev1Vwrw7hYv
         TjMw==
X-Forwarded-Encrypted: i=1; AJvYcCXgWGiWmV0w87174sSWMFoVYj0C+eaytBEpoNkx9HDjv/vFNAjlWpRo5/+Wi4XEXCMH2kj9N8xJttId1KSVgw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxSnxZHXlw/ivMdVd7xqmbNfYViCpjilVM40NyoBubEkUmk8r0g
	ir6lVl/ziUKNLFGuMz/Rt+3rSbj7e+0HzXZVsqBNyB7TYoe7Y4wpbFJ+NpOWY0et1w==
X-Gm-Gg: ASbGnctzb8j3VRPYLavrhw2njICs/G1R665kiEctMIdq+f4T7DJkUSAgVv63jEVInLD
	RjBR9cCS6siLmqxQtvg/J+K0Emt6egZ7WNBGmsBVrlaN04xisVjiG8Hwl7JeBOowcEfpzsnyihU
	gjh2eJOeVQKIebTyyXHVBDKLdBmhrMnIFM0YOr6XaFQl4uLfpIwDaSAp62k9QBhp+Asl7zgg1hy
	j1g1iQEunm9h28otB+VGUyLTZbXWNxVq8WAjyrSCOD53cSM/P+TtJUgvRzt79nPHiN3LI5ndFGe
	61zpSUUin/x4xBFEtl0GntXAiVWe7jWkSyv/MD0hPANe7+7MI5lgjPLDudAFJRqy8hcoKSVt1Zv
	i
X-Google-Smtp-Source: AGHT+IFD0I3P0mnZDdceuRH9XAJvvYKmYNHVDtVURKEkoHBc3BGVYVJeT3uh933j6Dzbu2Zpclzgcw==
X-Received: by 2002:a17:90a:d64e:b0:312:18e:d930 with SMTP id 98e67ed59e1d1-31a90bd4c31mr3078996a91.19.1751451046749;
        Wed, 02 Jul 2025 03:10:46 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:8825:8cdb:cb6b:8e71])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f5383eb6sm19125723a91.10.2025.07.02.03.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 03:10:46 -0700 (PDT)
Date: Wed, 2 Jul 2025 19:10:34 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: David Hildenbrand <david@redhat.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Minchan Kim <minchan@kernel.org>, Brendan Jackman <jackmanb@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v1 12/29] mm/zsmalloc: stop using __ClearPageMovable()
Message-ID: <ugm7j66msq2w2hd3jg3thsxd2mv7vudozal3nblnfemclvut64@yp7d6vgesath>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-13-david@redhat.com>
 <zmsay3nrpmjec5n7v44svfa7iwl6vklqan4dgjn4wpvsr5hqt7@cqfwdvhncgrg>
 <757cf6b9-730b-4b12-9a3d-27699e20e3ac@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <757cf6b9-730b-4b12-9a3d-27699e20e3ac@redhat.com>

On (25/07/02 10:25), David Hildenbrand wrote:
> On 02.07.25 10:11, Sergey Senozhatsky wrote:
> > On (25/06/30 14:59), David Hildenbrand wrote:
> > [..]
> > >   static int zs_page_migrate(struct page *newpage, struct page *page,
> > > @@ -1736,6 +1736,13 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
> > >   	unsigned long old_obj, new_obj;
> > >   	unsigned int obj_idx;
> > > +	/*
> > > +	 * TODO: nothing prevents a zspage from getting destroyed while
> > > +	 * isolated: we should disallow that and defer it.
> > > +	 */
> > 
> > Can you elaborate?
> 
> We can only free a zspage in free_zspage() while the page is locked.
> 
> After we isolated a zspage page for migration (under page lock!), we drop
                      ^^ a physical page? (IOW zspage chain page?)

> the lock again, to retake the lock when trying to migrate it.
> 
> That means, there is a window where a zspage can be freed although the page
> is isolated for migration.

I see, thanks.  Looks somewhat fragile.  Is this a new thing?

> While we currently keep that working (as far as I can see), in the future we
> want to remove that support from the core.

Maybe comment can more explicitly distinguish zspage isolation and
physical page (zspage chain) isolation?  zspages can get isolated
for compaction (defragmentation), for instance, which is a different
form of isolation.

> So what probably needs to be done is, checking in free_zspage(), whether the
> page is isolated. If isolated, defer freeing to the putback/migration call.

Perhaps.
