Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EB3158535
	for <virtualization@lists.linux.dev>; Thu,  3 Jul 2025 03:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751512959; cv=none; b=XcofePW5kMcpUmljKe5G6hqLI5wKywmHzKltFomijWmWBwkE0c29JITZREFwAaSUXyK8qdcEo0W8gYxRztGygQMnjVeTYLIVTyiCWXGyYjD1iolluQPSn1RJwMQjTPOT82At2FGldkL0BaxfYd/FonktnVsdtygoptoTxZhz0P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751512959; c=relaxed/simple;
	bh=jRAp1AVjN+o0z0U9utUV1cQ17XRWoHhVViGsl36T9Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JI6GCYOBrg99uEAGgA6CfzZShbUPHR6uDNvo0YM5E45dGa+sqRTxScJzFtYpce5VC7raP8YBayIOTyOvNVCQ16M8ORqUU7/BszI+2Lvt0qPhQCgh8cDchmAqIY3IJo4P7Jhv13eO/80vfM8w/B0z6Aa7eT1JF8My4VPmdhsP5Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=luV3DwvX; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="luV3DwvX"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b34a78bb6e7so3866570a12.3
        for <virtualization@lists.linux.dev>; Wed, 02 Jul 2025 20:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1751512956; x=1752117756; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u3/FURbw0Qjice8ym2SrrqkCxrOCjqZwE+s45rYEO0E=;
        b=luV3DwvX00K+i3unH4+g5m8CQBjW6TS/qVluWKQ1aGVku4W85Z9KmmFuQaJeKjN7k2
         b5xpiN8rDKaIimyU4Um0iLNmL/IzBLZRgLPZiUhiAiokS7Zc8TQjruhA3cao+2B1RaGo
         88b4VaqnbiFA0CcWxmey6wJT5MeN7jRoO2yOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751512956; x=1752117756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3/FURbw0Qjice8ym2SrrqkCxrOCjqZwE+s45rYEO0E=;
        b=HsXFYVxLumoCKi2AMGtrV22BzabIa7/c1dJBuD82DRCAcAHHeNLiqnxpszo+jqWZzr
         aMOOurIqnqRNnHYs4cx5oMhzGn0CgGEC2p+CC56S0TPN8Gy3ZfVkoYgPEfy2vTlIKrtT
         cA5ajxFufMvgPkBZdv8re9XVmmRxx0RdJ9zufMzpdm7iMTiHkG7CcsWMai1ANEV+5h9K
         p/fpK/SICzo/ozUj53n/HJwI8FFqMe+0ZI5/2r8lVAsaFq71EyiwSgXeW48N+NDMq7FK
         dwkPqw1k2p1Ye9tM/37zKTnKB61g9FncAjpQvOey1wGaJVheQfRC6OiuATtdMtIpHGYP
         3sog==
X-Forwarded-Encrypted: i=1; AJvYcCV3ZFGdBSo2xyq2qx+rjNLlyhR2ZACzS5qpOqVHtGEOyvzXOO2+Gc+4txKiAOlnpiGW8Dz0Um/sLvokQYr+xQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzznwpVU7b6OZ3cD5Q1HGBub6MtbBOm3h8AYeW2/k+vV5PJTB5o
	DjsU8K9T6AVgPG3ByDQPkIcTSaER0YM6ViW7uPIZHrjWHPWqDsGyM9mB24qEw0zMsw==
X-Gm-Gg: ASbGncvx/ddPI506eTrxlLODwixNmPrBoPFt3nZ2TK1BWNHIls2UcmFe85EH2k/5WX/
	RN7w2m6NLjJAZzl+tIPglNu9GRhvQMabZQPvmVGQD+WaU+pIsen5QzlIIgb24u2DL6/O0BqsPEQ
	nxTEoGMRU3W25/Hv65obXMP/Iokr+MiCJog50B75aPO1P2n55Y8ZzMOvKQoRe6FmVklrUf1QpbJ
	39YPRsO6sepmu0m+p4rgqiWXRz62cKHzQKLanGkFZC9IU6Q490sTyI64eu9a5f2koRfxy3XW/B0
	ffCXr2vaWMLlzKhjrHrOinbzh2nsjq8gFpoWchWzvsJMsY9+YUPPkcxdgc0wbiLfLmW4hVwjV4u
	U
X-Google-Smtp-Source: AGHT+IEAy0Xvd7q1RC5hmp7SawamH/oI/muiFAFExRx9I64wiUZ1PQhrNgi3qS6Dq4f35q/YwfITMQ==
X-Received: by 2002:a17:90b:3946:b0:311:e8cc:4264 with SMTP id 98e67ed59e1d1-31a9d545d21mr2763491a91.12.1751512955991;
        Wed, 02 Jul 2025 20:22:35 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:8e3f:7c33:158f:349b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31a9cc5204bsm1117959a91.8.2025.07.02.20.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 20:22:35 -0700 (PDT)
Date: Thu, 3 Jul 2025 12:22:23 +0900
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
	Minchan Kim <minchan@kernel.org>, Brendan Jackman <jackmanb@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v1 12/29] mm/zsmalloc: stop using __ClearPageMovable()
Message-ID: <vscedd6m3cq73c5ggjjz6ndordivgeh4dmvzeok222bnderr5c@dujm4ndthtxb>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-13-david@redhat.com>
 <zmsay3nrpmjec5n7v44svfa7iwl6vklqan4dgjn4wpvsr5hqt7@cqfwdvhncgrg>
 <757cf6b9-730b-4b12-9a3d-27699e20e3ac@redhat.com>
 <ugm7j66msq2w2hd3jg3thsxd2mv7vudozal3nblnfemclvut64@yp7d6vgesath>
 <11de6ae0-d4ec-43d5-a82e-146d82f17fff@redhat.com>
 <5thkl2h5qan5gm7putqd4o6yn5ht2c5zeei5qbjoni677xr7po@kbfokuekiubj>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5thkl2h5qan5gm7putqd4o6yn5ht2c5zeei5qbjoni677xr7po@kbfokuekiubj>

On (25/07/03 11:28), Sergey Senozhatsky wrote:
> > > > > >    static int zs_page_migrate(struct page *newpage, struct page *page,
> > > > > > @@ -1736,6 +1736,13 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
> > > > > >    	unsigned long old_obj, new_obj;
> > > > > >    	unsigned int obj_idx;
> > > > > > +	/*
> > > > > > +	 * TODO: nothing prevents a zspage from getting destroyed while
> > > > > > +	 * isolated: we should disallow that and defer it.
> > > > > > +	 */
> > > > > 
> > > > > Can you elaborate?
> > > > 
> > > > We can only free a zspage in free_zspage() while the page is locked.
> > > > 
> > > > After we isolated a zspage page for migration (under page lock!), we drop
> > >                        ^^ a physical page? (IOW zspage chain page?)
> > > 
> > > > the lock again, to retake the lock when trying to migrate it.
> > > > 
> > > > That means, there is a window where a zspage can be freed although the page
> > > > is isolated for migration.
> > > 
> > > I see, thanks.  Looks somewhat fragile.  Is this a new thing?
> > 
> > No, it's been like that forever. And I was surprised that only zsmalloc
> > behaves that way
> 
> Oh, that makes two of us.

I sort of wonder if zs_page_migrate() VM_BUG_ON_PAGE() removal and
zspage check addition need to be landed outside of this series, as
a zsmalloc fixup.
